class CreateInteractionLogs < ActiveRecord::Migration[8.0]
  def change
    create_table :interaction_logs do |t|
      t.references :user, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true
      t.string :type
      t.integer :previous_stage
      t.integer :current_stage
      t.text :feedback

      t.timestamps
    end
  end
end
