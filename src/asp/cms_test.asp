<!--#INCLUDE FILE="include_all.asp"-->
<%
' page_title = "Why List on NSX"
' meta_description = ""
' alow_robots = "no"
objJsIncludes.Add "cms_page", "/js/cms_page.js"
objJsIncludes.Add "jquery.datePicker", "/js/jquery.datePicker.js"
objJsIncludes.Add "date", "/js/date.js"
objJsIncludes.Add "feecalc", "/feecalc.js"

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
});
</script>

<!--div class="container_cont">

<div id="wrap" -->
<div style="background-color:#fff;">
<%
Server.Execute "side_menu.asp"
%>

<div style="margin-left:260px; margin-right:12px;" >



<!-- CONTENT -->

<div style="float:right;width:280px;">
<div class="small-table">
<div class="datagrid">
<div class="table-responsive"><table cellspacing="0">
    <thead>
        <tr>
            <th colspan="5" style="text-align:left;padding-left:5px;">Fee Examples</th>

        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="font-12">Mkt Cap.</td>
            <td class="font-12 col-dark">2 mil</td>
            <td class="font-12">10 mil</td>
            <td class="font-12 col-dark">25 mil</td>
            <td class="font-12">50 mil</td>
        </tr>
        <tr>
            <td class="font-12">Application<br />Fee</td>
            <td class="col-dark">5.500</td>
            <td>9.900</td>
            <td class="col-dark">14.960</td>
            <td>20.225</td>
        </tr>
        <tr>
            <td class="font-12">Annual Fee</td>
            <td class="col-dark">5.500</td>
            <td>9.900</td>
            <td class="col-dark">14.960</td>
            <td>20.225</td>
        </tr>
    </tbody>
</table></div>
</div>
</div>

<div style="float:right;width:100%; height:8px;"></div>

<div class="small-table">
<div class="datagrid">
<div class="table-responsive"><table cellspacing="0">
    <thead>
        <tr>
            <th style="text-align:left;padding-left:5px;">Equity Fee Calculator</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>
<form action="#" method="get" id="nsxfees">
<div class="table-responsive"><table width="100%">
  <tbody>
  <tr>
    <td><b>
	Type 
	of Fee</b></td>
    <td colspan="2" >
	<select size="1" name="FeeType" onchange="feeTypeSelect(this.value);doFeeCalc;" id="FeeType"> 
	<option selected="" value="application">Application Fee</option> 
	<option value="annual">Annual Fee</option> 
	<option value="subsequent">Additional Fees</option>
	</select> 
	</td></tr>
  <tr>
    <td><b>Number of Securities 
	</b> </td>
    <td colspan="2" >
	<input name="txtNumSecurities" value="10000000" size="16" maxlength="12" onkeyup="feecalc(this.value,this)" onblur="feecalc(this.value,this)" id="txtNumSecurities"></td>
  </tr>
  <tr>
    <td><b>Price Per Security</b></td>
    <td colspan="2">$<input name="txtSecValDol" value="1" size="5" maxlength="5" onkeyup="feecalc(this.value,this,event)" onblur="feecalc(this.value,this)" id="txtSecValDol">.<input name="txtSecValCnt" value="000" size="3" maxlength="3" onkeyup="feecalc(this.value,this,event)" onblur="feecalc(this.value,this)" id="txtSecValCnt"></td>
  </tr>
  <tr id="dvSecValError" class="hideBlock">
    <td colspan="3" id="error" name="error" class="error">
    <font size="1" color="red">The minimum value of a security is $0.10. The 
      calculations have been based on this amount. </font></td>
   </tr>
  <tr name="dvAnnualVariation" id="dvAnnualVariation" class="hideBlock">
    <td colspan="3" >
      <div id="dvListed"><input type="checkbox" name="cbListed" value="1" checked="" onclick="securityListed(this);doFeeCalc();"  id="cbListed">Already Listed?<br><font size="1">uncheck for pro-rata annual calculation</font></div>
      <div id="dvQuotationDate" class="hideBlock">
      <div><b>Expected Date of Listing</b></div>
      <div>
	  <input onchange="doFeeCalc();" id="txtDate" class="date-pick dp-applied" name="txtDate">

          
  </div></div></td></tr><tr><td bgcolor="#DDDDDD" colspan="2" ><b>Market Capitalisation</b></td>
    <td bgcolor="#DDDDDD" align="right" id="dvValue" >
	0</td></tr>
  
  <tr>
    <td colspan="2" id="dvFeePayHeader" name="dvFeePayHeader" >
	Application Fee</td>
    <td bgcolor="#FFFFFF" align="right" id="dvPayableAmount" name="dvPayableAmount" >$0</td>
    </tr>
    
    <tr>
    <td colspan="2" id="dvChessFeeHeader" name="dvChessFeeHeader" >
	CHESS Fee</td>
    <td bgcolor="#FFFFFF" align="right" id="dvChessFee" name="dvChessFee" >$0</td></tr>
    
    
      <tr>
    <td colspan="2" id="dvGrandTotalHeader" name="dvGrandTotalHeader" >
	Sub Total</td>
    <td bgcolor="#FFFFFF" align="right" id="dvGrandTotal" name="dvGrandTotal" >$0</td>
    </tr>
    
    <tr>
    <td bgcolor="#DDDDDD" colspan="2" id="dvGrandTotalGSTHeader" name="dvGrandTotalGSTHeader" ><b>Total Fee =<br>
	<font size="1">(incl GST) </font></b></td>
    <td bgcolor="#DDDDDD" align="right" id="dvGrandTotalGST" name="dvGrandTotalGST" class="plaintextbold">$0</td>
    </tr>
    <tr style="display:none;">
		<td align="right" id="dvSecValue" class="plaintextw" colspan="2">
			<font color="#FFFFFF">$1.000</font></td>
			<td align="right" id="dvNumSecurities" class="plaintextw" colspan="1">
			<font color="#FFFFFF">10,000,000 </font>
		</td>
    </tr>
    
    </tbody></table></div></form>
			</td>
        </tr>
    </tbody>
