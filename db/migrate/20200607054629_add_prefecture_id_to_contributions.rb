class AddPrefectureIdToContributions < ActiveRecord::Migration[5.2]
  def change
    add_column :contributions, :prefecture_id, :integer
  end
end
