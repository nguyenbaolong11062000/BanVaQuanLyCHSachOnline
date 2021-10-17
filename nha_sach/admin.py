from flask_login import logout_user, current_user
from flask import redirect
from nha_sach import admin, db
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
    column_display_pk = True;
    can_export = True

    def is_accessible(self):
        return current_user.is_authenticated


class BangSach(ModelView):
    column_display_pk = True;
    can_export = True

    def is_accessible(self):
        return current_user.is_authenticated

class BangTacGia(ModelView):
    column_display_pk = True;
    can_export = True

    def is_accessible(self):
        return current_user.is_authenticated

class BangTacGiaVietSach(ModelView):
    column_display_pk = True;
    can_export = True

    def is_accessible(self):
        return current_user.is_authenticated


class BangDonHang(ModelView):
    column_display_pk = True;
    can_export = True

    def is_accessible(self):
        return current_user.is_authenticated

class BangChiTietDonHang(ModelView):
    column_display_pk = True;
    can_export = True

    def is_accessible(self):
        return current_user.is_authenticated



class BangKhacHang(ModelView):
    column_display_pk = True;
    can_export = True

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
