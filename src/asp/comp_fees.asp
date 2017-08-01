<!--#INCLUDE FILE="include_all.asp"-->
<%
' page_title = "Why List on NSX"
' meta_description = ""
' alow_robots = "no"
objJsIncludes.Add "cms_page", "/js/cms_page.js"
objJsIncludes.Add "jquery.datePicker", "/js/jquery.datePicker.js"
objJsIncludes.Add "date", "/js/date.js"
if date > cdate("28-jun-2016") then
	objJsIncludes.Add "feecalc2017", "/feecalc2017june.js"
	else
	objJsIncludes.Add "feecalc2016", "/feecalc2017june.js"
end if

objCssIncludes.Add "datePicker", "/css/datePicker.css"

page = Request.QueryString("page")
Set regEx = New RegExp 
regEx.Pattern = "^[\w_\-]+$" 
isPageValid = regEx.Test(page) 
If Not isPageValid Then
  Response.Redirect "/"
End If
%>
<!--#INCLUDE FILE="header.asp"-->
<script type="text/javascript">
$(function()
{
	$('.date-pick').datePicker();
	doFeeCalc();
	$('#FeeType').change(function() {
		feeTypeSelect();
		doFeeCalc();
	});
	$('#cbListed').change(function() {
		securityListed();
		doFeeCalc();
	});
});
</script>

<%
Server.Execute "side_menu.asp"
%>

<div class="hero-banner subpage">
    <div class="hero-banner-img"></div>
    <div class="container hero-banner-cont">
        <div class="container hero-banner-content-holder subpage">
            <div class="col-sm-12 hero-banner-left">
                <h1>Company Fees</h1>
                <%
                Server.Execute "listing_kit.asp"
                %>
            </div>
        </div>
    </div>
</div><!-- /hero-banner -->

<%
Server.Execute "content_lower_nav.asp"
%>


<!-- CONTENT -->
<div class="container subpage">
    <div class="row">
    <div class="col-sm-8">
        <div class="subpage-center">
            <%
            RenderContent page, "editarea" 
            %>
        </div>
    </div>

    <div class="col-sm-4">
    <div class="small-table side-table">
        <div class="datagrid">
            <table cellspacing="0" cellpadding="0">
            <thead>
                <tr>
                    <th colspan="5" style="text-align:left"><h3>Fee Examples (incl GST)</h3></th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td class="font-12">Market Capitalisation</td>
                    <td class="font-12 col-dark">5 mil</td>
                    <td class="font-12">10 mil</td>
                    <td class="font-12 col-dark">50 mil</td>
                    <td class="font-12">100 mil</td>
                </tr>

                <tr>
                    <td class="font-12">Application<br />Fee $</td>
                    <td class="col-dark">33,340</td>
                    <td>55,387</td>
                    <td class="col-dark">88,391</td>
                    <td>117,260</td>
                </tr>
                <tr>
                    <td class="font-12">Annual Fee $</td>
                    <td class="col-dark">12,036</td>
                    <td>17,974</td>
                    <td class="col-dark">37,128</td>
                    <td>61,069</td>
                </tr>
		        <tr>
                    <td class="font-12">Additional Securities Fee $</td>
                    <td class="col-dark">10,434</td>
                    <td>16,369</td>
                    <td class="col-dark">34,945</td>
                    <td>58,166</td>
                </tr>
		        
            </tbody>
        </table>
        </div>
    </div>

    <div class="small-table side-table">
        <div class="datagrid">
    <table cellspacing="0" cellpadding="0">
        <thead>
            <tr>
                <th style="text-align:left"><h3>Equity Fee Calculator</h3></th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>
    <form action="#" method="get" id="nsxfees">
    <table width="100%">
      <tbody>
      <tr>
        <td align="left"><b>Type of Fee</b></td>
        <td align="left" colspan="2" >
	    <select size="1" name="FeeType" id="FeeType"> 
	    <option selected="selected" value="application">Application Fee</option> 
	    <option value="annual">Annual Fee</option> 
	    <option value="subsequent">Additional Securities Fee</option>
	    </select> 
	    </td></tr>
      <tr>
        <td align="left"><b>Number of Securities 
	    </b> </td>
        <td align="left" colspan="2" >
	    <input name="txtNumSecurities" value="10000000" size="16" maxlength="13" onkeyup="feecalc(this.value,this)" onblur="feecalc(this.value,this)" id="txtNumSecurities"></td>
      </tr>
      <tr>
        <td align="left" ><b>Price Per Security</b></td>
        <td align="left" colspan="2">$<input name="txtSecValDol" value="1" size="5" maxlength="5" onkeyup="feecalc(this.value,this,event)" onblur="feecalc(this.value,this)" id="txtSecValDol">.<input name="txtSecValCnt" value="000" size="3" maxlength="3" onkeyup="feecalc(this.value,this,event)" onblur="feecalc(this.value,this)" id="txtSecValCnt"></td>
      </tr>
      <tr id="dvSecValError" style="display:none;">
        <td colspan="3" id="error" class="error">
        <font size="1" color="red">The minimum value of a security is $0.10. The 
          calculations have been based on this amount. </font></td>
       </tr>
      <tr id="dvAnnualVariation" style="display:none;">
        <td colspan="3" >
		    <div id="dvListed">Already Listed?<br>
			    <input type="checkbox" name="cbListed" value="1" id="cbListed" style="padding-right:8px">&nbsp;<label for="cbListed">tick for pro-rata annual calculation</label>
		    </div>
		    <div id="dvQuotationDate" style="display:none;">
			    <div style="text-align:center;padding-top:4px;padding-bottom:4px;"><b>Expected Date of Listing</b></div>
			    <div style="padding-left:90px;padding-top:4px;padding-bottom:4px;">
				    <input onchange="doFeeCalc();" id="txtDate" class="date-pick dp-applied" name="txtDate" style="width:90px">
			    </div>
		    </div>
	    </td>
      </tr>
  
      <tr><td align="left" bgcolor="#DDDDDD" colspan="2" ><b>Market Capitalisation</b></td>
        <td align="right" bgcolor="#DDDDDD" id="dvValue" >
	    0</td></tr>
  
      <tr>
        <td align="left" colspan="2" id="dvFeePayHeader" >
	    Application Fee</td>
        <td align="right" id="dvPayableAmount">$0</td>
        </tr>
    
        <tr style="display:none;">
        <td align="left" colspan="2" id="dvChessFeeHeader" >
	    CHESS Fee</td>
        <td align="right" id="dvChessFee" >$0</td></tr>
    
    
          <tr style="display:none;">
        <td align="left" colspan="2" id="dvGrandTotalHeader" >
	    Sub Total</td>
        <td align="right" id="dvGrandTotal"  >$0</td>
        </tr>
    
        <tr>
        <td align="left" bgcolor="#DDDDDD" colspan="2" id="dvGrandTotalGSTHeader" ><b>Total Fee =<br>
	    <font size="1">(incl GST) </font></b></td>
        <td bgcolor="#DDDDDD" align="right" id="dvGrandTotalGST" class="plaintextbold">$0</td>
        </tr>
        <tr style="display:none;">
		    <td align="right" id="dvSecValue" class="plaintextw" colspan="2">$1.000</td>
		    <td align="right" id="dvNumSecurities" class="plaintextw" colspan="1">10,000,000</td>
        </tr>
    
        </tbody></table></form>
			    </td>
            </tr>
        </tbody>
    </table>
    </div>
    </div>
</div>
</div>

<!-- /CONTENT -->
<div style="clear:both;"></div>
</div>
<!--#INCLUDE FILE="footer.asp"-->