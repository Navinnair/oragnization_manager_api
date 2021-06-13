class CreateCompanyHierarchies < ActiveRecord::Migration[6.0]
  def change
    create_table :company_hierarchies, id: false do |t|
      t.integer :ancestor_id, null: false
      t.integer :descendant_id, null: false
      t.integer :generations, null: false
    end

    add_index :company_hierarchies, [:ancestor_id, :descendant_id, :generations],
      unique: true,
      name: "company_anc_desc_idx"

    add_index :company_hierarchies, [:descendant_id],
      name: "company_desc_idx"
  end
end
