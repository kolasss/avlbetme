ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

require "minitest/reporters"
Minitest::Reporters.use!

require 'webmock/minitest'

# WebMock.disable_net_connect!(:allow_localhost => true)
# WebMock.allow_net_connect!

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

end

class ActionController::TestCase
  include Sorcery::TestHelpers::Rails::Controller
end

class ActionDispatch::IntegrationTest

  private
    def stub_oauth_vk
      stub_request(:post, "https://oauth.vk.com/access_token").
        with(:body => {
          client_id: "4927976",
          client_secret: "fgIlsrt0B4Cp9Hdk3rqY",
          code: "depp",
          grant_type: "authorization_code",
          redirect_uri: "http://localhost:3000/oauth/callback?provider=vk"
        }).to_return(:status => 200,
          :body => '{"access_token":"depp_token","expires_in":86399,"user_id":11}',
          :headers => {
            'Content-Type' => 'application/json'
          })

      stub_request(:get, "https://api.vk.com/method/getProfiles?access_token=depp_token&fields=full_name,photo_100&scope=friends&uids=11").
        with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Authorization'=>'Bearer depp_token', 'User-Agent'=>'Faraday v0.9.1'}).
        to_return(:status => 200,
          :body => '{"response":[{"uid":"11","full_name":"Павел Дуров", "photo_100":"http:\/\/cs109.vkontakte.ru\/u00001\/c_df2abf56.jpg"}]}',
          :headers => {
            'Content-Type' => 'application/json'
          })
    end

    def login user_name
      stub_oauth_vk
      open_session do |sess|
        u = users(user_name)
        sess.https!
        sess.get "/oauth/callback?provider=vk&code=#{user_name}"
        sess.https!(false)
      end
    end
end
