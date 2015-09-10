//USE ESTA
var ready = function() {

   $('#nacionalidad_integrante_nacionalidad_id').change(function() {
        var urlToSubmit = ""
        var partial_name = ""
        //Habria que traer los tipos de documento            
        if($(this).val() == 8)     
        {  
          partial_name = "datos_nacional";
        }
        else
        { 
          partial_name = "datos_extranjero"
        }

        $( ".fields_nacionalidad" ).remove(); 
        urlToSubmit = "/integrantes_de_elenco_en_gira/pegar_form_parcial_nacionalidad"               
        $.ajax({  
        url: urlToSubmit,
        type: "POST",
        data: { partial_name: partial_name},
        success:function(result) 
            {  $("#div_datos_nacionalidad").html(result) }
        });                        
                    
    });   

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
              $('#integrante_de_elenco_en_gira_localidad_id').html('<option value="">seleccione...</option>');
              return $('#integrante_de_elenco_en_gira_localidad_id').append(options);
            } 
            else {
              return $('#integrante_de_elenco_en_gira_localidad_id').empty();
            }
          };
          localidades = $('#integrante_de_elenco_en_gira_localidad_id').html();
          llenarLocalidades(localidades);
          return $('#ideec_provincia_id').change(function() {
            return llenarLocalidades(localidades);
          });
        }); 
      }).call(this);
};

$(document).ready(ready);
$(document).on('page:load', ready);

