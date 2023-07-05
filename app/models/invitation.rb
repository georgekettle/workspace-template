class Invitation < ApplicationRecord
  include Tokenable # generates a unique token for the invitation

  belongs_to :workspace

  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end
