class AddReferenceToEvents < ActiveRecord::Migration
  def change
    add_column :events, :reference, :string
  end
end
