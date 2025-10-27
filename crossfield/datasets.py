import os
from datetime import datetime

from flask import (
    Blueprint,
    current_app,
    flash,
    redirect,
    render_template,
    request,
    send_from_directory,
    url_for,
)
from flask_login import current_user, login_required
from werkzeug.utils import secure_filename

from . import db
from .models import Dataset, DatasetType


datasets_bp = Blueprint("datasets", __name__)


@datasets_bp.route("/")
def dashboard():
    dataset_type_id = request.args.get("type", type=int)
    dataset_query = Dataset.query.order_by(Dataset.created_at.desc())
    if dataset_type_id:
        dataset_query = dataset_query.filter_by(dataset_type_id=dataset_type_id)
    datasets = dataset_query.all()
    dataset_types = DatasetType.query.order_by(DatasetType.name).all()
    selected_type = None
    if dataset_type_id:
        selected_type = DatasetType.query.get(dataset_type_id)

    return render_template(
        "dashboard.html",
        datasets=datasets,
        dataset_types=dataset_types,
        selected_type=selected_type,
        page_title="Explore datasets",
    )


@datasets_bp.route("/datasets/<int:dataset_id>")
def dataset_detail(dataset_id: int):
    dataset = Dataset.query.get_or_404(dataset_id)
    return render_template("dataset_detail.html", dataset=dataset, page_title=dataset.name)


@datasets_bp.route("/datasets/upload", methods=["GET", "POST"])
@login_required
def upload_dataset():
    dataset_types = DatasetType.query.order_by(DatasetType.name).all()
    if request.method == "POST":
        name = request.form.get("name", "").strip()
        description = request.form.get("description", "").strip()
        dataset_type_id = request.form.get("dataset_type", type=int)
        file = request.files.get("dataset_file")

        if not name or not dataset_type_id:
            flash("Name and dataset type are required.", "error")
        elif DatasetType.query.get(dataset_type_id) is None:
            flash("Invalid dataset type selected.", "error")
        else:
            file_path = None
            original_name = None
            if file and file.filename:
                original_name = file.filename
                timestamp = datetime.utcnow().strftime("%Y%m%d%H%M%S%f")
                filename = f"{timestamp}_{secure_filename(file.filename)}"
                storage_path = os.path.join(current_app.config["UPLOAD_FOLDER"], filename)
                file.save(storage_path)
                file_path = filename

            dataset = Dataset(
                name=name,
                description=description,
                dataset_type_id=dataset_type_id,
                owner_id=current_user.id,
                file_path=file_path,
                file_original_name=original_name,
            )
            db.session.add(dataset)
            db.session.commit()
            flash("Dataset uploaded successfully!", "success")
            return redirect(url_for("datasets.dashboard"))

    return render_template(
        "upload_dataset.html",
        dataset_types=dataset_types,
        page_title="Upload a dataset",
    )


@datasets_bp.route("/dataset-types", methods=["GET", "POST"])
@login_required
def manage_dataset_types():
    dataset_types = DatasetType.query.order_by(DatasetType.name).all()
    if request.method == "POST":
        name = request.form.get("name", "").strip()
        description = request.form.get("description", "").strip()
        if not name:
            flash("A name is required to create a dataset type.", "error")
        elif DatasetType.query.filter(db.func.lower(DatasetType.name) == name.lower()).first():
            flash("That dataset type already exists.", "error")
        else:
            dataset_type = DatasetType(name=name, description=description)
            db.session.add(dataset_type)
            db.session.commit()
            flash("Dataset type created.", "success")
            return redirect(url_for("datasets.manage_dataset_types"))

    return render_template(
        "manage_types.html",
        dataset_types=dataset_types,
        page_title="Manage dataset types",
    )


@datasets_bp.route("/uploads/<path:filename>")
@login_required
def download_file(filename: str):
    return send_from_directory(
        current_app.config["UPLOAD_FOLDER"],
        filename,
        as_attachment=True,
        download_name=filename,
    )
