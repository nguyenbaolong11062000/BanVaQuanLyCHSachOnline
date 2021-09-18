import hashlib
from nha_sach.models import UserRole, Sach, KhachHang, DonHang, ChiTietDonHang, TacGiaVietSach, TacGia
from nha_sach import db
from flask_login import current_user

#các chức năng tìm kiếm
def read_books(book_id=None, kw=None, kw2=None, from_price=None, to_price=None):
    books = Sach.query.join((TacGiaVietSach, Sach.MaSach == TacGiaVietSach.ma_sach), (TacGia, TacGia.MaTG == TacGiaVietSach.ma_tg))
    if book_id:
        books = books.filter(Sach.MaSach == book_id)
    if kw:
        books = books.filter(Sach.TuaSach.contains(kw))
    if kw2:
        books = books.filter(TacGia.Ten.contains(kw2))
    if from_price and to_price:
        books = books.filter(Sach.GiaBia.__gt__(from_price),
                             Sach.GiaBia.__lt__(to_price))

    return books.all()

#chức năng chi tiết sách
def get_book_by_id(book_id):
    return Sach.query.get(book_id)

#kiểm tra đăng nhập admin
def check_login(username, password, role = UserRole.ADMIN):
    password = str(hashlib.md5(password.strip().encode('utf-8')).hexdigest())

    user = KhachHang.query.filter(KhachHang.TenDangNhap == username.strip(),
                             KhachHang.MatKhau == password,
                             KhachHang.VaiTro == role).first()
    return user


#đăng ký khách hàng
def add_user(name1, name, phone, email, username, password, gender, avatar_path):
    password = str(hashlib.md5(password.strip().encode('utf-8')).hexdigest())
    u = KhachHang(Ho=name1,Ten=name, Email=email, SoDT=phone,
                  TenDangNhap=username, MatKhau=password, GioiTinh=gender,
                  HinhAnh=avatar_path)
    try:
        db.session.add(u)
        db.session.commit()
        return True
    except Exception as ex:
        print(ex)
        return False

#duyệt user để đăng nhập
def get_user_by_id(user_id):
   return KhachHang.query.get(user_id)

#thông tin hóa đơn
def cart_stats(cart):
    total_quantity, total_amount = 0, 0
    if cart:
        for p in cart.values():
            total_quantity = total_quantity + p["quantity"]
            total_amount = total_amount + p["quantity"] * p["price"]

    return total_quantity, total_amount

#ghi nhận hóa đơn xuống CSDL
def add_receipt(cart):
    if cart and current_user.is_authenticated:
        receipt = DonHang(ma_kh=current_user.id)
        db.session.add(receipt)

        for p in list(cart.values()):
            detail = ChiTietDonHang(DonHang=receipt,
                                   ma_sach=int(p["id"]),
                                   SoLuong=p["quantity"],
                                   GiaBan=p["price"])
            db.session.add(detail)

        try:
            db.session.commit()
            return True
        except Exception as ex:
            print(ex)

    return False