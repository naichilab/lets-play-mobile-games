module SessionsHelper

  # Redirects to stored location (or to the default).
  def redirect_back_or(default)
    redirect_to(user_session[:forwarding_url] || default)
    user_session.delete(:forwarding_url)
  end

  # Stores the URL trying to be accessed.
  def store_location
    # session[:forwarding_url] = request.url if request.get?
    user_session[:forwarding_url] = request.referer if request.get? && request.referer
  end

end
