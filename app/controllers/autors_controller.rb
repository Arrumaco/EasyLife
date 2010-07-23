
class AutorsController < ApplicationController
  
  # GET /autors
  # GET /autors.xml
  def index

    @qbe_index = Autor.new(params[:autor]) 
    
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
    
    lineas_por_pagina = 5
    sort = case params['sort']
           when "id"  then "id"
           when "nombre"  then "nombre"
           when "fecha"  then "fecha"
           when "id_reverse"  then "id DESC"
           when "nombre_reverse"  then "nombre DESC"
           when "fecha_reverse"  then "fecha DESC"           
           end

    
    if  not @select_buff_index.nil?
      @autors = Autor.paginate :page => params[:page], :per_page => lineas_por_pagina,  :order => sort, :conditions =>  @select_buff_index 
    else
      @autors = Autor.paginate :page => params[:page], :per_page => lineas_por_pagina,  :order => sort
    end

    if request.xml_http_request?
      render :partial => "tablas_lista", :layout => false
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @autors }
      format.pdf { render :layout => false } 
    end
  end

  # GET /autors/1
  # GET /autors/1.xml  
  def show
    @autor = Autor.find(params[:id])

    lineas_por_pagina = 5
    sort = case params['sort']
           when "titulo_id"  then "id"
           when "titulo_nombre"  then "nombre"
           when "titulo_fecha"  then "fecha"
           when "titulo_id_reverse"  then "id DESC"
           when "titulo_nombre_reverse"  then "nombre DESC"
           when "titulo_fecha_reverse"  then "fecha DESC"           
           end
    
    @titulos = Titulo.paginate :page => params[:page], :per_page => lineas_por_pagina, :order => sort, 
                               :conditions => " autor_id = " + params[:id] 
    @titulo = Titulo.new 
    session[:id] = params[:id]
    @titulo.autor_id = session[:id]
    
    respond_to do |format|
      format.html  # show.html.erb
      format.xml  { render :xml => @autor }
      format.pdf { render :layout => false }
    end
  end

  # GET /autors/new
  # GET /autors/new.xml
  def new
    @autor = Autor.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @autor }
    end
  end

  # GET /autors/1/edit
  def edit
    @autor = Autor.find(params[:id])
  end

  # POST /autors
  # POST /autors.xml
  def create
    @autor = Autor.new(params[:autor])

    respond_to do |format|
      if @autor.save
        flash[:notice] = ''
        format.html { redirect_to(autors_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @autor.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /autors/1
  # PUT /autors/1.xml
  def update
    @autor = Autor.find(params[:id])

    respond_to do |format|
      if @autor.update_attributes(params[:autor])
        flash[:notice] = ''
        format.html { redirect_to(autors_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @autor.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /autors/1
  # DELETE /autors/1.xml
  def destroy
    @autor = Autor.find(params[:id])
    @autor.destroy

    respond_to do |format|
      format.html { redirect_to(autors_url) }
      format.xml  { head :ok }
    end
  end
  
  def auto_complete_for_autor_nombre
    @autors = Autor.find(:all, :conditions=> "nombre like "+ "'"+ params[:autor] [:nombre] + "%'"+ " or  nombre like "+ "'"+ params[:autor] [:nombre].capitalize + "%'" )
    render :inline => "<%= auto_complete_result @autors, :nombre %>"
  end  
  
end
