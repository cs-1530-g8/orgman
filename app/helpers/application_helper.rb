module ApplicationHelper
  # Returns the full title on a per-page basis
  def full_title(page_title)
    base_title = "Orgman"
    if page_title.empty?
      base_title
    else
      "#{base_title} - #{page_title}"
    end
  end

  # Easily format dates in a single method for the entire application
  def format_date(date)
    date.strftime("%b #{date.day.ordinalize}, %Y")
  end
end
