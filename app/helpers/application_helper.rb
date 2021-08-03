module ApplicationHelper

  def select_title(page_title = "")
    base_title = "catcat"
    page_title.empty? ? base_title : page_title
  end
  
end
