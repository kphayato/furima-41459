class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :nickname, null: false
      t.string :email, null: false, unique: true
      t.string :encrypted_password, null: false
      t.string :last_name, null: false
      t.string :first_name, null: false
      t.string :last_name_kana, null: false
      t.string :first_name_kana, null: false
      t.date :birth_date, null: false

      t.timestamps
    end
  end
end