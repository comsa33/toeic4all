import os

from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_jwt_extended import JWTManager
import json

db = SQLAlchemy()
jwt = JWTManager()


def create_app():
    app = Flask(__name__, template_folder='../templates', static_folder='../static')
    app.secret_key = 'your_secret_key'  # Secret Key를 설정해주세요. 실제 서비스에서는 안전한 값을 사용해야 합니다.

    app.jinja_env.globals.update(enumerate=enumerate)
    app.jinja_env.globals.update(zip=zip)
    app.jinja_env.globals.update(len=len)

    # Load configurations
    with open('config.json') as f:
        config = json.load(f)

    app.config['SQLALCHEMY_DATABASE_URI'] = config['DATABASE_URL']
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
    app.config['JWT_SECRET_KEY'] = os.getenv('JWT_SECRET_KEY')
    app.config['JWT_TOKEN_LOCATION'] = ['headers']
    app.config['JWT_HEADER_NAME'] = 'Authorization'
    app.config['JWT_HEADER_TYPE'] = 'Bearer'

    db.init_app(app)
    jwt.init_app(app)

    # Register blueprints
    from .routes import api, main_bp, board
    app.register_blueprint(api.api, url_prefix='/api')
    app.register_blueprint(board.board, url_prefix='/api/board')
    app.register_blueprint(main_bp)

    from .errors import handlers
    app.register_blueprint(handlers.errors)

    with app.app_context():
        db.create_all()

    return app
