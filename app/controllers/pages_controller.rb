class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home
  # skip_before_action :find_workspace_and_set_tenant, only: :home

  def home
  end
end
