//USE ESTA
var ready = function() {


   // ideec_provincia_id
   
   //  integrante_de_elenco_en_gira_localidad_id
      (function() {
        jQuery(function() {
          var localidades, llenarLocalidades; 
          llenarLocalidades = function(localidades) {
            var provincia, options;
            provincia = $('#ideec_provincia_id :selected').text();
            options = $(localidades).filter("optgroup[label='" + provincia + "']").html();
            if (options) {
              $('#integrante_comision_directiva_localidad_id').html('<option value="">seleccione...</option>');
              return $('#integrante_comision_directiva_localidad_id').append(options);
            } 
            else {
              return $('#integrante_comision_directiva_localidad_id').empty();
            }
          };
          localidades = $('#integrante_comision_directiva_localidad_id').html();
          llenarLocalidades(localidades);
          return $('#ideec_provincia_id').change(function() {
            return llenarLocalidades(localidades);
          });
        }); 
      }).call(this);
};

$(document).ready(ready);
$(document).on('page:load', ready);

