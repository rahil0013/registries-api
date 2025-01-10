class CreateRegistries < ActiveRecord::Migration[8.0]
  def change
    create_table :registries do |t|
      t.string :source
      t.string :destination
      t.integer :status, default: 0, null: false
      t.boolean :confidential
      t.timestamps
    end
  end
end
