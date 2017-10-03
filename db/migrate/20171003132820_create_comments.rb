class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.text :body
      t.string :status
      t.integer :entry_id

      t.timestamps
    end
  end
end
