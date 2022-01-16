from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_admin import Admin
from flask_login import LoginManager
from flask_babelex import Babel #bộ dịch hổ trợ sẵn trong phân hệ admin
import cloudinary

app = Flask(__name__)
app.secret_key = '3^@&@&!&(@*UGUIEIU&@^!*(@&*(SS'
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root:Long1162000@@localhost/dbNhaSach1?charset=utf8'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = True
app.config['KICHTHUOC_BINHLUAN'] = 5

db = SQLAlchemy(app=app)
admin = Admin(app=app, name='Nhà Sách LT',
              template_mode="bootstrap4")
login = LoginManager(app=app)
babel = Babel(app=app)

@babel.localeselector
def get_locale():
        # Phương thức chuyển đổi thành tiếng việt trên các chức năng hoặc tiêu đề trên trang admin('địa phương hóa')
        return 'vi'

cloudinary.config(
    cloud_name='dkoppuet4',
    api_key='964675496746215',
    api_secret='ge0wUB1-0VcoZ1Dj9LyhpZpqYME'
)