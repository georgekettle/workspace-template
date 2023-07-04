module Multitenant
    extend ActiveSupport::Concern

    included do
        set_current_tenant_through_filter # Declare that we will set_current_tenant manually
        # find_workspace_and_set_tenant will be called before every action except if user_signed_in? is true
        before_action :find_workspace_and_set_tenant, unless: :devise_controller?
    end

    private

    def find_workspace_and_set_tenant
        return unless current_user
        if current_user.workspaces.any?
            # You can modify the below line based on how you want to select the current workspace for the user
            set_current_tenant(current_user.workspaces.first)
        else
            return if request.path == new_workspace_path
            redirect_to new_workspace_path, notice: 'You must create a workspace before continuing'
        end
    end
end
  