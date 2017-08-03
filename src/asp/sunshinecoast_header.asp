<script language="JavaScript">
<!--

var sn = new Image();sn.src = "images/v2/sun.jpg";
var mn = new Image();mn.src = "images/v2/moon.jpg";
var dt = new Date();thr = dt.getHours()-1;


imggoon = new Image();imggoon.src = "images/v2/dgobox1.jpg";imggooff = new Image();imggooff.src = "images/v2/lgobox1.jpg";
imgtdon = new Image();imgtdon.src = "images/v2/headp1.jpg";imgtdoff = new Image();imgtdoff.src = "images/v2/dpoint1.jpg";
imgmnon = new Image();imgmnon.src = "images/v2/Dpoint1.jpg";imgmnoff = new Image();imgmnoff.src = "images/v2/lpoint1.jpg";
imgnson = new Image();imgnson.src = "images/v2/nsxdbox1.jpg";imgnsoff = new Image();imgnsoff.src = "images/v2/nsxlbox1.jpg";



if (document.images)

browsok=1
else browsok = 0

//-->
</script>
<script language="JavaScript">
<!--
function spec(imagename,objectsrc)
{
if (browsok)
document.images[imagename].src=eval(objectsrc+".src");
}

//-->
</script>
<script language="JavaScript">
<!--
function spec2(fname,imagename,objectsrc)
{
if (browsok)
document.forms[fname].all[imagename].src=eval(objectsrc+".src");
}

//-->
</script>
 <div align="center">
   <div class="table-responsive"><table border="0" cellpadding="0" style="border-collapse: collapse" width="100%" id="table1" bgcolor="#FFFFFF">
     <tr>
       <td bgcolor="#959CA0" >
    <p align="right"><a class="bodylinks" href="Sunshinecoast_Default.asp">Sunshine 
	Coast Home</a> 
	<font color="#FFFFFF">|</font>
    <a class="bodylinks" href="contacts.asp?region=SSX">Contact Us</a> 
	<font color="#FFFFFF">|</font>&nbsp;
    <a class="bodylinks" a href="#" onclick="javascript:window.print();">Print</a> 
	<font color="#FFFFFF">|</font> <a class="bodylinks" href="whatis_rss.asp?region=SSX">RSS</a> &nbsp; </td>
     </tr>
     <tr>
     <%
     title = "Sunshine Coast Exchange<sup><font size=2>&reg;</font></sup>"
     pg = Request.ServerVariables("PATH_INFO")
     bk = "images\nsxcoinspeople800.jpg"
     if instr(pg,"weekly_") > 0 then bk = "images\nsxcoins800.jpg"
     if instr(pg,"security_") > 0 then bk = "images\nsxcoins800.jpg"
     if instr(pg,"prices_") > 0 then 
     		bk = "images\nsxcoins800.jpg"
     		board = ucase(request.querystring("board"))
      		if board = "COMM" then title = "Commmunity Bank Board"
     		if board = "DEBT" then title = "Debt Board"
     		if board = "NCRP" then title = "Corporate Board"
     		if board = "PROP" then title = "Property Board"
     end if
     		
     		
     if instr(pg,"charts_") > 0 then bk = "images\nsxcoins800.jpg"
     if instr(pg,"announcements_") > 0 then bk = "images\nsxcoins800.jpg"
     if instr(pg,"float_") > 0 then bk = "images\nsxcoins800.jpg"
     if instr(pg,"indices") > 0 then bk = "images\nsxcoins800.jpg"
     if instr(pg,"market_") > 0 then bk = "images\nsxcoins800.jpg"
     
     if instr(pg,"rules_") > 0 then bk = "images\nsxlistcoins800.jpg"
     if instr(pg,"company_") > 0 then bk = "images\nsxlistcoins800.jpg"
     
     if instr(pg,"adviser_") > 0 then bk = "images\nsxback01.jpg"
     if instr(pg,"facilitator_") > 0 then bk = "images\nsxback01.jpg"
     if instr(pg,"listing_") > 0 then bk = "images\nsxback01.jpg"
     if instr(pg,"broker_") > 0 then bk = "images\nsxback01.jpg" 
     
     if instr(pg,"why_") > 0 then bk = "images\nsxcoinspeople800.jpg"
     if instr(pg,"whatis_") > 0 then bk = "images\nsxcoinspeople800.jpg"
     if instr(pg,"whatisa_") > 0 then bk = "images\nsxcoinspeople800.jpg"
     if instr(pg,"about_") > 0 then bk = "images\nsxcoinspeople800.jpg"
     if instr(pg,"how_") > 0 then bk = "images\nsxcoinspeople800.jpg"
     if instr(pg,"thecall_") > 0 then bk = "images\nsxcoinspeople800.jpg"
     
  
     
     %>
     <td height="60" bgcolor="#FFFFFF" background="<%=bk%>">
    &nbsp;&nbsp;
    <a href="<%= Application("nsx_SiteRootURL") %>">
    <img border="0" src="images/NSX-LOGOx150.gif" width="150" height="37" title="NSX Home" align="middle"></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="http://niser.org.au/"><img border="0" src="Sunshinecoast/images/niserlogo2.gif"   align="middle"></a></td>
     </tr>
     <tr>
       <td bgcolor="#959CA0"><font color="#FFFFFF" size="5"><img border="0" src="images/nsxdiag25.gif" align="right"><b>&nbsp; </b></font><b>
		<font color="#FFFFFF" size="4"><%=title%></font></b></td>
     </tr>
     <tr>
       <td>
       <!--webbot CLIENTSIDE 
bot="Ws4FpEx" MODULEID="'nsxa (Project)\Links_off.xws'" PREVIEW="&lt;img src='images/Links.gif?019AA628' editor='Webstyle4' border='0'&gt;" startspan  --><script src="xaramenu.js"></script><script Webstyle4 src="images/links.js"></script><noscript><img src="images/Links.gif?019AA628" editor="Webstyle4"></noscript><!--webbot 
bot="Ws4FpEx" endspan  -->
       </td>
     </tr>
     <tr>
       <td bgcolor="#000000" class="plaintext" align="right">
       <form method="GET" name="frmSearch" action="site_search.asp" onSubmit="return CheckForm();" style="word-spacing: 0; line-height: 100%; margin: 0">
        &nbsp;<input type="hidden" name="mode" value="phrase"></form>
       </td>
     </tr>
   </table></div>
 </div>
 