class CreateCategoryInvites < ActiveRecord::Migration
  def change
    create_table :category_invites do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
