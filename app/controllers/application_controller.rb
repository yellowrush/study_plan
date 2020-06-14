class ApplicationController < ActionController::Base
  include Clearance::Controller

  def current_controller?(names)
    names.include?(params[:controller]) unless params[:controller].blank? || false
  end

  helper_method :current_controller?
end
