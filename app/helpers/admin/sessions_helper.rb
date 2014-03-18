module Admin::SessionsHelper
  def sign_admin_in(admin) 
    remember_token = Admin.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    admin.validate_password = false
    admin.update_attributes({ remember_token: Admin.hash(remember_token) })
    self.current_admin = admin
  end

  def current_admin=(admin)
    @current_admin = admin
  end

  def current_admin
    @current_admin ||= Admin.find_by(remember_token: Admin.hash(cookies[:remember_token]))
  end

  def current_admin?(admin)
    current_admin == admin
  end

  def signed_in_admin?
    !current_admin.nil?
  end

  def guest?    
    current_admin.nil?
  end

  def sign_admin_out
    current_admin.update_attributes({ remember_token: Admin.hash(Admin.new_remember_token) })
    cookies.delete :remember_token
    self.current_admin = nil
  end

  def save_location
    session[:return_to] = request.url if request.get?
  end

  def redirect_back_or(default)
    redirect_to session[:return_to] || default
    session.delete :return_to
  end

  def signed_in_admin
    unless signed_in_admin?
      save_location
      redirect_to admin_signin_url, notice: "Please sign in." 
    end
  end
end
