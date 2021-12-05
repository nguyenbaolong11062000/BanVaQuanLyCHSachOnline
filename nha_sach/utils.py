import hashlib
from nha_sach.models import PhanQuyen, Sach, KhachHang, DonHang, ChiTietDonHang, TacGiaVietSach, TacGia
from nha_sach import db
from flask_login import current_user
from sqlalchemy import or_

#các chức năng tìm kiếm
def timKiem_Sach(ma_sach=None, ten_sach=None, tac_gia=None, gia_batDau=None, gia_ketThuc=None):
    sach = Sach.query.join((TacGiaVietSach, Sach.MaSach == TacGiaVietSach.ma_sach), (TacGia, TacGia.MaTG == TacGiaVietSach.ma_tg))
    if ma_sach:
        sach = sach.filter(Sach.MaSach == ma_sach)
    if ten_sach:
        sach = sach.filter(Sach.TuaSach.contains(ten_sach))
    if tac_gia:
        hoVaTenTG1 = TacGia.Ten + ' ' + TacGia.Ho
        hoVaTenTG2 = TacGia.Ho + ' ' + TacGia.Ten
        sach = sach.filter(or_(hoVaTenTG1.contains(tac_gia),
                               hoVaTenTG2.contains(tac_gia)))
    if gia_batDau and gia_ketThuc:
        sach = sach.filter(Sach.GiaBia.__gt__(gia_batDau),
                             Sach.GiaBia.__lt__(gia_ketThuc))

    return sach.all()

#chức năng chi tiết sách
def thongtinSach_theoMaSach(ma_sach):
    return Sach.query.get(ma_sach)


#kiểm tra đăng nhập admin
def kiemTraDangNhapADMIN(TenDangNhap, MatKhau, VaiTro=PhanQuyen.ADMIN):
    matKhau = str(hashlib.md5(MatKhau.strip().encode('utf-8')).hexdigest())

    nguoidung_ADMIN = KhachHang.query.filter(KhachHang.TenDangNhap == TenDangNhap.strip(),
                             KhachHang.MatKhau == matKhau,
                             KhachHang.VaiTro == VaiTro).first()
    return nguoidung_ADMIN


#đăng ký khách hàng
def themKhachHang(Ho, Ten, SoDT, Email, TenDangNhap, MatKhau, GioiTinh, HinhAnh):
    MatKhau = str(hashlib.md5(MatKhau.strip().encode('utf-8')).hexdigest())
    u = KhachHang(Ho=Ho, Ten=Ten, Email=Email, SoDT=SoDT,
                  TenDangNhap=TenDangNhap, MatKhau=MatKhau, GioiTinh=GioiTinh,
                  HinhAnh=HinhAnh)
    try:
        db.session.add(u)
        db.session.commit()
        return True
    except Exception as ex:
        print(ex)
        return False

#duyệt user để đăng nhập
def duyet_taiKhoan(ma_KH):
   return KhachHang.query.get(ma_KH)

#thông tin tổng tiền và tổng số lượng (cách tính)
def tinhTongTien_SoLuong(gioHang):
    tong_SoLuong, tong_Tien = 0, 0
    if gioHang:
        for p in gioHang.values():
            tong_SoLuong = tong_SoLuong + p["soLuong"]
            tong_Tien = tong_Tien + p["soLuong"] * p["Gia"]

    return tong_SoLuong, tong_Tien


#ghi nhận hóa đơn xuống CSDL
def ghiNhanHoaDon(gioHang):
    if gioHang and current_user.is_authenticated:
        hoaDon = DonHang(ma_kh=current_user.MaKH)
        db.session.add(hoaDon)

        for p in list(gioHang.values()):
            chiTietHoaDon = ChiTietDonHang(DonHang=hoaDon,
                                   ma_sach=int(p["Ma_Sach"]), #p["?"] được là do trong giỏ hàng đã định nghĩa Ma_Sach, soLuong, Gia rồi
                                   SoLuong=p["soLuong"], #nên khi gọi phương cart.values() sẽ gọi được các biến đó
                                   GiaBan=p["Gia"])
            db.session.add(chiTietHoaDon)

        try:
            db.session.commit()
            return True
        except Exception as ex:
            print(ex)

    return False