import os
from datetime import datetime

from flask import Flask
from flask_login import LoginManager
from flask_sqlalchemy import SQLAlchemy


db = SQLAlchemy()
login_manager = LoginManager()


def create_app() -> Flask:
    app = Flask(__name__, instance_relative_config=True)
    app.config.setdefault('SECRET_KEY', os.environ.get('SECRET_KEY', 'dev-secret-key'))
    app.config.setdefault(
        'SQLALCHEMY_DATABASE_URI',
        os.environ.get('DATABASE_URL', 'sqlite:///crossfield.db'),
    )
    app.config.setdefault('SQLALCHEMY_TRACK_MODIFICATIONS', False)

    upload_dir = os.path.join(app.root_path, 'uploads')
    os.makedirs(upload_dir, exist_ok=True)
    app.config['UPLOAD_FOLDER'] = upload_dir

    db.init_app(app)
    login_manager.init_app(app)
    login_manager.login_view = 'auth.login'

    from .models import DatasetType, User  # noqa: F401

    with app.app_context():
        db.create_all()
        DatasetType.seed_defaults()

    from .auth import auth_bp
    from .datasets import datasets_bp
    from .collaborators import collaborators_bp

    app.register_blueprint(auth_bp)
    app.register_blueprint(datasets_bp)
    app.register_blueprint(collaborators_bp)

    @app.context_processor
    def inject_globals():
        return {
            'all_dataset_types': DatasetType.query.order_by(DatasetType.name).all(),
            'current_year': datetime.utcnow().year,
        }

    return app


@login_manager.user_loader
def load_user(user_id: str):
    from .models import User

    return User.query.get(int(user_id))
