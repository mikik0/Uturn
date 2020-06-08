class AddContributionIdToComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :contribution_id, :integer
  end
end
