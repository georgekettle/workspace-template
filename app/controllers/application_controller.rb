class ApplicationController < ActionController::Base
    include DeviseAuthentication
    include PunditAuthorization
    include Multitenant
end
