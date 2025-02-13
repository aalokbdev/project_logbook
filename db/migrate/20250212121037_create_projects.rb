class CreateProjects < ActiveRecord::Migration[8.0]
  def change
    create_table :projects do |t|
      t.string :name, null: false
      t.text :details
      t.references :creator, null: false, foreign_key: { to_table: :users }
      t.integer :current_status, null: false, default: 0
      t.timestamps
    end
  end
end
