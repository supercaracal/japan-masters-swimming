class CreateSwimmers < ActiveRecord::Migration[5.0]
  def change
    create_table :swimmers do |t|
      t.references :team, null: false, index: true, foreign_key: true
      t.string     :name, null: false

      t.timestamps
    end

    add_index :swimmers, %i(name team_id), unique: true
  end
end
