class ApplicationController < ActionController::Base
  include Authenticatable

  before_action :prepare_exception_notifier

  private

  def prepare_exception_notifier
    return unless user_signed_in?

    request.env["exception_notifier.exception_data"] = {
      current_user: Current.user
    }
  end

  def markdown(text)
    MarkdownService.to_html(text)
  end
  helper_method :markdown
end
