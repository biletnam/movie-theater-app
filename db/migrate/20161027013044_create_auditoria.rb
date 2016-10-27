class CreateAuditoria < ActiveRecord::Migration[5.0]
  def change
    create_table :auditoria do |t|
      t.integer :theater_id
      t.string :name
      t.integer :seating_capacity

      t.timestamps
    end
    add_index :auditoria, :theater_id
  end
end
