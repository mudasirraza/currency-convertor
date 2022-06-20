class CreateRates < ActiveRecord::Migration[6.1]
  def change
    create_table :rates do |t|
      t.string :from_currency
      t.string :to_currency
      t.date :date, index: true
      t.decimal :rate

      t.timestamps default: -> { "CURRENT_TIMESTAMP" }
    end
  end
end
