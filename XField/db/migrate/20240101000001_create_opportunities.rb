# frozen_string_literal: true

class CreateOpportunities < ActiveRecord::Migration[7.1]
  def change
    create_table :opportunities do |t|
      t.integer :opportunity_type, null: false
      t.string :title, null: false
      t.string :full_name, null: false
      t.string :organization, null: false
      t.text :description, null: false
      t.string :link
      t.integer :status, default: 0, null: false

      t.timestamps
    end
  end
end
