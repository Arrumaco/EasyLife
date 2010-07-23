pdf.font "Courier"
 
@autors.each do |autor|
  pdf.text "Autor: #{autor.id} -- #{autor.nombre}", :size => 16, :style => :bold, :spacing => 4
  pdf.move_down(30)

     titulos = Autor.titulos_del_autor(autor.id)
     if not titulos.blank? # ¿esta lleno el arreglo?.. Puede que el autor no tenga títulos asociados
		titulos = titulos.map do |titulo| 
		  [
		   titulo.nombre,
		   titulo.fecha
		  ]
    	end 
	    pdf.table titulos, 
	    :align_headers => :left,
	    :font_size => 8,
	    :border_style => :grid,
	    :row_colors => ["FFFFFF","DDDDDD"],
	    :headers => ["TITULO", "FECHA"],
	    :header_color => "aaaaaa",
	    :header_text_color => "#996600",
	    :align => { 0 => :left, 1 => :left },  
	    :column_widths => { 0 => 200, 1 => 80 }

	    pdf.start_new_page

  	 end
end