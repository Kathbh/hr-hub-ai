class CreateCases < ActiveRecord::Migration[7.1]
  def change
    create_table :cases do |t|
      t.references :employee, null: false, foreign_key: true
      t.string :category
      t.text :description
      t.integer :status
      t.integer :priority

      t.timestamps
    end
  end
end
