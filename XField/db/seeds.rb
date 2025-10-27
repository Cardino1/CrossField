# frozen_string_literal: true

puts "Seeding sample data for XField..."

Article.find_or_create_by!(title: "Welcome to XField") do |article|
  article.author = "XField Editorial"
  article.summary = "We are on a mission to spotlight innovators, researchers, and collaborators building the future of technology."
  article.content = <<~TEXT
    From curated opportunities across jobs, research collaborations, and open source initiatives to investor spotlights, XField is your home for discovering what is next in tech.
  TEXT
  article.published_at = Time.current
  article.link = "https://example.com/articles/welcome-to-xfield"
end

Opportunity.find_or_create_by!(title: "Founding Machine Learning Engineer") do |opportunity|
  opportunity.opportunity_type = :jobs
  opportunity.full_name = "Ava Founder"
  opportunity.organization = "Orbit Labs"
  opportunity.description = "Help us build infrastructure for synthetic data generation as our first ML hire."
  opportunity.link = "https://example.com/opportunities/ml"
  opportunity.status = :published
end

Investor.find_or_create_by!(firm_name: "North Star Ventures") do |investor|
  investor.values = "We believe in technical founders who obsess over product craft."
  investor.thesis = "Pre-seed and seed investments in developer tools, AI, and frontier compute."
  investor.portfolio_highlights = "Launchpad AI, Quantum Works, Lumen Robotics"
  investor.request_for_startups = "Infra for GenAI, security tooling, and AI-native productivity."
  investor.website = "https://northstar.vc"
  investor.contact_email = "hello@northstar.vc"
end

User.find_or_create_by!(email: "founders@xfield.example")

puts "Seeding complete."
