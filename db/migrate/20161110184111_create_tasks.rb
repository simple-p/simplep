class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.text :name
      t.text :description
      t.integer :owner_id
      t.datetime :due_date
      t.integer :section_id
      t.integer :project_id

      t.timestamps
    end
  end
end
