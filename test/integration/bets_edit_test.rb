require 'test_helper'

class BetsEditTest < ActionDispatch::IntegrationTest

  def setup
    # initialize user session
    @depp = login_session(:depp)
    @bet = bets(:opened)
  end

  test "unsuccessful edit" do
    @depp.get edit_bet_path(@bet)
    @depp.assert_template 'bets/edit'

    @depp.patch bet_path(@bet), bet: {
      title: ""
    }

    @depp.assert_template 'bets/edit'
    @depp.assert_select 'div.has-error'
  end

  test "successful edit" do
    new_title = "new valid title"
    new_body = 'olololo hehe'
    @depp.patch bet_path(@bet), bet: {
      title: new_title,
      body: new_body
    }

    @depp.assert_not @depp.flash.empty?
    @depp.assert_redirected_to @bet

    @bet.reload
    assert_equal @bet.title, new_title
    assert_equal @bet.body,  new_body
  end
end
