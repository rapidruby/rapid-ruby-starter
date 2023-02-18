class LessonsController < ApplicationController
  skip_before_action :authenticate, only: %i[index]

  def index
  end
end
