setCapslockState,alwaysOff
#singleInstance force
AutoTrim, Off
SetTitleMatchMode 2

executeScripts(sqlPlus, commands)
{
	; C:\workspace\APEX_VERW7\entw\sqlscri\
}

capslock & f7::
	; runPlsqlDeveloper()
	runChromePageDesigner()
	; runFirefoxPageDesigner()
	return

home::
capslock & a::
	sendInput,{end}+{home}
	text := getSelectedText()
        newText := RegexReplace(text, "^\s*")
	length := strLen(text) - strLen(newText)
        sendInput,{home}{right %length%}
	return

#IfWinActive PL/SQL Developer
~^s::
	sendInput,^s
	sendInput,{F8}
	return
:~:IF::
	sendInput,IF  THEN{enter}END IF;{left 15}
	return
:~*:setSession::
	sendInput,P_UTIL_APEX_V7.pSet_session_state('P', );{left 5}
	return
:~*:getSession::
	sendInput,P_UTIL_APEX_V7.fGet_session_state('P');{left 3}
	return
:*:getBewo::
	sendInput,P_BEWOHNER_V7.fGet_akt_bewope_nr_apex;
	return
:*:getAktBewo::
	sendInput,P_BEWOHNER_V7.fGet_akt_bewope_nr_apex;
	return

:*:CASE::
	sendInput,CASE{enter}WHEN  THEN{enter}{backspace 2}WHEN  THEN{enter}{backspace 4}END CASE;{up 2}{left 2}
	return

:*:FOR::
	sendInput,FOR i in 1...count LOOP{enter}{backspace 2}END LOOP;{up 1}{right 3}
	return
:*:debug::
	sendInput,P_LOG_V7.Log_Package_Error(1, cvModul, vLogstelle || '-:' || nLogpos, vLogText);{left 2}+{left 8}
	return
::BEGIN::
	sendInput,BEGIN
:*:logdat::
	sendInput,{enter}select * from logdat where name='EDE' order by nr desc;{f8}
	return
:*:showFK::
        Gui, Add, Text,, Table:
	Gui, Add, Edit, vTableName
        Gui, Add, Text,, Owner:
	Gui, Add, Edit, vOwner
        Gui, Add, Checkbox, vReversed, Reversed?
	Gui, Add, Button, x12 y160 w120 h30 , OK
        GuiControl,,owner,SENSO41
        GuiControl,,reversed,1
	Gui, Show,w300 h500
	return

	ButtonOK:
	Gui, Submit
	Gui, Destroy
	tableNumber := reversed ? 3 : 1
	sendInput,{enter}WITH constraint_colum_list AS ( SELECT owner, table_name, constraint_name, listagg(column_name,',') WITHIN GROUP ( ORDER BY position ) AS column_list{enter}FROM DBA_CONS_COLUMNS GROUP BY owner, table_name, constraint_name ){enter}SELECT DISTINCT c1.table_name AS "table", c2.column_list "columns", a1.nullable AS "nullable", c3.table_name "r_table", c3.column_list "r_columns", a2.nullable AS "r_nullable", c1.constraint_name AS "constraint", c3.constraint_name "r_constraint", c1.owner "owner", c3.owner "r_owner"{enter}FROM DBA_constraints c1{enter}JOIN constraint_colum_list c2 ON c1.CONSTRAINT_NAME=C2.CONSTRAINT_NAME AND c1.owner=c2.owner{enter}JOIN constraint_colum_list c3 ON C1.R_CONSTRAINT_NAME=C3.CONSTRAINT_NAME AND C1.R_OWNER=C3.owner{enter}LEFT JOIN all_tab_columns a1 ON (c1.owner = a1.owner AND c1.table_name = a1.table_name AND c2.column_list = a1.column_name){enter}LEFT JOIN all_tab_columns a2 ON (c3.owner = a2.owner AND c3.table_name = a2.table_name AND c3.column_list = a2.column_name){enter}WHERE C1.constraint_type = 'R'{enter}AND upper(c%tableNumber%.owner)=upper('%owner%') AND UPPER(c%tableNumber%.table_name)=UPPER('%tableName%');{enter}{f8}
	return

#IfWinActive

