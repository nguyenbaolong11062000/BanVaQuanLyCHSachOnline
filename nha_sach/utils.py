import json, hashlib
from nha_sach.models import UserRole, Sach, KhachHang, DonHang, ChiTietDonHang, TacGia, LoaiSach
from nha_sach import db
from flask_login import current_user


def read_books(tpbook_id=None, kw=None, kw2=None, from_price=None, to_price=None):
    books = Sach.query
    if tpbook_id:
        books = books.filter(Sach.MaSach == tpbook_id)
    if kw:
        books = books.filter(Sach.TuaSach.contains(kw))
    if kw2:
        books = books.filter(Sach.TuaSach.contains(kw2))
    #if typebook:
    #    books = books.filter(Sach.typeofBook_name.contains(typebook))

    if from_price and to_price:
        books = books.filter(Sach.GiaBia.__gt__(from_price),
                             Sach.GiaBia.__lt__(to_price))

    return books.all()

    # sach1 = read_data(path='data/sach1.json')
    #
    # if tpbook_id:
    #     tpbook_id = int(tpbook_id)
    #     sach1 = [p for p in sach1
    #              if p['typeofbook_id'] == tpbook_id]
    #
    # if kw:
    #     sach1 = [p for p in sach1
    #              if p['name'].find(kw) >= 0]
    #
    # if from_price and to_price:
    #     from_price = float(from_price)
    #     to_price = float(to_price)
    #     sach1 = [p for p in sach1
    #             if to_price >= p['price'] >= from_price]
    #
    # return sach1


def get_book_by_id(book_id):
    return Sach.query.get(book_id)
    # books = read_data('data/books.json')
    # for p in books:
    #     if p['id'] == book_id:
    #         return p


def check_login(username, password, role = UserRole.ADMIN):
    password = str(hashlib.md5(password.strip().encode('utf-8')).hexdigest())

    user = KhachHang.query.filter(KhachHang.TenDangNhap == username.strip(),
                             KhachHang.MatKhau == password,
                             KhachHang.VaiTro == role).first()
    return user



def add_user(name1, name, phone, email, username, password, gender, avatar_path):
    password = str(hashlib.md5(password.strip().encode('utf-8')).hexdigest())
    u = KhachHang(Ho=name1,Ten=name, Email=email, SoDT=phone,
                  TenDangNhap=username, MatKhau=password, GioiTinh=gender,
                  HinhAnh=avatar_path)
    #y = User(name1=name1, name=name, email=email,
    #         username=username, password=password, gender=gender,
    #         avatar=avatar_path)
    try:
    #    db.session.add(y)
        db.session.add(u)
        db.session.commit()
        return True
    except Exception as ex:
        print(ex)
        return False


def get_user_by_id(user_id):
   return KhachHang.query.get(user_id)


def cart_stats(cart):
    total_quantity, total_amount = 0, 0
    if cart:
        for p in cart.values():
            total_quantity = total_quantity + p["quantity"]
            total_amount = total_amount + p["quantity"] * p["price"]

    return total_quantity, total_amount

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