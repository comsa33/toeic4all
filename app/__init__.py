from flask import Flask
from flask_sqlalchemy import SQLAlchemy
import json

db = SQLAlchemy()


def create_app():
    app = Flask(__name__)

    # Load configurations
    with open('config.json') as f:
        config = json.load(f)

    app.config['SQLALCHEMY_DATABASE_URI'] = config['DATABASE_URL']
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

    db.init_app(app)

    # Register blueprints
    from .routes import api
    app.register_blueprint(api, url_prefix='/api')

    from .errors import errors  # Changed this line
    app.register_blueprint(errors)  # And this line

    with app.app_context():
        db.create_all()

    return app
