class CreatePolicies < ActiveRecord::Migration[7.1]
  def change
    create_table :policies do |t|
      t.string :title
      t.text :body
      t.string :category
      t.string :country
      t.string :tags
      t.string :visibility
      t.date :last_updated

      t.timestamps
    end
  end
end
