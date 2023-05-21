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
    from .routes import api, main_bp  # Add this line
    app.register_blueprint(api.api, url_prefix='/api')
    app.register_blueprint(main_bp)  # Add this line

    from .errors import handlers  # Changed this line
    app.register_blueprint(handlers.errors)  # And this line

    with app.app_context():
        db.create_all()

    return app
