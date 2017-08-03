<%@ LANGUAGE="VBSCRIPT" %>
<!--#INCLUDE FILE="include_all.asp"-->
<% CHECKFOR = "USR" %>
<!--#INCLUDE FILE="member_check.asp"-->
<%
page_title = "myNSX Portfolio View"
alow_robots = "no" 
objJsIncludes.Add "tablesorter", "/js/jquery.tablesorter.min.js"
objJsIncludes.Add "tablesorterp", "/js/addons/pager/jquery.tablesorter.pager.js"

objCssIncludes.Add "tablesorterpcss", "/js/addons/pager/jquery.tablesorter.pager.css"


Function ColorChange(n,d,s,p)
  If n < 0 Then
    ColorChange = "<span style=""color:red;"">" & s & FormatNumber(n,d) & p & "</span><img border=""0"" align=""middle"" alt="""" src=""images/down.gif"">"
  ElseIf n > 0 Then
    ColorChange = "<span style=""color:green;"">" & s & FormatNumber(n,d) & p & "</span><img border=""0"" align=""middle"" alt="""" src=""images/up.gif"">"
  Else
    ColorChange = s & FormatNumber(n,d) & p
  End If
End Function

%>
<!--#INCLUDE FILE="header.asp"-->
<script type="text/javascript" >
$(document).ready(function() 
    { 
        $("#myTable").tablesorter( { widgets: ["zebra"] } );
    } 
);
</script>

<div style="background-color:#fff; padding-bottom:20px;">
<%
Server.Execute "user_side_menu.asp"
%>
<div style="margin-left:260px; margin-right:12px;" >
<div class="prop min600px"></div>
<div style="float:left;width:750px;">
  <div class="editarea">
    <h1>Portfolio &amp; Alerts</h1>
<%
portfolioname=trim(request("portfolioname") & " ")
if len(portfolioname="") then portfolioname="default"
username = session("username")

SQL = "SELECT pf.username, pf.tradingcode, pf.pholding, pf.pprice, pc.[last], pc.issuedescription  "
SQL = SQL & "FROM nsx_portfolio pf JOIN PricesCurrent pc ON pc.tradingcode = pf.tradingcode "
SQL = SQL & "WHERE (pf.username='" & SafeSqlParameter(username) & "') AND (pf.portfolioname='" & SafeSqlParameter(portfolioname) & "' OR portfolioname IS NULL OR LEN(pf.tradingcode) < 1)  AND LEN(pf.tradingcode) > 0 AND pf.tradingcode IS NOT NULL "
SQL = SQL & "ORDER BY tradingcode ASC"
'Response.Write SQL
'Response.End

Set conn = GetReaderConn()
Set rs = conn.Execute(sql)
If rs.EOF Then
  %><p>You don't currently have any securities in your portfolio. <a href="user_portfolio_edit.asp">Click here</a> to add securities to your portfolio.<%
Else
%>
      <table class="tablesorter" id="myTable">
        <thead> 
          <tr> 
            <th class="header">Code</th>
            <th class="header">Description</th>
            <th class="header">Purchase<br>Price</th>
            <th class="header">Last<br>Price</th>
            <th class="header">Qty Held</th>  
            <th class="header">Cost</th>
            <th class="header">Value</th>
            <!-- th class="header">Change%</th -->
            <th class="header">Change$</th>  
          </tr> 
        </thead> 
        <tbody>
<%
  rowcount = 0
  totalcost = 0.0
  totalvalue = 0.0
  totalpricechange = 0.0
  totalpercentchange = 0.0
  While Not rs.EOF
    rowclass = "odd"
    If rowcount Mod 2 = 0 Then rowclass = "even" 
    last = CDbl(rs("last"))
    qtyheld = CLng(rs("pholding"))
    cost = CDbl(rs("pprice")) * qtyheld
    costps = CDbl(rs("pprice"))
    value = last * qtyheld
    pricechange = value-cost
	percentchange = 0
	If cost > 0 Then percentchange = (pricechange/cost)*100
    totalcost = totalcost + cost
    totalvalue = totalvalue + value 
%>
          <tr class="<%=rowclass%>"> 
            <td><a href="/summary/<%=UCase(Trim(rs("tradingcode")))%>"><%=UCase(rs("tradingcode"))%></a></td>
            <td><div style="overflow: hidden;text-overflow: ellipsis;white-space: nowrap;width: 160px;"><%=rs("issuedescription")%></div></td> 
            <td align="right">$<%=FormatNumber(costps,3)%></td>
            <td align="right">$<%=FormatNumber(last,3)%></td>
            <td align="right"><%=FormatNumber(qtyheld,0)%></td>
            <td align="right">$<%=FormatNumber(cost,2)%></td>
            <td align="right">$<%=FormatNumber(value,2)%></td>
            <!-- td align="right"><%=ColorChange(percentchange,2,"","%")%></td -->
            <td align="right"><%=ColorChange(pricechange,2,"$","")%></td>                 
          </tr>
<%
    rowcount = rowcount + 1
    rs.MoveNext 
  Wend
  rowclass = "odd"
  If rowcount Mod 2 = 0 Then rowclass = "even"
    totalpricechange = totalvalue - totalcost
	totalpercentchange = 0
	If totalcost > 0 Then totalpercentchange = (totalpricechange/totalcost)*100
%>
        </tbody>
        <tfoot>
          <tr class="<%=rowclass%>"> 
            <td>&nbsp;</td>
            <td>&nbsp;</td> 
            <td align="right">&nbsp;</td>
            <td align="right">&nbsp;</td>
            <td align="right">Total:</td>
            <td align="right">$<%=FormatNumber(totalcost,2)%></td>
            <td align="right">$<%=FormatNumber(totalvalue,2)%></td>
            <!-- td align="right"><%=ColorChange(totalpercentchange,2,"","%")%></td -->
            <td align="right"><%=ColorChange(totalpricechange,2,"$","")%></td>     
          </tr>
        </tfoot>                                
      </table>
      <div style="width:100%;padding-top:15px;text-align:right;">
        <input type="button" name="edit" value="Edit Portfolio &amp; Alerts" onclick="window.location.href='user_portfolio_edit.asp?portfolioname=default'" />
      </div>
<%
End If
%>
  </div>
</div>
</div>

<div style="clear:both;"></div>
</div>
<div style="height:20px;background-color:#fff;clear:both;margin-bottom:8px;"></div>


<!--#INCLUDE FILE="footer.asp"-->