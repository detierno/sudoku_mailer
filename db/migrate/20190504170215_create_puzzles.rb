class CreatePuzzles < ActiveRecord::Migration[6.0]
  def change
    create_table :puzzles do |t|
      t.string :sent_by
      t.jsonb :board, null: false

      t.timestamps
    end
  end
end
