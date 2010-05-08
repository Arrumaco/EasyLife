class TitulosController < ApplicationController

    before_filter :localize_date, :only => [:update, :create ]
    def localize_date
      params[:titulo][:fecha].gsub!(/[.\/]/,'-')
    end
	
  # GET /titulos
  # GET /titulos.xml
  def index

    @qbe_index = Titulo.new(params[:titulo]) 
    
    params.each do |key, value|
      if @qbe_index.attribute_names().include?(key)
         if not value.blank?
          if @select_buff_index.nil?
            @select_buff_index =  key + " like " + "'" + value + "%'"
            @qbe_index[key] = value
          else
            @select_buff_index = @select_buff_index + " and " + key + " like " + "'" + value + "%'"
            @qbe_index[key] = value
          end
        end
      end
    end  

    lineas_por_pagina = 1
    sort = case params['sort']
           when "titulo_id"  then "id"
           when "titulo_nombre"  then "nombre"
           when "titulo_fecha"  then "fecha"
           when "titulo_id_reverse"  then "id DESC"
           when "titulo_nombre_reverse"  then "nombre DESC"
           when "titulo_fecha_reverse"  then "fecha DESC"           
           end

    
    if  not @select_buff_index.nil?
      @titulos = Titulo.paginate :page => params[:page], :per_page => lineas_por_pagina, :order => sort, :conditions =>  @select_buff_index 
    else
      @titulos = Titulo.paginate :page => params[:page],  :per_page => lineas_por_pagina, :order => sort
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @titulos }
    end
  end

  # GET /titulos/1
  # GET /titulos/1.xml
  def show
    @titulo = Titulo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @titulo }
    end
  end

  # GET /titulos/new
  # GET /titulos/new.xml
  def new
    @titulo = Titulo.new
    @titulo.autor_id = session[:id]

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @titulo }
    end
  end

  # GET /titulos/1/edit
  def edit
    @titulo = Titulo.find(params[:id])
  end

  # POST /titulos
  # POST /titulos.xml
  def create
    @titulo = Titulo.new(params[:titulo])

    respond_to do |format|
      if @titulo.save
        flash[:notice] = ''
        format.html { redirect_to(autor_path(session[:id])) }
        format.xml  { head :ok }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @titulo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /titulos/1
  # PUT /titulos/1.xml
  def update
    @titulo = Titulo.find(params[:id])

    respond_to do |format|
      if @titulo.update_attributes(params[:titulo])
        flash[:notice] = ''
        format.html { redirect_to(autor_path(session[:id])) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @titulo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /titulos/1
  # DELETE /titulos/1.xml
  def destroy
    @titulo = Titulo.find(params[:id])
    @titulo.destroy

    respond_to do |format|
      format.html { redirect_to(titulos_url) }
      format.xml  { head :ok }
    end
  end
end
