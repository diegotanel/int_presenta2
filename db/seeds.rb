# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'

CSV.foreach(Rails.root + 'config/INT_regiones.csv', headers: true) do |row|
  Region.skip_callback(:create)
  @reg = Region.new(codigo: row[1].squish, detalle: row[2].squish)
  @reg.save(:validate => false)
  Region.set_callback(:create)
end

CSV.foreach(Rails.root + 'config/INT_provincias.csv', headers: true) do |row|
  Provincia.skip_callback(:create)
  @reg = Region.find_by(codigo: row[3].squish)
  @reg.provincias.create!(codigo: row[1].squish, detalle: row[2].squish)
  Provincia.set_callback(:create)
end

CSV.foreach(Rails.root + 'config/INT_localidades.csv', headers: true) do |row|
  Localidad.skip_callback(:create)
  @prov = Provincia.find_by(codigo: row[3].squish)
  @prov.localidades.create!(codigo: row[0].squish, detalle: row[1].squish)
  Localidad.set_callback(:create)
end

Grupo.create!(codigo: "a", detalle: "Grupo")
Grupo.create!(codigo: "b", detalle: "Espectáculo concertado")

@genero = %Q[antropológico,circo,clásico adaptado,clown,comedia,humor,comedia dramática – drama,comunitario,danza – físico,infantil,murga,nuevas tendencias,objetos – títeres – marionetas,teatro clásico argentino,teatro clásico universal,teatro de sombras,teatro y música,unipersonales].split(",")
@genero.each { |g| GenEsp.create!(detalle: g) }

@publico_por_experiencia = %Q[con experiencia,especialmente experimentado,nuevos públicos].split(",")
@publico_por_experiencia.each { |p| PublExp.create!(detalle: p) }

@publico_por_edad = %Q[niños,adolescentes,adultos,apto todo público].split(",")
@publico_por_edad.each { |p| PublEdad.create!(detalle: p) }

@formato = %Q[grande,mediano,pequeño].split(",")
@formato.each { |p| Formato.create!(detalle: p) }

@tipo_de_espacio = %Q[calle – exteriores,convencional,no convencional].split(",")
@tipo_de_espacio.each { |p| EspsEsp.create!(detalle: p) }

@integrante_rol = %Q[Actor,Director,Tecnico].split(",")
@integrante_rol.each { |p| IntegranteRol.create!(detalle: p) }
