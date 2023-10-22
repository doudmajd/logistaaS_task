class CreateBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :books do |t|
      t.string :name
      t.date :release_date, null: false
      t.references :author, foreign_key: true
      t.timestamps
    end
  end
end
