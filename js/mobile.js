
$(document).ready(function() {
    $('#searchpage h1').html('Søg');
    $('a#search > span > span.ui-btn-text').html('Søg');
});

function initSearch () {
	var datasource = getParameter('datasource');
    $("#searchinput").autocomplete({
        selectFirst : true,
        delay: 750,
        minLength: 2,
        source : function(request, response) {
          var parameters = {
            page: 'mobile-content-singleselect.search',
            datasource: datasource,
            limit: 7,
            sessionid: initOptions.sessionId,
            searchstring: encodeURIComponent(request.term)
          };
            
          $.ajax( {
            url : '/cbkort',
            dataType : 'xml',
            data : parameters,
            success : function(result) {
                
              result.data = [];
              $(result).find('row').each(function (i, val) {
            	  var r = {
                    presentationString: $(val).find('col[name="displayname"]').text(),
                    wkt: $(val).find('col[name="shape_wkt"]').text(),
                    type: null
            	  }
            	  result.data.push(r);
              })
              
              response( $.map( result.data, function(item) {
                displayLabel = item.presentationString;
                displayValue = item.presentationString;
                return {
                  label : displayLabel,
                  value : displayValue,
                  data : item
                };
              }));
            }
          });
        },
        select : function(event, ui) {
            handleSelect(ui.item.data);
        }
    });
}

function getParameter(name) {
  name = name.replace(/[\[]/,"\\\[").replace(/[\]]/,"\\\]");
  var regexS = "[\\?&]"+name+"=([^&#]*)";
  var regex = new RegExp( regexS );
  var results = regex.exec( location.href );
  if( results == null )
    return "";
  else
    return decodeURIComponent(results[1].replace(/\+/g, " "));
}
