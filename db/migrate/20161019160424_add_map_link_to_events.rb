class AddMapLinkToEvents < ActiveRecord::Migration
  def change
    add_column :events, :maplink, :text
  end
end
