//USE ESTA
var ready = function() {

      (function() {
        jQuery(function() {
          var localidades, llenarLocalidades; 
          llenarLocalidades = function(localidades) {
            var provincia, options;
            provincia = $('#ideec_provincia_id :selected').text();
            options = $(localidades).filter("optgroup[label='" + provincia + "']").html();
            if (options) {
              $('#persona_fisica_n_localidad_id').html('<option value="">seleccione...</option>');
              return $('#persona_fisica_n_localidad_id').append(options);
            } 
            else {
              return $('#persona_fisica_n_localidad_id').empty();
            }
          };
          localidades = $('#persona_fisica_n_localidad_id').html();
          llenarLocalidades(localidades);
          return $('#ideec_provincia_id').change(function() {
            return llenarLocalidades(localidades);
          });
        }); 
      }).call(this);
};

$(document).ready(ready);
$(document).on('page:load', ready);

