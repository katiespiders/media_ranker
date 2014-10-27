class CreateMedia < ActiveRecord::Migration
  def change
    create_table :media do |t|
      t.string :title
      t.string :author
      t.text :description
      t.integer :votes
      t.string :type

      t.timestamps
    end
  end
end
