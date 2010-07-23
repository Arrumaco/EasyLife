# Configures your navigation

SimpleNavigation::Configuration.run do |navigation|  
  navigation.auto_highlight = true

  navigation.items do |primary|
    #TODO Meter la seguridad segun la configuracion de usuarios
    primary.item :autores, 'Autores', autors_path
    primary.item :prueba1, 'Con Submenu', autors_path do |submenu1|
      submenu1.item :prueba11, 'Sub 11', new_autor_path
      submenu1.item :prueba12, 'Sub 12', new_autor_path
    end
    primary.item :titulos, 'Titulos', titulos_path
    primary.item :prueba2, 'Con Submenu', titulos_path do |submenu2|
      submenu2.item :prueba21, 'Sub 21', new_titulo_path
    end
  end
end

