class AddSubjectToActivity < ActiveRecord::Migration[5.0]
  def change
    add_reference :activities, :subject, polymorphic: true
  end
end
