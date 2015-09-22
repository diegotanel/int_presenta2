//USE ESTA
var ready = function() {

   // p_provincia_id

   //  principal_localidad_id


      (function() {
        jQuery(function() {
          var localidades, llenarLocalidades; 
          llenarLocalidades = function(localidades) {
            var provincia, options;
            provincia = $('#p_provincia_id :selected').text();
            options = $(localidades).filter("optgroup[label='" + provincia + "']").html();
            if (options) {
              $('#principal_localidad_id').html('<option value="">seleccione...</option>');
              return $('#principal_localidad_id').append(options);
            } 
            else {
              return $('#principal_localidad_id').empty();
            }
          };
          localidades = $('#principal_localidad_id').html();
          llenarLocalidades(localidades);
          return $('#p_provincia_id').change(function() {
            return llenarLocalidades(localidades);
          });
        }); 
      }).call(this);
};

$(document).ready(ready);
$(document).on('page:load', ready);

