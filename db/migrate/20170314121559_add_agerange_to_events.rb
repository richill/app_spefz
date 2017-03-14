class AddAgerangeToEvents < ActiveRecord::Migration
  def change
    add_column :events, :agerange_info, :string
    add_column :events, :agerange, :boolean
  end
end
