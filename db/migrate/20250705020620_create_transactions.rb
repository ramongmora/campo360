class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions do |t|
      t.decimal :amount
      t.string :kind
      t.string :status
      t.date :date
      t.text :notes
      t.references :transactionable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
