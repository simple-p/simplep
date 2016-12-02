class AddPositionToTasks < ActiveRecord::Migration[5.0]
  def change
    add_column :tasks, :position, :integer
    Task.order(:position).each.with_index(1) do |task, pos|
      task.update_column :position, pos
    end
  end
end
