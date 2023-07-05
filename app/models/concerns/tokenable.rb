# app/models/concerns/tokenable.rb

module Tokenable
    extend ActiveSupport::Concern
  
    included do
      before_create :generate_token
    end
  
    protected
  
    def generate_token
      begin
        self.token = SecureRandom.urlsafe_base64
      end while self.class.exists?(token: token)
    end
  end
  