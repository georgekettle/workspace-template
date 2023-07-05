class InvitationsController < ApplicationController
    before_action :set_workspace, only: [:new, :create]

    # GET /workspaces/1/invitations/new
    def new
        @invitation = @workspace.invitations.new
        authorize @invitation
    end

    # POST /workspaces/1/invitations
    def create
        successful_invitations = []
        failed_invitations = []

        emails = params[:invitation][:emails].split(',').map(&:strip)
        emails.each do |email|
            invitation = Invitation.new(email: email, workspace: @workspace)
            authorize invitation

            if invitation.save
                successful_invitations << invitation
            else
                failed_invitations << invitation
            end
        end

        if successful_invitations.any?
            flash[:notice] = "Invitations sent to #{successful_invitations.map(&:email).join(', ')}"
        end

        if failed_invitations.any?
            flash[:alert] = "Failed to send invitations to #{failed_invitations.map(&:email).join(', ')}"
        end

        redirect_to new_workspace_invitation_path(@workspace)
    end

    private

    def set_workspace
        @workspace = Workspace.find(params[:workspace_id])
    end
end
