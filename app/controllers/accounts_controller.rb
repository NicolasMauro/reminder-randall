class AccountsController < ApplicationController
  def edit = (@user = current_user)

  def update
    current_user.update!(account_params)
    redirect_to edit_account_path, notice: "Saved."
  end

  private
    def account_params
      params.require(:user).permit(:name, :email, :phone, :ics_url,
        setting_attributes: [ :id, :grace_minutes, :lead_minutes, :confirm_nudge, :escalate_after_seconds, channels: [] ])
    end
end
