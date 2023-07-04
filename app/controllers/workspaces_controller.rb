class WorkspacesController < ApplicationController
    before_action :set_workspace, only: %i[show destroy settings]
    skip_before_action :find_workspace_and_set_tenant, only: %i[new create]
    
    # GET /workspaces/1
    def show
        set_current_tenant(@workspace) # set current tenant to this workspace
    end

    # GET /workspaces/new
    def new
        @workspace = Workspace.new

        authorize @workspace
    end

    # POST /workspaces
    def create
        @workspace = Workspace.new(workspace_params)
        authorize @workspace
        if @workspace.save
            WorkspaceUser.create(user_id: current_user.id, workspace_id: @workspace.id, role: 0) # create owner
            redirect_to @workspace, notice: 'Workspace was successfully created.'
        else
            render :new, status: :unprocessable_entity
        end
    end

    # DELETE /workspaces/1
    def destroy
        @workspace.destroy
        redirect_to root_path, notice: 'Workspace was successfully destroyed.'
    end

    # GET /workspaces/1/settings
    def settings
        @workspace_users = @workspace.workspace_users.includes(:user)
    end

    private

    def set_workspace
        @workspace = Workspace.find(params[:id])
        authorize @workspace
    end

    # Only allow a list of trusted parameters through.
    def workspace_params
        params.require(:workspace).permit(:name)
    end
end
