json.array!(@blogs) do |blog|
  json.extract! blog, :id, :title, :content, :image, :user_id, :category_blog_id, :video_link
  json.url blog_url(blog, format: :json)
end
