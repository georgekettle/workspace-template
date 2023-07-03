class ApplicationController < ActionController::Base
    include DeviseAuthentication
    include PunditAuthorization
end
