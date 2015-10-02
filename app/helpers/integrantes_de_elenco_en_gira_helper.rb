module IntegrantesDeElencoEnGiraHelper
	def obtener_nacionalidad(integrante)
		if integrante.nacionalidad_integrante.nil?
			return ""
		else
			return @integrante.nacionalidad_integrante.nacionalidad_id
		end
	end		

end
