class AddDataManagerModel < ActiveRecord::Migration[5.2]
  def change
    create_table :data_managers do |t|
      t.string :name
      t.string :location
      t.string :gender
      t.string :image
      t.string :email
      t.string :birthday
      t.string :languageSpoken
      t.string :ITlanguages
      t.text :biography
      t.timestamps
    end
  end
end
