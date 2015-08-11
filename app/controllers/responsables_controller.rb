class ResponsablesController < ApplicationController

  def index
  end

  def destroy
    @formulario = Formulario.find_by_id(params[:formulario_id])
    if @formulario.responsable.destroy
      flash[:success] = "Se ha eliminado el responsable"
      redirect_to edit_formulario_path(@formulario)
    else
      flash.now[:failure] = "El responsable no pudo ser eliminado"
      redirect_to edit_formulario_path(@formulario)
    end
  end

end
