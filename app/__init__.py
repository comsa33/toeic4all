from flask import Flask
from flask_sqlalchemy import SQLAlchemy
import json

db = SQLAlchemy()


def create_app():
    app = Flask(__name__, template_folder='../templates', static_folder='../static')
    app.jinja_env.globals.update(enumerate=enumerate)
    app.jinja_env.globals.update(zip=zip)
    app.jinja_env.globals.update(len=len)

    # Load configurations
    with open('config.json') as f:
        config = json.load(f)

    app.config['SQLALCHEMY_DATABASE_URI'] = config['DATABASE_URL']
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

    db.init_app(app)

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
