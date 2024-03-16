class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include Error::ErrorHandler

  private

  def parse_date(date_str)
    Date.strptime(date_str, "%d/%m/%Y").to_datetime if date_str.present?
  end
end
