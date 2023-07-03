class WorkspacesController < ApplicationController
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
            redirect_to root_path, notice: 'Workspace was successfully created.'
        else
            render :new, status: :unprocessable_entity
        end
    end

    private

    # Only allow a list of trusted parameters through.
    def workspace_params
        params.require(:workspace).permit(:name)
    end
end
