class AddTeamIdColumnToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :team_id, :integer
  end
end
