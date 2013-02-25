class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title

      t.translate_columns do |tc|
        tc.text :body
      end

      t.timestamps
    end
  end
end

