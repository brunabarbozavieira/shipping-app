class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
  
  private
  def authenticate_user_is_admin? 
    if current_user.user_type == 'admin'
      true
    else
      flash[:alert] = 'Usuário não possui autorização.'
      redirect_to root_path
    end
  end
end
