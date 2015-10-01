module ActivitiesHelper

  # использовать с Feed::StakeCreate и Feed::StakeUpdate
  def activity_stake_user_link activity
    if activity.stake.present?
      activity_user_link activity.stake.user
    else
      activity_stake_user_name activity
    end
  end

  def activity_user_link user
    link_to user do
      user.name
    end
  end

  def activity_stake_user_name activity
    activity.stake_user_name
  end

  def activity_bet_link activity
    if activity.bet.present?
      link_to activity.bet do
        activity.bet.title
      end
    else
      activity.bet_title
    end
  end

  def activity_updates activity
    html = ""
    model = activity.class.name.include?('Stake') ? 'stake' : 'bet'
    activity.updates.each do |update|
      html += render_update_details update, model
    end
    html.html_safe
  end

  protected

    def render_update_details update, model
      content = activity_update_content update
      title = t(update.first, scope: "simple_form.labels.#{model}")
      %{
        <button type="button"
          class="btn btn-link btn-xs"
          data-toggle="popover"
          data-placement="auto bottom"
          data-html="true"
          data-content="#{content}">
          #{title}
        </button>
      }
    end

    def activity_update_content update
      if update.first == 'user_id'
        old_data = safe_user_name update.last[0]
        new_data = safe_user_name update.last[1]
      elsif update.first == 'stake_type_id'
        old_data = safe_stake_type_name update.last[0]
        new_data = safe_stake_type_name update.last[1]
      else
        old_data = sanitize update.last[0]
        new_data = sanitize update.last[1]
      end

      content = %{
        Было:
        #{old_data}
        <hr>
        Стало:
        #{new_data}
      }
    end

    def safe_user_name id
      user = User.find id
      user.name
    rescue ActiveRecord::RecordNotFound
      "Пользователь не найден"
    end

    def safe_stake_type_name id
      st = StakeType.find id
      st.title
    rescue ActiveRecord::RecordNotFound
      "Тип ставки не найден"
    end

end
