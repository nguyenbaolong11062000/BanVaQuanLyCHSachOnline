import hashlib

from flask import render_template, request, url_for, session, jsonify
from nha_sach import app, login, utils, decorator
from nha_sach.admin import *
from flask_login import login_user
import os, json

from nha_sach.models import KhachHang


@app.route('/')
def index():
    return render_template('index.html')

@app.route('/privacy-policy')
def pri_policy():
    return render_template('privacy-policy.html')


@app.route('/about-us')
def about_us():
   return render_template('about-us.html')

#duyệt danh sách các loại sách
@app.route('/book')
@decorator.login_required
def book_list():
    tpbook_id = request.args.get('typeofbook_id')
    #typebook = request.args.get('typebook')
    kw = request.args.get('kw')
    kw2 = request.args.get('kw2')
    from_price = request.args.get('from_price')
    to_price = request.args.get('to_price')
    books = utils.read_books(tpbook_id=tpbook_id, kw=kw, kw2=kw2, from_price=from_price, to_price=to_price)
    return render_template('book-list.html',
                           books=books, tpbook_id=tpbook_id)

#xem thông tin chi tiết một cuốn sách
@app.route('/books/<int:book_id>')
def book_detail(book_id):
    book = utils.get_book_by_id(book_id=book_id)
    return render_template('book-detail.html',
                           book=book)

#đăng nhập khách hàng
@app.route('/login-user', methods=['POST', 'GET'])
def login_usr():
    err_msg = ""
    if request.method == 'POST':
        username = request.form.get('username')
        password = request.form.get('password', '')
        password = hashlib.md5(password.encode('utf-8')).hexdigest()

        user = KhachHang.query.filter(KhachHang.TenDangNhap == username.strip(),
                             KhachHang.MatKhau == password).first()
        if user:
            login_user(user=user)
            if "next" in request.args:
                return redirect(request.args.get('next'))
            else:
                return redirect(url_for("index"))
        else:
            err_msg = "Login unsuccessful!"


    return render_template("login_user.html", err_msg=err_msg)

#đăng nhập trang admin
@app.route('/login', methods=['GET', 'POST'])
def login_admin():
    if request.method == 'POST':
        username = request.form.get('username')
        password = request.form.get('password', '')

        user = utils.check_login(username=username,
                                 password=password)
        if user:
            login_user(user=user)

    return redirect('/admin')

#đăng xuất khách hàng
@app.route('/logout')
def logout_usr():
    logout_user()
    return redirect(url_for('index'))

#đăng ký khách hàng
@app.route('/registerCustomer', methods=['get', 'post'])
def registerCustomer():
    err_msg = ""
    if request.method == 'POST':
        password = request.form.get('password')
        confirm = request.form.get('confirm')
        if password == confirm:
            phone = request.form.get('phone')
            name1 = request.form.get('name1')
            name = request.form.get('name')
            email = request.form.get('email')
            username = request.form.get('username')
            gender = request.form.get('gender')
            avatar = request.files["avatar"]

            avatar_path = 'images/upload/%s' % avatar.filename
            avatar.save(os.path.join(app.root_path, 'static/', avatar_path))

            if utils.add_user(name=name, name1=name1, email=email, phone=phone,
                              username=username, gender=gender,
                              password=password, avatar_path=avatar_path):
                return redirect('/')
            else:
                err_msg = "The system is faulty ... Please login again later!"
        else:
            err_msg = "Password incorrect!"

    return render_template('registerCustomer.html', err_msg=err_msg)


#duyệt các account khách hàng và admin để đăng nhập
@login.user_loader
def get_user(user_id):
    return utils.get_user_by_id(user_id=user_id)

#thêm sách vào giỏ hàng
@app.route('/api/cart', methods=['post'])
def cart():
    if 'cart' not in session:
        session['cart'] = {}

    cart = session['cart']

    data = json.loads(request.data)
    id = str(data.get("id"))
    name = data.get("name")
    price = data.get("price")

    if id in cart:
        cart[id]["quantity"] = cart[id]["quantity"] + 1
    else:
        cart[id] = {
            "id": id,
            "name": name,
            "price": price,
            "quantity": 1
        }

    session['cart'] = cart

    quan, price = utils.cart_stats(cart)

    return jsonify({
        "total_amount": price,
        "total_quantity": quan
    })

#thanh toán giỏ hàng
@app.route('/payment')
@decorator.login_required
def payment():
    quan, price = utils.cart_stats(session.get('cart'))
    cart_info = {
        "total_amount": price,
        "total_quantity": quan
    }
    return render_template('payment.html',
                           cart_info=cart_info)

#ghi nhận thanh toán
@app.route('/api/pay', methods=['post'])
def pay():
    if utils.add_receipt(session.get('cart')):
        del session['cart']
        return jsonify({'message': 'Add receipt successful!'})

    return jsonify({'message': 'Failed!'})

#xóa một sản phẩm trong giỏ hàng
@app.route('/api/cart/<item_id>', methods=['delete'])
def delete_book_in_cart(item_id):
    if 'cart' in session:
        cart = session['cart']
        if item_id in cart:
            del cart[item_id]
            session['cart'] = cart

            return jsonify({'err_msg': 'Xóa thành công!', 'code': 200, 'item_id': item_id})
        return jsonify({'err_msg': 'Xóa không thành công!', 'code': 500})


#cập nhật thông tin sản phẩm trong giỏ hàng
@app.route('/api/cart/<item_id>', methods=['post'])
def update_book(item_id):
    if 'cart' in session:
        cart = session['cart']
        data = request.json
        if item_id in cart and 'quantity' in data:
            cart[item_id]['quantity'] = int(data['quantity'])
            session['cart'] = cart
            quan, price = utils.cart_stats(session.get('cart'))


            return jsonify({'err_msg': 'Cập nhật thành công!',
                            'code': 200,
                            'total_quantity': quan,
                            'total_amount': price})
    return jsonify({'err_msg': 'Cập nhật không thành công!', 'code': 500})

if __name__ == '__main__':
    app.run(debug=True)
