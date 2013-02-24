class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body_de
      t.text :body_en
      t.text :body_es

      t.timestamps
    end
  end
end

