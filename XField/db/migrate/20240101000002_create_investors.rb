# frozen_string_literal: true

class CreateInvestors < ActiveRecord::Migration[7.1]
  def change
    create_table :investors do |t|
      t.string :firm_name, null: false
      t.text :values, null: false
      t.text :thesis, null: false
      t.text :portfolio_highlights
      t.text :request_for_startups, null: false
      t.string :website
      t.string :contact_email

      t.timestamps
    end
  end
end
