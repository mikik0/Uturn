class CreateContributions < ActiveRecord::Migration[5.2]
  def change
    create_table :contributions do |t|
      t.string :title
      t.string :body
      t.string :course

      t.timestamps null: false
    end
  end
end
