class CreateResults < ActiveRecord::Migration[5.0]
  def change
    create_table :results do |t|
      t.references :swimmer, null: false, index: true, foreign_key: true
      t.references :event,   null: false, index: true, foreign_key: true
      t.integer    :year,    null: false
      t.float      :time,    null: false

      t.timestamps
    end

    add_index :results, %i[year event_id swimmer_id], unique: true
  end
end
