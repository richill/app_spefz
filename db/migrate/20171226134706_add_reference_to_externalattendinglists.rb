class AddReferenceToExternalattendinglists < ActiveRecord::Migration
  def change
    add_column :externalattendinglists, :reference, :string
  end
end
