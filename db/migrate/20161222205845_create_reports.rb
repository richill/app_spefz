class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.text :content
      t.integer :category_report_id
      t.integer :event_id
      t.integer :social_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
