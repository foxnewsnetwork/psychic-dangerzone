class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :title
      t.string :slug
      t.text :content
      t.integer :user_id

      t.timestamps
    end
    add_index :blogs, :slug, :unique => true
  end
end
