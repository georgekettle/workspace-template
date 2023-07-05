class Invitation < ApplicationRecord
  include Tokenable # generates a unique token for the invitation

  belongs_to :workspace
end
