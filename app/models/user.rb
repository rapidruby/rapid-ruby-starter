class User < ApplicationRecord
  include Avatarable
  include SanitizableNames

  attribute :terms_and_conditions

  has_secure_password

  belongs_to :team
  has_many :team_users, dependent: :destroy
  has_many :teams, through: :team_users

  has_many :email_verification_tokens, dependent: :destroy
  has_many :password_reset_tokens, dependent: :destroy
  has_many :sessions, dependent: :destroy

  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_limit: [64, 64]
    attachable.variant :medium, resize_to_limit: [192, 192]
  end

  validates :first_name, :last_name, presence: true
  validates :email, disposable_email: true, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, allow_nil: true, length: { minimum: 8 }, format: { with: /(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])/ }
  validates :terms_and_conditions, acceptance: true, on: :create

  before_validation if: -> { email.present? } do
    self.email = email.downcase.strip
  end

  before_validation if: :email_changed?, unless: :new_record? do
    self.verified = false
  end

  after_update if: :password_digest_previously_changed? do
    sessions.where.not(id: Current.session).destroy_all
  end

  def name
    [first_name, last_name].compact.join(" ")
  end

  def obfuscated_name
    if last_name.present?
      "#{first_name} #{last_name.chars.first}."
    else
      first_name
    end
  end
end
