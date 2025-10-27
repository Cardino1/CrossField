# XField

XField is a Ruby on Rails application that curates technology news, vetted opportunities, and investor partners for the CrossField community.

## Features

- **Home** – Highlights the latest opportunities, featured investors, and news from the editorial team.
- **Opportunities** – Community submissions for jobs, research, open source, and co-founder searches. Submissions require admin approval before publication.
- **Investors** – Venture partners can publish pages describing their values, thesis, portfolio, and requests for startups.
- **News** – Internal team articles with publication dates and outbound links.
- **Get Updates** – Collects subscriber emails for future announcements.
- **Admin Dashboard** – Basic-auth protected area available at `/admin` to manage articles, opportunities, and subscribers.

## Default Admin Credentials

- Username: `Admin`
- Password: `Team111***`

Set the environment variables `XFIELD_ADMIN_USERNAME` and `XFIELD_ADMIN_PASSWORD` to override the defaults in production.

## Running Locally

1. Install Ruby 3.2.3 and Bundler.
2. Install dependencies:
   ```bash
   bundle install
   ```
3. Set up the database:
   ```bash
   bin/rails db:setup
   ```
4. Start the server:
   ```bash
   bin/rails server
   ```
5. Visit `http://localhost:3000` to explore the experience.

## Tests

Execute the test suite with:
```bash
bin/rails test
```
