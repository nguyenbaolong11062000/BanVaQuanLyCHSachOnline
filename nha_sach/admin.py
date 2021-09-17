from flask_login import logout_user, current_user
from flask import redirect
from nha_sach import admin, db
from flask_admin.contrib.sqla import ModelView
from flask_admin import BaseView, expose
from nha_sach.models import *


class ContactView(BaseView):
    @expose('/')
    def index(self):
        return self.render('admin/contact.html')


class AboutUsView(BaseView):
    @expose('/')
    def index(self):
        return self.render('admin/about-us.html')

class LoaiSachView(ModelView):
    column_display_pk = True;
    can_export = True

    def is_accessible(self):
        return current_user.is_authenticated


class SachView(ModelView):
    column_display_pk = True;
    can_export = True

    def is_accessible(self):
        return current_user.is_authenticated

class TacGiaView(ModelView):
    column_display_pk = True;
    can_export = True

    def is_accessible(self):
        return current_user.is_authenticated

class TacGiaVietSachView(ModelView):
    column_display_pk = True;
    can_export = True

    def is_accessible(self):
        return current_user.is_authenticated


class DonHangView(ModelView):
    column_display_pk = True;
    can_export = True

    def is_accessible(self):
        return current_user.is_authenticated

class ChiTietDonHangView(ModelView):
    column_display_pk = True;
    can_export = True

    def is_accessible(self):
        return current_user.is_authenticated



class KhachHangView(ModelView):
    column_display_pk = True;
    can_export = True

    def is_accessible(self):
        return current_user.is_authenticated

class LogoutView(BaseView):
    @expose('/')
    def logout(self):
        logout_user()

        return redirect('/admin')

    def is_accessible(self):
        return current_user.is_authenticated


admin.add_view(KhachHangView(KhachHang, db.session))
admin.add_view(LoaiSachView(LoaiSach, db.session))
admin.add_view(SachView(Sach, db.session))
admin.add_view(TacGiaView(TacGia, db.session))
admin.add_view(TacGiaVietSachView(TacGiaVietSach, db.session))
admin.add_view(DonHangView(DonHang, db.session))
admin.add_view(ChiTietDonHangView(ChiTietDonHang, db.session))
admin.add_view(ContactView(name='Liên hệ'))
admin.add_view(AboutUsView(name='About Us'))
admin.add_view(LogoutView(name='Logout'))
