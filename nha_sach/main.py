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


@app.route('/gioi-thieu')
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
    sach = utils.timKiem_Sach(ma_sach=ma_sach, ten_sach=ten_sach,
                              tac_gia=tac_gia, gia_batDau=gia_batDau, gia_ketThuc=gia_ketThuc)
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
            thong_bao = "Sai tên đăng nhập hoặc mật khẩu. Vui lòng đăng nhập lại!"


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
            HinhAnh = request.files["hinhDaiDien"]

            duongDan_HinhAnh = 'images/upload/%s' % HinhAnh.filename
            HinhAnh.save(os.path.join(app.root_path, 'static/', duongDan_HinhAnh))

            if utils.themKhachHang(Ho=Ho, Ten=Ten, Email=Email, SoDT=soDT,
                                   TenDangNhap=TenDangNhap, GioiTinh=GioiTinh,
                                   MatKhau=matKhau, HinhAnh=duongDan_HinhAnh):
                return redirect('/')
            else:
                thong_bao = "Hệ thống đang lỗi ... Vui lòng quay lại sau!"
        else:
            thong_bao = "Mật khẩu xác nhận không đúng!"

    return render_template('registerCustomer.html', thong_bao=thong_bao)


#xét các account khách hàng để đăng nhập sau khi đăng ký
@login.user_loader
def xet_taiKhoan(ma_KH):
    return utils.duyet_taiKhoan(ma_KH=ma_KH)

#thêm sách vào giỏ hàng
@app.route('/api/gioHang', methods=['post'])
def them_vao_gio_hang():
    if 'gioHang' not in session:
        session['gioHang'] = {}

    gioHang = session['gioHang']

    duLieu = json.loads(request.data)
    Ma_Sach = str(duLieu.get("Ma_Sach"))
    Ten = duLieu.get("Ten")
    Gia = duLieu.get("Gia")

    if Ma_Sach in gioHang:
        gioHang[Ma_Sach]["soLuong"] = gioHang[Ma_Sach]["soLuong"] + 1
    else:
        gioHang[Ma_Sach] = {
            "Ma_Sach": Ma_Sach,
            "Ten": Ten,
            "Gia": Gia,
            "soLuong": 1
        }

    session['gioHang'] = gioHang

    tongSoLuong, tongTien = utils.tinhTongTien_SoLuong(gioHang)

    return jsonify({
        "tongSoLuong": tongSoLuong,
        "tongTien": tongTien
    })

#thanh toán giỏ hàng
@app.route('/donDatHang')
def chuyenSang_thanhToan():
    tongSoLuong, tongTien = utils.tinhTongTien_SoLuong(session.get('gioHang'))
    return render_template('payment.html',
                           tongSoLuong=tongSoLuong, tongTien=tongTien)

#ghi nhận thanh toán
@app.route('/api/thanhToan', methods=['post'])
def ghiNhan_thanhToan():
    if utils.ghiNhanHoaDon(session.get('gioHang')):
        del session['gioHang']
        return jsonify({'thongBao': 'Ghi nhận đơn đặt hàng thành công!'})

    return jsonify({'thongBao': 'Không có sản phẩm để thanh toán! Vui lòng quay lại chọn sản phẩm'})

#xóa một sản phẩm trong giỏ hàng
@app.route('/api/gioHang/<ma_sanPham>', methods=['delete'])
def xoaSanPham_trongGioHang(ma_sanPham):
    if 'gioHang' in session:
        gioHang = session['gioHang']
        if ma_sanPham in gioHang:
            del gioHang[ma_sanPham]
            session['gioHang'] = gioHang
            tongSoLuong, tongTien = utils.tinhTongTien_SoLuong(session.get('gioHang'))


            return jsonify({'code': 200,
                            'ma_sanPham': ma_sanPham,
                            'tongSoLuong': tongSoLuong,
                            'tongTien': tongTien})
        return jsonify({'code': 500})


#cập nhật thông tin sản phẩm trong giỏ hàng
@app.route('/api/gioHang/<ma_sanPham>', methods=['post'])
def capNhatSanPham_trongGioHang(ma_sanPham):
    if 'gioHang' in session:
        gioHang = session['gioHang']
        duLieu = request.json
        if ma_sanPham in gioHang and 'soLuong' in duLieu:
            gioHang[ma_sanPham]['soLuong'] = int(duLieu['soLuong'])
            session['gioHang'] = gioHang
            tongSoLuong, tongTien = utils.tinhTongTien_SoLuong(session.get('gioHang'))


            return jsonify({'code': 200,
                            'tongSoLuong': tongSoLuong,
                            'tongTien': tongTien})
    return jsonify({'code': 500})

if __name__ == '__main__':
    app.run(debug=True)
