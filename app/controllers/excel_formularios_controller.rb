#encoding: utf-8
class ExcelFormulariosController < ApplicationController
  before_action :signed_in_user, only: [:index]
  before_action :admin_user, only: [:index]

  def index
    @formulario = Formulario.find_by_id(params[:formulario_id])
    respond_to do |format|
      format.html
      format.csv { send_data @formulario.to_csv }
      format.xls #{ send_data @formulario.to_csv(col_sep: "\t") }
    end
  end

  private

  def admin_user
    redirect_to(root_url) unless current_user.admin? or current_user.jurado?
  end
end