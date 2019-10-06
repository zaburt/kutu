class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery :with => :exception

  before_action :set_locale
  before_action :set_time_zone
  before_action :set_dynamic_hosts
  # before_action :authenticate_as_needed!
  before_action :check_authorization

  # skip_around_action :set_locale_from_url

  PUBLIC_ROUTES = [
    ['home', 'index'],
    ['articles', 'index'],
    ['articles', 'show'],
    ['games', 'index'],
    ['games', 'show'],
    ['game_ratings', 'index'],
    ['map', 'index'],
    ['sessions', 'new'],
    ['sessions', 'create']
  ].freeze


  private


  # SKIP_AUTH_FOR = {
  #   'home' => ['index']
  # }.freeze

  # REQUIRE_AUTH_FOR = [
  #   'admin'
  # ].freeze

  # def authenticate_as_needed!
  #   return if SKIP_AUTH_FOR.include?(controller_name) && SKIP_AUTH_FOR[controller_name].include?(action_name)
  #   authenticate_user! if REQUIRE_AUTH_FOR.include?(controller_name)
  # end

  def not_found
    fail ActionController::RoutingError.new('Not Found')
  end

  def check_authorization
    return true if signed_in?
    Rails.logger.debug "controller:#{controller_name} action:#{action_name}"

    return true if PUBLIC_ROUTES.include?([controller_name, action_name])
    not_found
  end

  def set_dynamic_hosts
    ActionController::Base.asset_host = proc { |_source, request|
      "#{request.protocol}#{request.host_with_port}"
    }

    ActionMailer::Base.default_url_options = {:host => request.host_with_port}
  end

  def set_locale
    # enable this when we want multiple locales, it will automatically
    # change routes ui etc
    # I18n.locale = params[:locale] || I18n.default_locale
    I18n.locale = I18n.default_locale
  end

  def set_time_zone
    Time.zone = 'Europe/Istanbul'
  end

end

