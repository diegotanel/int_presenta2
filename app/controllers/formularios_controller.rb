#encoding: utf-8
class FormulariosController < ApplicationController
  before_action :signed_in_user, only: [:new, :create, :index, :edit, :update, :destroy, :imprimir_remito, :imprimir_formulario_interno]

  def new
    @formulario = Formulario.new
  end

  def show
    @formulario = Formulario.find(params[:id])
  end

  def index
    @formularios = current_user.formularios ? current_user.formularios : []
  end

  def create
    if @formulario = current_user.formularios.create!()
      redirect_to edit_formulario_path(@formulario)
    else
      render 'new'
    end
  end

  def edit
    @formulario = Formulario.find(params[:id])
  end

  def update
    @formulario = Formulario.find(params[:id])
    if @formulario.update_attributes(formulario_params)
      flash[:success] = "Formulario actualizado"
      redirect_to @formulario
    else
      render 'edit'
    end
  end

  def destroy
    Formulario.find(params[:id]).destroy
    flash[:success] = "Formulario eliminado"
    redirect_to formularios_path

  end

  def imprimir_remito
    @formulario = Formulario.find(params[:id])
    gen_remito = GeneradorDeRemito.new()
    gen_remito.generar_pdf(@formulario)
    file = Rails.root.join("public/remitos/" + gen_remito.nombre_remito_pdf)
    send_file ( file )
  end

  def imprimir_formulario_interno
    @formulario = Formulario.find(params[:id])
    gen_form_interno = GeneradorDeFormularioInterno.new()
    gen_form_interno.generar_pdf(@formulario)
    file = Rails.root.join("public/forms_fomento/" + gen_form_interno.nombre_formulario_interno_pdf)
    send_file ( file )
  end


  private

  def formulario_params
    params.require(:formulario).permit(:principal_id)
  end

end
