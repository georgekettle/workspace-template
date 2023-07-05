module DeviseAuthentication
    extend ActiveSupport::Concern
  
    included do
      before_action :authenticate_user!
      before_action :configure_permitted_parameters, if: :devise_controller?
    end
    
    def after_sign_in_path_for(resource)
      handle_invitation || root_path
    end
    
    def after_sign_up_path_for(resource)
      handle_invitation || root_path
    end
    
    protected
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
    end
    
    private
    
    def handle_invitation
      return unless params[:invitation_token]
      
      invitation = Invitation.find_by(token: params[:invitation_token])
      if invitation
        invitation.workspace.users << current_user
        flash[:notice] = 'You have joined the workspace'
        return invitation.workspace
      end
    
      nil
    end    
end
  