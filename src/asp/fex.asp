<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<%
Dim devPass
devPass = Request.QueryString("devPass")

'Security Check
'If devPass = "NSXASSD" Then

	'Define Variables
    Dim objConn
    Dim objRs
	Dim strSql
	Dim strConnString_Prices
	Dim strConnString_NewsAndEvents	
	Dim strFields
	Dim strTable
	Dim strWhere
	

	'Connect to requested DB
  Set objConn = Server.CreateObject("ADODB.Connection") 
	Set objRs = CreateObject("ADODB.RecordSet")
	objConn.Open Application("nsx_ReaderConnectionString")


	'Security Check
	if InStr(LCASE(strTable), "update") Or Instr(LCase(strWhere), "update") or InStr(LCASE(strTable), "delete") Or Instr(LCase(strWhere), "delete") or InStr(LCASE(strTable), "insert") Or Instr(LCase(strWhere), "insert") Then
		Response.Write("CANNOT DO UPDATES/DELETES ON DATABASE! ACCESS DENIED!")
	Else	
		'Build Query
		if Trim(Request("FIELDS")) = "" Then  strFields = "*"
		strTable = Request("TABLE")
		strWhere = Request("WHERE")			
		
		'Only do Selects
		strSql = "SELECT "& strFields &" FROM " & strTable & " " & strWhere
	
		'If on Debug Mode, show query
		If Request.QueryString("DEBUG") = "TRUE" then Response.Write(strSql & VbNewLine)
	
		'Execute Query
		objRs.Open strSql, objConn, 3, 3
	
		If not objRs.EOF Then
			'Write first line wit filds name and DataTypes
			For Each Item In objRs.Fields
				Response.Write(Item.Name & ":" & Item.Type & "|")
			Next
			Response.Write(VbNewLine)
				
			'Write Fields Values for each line
			While Not objRs.EOF 
				For Each Item In objRs.Fields
					Response.Write(objRs(Item.Name) &  "|")
				Next
				Response.Write(VbNewLine)
				objRs.MoveNext
			Wend
		End if
		
		'Close Conneciton and Destroy Objects
		objRs.Close
		Set objRs = Nothing
		Set objConn = Nothing	
	End if	
'Else
	'Response.Write("ACCESS DENIED!")
'End if
%>