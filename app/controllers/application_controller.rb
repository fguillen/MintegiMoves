class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_locale

  private

  def set_locale
    new_locale = params[:locale] || ENV["RAILS_LOCALE"] || cookies[:locale] || extract_locale_from_accept_language_header || I18n.default_locale

    if I18n.available_locales.include?( new_locale.to_sym )
      I18n.locale = new_locale
      cookies[:locale] = {:value => new_locale, :expires => 10.years.from_now}
    end
  end

  def extract_locale_from_accept_language_header
    return nil  if !request.env['HTTP_ACCEPT_LANGUAGE']

    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
  end
end
