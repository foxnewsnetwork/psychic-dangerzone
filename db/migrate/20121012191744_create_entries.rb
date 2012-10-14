class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :header
      t.string :image
      t.string :hyperlink
      t.integer :user_id

      t.timestamps
    end
  end
end
