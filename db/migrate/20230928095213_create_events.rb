class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.references :owner, null: false, foreign_key: { to_table: :users }
      t.string :title
      t.string :description
      t.datetime :start_at
      t.datetime :end_at

      t.timestamps
    end
  end
end
