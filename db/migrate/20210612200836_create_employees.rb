class CreateEmployees < ActiveRecord::Migration[6.0]
  def change
    create_table :employees do |t|
      t.string  :name
      t.string  :identification_number
      t.references :company
      t.timestamps
    end

    add_index :employees, :identification_number, unique: true
  end
end
