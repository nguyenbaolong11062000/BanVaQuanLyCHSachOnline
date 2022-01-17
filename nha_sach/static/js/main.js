function themVaoGioHang(Ma_Sach, Ten, Gia) {
    fetch('/api/gioHang', {
        method: "post",
        body: JSON.stringify({
            "Ma_Sach": Ma_Sach,
            "Ten": Ten,
            "Gia": Gia
        }),
        headers: {
            'Content-Type': 'application/json'
        }
    }).then(res => res.json()).then(data => {
        console.info(data);
        document.getElementById("thongTinGioHang").innerText = data.tongSoLuong;
    }).catch(err => {
        console.log(err);
    })
}

function ghiNhanThanhToan() {
    if(confirm("Bạn có chắc chắn đặt hàng?")){
        fetch('/api/thanhToan', {
        method: "post",
        headers: {
            'Content-Type': 'application/json'
        }
        }).then(res => res.json()).then(data => {
            alert(data.thongBao);
            location.reload();
        }).catch(err => {
            location.href = '/admin?next=/payment';
        })
    }
}


//hàm để xóa sản phẩm
function xoaSanPhamTrongGioHang(ma_sanPham) {
    if(confirm("Bạn có chắc xóa sản phẩm này không?")) {
        fetch(`/api/gioHang/${ma_sanPham}`, {
            'method': 'delete',
            'headers': {
                'Content-Type': 'application/json'
            }
        }).then(res => res.json()).then(data => {
            if(data.code == 200){
                var x = document.getElementById(`item${data.ma_sanPham}`);
                x.style.display = 'none';
                let dem = document.getElementsByClassName('demSoLuong')
                for(let i = 0; i < dem.length; i++)
                    dem[i].innerText = data.tongSoLuong //dùng phương thức "innerText" để gán giá trị Text cho thẻ span
                document.getElementById('tongTien').innerText = new Intl.NumberFormat().format(data.tongTien); //cập nhật bằng ajax chứ không cập nhật bằng reload (F5 lại) trang
            } else {
                alert('Xóa thất bại!');
            }
        }).catch(err => alert('Xóa thất bại!'))
        }
    }
//hàm để cập nhật tổng số lượng và tổng tiền khi thay đổi trên thanh số lượng ở trang hóa đơn thanh toán
function capNhatSanPhamTrongGioHang(obj, ma_sanPham) {
    fetch(`/api/gioHang/${ma_sanPham}`, {
        'method': "post",
        'body': JSON.stringify({
            'soLuong': obj.value
        }),
        'headers': {
            'Content-Type': 'application/json'
        }
        }).then(res => res.json()).then(data => {
            if(data.code != 200)
                alert('Cập nhật thất bại!')
            else{
                let dem = document.getElementsByClassName('demSoLuong')
                for(let i = 0; i < dem.length; i++)
                    dem[i].innerText = data.tongSoLuong //dùng phương thức "innerText" để gán giá trị Text cho thẻ span
                document.getElementById('tongTien').innerText = new Intl.NumberFormat().format(data.tongTien); //cập nhật bằng ajax chứ không cập nhật bằng reload (F5 lại) trang.
            }
        }).catch(err => console.log('Cập nhật thất bại!'));
}

function hienThi() {
    let xemThongTinTG = document.getElementById("popup-tacGia");
    let xemChiTiet = document.querySelector(".popup"); //phương thức này để trả về thành phần đầu tiên
    let nutDong = document.querySelector(".close-btn");
    //Hiển thị popup
    xemThongTinTG.onclick = function(){
        xemChiTiet.style.display = "block"
    }
    // Đóng popup khi ấn vào nút đóng
    nutDong.onclick = function(){
        xemChiTiet.style.display = "none"
    }
    // Đóng popup khi nhấp chuột vào bất kỳ chỗ nào trên màn hình
    window.onclick = function(e){
        if(e.target == xemChiTiet){
            xemChiTiet.style.display = "none"
        }
    }
}
//hàm thêm bình luận
function themBinhLuan(ma_Sach) {
    let noiDung = document.getElementById('binhLuan')
    if (noiDung !== null) {
        fetch('/api/binhLuan', {
            method: 'post',
            body: JSON.stringify({
                'ma_Sach': ma_Sach,
                'noiDung': noiDung.value
            }),
            headers: {
                'Content-Type': 'application/json'

            }
        }).then(res => res.json()).then(data => {
            if(data.code == 201){
                let c = data.BinhLuan

                let vungBinhLuan = document.getElementById('hienThiBinhLuan')
                vungBinhLuan.innerHTML = `
                      <div class="row">
                          <div class="col-md-2 col-xs-4">
                              <img src="${c.KH.anhDaiDien}" class="img-fluid rounded-circle" alt="binhLuan"/>
                          </div>
                          <div class="col-md-10 col-xs-8" id="chiTietBinhLuan">
                              <p>${c.KH.TenKH}</p>
                              <p>${c.noiDung}</p>
                              <p><em>${moment(c.ngayTao).locale('vi').fromNow()}</em></p>
                      </div>
                ` + vungBinhLuan.innerHTML // dấu `` trong javascript dùng để cộng chuỗi bất kì
            } else if(data.code == 404)
                alert(data.thongBao)
        })
    }
}