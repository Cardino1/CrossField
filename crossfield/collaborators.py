from flask import Blueprint, flash, redirect, render_template, request, url_for
from flask_login import current_user, login_required

from . import db
from .models import User


collaborators_bp = Blueprint("collaborators", __name__)


@collaborators_bp.route("/collaborators")
def collaborator_directory():
    search = request.args.get("search", "").strip()
    query = User.query.filter_by(is_looking_for_collaborators=True)
    if search:
        query = query.filter(
            (User.username.ilike(f"%{search}%"))
            | (User.expertise.ilike(f"%{search}%"))
            | (User.organization.ilike(f"%{search}%"))
        )
    collaborators = query.order_by(User.created_at.desc()).all()
    return render_template(
        "collaborators.html",
        collaborators=collaborators,
        search=search,
        page_title="Find collaborators",
    )


@collaborators_bp.route("/profile", methods=["GET", "POST"])
@login_required
def profile():
    if request.method == "POST":
        current_user.organization = request.form.get("organization", "").strip() or None
        current_user.expertise = request.form.get("expertise", "").strip() or None
        current_user.bio = request.form.get("bio", "").strip() or None
        current_user.collaboration_message = (
            request.form.get("collaboration_message", "").strip() or None
        )
        current_user.is_looking_for_collaborators = request.form.get("is_looking", "off") == "on"
        db.session.commit()
        flash("Profile updated.", "success")
        return redirect(url_for("collaborators.profile"))

    return render_template("profile.html", page_title="Your profile")
