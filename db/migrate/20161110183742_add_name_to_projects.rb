class AddNameToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :name, :string
  end
end
