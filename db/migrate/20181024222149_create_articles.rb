class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.string :title
      t.string :tagline
      t.text :body
      t.references :user, foreign_key: true

      t.timestamps
    end

    add_index :articles, unique: true
  end
end
