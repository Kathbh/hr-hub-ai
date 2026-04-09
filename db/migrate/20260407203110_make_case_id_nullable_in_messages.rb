class MakeCaseIdNullableInMessages < ActiveRecord::Migration[7.1]
  def change
    change_column_null :messages, :case_id, true
  end
end