:*:(::
	sendInput,(){left}
	return
:*:{::
	sendInput,{{}{}}{left}
	return
:*:[::
	sendInput,{[}{]}{left}
	return

capslock & =::
        sendInput,{up}{end}+{home}
	text := getSelectedText()
        newText := RegexReplace(text, "^\s*")
	length := strLen(text) - strLen(newText)
        sendInput,{home}{right %length%}
	return


#IfWinActive Eclipse
~^s::
	sendInput,^s
	sleep,150
	sendInput,{alt down}{tab}{alt up}
	sleep,100
	sendInput,{f5}
	return
#IfWinActive

runChromePageDesigner()
{
	run % "chrome.exe sigapexprod`:9005/ords"
	sleep,4500
	sendInput,^a1234{enter}
	sleep,3500
	sendInput,f
	sleep,50
	sendInput,j
	sleep,3500
	sendInput,f
	sleep,50
	sendInput,jh
	sleep,3500
	sendInput,f
	sleep,50
	sendInput,je
	sleep,3500
	sendInput,EDE{tab}
	sleep,30
	sendInput,^a1234{enter}
	return
}



runFirefoxPageDesigner()
{
	run % "C:\Program Files\Mozilla Firefox\firefox.exe" "sigapexprod:9005/ords/f?p=4000:4500:16081287792358::NO:1,4150:FB_FLOW_ID,FB_FLOW_PAGE_ID,F4000_P1_FLOW,F4000_P4150_GOTO_PAGE,F4000_P1_PAGE:101,20000,101,20000,20000"
	sleep,3500
	sendInput,^a1234{enter}
	sleep,3500
	sendInput,f
	sleep,50
	sendInput,ah
	sleep,3500
	sendInput,f
	sleep,50
	sendInput,ah
	sleep,3500
	sendInput,f
	sleep,50
	sendInput,je
	sleep,3500
	sendInput,EDE{tab}
	sleep,30
	sendInput,^a1234{enter}
	return
}

runPlsqlDeveloper()
{
	if WinExist("ahk_exe plsqldev.exe") = 0x0
	{
	run,"C:\Program Files\PLSQL Developer 12\plsqldev.exe"
	sleep,3500
	sendInput,+{tab}senso{tab}senso{enter}
	sleep,5000
	sendInput,!n{down 2}{enter}
	sleep,300
	sendInput,^!l
	sleep,200
	sendInput,+{tab}senso41{tab}senso41{enter}
	sleep,500
	sendInput,SELECT * FROM logdat WHERE name = 'EDE' ORDER BY nr desc`;
	}
	else
	{
		msgBox,plsqldev already runnind!
	}
	return
}



capslock & f6 up::
	sendInput,{f6}
	sleep,400
	sendInput,sigapexprod:9005/ords/f?p=4000:4500:16081287792358::NO:1,4150:FB_FLOW_ID,FB_FLOW_PAGE_ID,F4000_P1_FLOW,F4000_P4150_GOTO_PAGE,F4000_P1_PAGE:101,20000,101,20000,20000{enter}
	sleep,2500
	sendInput,1234{enter}
	sleep,3500
	sendInput,f
	sleep,50
	sendInput,j
	sleep,3500
	sendInput,f
	sleep,50
	sendInput,jh
	sleep,3500
	sendInput,f
	sleep,50
	sendInput,je
	sleep,3500
	sendInput,EDE{tab}
	sleep,30
	sendInput,1234{enter}
	return



capslock up::
	sendInput,{escape}
	return

capslock & j::
	sendInput,{down}
	return

capslock & k::
	sendInput,{up}
	return

capslock & h::
	sendInput,{left}
	return

capslock & l::
	sendInput,{right}
	return

capslock & o::
	if(getKeyState("shift", "p"))
	{
		sendInput,{up}{home}{enter}
		return
	}
	sendInput,{end}{enter}
	return

capslock & m::
	sendInput,{enter}
	return

capslock & p::
	sendInput,{BACKSPACE}
	return

capslock & r::
	run,C:\Users\ederer\MyPrograms\Snippets\Snippets.exe
	return

:*:senso/senaso::
	sendInput,senso/senso@entwv7{enter}
	sleep,1
	sendInput,@defss6{enter}
	return

:*:addMenuEntry::
	sendInput,@INSERT/hiprozna_v7{enter}
	sleep,1
	sendInput,commit;{enter}
	return

:*:showConstraints::
	run,notepad++.exe C:\workspace\SENSO\entw\sqlscri\chr.sql
	return
^!`;::
	run,C:\Program Files\Everything\Everything.exe
	return

^!+x::
	inputBox, nLogPos, nLogPos setzen, nLogPos setzen
        return
^!x::
	sendInput,{home}{enter}{up}{space 4}nLogPos := %nlogPos%`;
        nlogPos := nlogPos + 10
	return

;::select::SELECT
;::from::FROM
;::into::INTO
;::where::WHERE
;::group by::GROUP BY
;::order by::ORDER BY
;::procedure::PROCEDURE
;::function::FUNCTION
;::like::LIKE
;::join::JOIN
;::on::ON
;::return::RETURN
;::varchar2::VARCHAR2
;::number::NUMBER
;::and::AND
;::or::OR
;::update::UPDATE
;::set::SET
;::insert::INSERT
;::desc::DESC

capslock & n::
    insertNLogPos(clipboard)
    return

insertNLogPos(str)
{
    msgBox % str
}

capslock & ,::
    run,C:\Users\ederer\source\repos\Snippets\Snippets\bin\Release\Snippets.exe
    return

capslock & t::
    run,http://sigapexprod:9009/ords
    sleep,2000
    sendInput,+{tab}
    sleep,30
    sendInput,+{tab}
    sleep,30
    sendInput,SENSOWEB{tab}
    sleep,30
    sendInput,ADMIN{tab}
    sleep,30
    sendInput % "Manager124!"
    sleep,30
    sendInput,{enter}
    return

capslock & f::
    inputbox,search,Grep,Pattern:
    search := "\""" . search . "\""" . A_Space
    s := "powershell -WindowStyle maximized -NoExit Set-Location -Path ""C:/workspace/""; dir -recurse *.* | sls -pattern " . search . " | select -unique path"
    run,%s%
    return

capslock & g::
    inputbox,search,Grep,Pattern:
    search := "\""" . search . "\""" . A_Space
    s := "powershell -NoExit Set-Location -Path ""C:/workspace/APEX_VERW7/entw/sqlscri""; mode 300; dir -recurse *.* | sls -pattern " . search . " | Sort-Object -Unique path | Select-Object -Property path, line"
    run,%s%
    return

capslock & escape::
    reload
    return

capslock & e::
    run % "http://sigapexprod:9005/ords/f?p=4000:4500:16081287792358::NO:1,4150:FB_FLOW_ID,FB_FLOW_PAGE_ID,F4000_P1_FLOW,F4000_P4150_GOTO_PAGE,F4000_P1_PAGE:101,20000,101,20000,20000"
    sleep,20000
    sendInput,1234
    sleep,100
    sendInput,{enter}


insertLogPos(str)
{
	arr := strSplit(str, "`r`n")
	s := ""
	nLogPos := 0
	isStatementFinished := true
	for i, v in arr
	{
		if(regexMatch(v, "^\s*n?[lL]ogPos\s*:=\s*\d{1,4}\s*;\s*$") == 0) ; keine logPos-Zuweisung
		{
		    if(regexMatch(v, ";\s*$") >= 2)
	        {
				if(isStatementFinished)
				{
				    nLogPos := nLogPos + 10
				    s := s . "nLogPos := " . nLogPos . ";`r`n"
				}
				else
				{
					isStatementFinished := true
				}
			}
			else if(isStatementFinished)
			{
				nLogPos := nLogPos + 10
			    s := s . "nLogPos := " . nLogPos . ";`r`n"
				isStatementFinished := false
			}
			s := s . v . "`r`n"
		}
	}
	return substr(s, 1, -2)
}

    getSelectedText()
    {
    clipboardOld = %clipboard%
    clipboard := ""ff
    sendInput,^c
    clipWait,0.7
    selectedText = %clipboard%
    clipboard = %clipboardOld%
    return selectedText
    }

openInPlsqlDeveloper(file)
{
        IfWinExist PL/SQL Developer
	{
		WinActivate, PL/SQL Developer
	} 
        else
	{
		return
	}
	sleep,100

	sendInput,^!o
	sleep,200
	sendInput % file.fileName
	sleep,50
	sendInput,{enter}
	sleep,500
	if(file.functionName != "")
	{
		sleep,400
		sendInput,^f
		sleep,200
		sendInput % file.functionName
		sleep,50
		sendInput,{enter}
	}
	return
}

getSqlFiles(path, text, onlyBody)
{
	if(regexMatch(text, "\s*[a-zA-Z]:\\.*?\.sql\s*") >= 1)
	{
		retVal := {}
		retVal.fileName := trim(text)
		retVal.functionName := ""
		return [retVal]
	}
	xs := strSplit(text, ".")
	packageName := trim(xs[1])
	functionNameWithParens := trim(xs[2])
	functionName := regexReplace(functionNameWithParens, "\s*(\(.*?\))?\s*;?$")
	if(packageName == "")
	{
		msgBox,Sorry, could not proceed.
		return
	}
	fileName := substr(packageName, 3)
	stringLower, fileName, fileName
	if(fileName == "bewohner_v7")
	{
		fileName := "bewo_v7"
	}
	bodyFileName := path . "bh" . fileName . ".sql"
	headerFileName := path . "ph" . fileName . ".sql"
	body := {}
	body.fileName := trim(bodyFileName)
	body.functionName := functionName
	header := {}
	header.fileName := trim(headerFileName)
	header.functionName := functionName
	if(onlyBody)
	{
		return [body]
	}
	else
	{
		return [header,body]
	}
}

capslock & 1::
	text := getSelectedText()
	sqlFiles := getSqlFiles("C:\workspace\APEX_VERW7\entw\sqlscri\", text, true)
	for i,file in sqlFiles
	{
		openInPlsqlDeveloper(file)
	}
	return

capslock & 2::
	text := getSelectedText()
	sqlFiles := getSqlFiles("C:\workspace\APEX_VERW7\entw\sqlscri\", text, false)
	for i,file in sqlFiles
	{
		openInPlsqlDeveloper(file)
	}
	return


