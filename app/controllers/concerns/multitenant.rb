module Multitenant
    extend ActiveSupport::Concern

    included do
        set_current_tenant_through_filter # Declare that we will set_current_tenant manually
        # find_workspace_and_set_tenant will be called before every action except if user_signed_in? is true
        before_action :find_workspace_and_set_tenant
    end

    private

    def find_workspace_and_set_tenant
        return unless current_user
        if current_user.workspaces.any?
            # Check session to see if session[:tenant_id] is set
            if session[:tenant_id]
                # If it is, find the workspace by id and set it as the current tenant
                set_current_tenant(current_user.workspaces.find(session[:tenant_id]))
            else
                # If it is not, find the first workspace for the user and set it as the current tenant
                set_current_tenant(current_user.workspaces.first)
            end
        else
            return if request.path == new_workspace_path
            redirect_to new_workspace_path, notice: 'You must create a workspace before continuing'
        end
    end
end
  