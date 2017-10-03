class CreateEntries < ActiveRecord::Migration[5.1]
  def change
    create_table :entries do |t|
      t.string :title
      t.text :body
      t.integer :blog_id

      t.timestamps
    end
  end
end
