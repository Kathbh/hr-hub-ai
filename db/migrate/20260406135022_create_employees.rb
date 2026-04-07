class CreateEmployees < ActiveRecord::Migration[7.1]
  def change
    create_table :employees do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :employee_id
      t.string :job_title
      t.string :department
      t.string :country
      t.string :manager_name
      t.date :hire_date
      t.integer :employment_status

      t.timestamps
    end
  end
end
