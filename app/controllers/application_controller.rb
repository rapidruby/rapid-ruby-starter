class ApplicationController < ActionController::Base
  # General rate limiting (300 requests per 5 minutes)
  rate_limit to: 300, within: 5.minutes, name: "general_requests"

  # Stricter rate limiting for unsafe HTTP methods (50 requests per 5 minutes)
  rate_limit to: 50, within: 5.minutes, name: "unsafe_requests",
    by: -> { request.ip if %w[POST PATCH PUT DELETE].include?(request.method) }

  include Authentication

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
