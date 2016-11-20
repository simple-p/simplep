class AddProjectIdColumnsToTeams < ActiveRecord::Migration[5.0]
  def change
    add_column :teams, :project_id, :integer
  end
end
