# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  # protect_from_forgery # See ActionController::RequestForgeryProtection for details
  require 'simple_navigation'
  protect_from_forgery :only => '8fc080370e56e929a2d5afca5540a0f7'

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  before_filter :localize_date, :only => [:update, :create ]
  
  def localize_date
    params[:titulo][:fecha].gsub!(/[.\/]/,'-')
  end
end
