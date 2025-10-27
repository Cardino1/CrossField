# frozen_string_literal: true

class CreateArticles < ActiveRecord::Migration[7.1]
  def change
    create_table :articles do |t|
      t.string :title, null: false
      t.string :author, null: false
      t.text :summary, null: false
      t.text :content, null: false
      t.datetime :published_at, null: false
      t.string :link

      t.timestamps
    end
  end
end
