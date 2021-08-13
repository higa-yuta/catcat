ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'minitest/reporters'

Minitest::Reporters.use!

class ActiveSupport::TestCase
  parallelize(workers: :number_of_processors)

  fixtures :all
  include ApplicationHelper
  
  # テストユーザーがログインしている場合はtrueを返す
  def is_logged_in?
    !session[:user_id].nil?
  end

  class ActionDispatch::IntegrationTest
    # テストユーザーをログインする
    def log_in_as(user, password: 'password', remember_me: '1')
      post login_path, params: { session: { email: user.email,
                                            password: password,
                                            remember_me: remember_me}}
    end
  end
  
end
