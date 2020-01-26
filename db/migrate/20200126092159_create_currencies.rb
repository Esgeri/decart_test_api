class CreateCurrencies < ActiveRecord::Migration[5.2]
  def change
    create_table :currencies do |t|
      t.string :name
      t.decimal :rate, precision: 4, scale: 2, default: 0.0, null: false

      t.timestamps
    end
  end
end
