# CrossField

CrossField is a community-driven hub for exploring, sharing, and collaborating on research datasets. The application ships with default dataset categories for biotech, climate, healthcare, and fintech data, and allows authenticated users to introduce new dataset types as the catalog grows.

## Features

- User registration, login, and logout flows backed by Flask-Login.
- Explore datasets by category with filter controls and detailed dataset pages.
- Upload dataset files and descriptions, with secure storage in the `uploads/` directory.
- Manage dataset types and add new categories beyond the built-in biotech, climate, healthcare, and fintech types.
- Collaboration hub where researchers can signal that they are looking for partners, share bios, and search for potential collaborators.

## Getting started

1. Create a virtual environment and install the dependencies:

   ```bash
   python -m venv .venv
   source .venv/bin/activate
   pip install -r requirements.txt
   ```

2. Run the application:

   ```bash
   flask --app app run --debug
   ```

   The first launch creates the SQLite database (`crossfield.db`) and seeds the default dataset types automatically.

3. Visit http://127.0.0.1:5000/ to explore CrossField.

Uploaded dataset files are stored in `crossfield/uploads/`, which is ignored by Git.
