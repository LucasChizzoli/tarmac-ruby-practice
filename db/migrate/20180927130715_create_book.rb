class CreateBook < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :isbn
      t.string :title
      t.string :publisher
      t.string :releaseDate
      t.string :website
  	end
  end

  def up
  	create_table :books do |t|
      t.string :isbn
      t.string :title
      t.string :publisher
      t.string :releaseDate
      t.string :website
  	end
  end

  def down
  	drop_table :books
  end
end
