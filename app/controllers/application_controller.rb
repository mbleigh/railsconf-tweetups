class ApplicationController < ActionController::Base
  layout 'master'

  protected

  def authentication_succeeded(message = 'You have logged in successfully.', destination = '/home')
    current_user.refresh_friendships!
    flash[:notice] = message
    redirect_to destination
  end

end
