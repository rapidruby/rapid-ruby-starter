# frozen_string_literal: true

class FieldsetHeaderComponent < ApplicationComponent
  option :title, required: true
  option :description, optional: true, default: nil

  def render?
    title.present? || description.present?
  end
end
