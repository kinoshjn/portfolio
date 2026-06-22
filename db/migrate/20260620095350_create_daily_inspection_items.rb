class CreateDailyInspectionItems < ActiveRecord::Migration[7.2]
  def change
    create_table :daily_inspection_items do |t|
      t.string :item_name,null: false
      t.string :result,null: false
      t.string :note
      t.references :daily_inspection, foreign_key: true

      t.timestamps
    end
  end
end
