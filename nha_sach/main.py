import hashlib

from flask import render_template, request, url_for, session, jsonify
from nha_sach import app, login, utils, decorator
from nha_sach.admin import *
from flask_login import login_user
import os, json

from nha_sach.models import KhachHang


@app.route('/')
def trangChu():
    return render_template('index.html')


@app.route('/about-us')
def gioiThieu():
   return render_template('about-us.html')

#duyệt danh sách các loại sách
@app.route('/sach')
@decorator.login_required
def danhsach_Sach():
    ma_sach = request.args.get('ma_sach')
    ten_sach = request.args.get('ten_sach')
    tac_gia = request.args.get('tac_gia')
    gia_batDau = request.args.get('gia_batDau')
    gia_ketThuc = request.args.get('gia_ketThuc')
    sach = utils.timKiem_Sach(ma_sach=ma_sach, ten_sach=ten_sach, tac_gia=tac_gia, gia_batDau=gia_batDau, gia_ketThuc=gia_ketThuc)
    return render_template('book-list.html',
                           sach=sach, ma_sach=ma_sach)

#xem thông tin chi tiết một cuốn sách
@app.route('/sach/<int:ma_sach>')
def chitiet_Sach(ma_sach):
    cuon_sach = utils.thongtinSach_theoMaSach(ma_sach=ma_sach)
    return render_template('book-detail.html',
                           cuon_sach=cuon_sach)



#đăng nhập khách hàng
@app.route('/login-user', methods=['POST', 'GET'])
def dangNhap():
    thong_bao = ""
    if request.method == 'POST':
        TenDangNhap = request.form.get('TenDangNhap')
        MatKhau = request.form.get('MatKhau', '')
        matKhau = hashlib.md5(MatKhau.encode('utf-8')).hexdigest()

        nguoiDung = KhachHang.query.filter(KhachHang.TenDangNhap == TenDangNhap.strip(),
                             KhachHang.MatKhau == matKhau).first()
        if nguoiDung:
            login_user(user=nguoiDung)
            if "next" in request.args:
                return redirect(request.args.get('next'))
            else:
                return redirect(url_for("trangChu"))
        else:
            thong_bao = "Đăng nhập không thành công!"


    return render_template("login_user.html", thong_bao=thong_bao)

#đăng nhập trang admin
@app.route('/login', methods=['GET', 'POST'])
def dangNhapAdmin():
    if request.method == 'POST':
        TenDangNhap = request.form.get('TenDangNhap')
        MatKhau = request.form.get('MatKhau', '')

        nguoidung_ADMIN = utils.kiemTraDangNhapADMIN(TenDangNhap=TenDangNhap,
                                          MatKhau=MatKhau)
        if nguoidung_ADMIN:
            login_user(user=nguoidung_ADMIN)

    return redirect('/admin')

#đăng xuất khách hàng
@app.route('/dangXuat')
def dangXuat():
    logout_user()
    return redirect(url_for('trangChu'))

#đăng ký khách hàng
@app.route('/dangKyKhachHang', methods=['get', 'post'])
def dangKyKhachHang():
    thong_bao = ""
    if request.method == 'POST':
        matKhau = request.form.get('MatKhau')
        xacNhanMatKhau = request.form.get('xacNhanMatKhau')
        if matKhau == xacNhanMatKhau:
            soDT = request.form.get('soDT')
            Ho = request.form.get('Ho')
            Ten = request.form.get('Ten')
            Email = request.form.get('Email')
            TenDangNhap = request.form.get('TenDangNhap')
            GioiTinh = request.form.get('GioiTinh')
            HinhAnh = request.files["avatar"]

            duongDan_HinhAnh = 'images/upload/%s' % HinhAnh.filename
            HinhAnh.save(os.path.join(app.root_path, 'static/', duongDan_HinhAnh))

            if utils.themKhachHang(Ho=Ho, Ten=Ten, Email=Email, SoDT=soDT,
                                   TenDangNhap=TenDangNhap, GioiTinh=GioiTinh,
                                   MatKhau=matKhau, HinhAnh=duongDan_HinhAnh):
                return redirect('/')
            else:
                thong_bao = "Hệ thống đang lỗi ... Vui lòng quay lại sau!"
        else:
            thong_bao = "Mật khẩu sai!"

    return render_template('registerCustomer.html', thong_bao=thong_bao)


#xét các account khách hàng để đăng nhập sau khi đăng ký
@login.user_loader
def xet_taiKhoan(ma_KH):
    return utils.duyet_taiKhoan(ma_KH=ma_KH)

#thêm sách vào giỏ hàng
@app.route('/api/cart', methods=['post'])
def them_vao_gio_hang():
    if 'cart' not in session:
        session['cart'] = {}

    cart = session['cart']

    data = json.loads(request.data)
    STT = str(data.get("STT"))
    Ten = data.get("Ten")
    Gia = data.get("Gia")

    if STT in cart:
        cart[STT]["soLuong"] = cart[STT]["soLuong"] + 1
    else:
        cart[STT] = {
            "STT": STT,
            "Ten": Ten,
            "Gia": Gia,
            "soLuong": 1
        }

    session['cart'] = cart

    tongSoLuong, tongTien = utils.tinhTongTien_SoLuong(cart)

    return jsonify({
        "tongSoLuong": tongSoLuong,
        "tongTien": tongTien
    })

#thanh toán giỏ hàng
@app.route('/payment')
@decorator.login_required
def chuyenSang_thanhToan():
    tongSoLuong, tongTien = utils.tinhTongTien_SoLuong(session.get('cart'))
    return render_template('payment.html',
                           tongSoLuong=tongSoLuong, tongTien=tongTien)

#ghi nhận thanh toán
@app.route('/api/pay', methods=['post'])
def ghiNhan_thanhToan():
    if utils.ghiNhanHoaDon(session.get('cart')):
        del session['cart']
        return jsonify({'message': 'Ghi nhận phiếu mua hàng thành công!'})

    return jsonify({'message': 'Lỗi!'})

#xóa một sản phẩm trong giỏ hàng
@app.route('/api/cart/<item_id>', methods=['delete'])
def xoaSanPham_trongGioHang(item_id):
    if 'cart' in session:
        cart = session['cart']
        if item_id in cart:
            del cart[item_id]
            session['cart'] = cart

            return jsonify({'err_msg': 'Xóa thành công!', 'code': 200, 'item_id': item_id})
        return jsonify({'err_msg': 'Xóa không thành công!', 'code': 500})


#cập nhật thông tin sản phẩm trong giỏ hàng
@app.route('/api/cart/<item_id>', methods=['post'])
def capNhatSanPham_trongGioHang(item_id):
    if 'cart' in session:
        cart = session['cart']
        data = request.json
        if item_id in cart and 'soLuong' in data:
            cart[item_id]['soLuong'] = int(data['soLuong'])
            session['cart'] = cart
            tongSoLuong, tongTien = utils.tinhTongTien_SoLuong(session.get('cart'))


            return jsonify({'err_msg': 'Cập nhật thành công!',
                            'code': 200,
                            'tongSoLuong': tongSoLuong,
                            'tongTien': tongTien})
    return jsonify({'err_msg': 'Cập nhật không thành công!', 'code': 500})

if __name__ == '__main__':
    app.run(debug=True)
