require 'test_helper'

class IconsHelperTest < ActionView::TestCase
  include FontAwesome::Rails::IconHelper

  test "icon_close helper" do
    dismiss = 'alert'
    html = icon_close dismiss
    expected_html = "<button class=\"close\" data-dismiss=\"#{dismiss}\"><i class=\"fa fa-times-circle\"></i></button>"
    assert_equal expected_html, html
  end

  test "boolean_icon helper" do
    html = boolean_icon true
    assert_equal '<i class="fa fa-check text-success"></i>', html
    html = boolean_icon false
    assert_equal '<i class="fa fa-times text-danger"></i>', html
  end

  test "edit_link helper" do
    path = bet_path bets(:finished)
    html = edit_link path
    edit_title = t('common.edit')
    expected_html = "<a title=\"#{edit_title}\" href=\"#{path}\"><i class=\"fa fa-pencil fa-lg\"></i></a>"
    assert_equal expected_html, html
  end

  test "remove_link helper" do
    path = bet_path bets(:finished)
    html = remove_link path
    remove_title = t('common.delete')
    confirm_text = t('messages.confirm_deletion')
    expected_html = "<a title=\"#{remove_title}\" data-method=\"delete\" data-confirm=\"#{confirm_text}\" class=\"text-danger\" href=\"#{path}\"><i class=\"fa fa-trash-o fa-lg\"></i></a>"
    assert_equal expected_html, html
  end
end

