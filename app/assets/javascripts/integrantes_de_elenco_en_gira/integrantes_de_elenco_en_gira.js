//USE ESTA
var ready = function() {
   $('#nacionalidad_integrante_nacionalidad_id').change(function() {
        var urlToSubmit = ""
        var partial_name = ""
        //Habria que traer los tipos de documento            
        if($(this).val() == 7)     
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

      /*integrante_rol_1
      integrante_rol_2
      integrante_rol_3*/
      function setear_checks_roles_integrantes()
      {

         if($('#integrante_de_elenco_en_gira_id').val() == "")
         {
            if($('#val_max_3_entre_los_dos').val() == "false" )
            {
               $('#integrante_rol_2').prop('disabled', true); 
               $('#integrante_rol_3').prop('disabled', true);   
            }
            else
            {            
               if($('#val_max_3_directores').val() == "false")
                  { $('#integrante_rol_2').prop('disabled', true); }
               else
                  { $('#integrante_rol_2').prop('disabled', false); }

               if($('#val_max_2_tecnicos').val() == "false" )
                  { $('#integrante_rol_3').prop('disabled', true ); }
               else
                  { $('#integrante_rol_3').prop('disabled', false ); }
            }
         }
         else
         {
            if($('#val_max_3_entre_los_dos').val() == "false" )
            {
               if($('#integrante_rol_2').attr('checked') != "checked")
               {$('#integrante_rol_2').prop('disabled', true);}
                  
               if($('#integrante_rol_3').attr('checked') != "checked")
               {$('#integrante_rol_3').prop('disabled', true);}  
            }
            else
            {          
               if($('#val_max_3_directores').val() == "false" && $('#integrante_rol_2').attr('checked') != "checked" )
                  { $('#integrante_rol_2').prop('disabled', true); }
               else
                  { $('#integrante_rol_2').prop('disabled', false); }

               if($('#val_max_2_tecnicos').val() == "false" && $('#integrante_rol_3').attr('checked') != "checked")
                  { $('#integrante_rol_3').prop('disabled', true ); }
               else
                  { $('#integrante_rol_3').prop('disabled', false ); }
            }
         } 

      }
      setear_checks_roles_integrantes();
};

$(document).ready(ready);
$(document).on('page:load', ready);




