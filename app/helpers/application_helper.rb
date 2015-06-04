module ApplicationHelper
  def title new_title = nil
    if new_title.present?
      provide(:title, new_title)
      return new_title
    else
      return content_for(:title)
    end
  end

  def full_title
    [ title, "AvlBet.Me" ].reject(&:blank?).join(' - ')
  end
end
