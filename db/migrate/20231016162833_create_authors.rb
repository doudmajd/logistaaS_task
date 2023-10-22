class CreateAuthors < ActiveRecord::Migration[7.1]
  def change
    create_table :authors do |t|
      t.string :name, null: false
      ## Add any Devise default columns (e.g., email, password) here
      # t.string :email, null: false, default: ""
      # t.string :encrypted_password, null: false, default: ""
      t.timestamps
    end

    # add_index :authors, :email, unique: true
  end
end
