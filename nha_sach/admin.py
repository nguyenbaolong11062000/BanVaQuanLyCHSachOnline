from flask_login import logout_user, current_user
from flask import redirect
from nha_sach import admin
from flask_admin.contrib.sqla import ModelView
from flask_admin import BaseView, expose
from nha_sach.models import *


class LienHe(BaseView):
    @expose('/')
    def index(self):
        return self.render('admin/contact.html')


class GioiThieu(BaseView):
    @expose('/')
    def index(self):
        return self.render('admin/about-us.html')

class BangLoaiSach(ModelView):
    column_display_pk = True
    can_export = True
    can_view_details = True
    details_modal = True
    edit_modal = True #_modal là hiển thị ra box modal chứ không phải chuyển qua trang mới
    create_modal = True
    column_filters = ['MieuTaLoaiSach'] #lọc ra các kết quả với biến trong ['?'] là giá trị cột bên model
    column_searchable_list = ['MieuTaLoaiSach'] #tiềm kiếm ra các kết quả mong muốn với biến trong ['?'] là giá trị cột bên model
    column_labels = {
        'MaLoaiSach': 'Mã Loại Sách',
        'MieuTaLoaiSach': 'Tên Loại Sách'
    } #sửa tên các cột trên trang chủ admin theo ý mình với giá trị key '?' là giá trị cột bên model
    form_excluded_columns = ['sach']

    def is_accessible(self):
        return current_user.is_authenticated


class BangSach(ModelView):
    column_display_pk = True
    can_export = True
    can_view_details = True
    details_modal = True
    edit_modal = True
    create_modal = True
    column_filters = ['TuaSach', 'MoTaSach', 'GiaBia']
    column_searchable_list = ['TuaSach', 'MoTaSach', 'GiaBia']
    column_labels = {
        'MaSach': 'Mã Sách',
        'TuaSach': 'Tên Sách',
        'MoTaSach': 'Mô Tả Sách',
        'GiaBia': 'Giá Bìa',
        'HinhAnh': 'Hình Ảnh',
        'NamXuatBan': 'Năm Xuất Bản',
        'LoaiSach': 'Loại Sách'
    }
    form_excluded_columns = ['chiTiet_DH', 'tg_vietsach'] #danh sách các cột không hiển thị trong form nhập mới một sản phẩm hoặc sửa thông tin sản phẩm

    def is_accessible(self):
        return current_user.is_authenticated

class BangTacGia(ModelView):
    column_display_pk = True
    can_export = True
    can_view_details = True
    details_modal = True
    edit_modal = True
    create_modal = True
    column_filters = ['Ho', 'Ten']
    column_searchable_list = ['Ho', 'Ten']
    column_labels = {
        'MaTG': 'Mã Tác Giả',
        'Ho': 'Họ',
        'Ten': 'Tên',
        'HinhAnh': 'Hình Ảnh',
        'TieuSu': 'Tiểu Sử'
    }
    form_excluded_columns = ['tg_vietsach']

    def is_accessible(self):
        return current_user.is_authenticated

class BangTacGiaVietSach(ModelView):
    column_display_pk = True
    can_export = True
    can_view_details = True
    details_modal = True
    edit_modal = True
    create_modal = True
    column_labels = {
        'TacGia': 'Tác Giả',
        'Sach': 'Sách'
    }

    def is_accessible(self):
        return current_user.is_authenticated


class BangDonHang(ModelView):
    column_display_pk = True
    can_export = True
    can_view_details = True
    details_modal = True
    edit_modal = True
    create_modal = True
    column_filters = ['NgayMua']
    column_labels = {
        'MaDH': 'Mã Đơn Hàng',
        'NgayMua': 'Ngày Mua Hàng',
        'TenKH': 'Khách Hàng'
    }
    form_excluded_columns = ['chiTiet_DH']

    def is_accessible(self):
        return current_user.is_authenticated

class BangChiTietDonHang(ModelView):
    column_display_pk = True
    can_export = True
    can_view_details = True
    details_modal = True
    edit_modal = True
    create_modal = True
    column_filters = ['SoLuong', 'GiaBan', 'TyLeGiamGia']
    column_searchable_list = ['SoLuong', 'GiaBan', 'TyLeGiamGia']
    column_labels = {
        'DonHang': 'Đơn Hàng',
        'Sach': 'Sách',
        'SoLuong': 'Số Lượng',
        'GiaBan': 'Giá Bán',
        'TyLeGiamGia': 'Tỷ Lệ Giảm Giá'
    }

    def is_accessible(self):
        return current_user.is_authenticated



class BangKhacHang(ModelView):
    column_display_pk = True
    can_export = True
    can_view_details = True
    details_modal = True
    edit_modal = True
    create_modal = True
    column_filters = ['Ho', 'Ten', 'GioiTinh']
    column_searchable_list = ['Ho', 'Ten', 'GioiTinh']
    column_labels = {
        'MaKH': 'Mã Khách Hàng',
        'Ho': 'Họ',
        'Ten': 'Tên',
        'Email': 'Email',
        'TenDangNhap': 'Tên Đăng Nhập',
        'MatKhau': 'Mật Khẩu',
        'GioiTinh': 'Giới Tính',
        'HinhAnh': 'Hình Ảnh',
        'SoDT': 'Số Điện Thoại',
        'HoatDong': 'Còn Sử Dụng',
        'VaiTro': 'Phân Quyền',
    }
    form_excluded_columns = ['don_hang']

    def is_accessible(self):
        return current_user.is_authenticated

class DangXuat(BaseView):
    @expose('/')
    def logout(self):
        logout_user()

        return redirect('/admin')

    def is_accessible(self):
        return current_user.is_authenticated


admin.add_view(BangKhacHang(KhachHang, db.session, name='Khách Hàng'))
admin.add_view(BangLoaiSach(LoaiSach, db.session, name='Loại Sách'))
admin.add_view(BangSach(Sach, db.session, name='Sách'))
admin.add_view(BangTacGia(TacGia, db.session, name='Tác Giả'))
admin.add_view(BangTacGiaVietSach(TacGiaVietSach, db.session, name='Tác Giả Viết Sách'))
admin.add_view(BangDonHang(DonHang, db.session, name='Đơn Hàng'))
admin.add_view(BangChiTietDonHang(ChiTietDonHang, db.session, name='Chi Tiết Đơn Hàng'))
admin.add_view(LienHe(name='Liên hệ'))
admin.add_view(GioiThieu(name='Giới Thiệu'))
admin.add_view(DangXuat(name='Đăng Xuất'))
