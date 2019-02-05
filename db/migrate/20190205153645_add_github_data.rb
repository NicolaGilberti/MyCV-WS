class AddGithubData < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :ITlanguages, :string
    add_column :users, :biography, :text
  end
end
