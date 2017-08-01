<HTML>
<HEAD><TITLE>Weekday</TITLE></HEAD>
<BODY>

<% ' Response.Write Trim(Lcase(WeekdayName(DatePart("w", Date())))) 

response.write DatePart("w", Date()) & "<BR>"

Dim weekday
Dim weekdayn
weekday = weekday(Date())
weekdayn = weekdayname(weekday(Date()))

response.write weekday & "<BR>"
response.write weekdayn & "<BR>"
%>

</BODY>
</HTML>
