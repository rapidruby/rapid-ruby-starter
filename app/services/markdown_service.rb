require "redcarpet"

module MarkdownService
  module_function

  class HTML < Redcarpet::Render::HTML; end

  def to_html(text)
    return "" if text.nil?

    raise ArgumentError, "Input must be a string or nil" unless text.is_a?(String)

    renderer = HTML.new({
      # filer_html: true,
      hard_wrap: true,
      link_attributes: { rel: "nofollow noreferer noopener", target: "_blank" },
      prettify: true
    })

    extras = {
      autolink: true,
      no_intra_emphasis: true,
      disable_indented_code_blocks: true,
      fenced_code_blocks: true,
      strikethrough: true,
      superscript: true,
      lax_spacing: true
    }

    markdown = Redcarpet::Markdown.new(renderer, extras)
    markdown.render(text).html_safe
  end
end
