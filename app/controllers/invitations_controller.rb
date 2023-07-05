class InvitationsController < ApplicationController
    skip_before_action :authenticate_user!, only: [:show]
    before_action :set_workspace, only: [:new, :create]

    # GET /invitations/:token
    def show
        @invitation = Invitation.find_by(token: params[:token])
        authorize @invitation

        if user_signed_in?
            if @invitation.workspace.users.include?(current_user)
                flash[:notice] = 'You are already a member of this workspace'
            else
                @invitation.workspace.users << current_user
                flash[:notice] = 'You have joined the workspace'
            end
            redirect_to @invitation.workspace
        else
            redirect_to new_user_registration_path(invitation_token: @invitation.token), notice: 'Please sign up to join the workspace'
        end
    end

    # GET /workspaces/1/invitations/new
    def new
        @invitation = @workspace.invitations.new
        authorize @invitation

        breadcrumb 'Home', @workspace
        breadcrumb 'Settings', settings_workspace_path(@workspace) if request.referer&.include?('settings')
        breadcrumb 'Invite Members', new_workspace_invitation_path(@workspace)
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
                InvitationMailer.invitation_email(invitation).deliver_now
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
