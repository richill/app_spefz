module ApplicationHelper
  # Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = "Spefz"
    if page_title.empty?
      base_title
    else
      base_title + " | " + page_title
    end
  end

  def active_page(active_page)
    @active == active_page ? "active" : ""
  end

  def is_active?(page_name)
    "active" if params[:action] == page_name
  end
end
