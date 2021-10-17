function themVaoGioHang(STT, Ten, Gia) {
    fetch('/api/cart', {
        method: "post",
        body: JSON.stringify({
            "STT": STT,
            "Ten": Ten,
            "Gia": Gia
        }),
        headers: {
            'Content-Type': 'application/json'
        }
    }).then(res => res.json()).then(data => {
        console.info(data);
        var cart = document.getElementById("thongTinGioHang");
        cart.innerText = `${data.tongSoLuong} - ${data.tongTien} VNĐ`;
    }).catch(err => {
        console.log(err);
    })
}

function ghiNhanThanhToan() {
    if(confirm("Bạn có chắc chắn thanh toán?")){
        fetch('/api/pay', {
        method: "post",
        headers: {
            'Content-Type': 'application/json'
        }
        }).then(res => res.json()).then(data => {
            alert(data.message);
            location.reload();
        }).catch(err => {
            location.href = '/admin?next=/payment';
        })
    }
}


//hàm để xóa sản phẩm
function xoaSanPhamTrongGioHang(item_id) {
    if(confirm("Bạn có chắc xóa sản phẩm này không? Nếu có hãy nhấn OK và sau đó nhấn F5 để hệ thống cập nhật!")) {
        fetch(`/api/cart/${item_id}`, {
            'method': 'delete',
            'headers': {
                'Content-Type': 'application/json'
            }
        }).then(res => res.json()).then(data => {
            if(data.code == 200){
                var x = document.getElementById(`item${data.item_id}`);
                x.style.display = 'none';
            } else {
                alert('Xóa thất bại!');
            }
        }).catch(err => alert('Xóa thất bại!'))
        }
    }
//hàm để cập nhật tổng số lượng và tổng tiền khi thay đổi trên thanh số lượng ở trang hóa đơn thanh toán
function capNhatSanPhamTrongGioHang(obj, item_id) {
    fetch(`/api/cart/${item_id}`, {
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
                document.getElementById('tongSoLuong').innerText = data.tongSoLuong; //dùng phương thức "innerText" để gán giá trị Text cho thẻ span
                document.getElementById('tongTien').innerText = data.tongTien;
            }
        }).catch(err => console.log('Cập nhật thất bại!'));
}

function hienThi() {
    let xemThongTinTG = document.getElementById("popup-author");
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