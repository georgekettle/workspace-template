class UsersController < ApplicationController
    skip_after_action :verify_authorized, only: :update # authorization not needed because current_user is used

    # PATCH /users/:id
    def update
        if current_user.update(user_params)
            redirect_to edit_user_registration_path, notice: "Your account has been updated successfully."
        else
            redirect_to edit_user_registration_path, alert: "An error occurred while updating your account."
        end
    end

    private

    def user_params
        params.require(:user).permit(:first_name, :last_name)
    end
end
