class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :description
      t.timestamp :due_date
      t.string :status
      t.references :created_by, null: false, foreign_key: { to_table: 'users' }
      t.references :last_updated_by, null: false, foreign_key: { to_table: 'users' }
      t.timestamps
    end
  end
end
