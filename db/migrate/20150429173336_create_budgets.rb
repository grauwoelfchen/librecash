class CreateBudgets < ActiveRecord::Migration
  def change
    create_table :budgets do |t|
      t.integer   :account_id,  null: false
      t.string    :title,       null: false
      t.text      :description, null: true,  default: nil
      t.integer   :carryover,   null: false, default: 0
      t.datetime  :approved_at, null: true,  default: nil

      t.timestamps null: false
    end

    add_index :budgets, :account_id
  end
end
