class AddCategoryTopicIdToSocials < ActiveRecord::Migration
  def change
    add_column :socials, :category_topic_id, :integer
  end
end
