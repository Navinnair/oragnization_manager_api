class CreateCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :companies do |t|
      t.string  :name
      t.string  :identification_number
      t.string  :location
      t.integer :required_employee_count
      t.references :parent, foreign_key: { to_table: :companies }
      t.timestamps
    end

    add_index :companies, :identification_number, unique: true
  end
end
