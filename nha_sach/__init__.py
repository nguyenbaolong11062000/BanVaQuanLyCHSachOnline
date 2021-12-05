from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_admin import Admin
from flask_login import LoginManager
from flask_babelex import Babel #bộ dịch hổ trợ sẵn trong phân hệ admin

app = Flask(__name__)
app.secret_key = '3^@&@&!&(@*UGUIEIU&@^!*(@&*(SS'
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root:Long1162000@@localhost/dbNhaSach1?charset=utf8'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = True

db = SQLAlchemy(app=app)
admin = Admin(app=app, name='Nhà Sách LT',
              template_mode="bootstrap4")
login = LoginManager(app=app)
babel = Babel(app=app)

@babel.localeselector
def get_locale():
        # Phương thức chuyển đổi thành tiếng việt trên các chức năng hoặc tiêu đề trên trang admin('địa phương hóa')
        return 'vi'