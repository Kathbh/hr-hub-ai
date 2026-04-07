class CreateMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :messages do |t|
      t.references :employee, null: false, foreign_key: true
      t.references :case, null: false, foreign_key: true
      t.text :content
      t.string :sender
      t.string :channel

      t.timestamps
    end
  end
end
