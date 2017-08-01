<%
Sub PrintStockTicker()
%>
<ul id="ticker01">
<%


Set ConnTicker = GetReaderConn() 
Set TickerRS = Server.CreateObject("ADODB.Recordset")
SQL = "SELECT tradingcode, tradedatetime, [open], [last], sessionmode, volume, prvclose  FROM pricescurrent  "
SQL = SQL & " WHERE (issuestatus='Active'  AND exchid<>'SIMV')"
SQL = SQL & " ORDER BY tradingcode"

TickerRS.CacheSize=1000 
on error resume next
TickerRS.Open SQL, ConnTicker ,1,3
' check no error with database.
If err.number <> 0 Then
  RecordWebError "ticker4.asp", err 
  Response.End
End If


WEOF = TickerRS.EOF
If Not WEOF Then 
  alldata = TickerRS.getrows
  rc = ubound(alldata,2) 
Else
  rc = -1
End if

TickerRS.Close
Set TickerRS = Nothing
If WEOF Then 
  eml=" "
Else
  eml =  ""
  marketstatus=0 ' open or closed market
  lastcode=""
  volume=0

  FOR jj = 0 TO rc
    nsxcode = ucase(alldata(0,jj))
    volume = alldata(5,jj)
    
    ' minimise number of codes displayed to just 1 security from each series OR if the code has traded
    If left(nsxcode,3)<>lastcode or volume>0 Then
      lastcode = left(nsxcode,3)
      tradedatetime=alldata(1,jj)
      
      If isdate(tradedatetime) Then
        tradedatetime =tradedatetime
      Else
        tradedatetime=date
      End If
      
      open = alldata(2,jj)
      last = alldata(3,jj)
      sessionmode = alldata(4,jj)
      if sessionmode="NORMAL" then marketstatus = marketstatus+1
      
      prvclose=alldata(6,jj)
      If volume = 0 Then
      	volume = ""
      Else
      	volume = "&nbsp;(" & formatnumber(volume,0) & ")"
      End if
      if last=0 then last=prvclose
      if open = 0 then open = last
      diff = last - prvclose 
      

  
      if diff >0 then diff2 ="<li><a class=""ticklinks"" href=""/summary/" & nsxcode & """>" & nsxcode & "</a><span class=""ticker_price ticker_price_up"">" & formatnumber(last,3) & "<span class=""price_up"">&nbsp;</span>" & formatnumber(diff,3) & volume & "</span></li>"
      if diff <0 then diff2 ="<li><a class=""ticklinks"" href=""/summary/" & nsxcode & """>" & nsxcode & "</a><span class=""ticker_price ticker_price_dn"">" & formatnumber(last,3) & "<span class=""price_dn"">&nbsp;</span>" & formatnumber(diff * -1,3) & volume & "</span></li>"
      if diff =0 then diff2 ="<li><a class=""ticklinks"" href=""/summary/" & nsxcode & """>" & nsxcode & "</a><span class=""ticker_price"">" & formatnumber(last,3) & volume & "</span></li>"

      Response.Write diff2 & vbCrLf
    End If
  Next
End If
%></ul>
<%
End Sub
%>
