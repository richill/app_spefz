class CreateCategoryInviteoptions < ActiveRecord::Migration
  def change
    create_table :category_inviteoptions do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
