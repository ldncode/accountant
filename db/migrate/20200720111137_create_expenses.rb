class CreateExpenses < ActiveRecord::Migration[6.0]
  def change
    create_table :expenses do |t|
      t.string :title
      t.integer :value, default: 0
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
