# frozen_string_literal: true

class AvatarComponent < ApplicationComponent
  option :user
  option :size, default: -> { :medium } # :thumb / :small / :medium
  option :css_classes, default: -> { "rounded-full" }

  def has_custom_avatar?
    user.avatar.attached?
  end

  def svg_dimensions
    return 96 if size == :medium
    return 48 if size == :small
    32
  end

  def svg_font_size
    return 36 if size == :medium
    return 18 if size == :small
    14
  end

  def combined_css_classes
    classes = [css_classes]
    classes << "flex-none bg-gray-800 object-cover"
    classes << "h-24 w-24" if size == :medium
    classes << "h-12 w-12" if size == :small
    classes << "h-8 w-8" if size == :thumb
    classes.join(" ")
  end
end
