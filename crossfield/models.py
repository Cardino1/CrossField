from __future__ import annotations

from datetime import datetime
from typing import Iterable, List

from flask_login import UserMixin
from werkzeug.security import check_password_hash, generate_password_hash

from . import db


class User(UserMixin, db.Model):
    __tablename__ = "users"

    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(80), unique=True, nullable=False)
    email = db.Column(db.String(120), unique=True, nullable=False)
    password_hash = db.Column(db.String(256), nullable=False)
    organization = db.Column(db.String(120))
    expertise = db.Column(db.String(120))
    bio = db.Column(db.Text)
    collaboration_message = db.Column(db.Text)
    is_looking_for_collaborators = db.Column(db.Boolean, default=False)
    created_at = db.Column(db.DateTime, default=datetime.utcnow, nullable=False)

    datasets = db.relationship("Dataset", back_populates="owner", lazy=True)

    def set_password(self, password: str) -> None:
        self.password_hash = generate_password_hash(password)

    def check_password(self, password: str) -> bool:
        return check_password_hash(self.password_hash, password)


class DatasetType(db.Model):
    __tablename__ = "dataset_types"

    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(80), unique=True, nullable=False)
    description = db.Column(db.Text)
    created_at = db.Column(db.DateTime, default=datetime.utcnow, nullable=False)

    datasets = db.relationship("Dataset", back_populates="dataset_type", lazy=True)

    DEFAULT_TYPES: List[str] = [
        "Biotech",
        "Climate",
        "Healthcare",
        "Fintech",
    ]

    @classmethod
    def seed_defaults(cls) -> None:
        existing_names: Iterable[str] = {type_.name for type_ in cls.query.all()}
        for name in cls.DEFAULT_TYPES:
            if name not in existing_names:
                db.session.add(cls(name=name))
        db.session.commit()


class Dataset(db.Model):
    __tablename__ = "datasets"

    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(120), nullable=False)
    description = db.Column(db.Text)
    dataset_type_id = db.Column(db.Integer, db.ForeignKey("dataset_types.id"), nullable=False)
    owner_id = db.Column(db.Integer, db.ForeignKey("users.id"), nullable=False)
    file_path = db.Column(db.String(255))
    file_original_name = db.Column(db.String(255))
    created_at = db.Column(db.DateTime, default=datetime.utcnow, nullable=False)

    dataset_type = db.relationship("DatasetType", back_populates="datasets")
    owner = db.relationship("User", back_populates="datasets")
