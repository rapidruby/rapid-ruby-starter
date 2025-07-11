module SanitizableNames
  extend ActiveSupport::Concern

  included do
    before_validation :sanitize_names
  end

  # Public method for manual sanitization if needed
  def sanitize_text(text)
    sanitize_name_field(text)
  end

  private

  def sanitize_names
    self.first_name = sanitize_name_field(first_name) if respond_to?(:first_name) && first_name.present?
    self.last_name = sanitize_name_field(last_name) if respond_to?(:last_name) && last_name.present?
    # self.name = sanitize_name_field(name) if respond_to?(:name) && name.present?
  end

  def sanitize_name_field(name)
    return name unless name.is_a?(String)

    # Remove URLs and suspicious characters
    sanitized = name.gsub(%r{https?://[^\s]+}, "")           # Remove http/https URLs
                    .gsub(/www\.[^\s]+/, "")                 # Remove www URLs
                    .gsub(/<[^>]*>/, "")                     # Remove HTML tags
                    .gsub(/[\u{1F600}-\u{1F64F}]/, "")       # Remove emoticons
                    .gsub(/[\u{1F300}-\u{1F5FF}]/, "")       # Remove symbols & pictographs
                    .gsub(/[\u{1F680}-\u{1F6FF}]/, "")       # Remove transport & map symbols
                    .gsub(/[\u{1F1E0}-\u{1F1FF}]/, "")       # Remove flags
                    .gsub(/[\u{2600}-\u{26FF}]/, "")         # Remove miscellaneous symbols
                    .gsub(/[\u{2700}-\u{27BF}]/, "")         # Remove dingbats
                    .gsub(/[:<>\/]/, "")                     # Remove remaining : < > / characters
                    .strip                                   # Remove leading/trailing whitespace
                    .squeeze(" ")                            # Replace multiple spaces with single space

    sanitized
  end
end
