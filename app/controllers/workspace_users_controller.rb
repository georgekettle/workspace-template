class WorkspaceUsersController < ApplicationController
    # GET /workspace_users/:id/edit
    def edit
        @workspace_user = WorkspaceUser.find(params[:id])
        authorize @workspace_user

        breadcrumb 'Home', @workspace_user.workspace
        breadcrumb 'Settings', settings_workspace_path(@workspace_user.workspace)
        breadcrumb 'Update Permissions', edit_workspace_user_path(@workspace_user)
    end

    # PATCH /workspace_users/:id
    def update
        @workspace_user = WorkspaceUser.find(params[:id])
        authorize @workspace_user

        if @workspace_user.update(workspace_user_params)
            redirect_to settings_workspace_path(@workspace_user.workspace), notice: "User updated."
        else
            breadcrumb 'Home', @workspace_user.workspace
            breadcrumb 'Settings', settings_workspace_path(@workspace_user.workspace)
            breadcrumb 'Update Permissions', settings_workspace_path(@workspace_user.workspace)

            render :edit, status: :unprocessable_entity
        end
    end

    # DELETE /workspace_users/:id
    def destroy
        @workspace_user = WorkspaceUser.find(params[:id])
        @workspace = @workspace_user.workspace
        authorize @workspace_user
        @workspace_user.destroy
        redirect_to settings_workspace_path(@workspace), notice: "User removed from workspace."
    end

    # PATCH /workspace_users/:id/make_owner
    def make_owner
        # Transfer ownership of workspace to another user inside of a transaction
        # to ensure that the workspace always has an owner.
        Workspace.transaction do
            @new_owner = WorkspaceUser.find(params[:id])
            @workspace = @new_owner.workspace
            @current_owner = WorkspaceUser.find_by(workspace: @workspace, user: current_user)
            
            authorize @new_owner

            @new_owner.update(role: :owner)
            @current_owner.update(role: :member)
        end
        redirect_to @workspace, notice: "Ownership successfully transferred to #{@new_owner.user.name}."
    end

    private

    def workspace_user_params
        params.require(:workspace_user).permit(:role)
    end
end
