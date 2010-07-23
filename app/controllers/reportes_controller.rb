class ReportesController < ApplicationController
  def catalogo
    @autors = Autor.find(:all)
    respond_to do |format|
      format.pdf { render :layout => false }
    end
  end
end
