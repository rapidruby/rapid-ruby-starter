module Avatarable
  extend ActiveSupport::Concern

  def letters_svg(size: 32, font_size: 14, extra_classes: "rounded-full h-8 w-8 text-gray-600")
    letters = name.split.map(&:first).join.upcase[0..1] if name.is_a?(String)
    [
      '<?xml version="1.0" encoding="UTF-8"?>',
      "<svg version=\"1.1\" xmlns=\"http://www.w3.org/2000/svg\" width=\"#{size}\" height=\"#{size}\" viewBox=\"0 0 #{size} #{size}\" class=\"#{extra_classes}\">",
      "  <rect width=\"100%\" height=\"100%\" fill=\"currentColor\" />",
      "  <text fill=\"#fff\" font-size=\"#{font_size}\" font-weight=\"500\" x=\"50%\" y=\"55%\" dominant-baseline=\"middle\" text-anchor=\"middle\">",
      "    #{letters}",
      "  </text>",
      "</svg>"
    ].join("\n").html_safe
  end
end
