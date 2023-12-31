module Multitenant
    extend ActiveSupport::Concern

    included do
        set_current_tenant_through_filter # Declare that we will set_current_tenant manually
        before_action :find_workspace_and_set_tenant
    end

    private

    def find_workspace_and_set_tenant
        # Return early if no user is currently signed in
        return unless current_user
    
        # If the current user has any workspaces
        if current_user.workspaces.any?
            # If there's a tenant_id set in the session, and a workspace with that ID exists for the current user
            if session[:tenant_id] && current_user.workspaces.exists?(session[:tenant_id])
                # Find the workspace by the id stored in the session and set it as the current tenant
                set_current_tenant(current_user.workspaces.find(session[:tenant_id]))
            else
                # If there's no tenant_id in the session, set the first workspace of the user as the current tenant
                set_current_tenant(current_user.workspaces.first)
            end
        end
    end    
end
  