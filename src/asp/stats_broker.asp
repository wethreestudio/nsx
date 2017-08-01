<%
' Response.Buffer = False
response.expires = 0
response.expiresabsolute = #JAN 2, 2000 00:00:00#
response.cachecontrol = "PRIVATE"
%>
<!--#INCLUDE FILE="include_all.asp"-->
<%
objJsIncludes.Add "tablesorter", "/js/jquery.tablesorter.min.js"
'objJsIncludes.Add "tablesorterp", "/js/addons/pager/jquery.tablesorter.pager.js"
objCssIncludes.Add "tablesortercss", "/css/table_sort_blue.css"
'objCssIncludes.Add "tablesorterpcss", "/js/addons/pager/jquery.tablesorter.pager.css"
%>
<!--#INCLUDE FILE="header.asp"-->
<script type="text/javascript" >
// add parser through the tablesorter addParser method 
$.tablesorter.addParser({ 
	// set a unique id 
	id: 'formatted_num', 
	is: function(s) { 
		// return false so this parser is not auto detected 
		return false; 
	}, 
	format: function(s) { 
		// format your data for normalization 
		var x = s.toLowerCase().replace(/,/g,''); 
		x = parseFloat(x);
		return (isNaN(x)) ? null : x;
	}, 
	// set type, either numeric or text 
	type: 'numeric' 
}); 

$(document).ready(function() 
    { 
		$.tablesorter.formatInt = function (s) {
			var x = s.toLowerCase().replace(/,/g,''); 
            var i = parseInt(x);
            return (isNaN(i)) ? null : i;
        };
        $.tablesorter.formatFloat = function (s) {
			var x = s.toLowerCase().replace(/,/g,''); 
            var i = parseFloat(x);
            return (isNaN(i)) ? null : i;
        };
		
        var pagesize = 20;
        
        if ($("#pager select").length>0) 
        {
          pagesize=$("#pager select").val();
        }
        $("#myTable").tablesorter( { 
			widgets: ["zebra"],
			headers: { 
			
	            1: { 
					sorter: 'text' 
                },			
				2: { 
					sorter: 'formatted_num' 
                },
				3: { 
					sorter:  'formatted_num' 
                },
				4: { 
					sorter:  'formatted_num' 
                },
				5: { 
                    sorter:'formatted_num' 
					//sorter: false
                } 
            }
		});
		$("#myTable2").tablesorter( { 
			widgets: ["zebra"],
			headers: { 
			
	            1: { 
					sorter: 'text' 
                },			
				2: { 
					sorter: 'formatted_num' 
                },
				3: { 
					sorter:  'formatted_num' 
                },
				4: { 
					sorter:  'formatted_num' 
                },
				5: { 
                    sorter:'formatted_num' 
					//sorter: false
                } 
            }
		});
        $("#myTable").tablesorterPager({ container: $("#pager"), positionFixed: false, size: pagesize }); 
    } 
);
</script>

<!-- breadcrumbs - manual -->
<div class="subnav-cont  " style="border:none;background:none;">
<div class="container">
<div class="row subnav-holder"><div class="col-sm-8 breadcrumb-nav">
   <ol class="breadcrumb">
    <li><a href="/default.asp">home</a></li>
    <li><a href="/marketdata/">Market data</a></li>
    <li><a href="/marketdata/statistics/">Statistics</a></li>
    <li><a href="/stats_broker.asp">Broker Trading Statistics</a></li>
    </ol></div></div>
</div><!-- /row --> 
</div>


<div class="hero-banner subpage">
    <div class="hero-banner-img"></div>
    <div class="container hero-banner-cont">
        <div class="container hero-banner-content-holder subpage">
            <div class="col-sm-12 hero-banner-left">
                <h1>Market Data</h1>
            </div>
        </div>
    </div>
</div>

<div class="container subpage">
    <div class="row">
        <div class="col-sm-12">
            <div class="subpage-center">
                <h1>Broker Trading Statistics <%=request("choose")%></h1>
                <div align="center">
                <%
                session("choose")=trim(request("choose") & " ")

                server.execute "stats_brokers_buy2.asp"

                server.execute "stats_brokers_sell2.asp"
                %>
                <p>&nbsp;</p>
                </div>
            </div>   
        </div>
    </div>
</div>
<!--#INCLUDE FILE="footer.asp"-->