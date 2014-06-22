class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authenticate_user!

  def has_permission?(user_id,deployment_id)
  		return !Permission.find_by_user_id_and_deployment_id(user_id, deployment_id ).nil?
  end

  def forbidden
	render(:file => File.join(Rails.root, 'public/403.html'), :status => 403, :layout => false)
  end

end
