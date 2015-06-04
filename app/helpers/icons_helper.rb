module IconsHelper
  # def icon_link name, href, options = {}
  #   link_to href, options do
  #     fa_icon name
  #   end
  # end

  def edit_link href, options = {}
    defaults = {
      title: t('common.edit')
    }
    options.deep_merge! defaults
    link_to href, options do
      fa_icon 'pencil lg'
    end
  end

  def remove_link href, options = {}
    defaults = {
      title: t('common.delete'),
      data: {
        method: :delete,
        confirm: t('messages.confirm_deletion')
      },
      class: 'text-danger'
    }
    options.deep_merge! defaults
    link_to href, options do
      fa_icon 'ban lg'
    end
  end

  # def new_link href, options = {title: t('common.create'), class: "icon-new"}
  #   link_to href, options do
  #     fa_icon 'plus-circle'
  #   end
  # end

  def icon_close dismiss = ''
    content_tag :button, class: 'close', data: { dismiss: dismiss } do
      fa_icon 'times-circle'
    end
  end

  def boolean_icon bool
    if bool
      fa_icon 'check', class: 'text-success'
    else
      fa_icon 'times', class: 'text-danger'
    end
  end

  # def xlsx_link
  #   link_to params.merge(format: :xlsx), title: "Экспорт в Excel" do
  #     fa_icon 'file-excel-o'
  #   end
  # end
end
