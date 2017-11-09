/*!
 *  Insert the doxygen style comments of file.
 */

macro DoxyFileHeader()
{
    var hwnd
    var hbuf
    /*prepare*/
    hwnd = GetCurrentWnd()
    hbuf = GetCurrentBuf()
    if(hbuf == hNil || hwnd == hNil)
    {
        Msg("Can't open file")
        stop
    }

    /*Get need information*/
    var fFullName
    var fName
    var nLength
    fFullName = GetBufName(hbuf)
    nLength = strlen(fFullName)
    fName   = ""

    var i
    var ch
    i = nLength - 1
    while(i >= 0)
    {
        ch = fFullName[i]
        if("@ch@" == "\\")
        {
            i=i+1 //don't take the '\' charater
            break
        }
        i=i-1
    }
    fName = strmid(fFullName, i, nLength)

    var szTime
    var Year
    var Month
    var Day
    szTime = GetSysTime(1)
    Year   = szTime.Year
    Month  = szTime.Month
    Day    = szTime.Day

    var user
    var siInfo
    siInfo = GetProgramEnvironmentInfo()
    user   = siInfo.UserName

    /*Insert comments*/
    ln = 0 //this will cause the file comments will always stay on the top of file
    InsBufLine(hbuf, ln++, "/******************************************************************************/")
	InsBufLine(hbuf, ln++, "/**")
    InsBufLine(hbuf, ln++, " * \@file     @fName@")
    InsBufLine(hbuf, ln++, " *")
    InsBufLine(hbuf, ln++, " * \@brief   ")
    InsBufLine(hbuf, ln++, " *")
    InsBufLine(hbuf, ln++, " * \@note     Copyright (c) @Year@ Availink Technology Co., Ltd. \\n")
    InsBufLine(hbuf, ln++, " *           All rights reserved.")
    InsBufLine(hbuf, ln++, " *")
    InsBufLine(hbuf, ln++, " * \@author  @user@")
    InsBufLine(hbuf, ln++, " * \@date     @Year@-@Month@-@Day@")
    InsBufLine(hbuf, ln++, " *")
    InsBufLine(hbuf, ln++, " ******************************************************************************/")

    /*Locate to the file begin*/
    ScrollWndToLine(hwnd, 0)
}

macro DoxyTypeHeaderNote()
{
    hbufCur = GetCurrentBuf();
	ln = GetBufLnCur(hbufCur)
    InsBufLine(hbufCur, ln++, "/**")
    InsBufLine(hbufCur, ln++, "* \\brief xxx")
    InsBufLine(hbufCur, ln++, "*/")
}

macro DoxyMemberNote()
{
    hbufCur = GetCurrentBuf();
    SetBufSelText(hbufCur, "/*!< xxx */")      
}

macro DoxyInsertFunHead()
{
	// Get a handle to the current file buffer and the name
	// and location of the current symbol where the cursor is.
	hbuf = GetCurrentBuf()

	//szFunc = GetCurSymbol()
	//ln = GetSymbolLine(szFunc)
	
	lnFirst = GetBufLnCur(hbuf)
	ln = lnFirst
    szLine = GetBufLine (hbuf, lnFirst)
    Len = strlen(szLine)
    FuncName = "" 
    if( 0 != Len) 
    { 
        cch = 0 
        while ("(" !=  szLine[cch]) 
        { 
            cch = cch + 1 
        } 

		ichLast = Len 
        while((" " != szLine[cch]) && ("    " != szLine[cch]) && ("*" != szLine[cch])) 
        { 
            cch = cch - 1 
        } 
        ichFirst = cch 
 
        while(ichFirst < ichLast) 
        { 
            ichFirst = ichFirst + 1 
            FuncName = Cat(FuncName, szLine[ichFirst]) 
        } 
    } 

	// begin assembling the title string

	InsBufLine(hbuf, ln++, "")
	InsBufLine(hbuf, ln++, "/******************************************************************************/")
	InsBufLine(hbuf, ln++, "/**")
	InsBufLine(hbuf, ln++, " * \@fn      @FuncName@")
    InsBufLine(hbuf, ln++, " *")
	InsBufLine(hbuf, ln++, " * \@brief  xxx")
    InsBufLine(hbuf, ln++, " *")
	InsBufLine(hbuf, ln++, " * \@param  xxx: zzz ")
	InsBufLine(hbuf, ln++, " *")
	InsBufLine(hbuf, ln++, " * \@return	\\e  0 : success \\n")
	InsBufLine(hbuf, ln++, " *          \\e -1 : fail")
	InsBufLine(hbuf, ln++, " *")
	InsBufLine(hbuf, ln++, " * \@note   none")
    InsBufLine(hbuf, ln++, " ******************************************************************************/")
	
	// put the insertion point inside the header comment
	SetBufIns(hbuf, ln, 4)
}
