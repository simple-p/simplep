class CreateTeams < ActiveRecord::Migration[5.0]
	def change
		create_table :teams do |t|
			t.string :name, index: true
			t.text :description
			t.integer :owner_id

			t.timestamps
		end
	end
end
