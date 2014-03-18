module SessionsHelper
  def sign_in(user) 
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attributes({ remember_token: User.hash(remember_token) })
    self.current_user = user
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= User.find_by(remember_token: User.hash(cookies[:remember_token]))
  end

  def signed_in?
    !current_user.nil?
  end

  def sign_out
    current_user.update_attributes({ remember_token: User.hash(User.new_remember_token) })
    cookies.delete :remember_token
    self.current_user = nil
  end

  def current_user?(user)
    current_user == user
  end

  def save_location
    session[:return_to] = request.url if request.get?
  end

  def redirect_back_or(default)
    redirect_to session[:return_to] || default
    session.delete :return_to
  end

  def signed_in_user
    unless signed_in?
      save_location
      redirect_to signin_url, notice: "Please sign in." 
    end
  end
  
  private
  def guest
    redirect_to root_url if signed_in?
  end
end
