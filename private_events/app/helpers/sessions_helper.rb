module SessionsHelper

  # Logs in the given user.
  def sign_in(user)
    session[:user_id] = user.id
  end

  # Remembers a user in a persistent session
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # Returns the current signed-in user.
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        sign_in user
        @current_user = user
      end
    end
  end

  # Returns true if the user is signed in.
  def signed_in?
    !current_user.nil?
  end

  # Signs out the current user.
  def sign_out
    session.delete(:user_id)
    @current_user = nil
  end

  # Forgets a persistent session.
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # Signs out the current user.
  def sign_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end
end
