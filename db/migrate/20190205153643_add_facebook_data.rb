class AddFacebookData < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name, :string
    add_column :users, :image, :text
    add_column :users, :location, :text
    add_column :users, :gender, :string
    add_column :users, :birthday, :string
    add_column :users, :hometown, :string
    add_column :users, :age_range, :int
  end
end
