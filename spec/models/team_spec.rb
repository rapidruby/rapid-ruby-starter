require 'rails_helper'

RSpec.describe Team, type: :model do
  it { is_expected.to have_many :team_users }
  it { is_expected.to have_many :users }
end
