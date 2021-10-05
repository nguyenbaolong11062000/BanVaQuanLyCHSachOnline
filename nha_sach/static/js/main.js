function addToCart(id, name, price) {
    fetch('/api/cart', {
        method: "post",
        body: JSON.stringify({
            "id": id,
            "name": name,
            "price": price
        }),
        headers: {
            'Content-Type': 'application/json'
        }
    }).then(res => res.json()).then(data => {
        console.info(data);
        var cart = document.getElementById("cart-info");
        cart.innerText = `${data.total_quantity} - ${data.total_amount} VNĐ`;
    }).catch(err => {
        console.log(err);
    })

    // promise --> await/async
}

function pay() {
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
function del_book_in_cart(item_id) {
    if(confirm("Bạn có chắc xóa sản phẩm này không?")) {
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
function update_book(obj, item_id) {
    fetch(`/api/cart/${item_id}`, {
        'method': "post",
        'body': JSON.stringify({
            'quantity': obj.value
        }),
        'headers': {
            'Content-Type': 'application/json'
        }
        }).then(res => res.json()).then(data => {
            if(data.code != 200)
                alert('Cập nhật thất bại!')
            else{
                document.getElementById('total_quantity').innerText = data.total_quantity; //dùng phương thức "innerText" để lấy giá trị Text trong thẻ span
                document.getElementById('total_amount').innerText = data.total_amount;
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