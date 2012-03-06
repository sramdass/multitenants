class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.integer :tenant_id
      t.string :name
      t.integer :planner_id

      t.timestamps
    end
  end
end
