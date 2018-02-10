class SorceryCore < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :crypted_password
      t.string :salt
      t.string :cellphone
      t.timestamps                :null => false
    end

    add_index :users, :email
    add_index :users, :cellphone
  end
end
