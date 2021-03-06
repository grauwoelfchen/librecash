class CreateFinanceAccounts < ActiveRecord::Migration
  def change
    create_table :finance_accounts do |t|
      t.belongs_to :ledger,      null: false, index: true
      t.string     :name,        null: false
      t.string     :description, null: true
      t.text       :memo

      t.timestamps null: false
    end
  end
end
