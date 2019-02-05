class AddlinkedinData < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :languageSpoken, :string
  end
end