</table></div>
</div>
</div>
</div>

<h1>Company Fees</h1>
<p>Fees are calculated on the NSX market capitalisation of the quoted security using a sliding scale.</p>
<h2>Application Fees</h2>
<p>The application fee is paid at the time the initial application for listing is made of the primary securities.  This is a once off fee.</p>
<h2>Annual Fees</h2>
<p>Annual fees are payable each year.  In a full year they are calculated on a 1st July to 30 June basis.  In the first year of listing they are calculated on a pro-rata basis.  Annual fees are non-refundable.</p>
<h2>Capital Raising Fees</h2>
<p>Additional fees are required to be paid when newly issued or restricted securities are to be quoted.</p>
<h2>Notes to Fees</h2>
<h4>Minimum Share Price</h4>
<p>There is no minimum price per share for shares listed on the NSX.&nbsp; All fees are calculated as the greater of 10 cents, the initial issue price and the current market (last sale) price per share.Third Party</p>
<h4>Third Party Fees</h4>
<p>External companies to NSX charge fees for their service which are payable direct to those service providers, such as:</p>
<ul>
    <li><strong>Adviser Fee</strong>s - Nominated Advisers and Sponsoring Brokers charge a fee for service. The amount and format of these fees is up to the issuer and Adviser to negotiate. The NSX does not become involved in these negotiations.</li>
    <li><strong>Share Registry Fees</strong> - A share registry must be appointed that is able to connect to CHESS.  Share Registries charge a fee for this service.</li>
    <li><strong>Legal Services, Audit Services and Experts Reports</strong></li>
    <li><strong>CHESS Fees</strong> - Access to the ASX Settlement CHESS facility incurs a fee.  These are listed in the examples above.  In addition CHESS charges fees on the movement in holdings at its standard schedule of rates and are billed direct to the issuer or broker.<br />
    Transition fee</li>
</ul>
<h2>More Information on Fees</h2>
<p>For full details of all NSX fees and charges please refer to the Listing Fees Practice note available from the NSX website.  Click <a href="/rules_practicenotes.asp">here</a> to see the Practice Notes.</p>
<!-- /CONTENT -->





</div>

<div style="clear:both;"></div>
</div>
<div style="clear:both;margin-bottom:8px;"></div>
<!--/div>
</div-->

<!--#INCLUDE FILE="footer.asp"-->