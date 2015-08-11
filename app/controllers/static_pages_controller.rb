class StaticPagesController < ApplicationController
	before_action :signed_in_user, only: [:show, :edit, :update]
  def home
  end

  def home2
  end
end
