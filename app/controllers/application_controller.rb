class ApplicationController < ActionController::Base
  
  include SessionsHelper
  
  before_action :auto_login, unless: :logged_in?

end
