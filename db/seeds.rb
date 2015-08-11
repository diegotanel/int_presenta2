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

@nacionalidades = %Q[Afgano, albanés, argelino, americano, andorrana, Angola, antigua, argentino, armenio, australiano, austríaco, azerí, Bahamas, Bahréin, Bangladesh, Barbados, Barbuda, Batswana, bielorruso, belga, Belice, benineses, Butanés, boliviano, bosnio, brasileño, británico, Brunei, búlgaro, Burkina Faso, birmano, Burundi, camboyano, camerunés, canadiense, caboverdiano, africano Central, Chad, chileno, Chino, colombiano, comorense, congoleños, congoleños, Costa Rica, croata, cubano, chipriota, Checa, danés, Djibouti, Dominicana, Dominicana, holandés, holandés, holandesa, timoreses orientales , Ecuatoriano, egipcio, Emirian, Guinea Ecuatorial, Eritrea, Estonia, etíope, Fijiano, Filipino, finlandés, Francés, gabonesa, gambiano, georgiano, alemán, ghanés, griego, granadino, Guatemala, Guinea-seguir, Guinea, Guyana, Haití, Herzegovina, hondureño, Húngaro, I-Kiribati, islandés, indio, indonesio, iraní, iraquí, irlandés, israelí, Italiano, Costa de marfil, Jamaica, Japonés, jordano, kazajo, Kenia, Kittian y Nevisian, kuwaitíes, kirguís, laosiano, letón, libanés, Liberia, Libia, Liechtensteiner, lituano, luxemburgués, Macedonio, malgache, Malawi, Malasia, Maldivan , Maliense, maltés, marshalés, mauritano, Mauricio, México, Micronesia, moldavo, Monacan, mongol, marroquí, Mosotho, Motswana, Mozambique, Namibia, Nauruan, nepaleses, neerlandés, neozelandés, Ni-Vanuatu, nicaragüense, nigeriano, Níger, Corea del norte, irlandés norteño, noruego, Omani, paquistaní, Palao, panameño, Papua Nueva Guinea, paraguayo, peruano, Polaco, Portugués, qatarí, rumano, Ruso, Rwanda, Saint Lucian, salvadoreño, Samoa, San Marinese, Sao Tomean Saudita, escocés, senegaleses, serbio, seychellense, Sierra Leona, Singapur, Eslovaquia , Esloveno, isleño de Solomon, somalí, del africano del sur, Corea del sur, español, Sri Lanka, sudaneses, Surinamer, Swazi, sueco, suizo, Siria, taiwaneses, tayiko, Tanzania, tailandés, togolesa, Tongan, afrotrinitarias o los, tunecino, Turco, Tuvalu, Uganda, ucraniano, uruguayo, uzbekos, venezolano, vietnamita, Galés, yemenita, Zambia, Zimbabue].split(",")
@nacionalidades.each { |n| Nacionalidad.create!(detalle: n) }