# frozen_string_literal: true

module SolidusAdmin::AuthenticationAdapters::Backend
  extend ActiveSupport::Concern

  included do
    delegate :admin_logout_path, to: :spree
    helper_method :admin_logout_path
  end

  private

  def authenticate_solidus_backend_user!
    return if spree_current_user

    Spree::Backend::Config.unauthorized_redirect_handler_class.new(self).call
  end

  def store_location
    Spree::UserLastUrlStorer.new(self).store_location
  end

  def spree_current_user
    defined?(super) ? super : nil
  end
end
