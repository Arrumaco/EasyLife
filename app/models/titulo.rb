class Titulo < ActiveRecord::Base
  validates_presence_of :fecha, :message => ' - Fecha Invalida'
  
  cattr_reader :per_page
  @@per_page = 7
  
  belongs_to :autor
  
  def self.titulos_del_autor (id)
     @titulos = Titulo.find(:all, :conditions => "autor_id =" + id.to_s)
  end
end
