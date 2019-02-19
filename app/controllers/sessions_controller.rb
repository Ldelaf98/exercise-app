class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    session[:effective_id] = user.id
    redirect_to dashboard_path
  end
  
  def set_effective_id
    effective_id = params[:effective_id]
    session[:effective_id] = effective_id
    render json: {redirect_path: dashboard_path}
  end 
  
  def unset_effective_id
    user_id = session[:user_id]
    session[:effective_id] = user_id
    redirect_to dashboard_path
  end

  def destroy
    session[:user_id] = nil
    session[:effective_id] = nil
    redirect_to root_path
  end
  

end
