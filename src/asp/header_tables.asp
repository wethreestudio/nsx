<%
     pg = Request.ServerVariables("PATH_INFO")
     bk = "images\nsxcoinspeople30.jpg"
     if instr(pg,"weekly_") > 0 then bk = "images\nsxcoins30.jpg"
     if instr(pg,"security_") > 0 then bk = "images\nsxcoins30.jpg"
     if instr(pg,"prices_") > 0 then bk = "images\nsxcoins30.jpg"
     if instr(pg,"charts_") > 0 then bk = "images\nsxcoins30.jpg"
     if instr(pg,"announcements_") > 0 then bk = "images\nsxcoins30.jpg"
     if instr(pg,"float_") > 0 then bk = "images\nsxcoins30.jpg"
     if instr(pg,"indices") > 0 then bk = "images\nsxcoins30.jpg"
     if instr(pg,"market_") > 0 then bk = "images\nsxcoins30.jpg"
     
     if instr(pg,"rules_") > 0 then bk = "images\nsxlistcoins30.jpg"
     if instr(pg,"company_") > 0 then bk = "images\nsxlistcoins30.jpg"
     
     if instr(pg,"adviser_") > 0 then bk = "images\nsxback01.jpg"
     if instr(pg,"facilitator_") > 0 then bk = "images\nsxback01.jpg"
     if instr(pg,"listing_") > 0 then bk = "images\nsxback01.jpg"
     if instr(pg,"broker_") > 0 then bk = "images\nsxback01.jpg" 
     
     if instr(pg,"why_") > 0 then bk = "images\nsxcoinspeople30.jpg"
     if instr(pg,"whatisa_") > 0 then bk = "images\nsxcoinspeople30.jpg"
     if instr(pg,"about_") > 0 then bk = "images\nsxcoinspeople30.jpg"
     if instr(pg,"how_") > 0 then bk = "images\nsxcoinspeople30.jpg"
     if instr(pg,"thecall_") > 0 then bk = "images\nsxcoinspeople30.jpg"
%>
<!-- table align=center border="0" cellspacing="0" cellpadding="0"  width="100%" id="table1000"><tr><td height="30">
	<a target="_blank" href="<%= Application("nsx_SiteRootURL") %>">
	<img border="0" src="images/NSX-GHOST.gif" alt="" width="100" height="24"></a></td>
</tr></table -->