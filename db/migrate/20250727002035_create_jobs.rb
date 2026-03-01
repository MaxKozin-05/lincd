class CreateJobs < ActiveRecord::Migration[7.1]
  def change
    create_table :jobs do |t|
      t.string :title
      t.string :sub_heading
      t.string :category
      t.string :description
      t.integer :salary
      t.string :location

      t.timestamps
    end
  end
end
