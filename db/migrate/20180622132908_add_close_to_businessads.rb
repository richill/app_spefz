class AddCloseToBusinessads < ActiveRecord::Migration
  def change
    add_column :businessads, :close, :boolean
  end
end
