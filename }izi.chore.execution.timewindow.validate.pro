601,100
602,"}izi.chore.execution.timewindow.validate"
562,"NULL"
586,
585,
564,
565,"o`>EbIhHJ3rg@v:aTC>yiGrxRDNRtmC_[=FD<<9s7SjTRYUX9NvCF\Oip`_ttjw43k3a<81R>bE1olWgwN2HUg6mA_k2W^S;nhM_f9ef5or[EN3No2mWuBBOiu^:?7\T9rHwSNp]hjsfNo^RUm5FF45CRY\Cub^ll?==yThmDFTMxMA`6@Pffhz9JxpN@]O7sh@2Z2uY"
559,1
928,0
593,
594,
595,
597,
598,
596,
800,
801,
566,0
567,","
588,","
589," "
568,""""
570,
571,
569,0
592,0
599,1000
560,10
pDebugMode
pSetUseActiveSandbox
pDayOfTheMonthStart
pDayOfTheMonthEnd
pDayOfTheWeekStart
pDayOfTheWeekEnd
pHourStart
pHourEnd
pMinuteStart
pMinuteEnd
561,10
1
1
1
1
1
1
1
1
1
1
590,10
pDebugMode,0
pSetUseActiveSandbox,0
pDayOfTheMonthStart,0
pDayOfTheMonthEnd,30
pDayOfTheWeekStart,1
pDayOfTheWeekEnd,7
pHourStart,0
pHourEnd,23
pMinuteStart,0
pMinuteEnd,59
637,10
pDebugMode,"[Optional] 0 = Nothing | 1 = Write to server message log | 2 = 1 + Keep temporary objects"
pSetUseActiveSandbox,"[Optional] 0 = Reads and writes to the base data | 1 = Reads and writes to the user's active sandbox"
pDayOfTheMonthStart,"[Optional] Day of the month expressed in D+N for the lower bound of the execution time window. For the 2nd day of the month, the value must be set to 1. Negative values are allowed (Example : -1)"
pDayOfTheMonthEnd,"[Optional] Day of the month expressed in D+N for the upper bound of the execution time window. For the 7th day of the month, the value must be set to 6. Negative values are allowed (Example : 0)"
pDayOfTheWeekStart,"[Optional] Day of the week for the lower bound of the execution time window. The first day of the week is Monday (Example : 1)"
pDayOfTheWeekEnd,"[Optional] Day of the week for the lower bound of the execution time window. Must be greater than or equal to pDayOfTheWeekStart. The first day of the week is Monday (Example : 7)"
pHourStart,"[Optional] Hour for the lower bound of the execution time window (Example : 0)"
pHourEnd,"[Optional] Hour for the upper bound of the execution time window. Must be greater than or equal to pHourStart (Example : 23)"
pMinuteStart,"[Optional] Minute for the lower bound of the execution time window (Example : 0)"
pMinuteEnd,"[Optional] Minute for the upper bound of the execution time window. Must be greater than or equal to pMinuteStart (Example : 59)"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,235

#****Begin: Generated Statements***
#****End: Generated Statements****

# ######  ######  ######
#   ##       ##     ##
#   ##      ##      ##
#   ##     ##       ##
# ######  ######  ######
# https://github.com/ichermak/Izi

# ====================================================================================================
# Description : Aborts a chore if its execution time is outside the time window defined in the parameters.
#
# Updates :
# 	- 2021/12/11 - Ifthen CHERMAK (www.linkedin.com/in/ichermak) : Creation
# ====================================================================================================


# === GLOBAL VARIABLES 
# ====================================================================================================
NumericGlobalVariable('PrologMinorErrorCount');
NumericGlobalVariable('MetadataMinorErrorCount');
NumericGlobalVariable('DataMinorErrorCount');

NumericGlobalVariable('nProcessReturn');
StringGlobalVariable('sProcessReturn');
nProcessReturn = 0;
sProcessReturn = '';

SetUseActiveSandboxProperty(pSetUseActiveSandbox);


# === CONSTANT VARIABLES 
# ====================================================================================================

# *** Standard variables 
# **************************************** 
cCrLf = Char(13) | Char(10);
If(DimIx('}Clients', Tm1User) = 0); cTM1User = 'Admin'; Else; cTM1User = Tm1User; EndIf;
cStartTime = Now;
cProcessName = GetProcessName;
cUserCode = ''; nMax = Long(cTM1User); nChar = 1; While(nChar <= nMax); If((Code(cTM1User, nChar) = 45) % ((Code(cTM1User, nChar) >= 65) & (Code(cTM1User, nChar) <= 90)) % ((Code(cTM1User, nChar) >= 97) & (Code(cTM1User, nChar) <= 122))); cUserCode = cUserCode | Subst(cTM1User, nChar, 1); EndIf; nChar = nChar + 1; End;
cIdExecution = cProcessName | '_' | TimSt(cStartTime, '\Y\m\d\h\i\s') | '_' | cUserCode  | '_' | Fill('0', 5 - Long(NumberToString(Int(Rand * 65536)))) | NumberToString(Int(Rand * 65536));
cDebugFile = GetProcessErrorFileDirectory | cIdExecution | '.dbg';
cTemporaryObject = 1;
If(pDebugMode > 1); cTemporaryObject = 0; EndIf;


# === PARAMETERS VERIFICATION AND OTHER CHECKS
# ====================================================================================================
If((pDebugMode = 1) % (pDebugMode = 2));
    sNewMsg = Expand('Process started with : pDebugMode=%pDebugMode%, pSetUseActiveSandbox=%pSetUseActiveSandbox%, pDayOfTheMonthStart=%pDayOfTheMonthStart%, pDayOfTheMonthEnd=%pDayOfTheMonthEnd%, pDayOfTheWeekStart=%pDayOfTheWeekStart%, pDayOfTheWeekEnd=%pDayOfTheWeekEnd%, pHourStart=%pHourStart%, pHourEnd=%pHourEnd%, pMinuteStart=%pMinuteStart%, pMinuteEnd=%pMinuteEnd%.');
    ExecuteProcess('}izi.process.message.add'
                , 'pProcess', cProcessName
                , 'pMessage', sNewMsg
                , 'pMessageType', 'Info'
                );
EndIf;

sErrorMsg = '';
pDayOfTheMonthStart = Int(pDayOfTheMonthStart);
pDayOfTheMonthEnd = Int(pDayOfTheMonthEnd);
pDayOfTheWeekStart = Int(pDayOfTheWeekStart);
pDayOfTheWeekEnd = Int(pDayOfTheWeekEnd);
pHourStart = Int(pHourStart);
pHourEnd = Int(pHourEnd);
pMinuteStart = Int(pMinuteStart);
pMinuteEnd = Int(pMinuteEnd);

If((pDayOfTheMonthStart > 30) % (pDayOfTheMonthStart < (-1) * 31));
	sNewMsg = Expand('Invalid parameter : pDayOfTheMonthStart=%pDayOfTheMonthStart%.');
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If((pDayOfTheMonthEnd > 30) % (pDayOfTheMonthEnd < (-1) * 31));
	sNewMsg = Expand('Invalid parameter : pDayOfTheMonthEnd=%pDayOfTheMonthEnd%.');
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If((pDayOfTheMonthStart * pDayOfTheMonthEnd > 0) & (pDayOfTheMonthStart > pDayOfTheMonthEnd));
	sNewMsg = Expand('Invalid parameters : pDayOfTheMonthStart=%pDayOfTheMonthStart% and pDayOfTheMonthEnd=%pDayOfTheMonthEnd% .');
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If((pDayOfTheWeekStart < 1) % (pDayOfTheWeekStart > 7));
	sNewMsg = Expand('Invalid parameter : pDayOfTheWeekStart=%pDayOfTheWeekStart%.'); 
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If((pDayOfTheWeekEnd < 1) % (pDayOfTheWeekEnd > 7));
	sNewMsg = Expand('Invalid parameter : pDayOfTheWeekEnd=%pDayOfTheWeekEnd%.'); 
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If(pDayOfTheWeekStart > pDayOfTheWeekEnd);
	sNewMsg = Expand('Invalid parameters : pDayOfTheWeekStart=%pDayOfTheWeekStart% and pDayOfTheWeekEnd=%pDayOfTheWeekEnd%. pDayOfTheWeekStart must be less than or equal to pDayOfTheWeekEnd.'); 
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If((pHourStart < 0) % (pHourStart > 23));
	sNewMsg = Expand('Invalid parameter : pHourStart=%pHourStart%.'); 
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If((pHourEnd < 0) % (pHourEnd > 23));
	sNewMsg = Expand('Invalid parameter : pHourEnd=%pHourEnd%.'); 
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If(pHourStart > pHourEnd);
	sNewMsg = Expand('Invalid parameters : pHourStart=%pHourStart% and pHourEnd=%pHourEnd%. pHourStart must be less than or equal to pHourEnd.'); 
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If((pMinuteStart < 0) % (pMinuteStart > 59));
	sNewMsg = Expand('Invalid parameter : pMinuteStart=%pMinuteStart%.'); 
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If((pMinuteEnd < 0) % (pMinuteEnd > 59));
	sNewMsg = Expand('Invalid parameter : pMinuteEnd=%pMinuteEnd%.'); 
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If(pMinuteStart > pMinuteEnd);
	sNewMsg = Expand('Invalid parameters : pMinuteStart=%pMinuteStart% and pMinuteEnd=%pMinuteEnd%. pMinuteStart must be less than or equal to pMinuteEnd.'); 
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If(sErrorMsg @<> '');
    If((pDebugMode = 1) % (pDebugMode = 2));
        sNewMsg = sErrorMsg;
        ExecuteProcess('}izi.process.message.add'
                    , 'pProcess', cProcessName
                    , 'pMessage', sNewMsg
                    , 'pMessageType', 'Error'
                    );
    EndIf;
    ProcessBreak;
EndIf;


# === OPERATIONS
# ==================================================================================================== 
nDayOfTheMonth = DayNo(TimSt(cStartTime, '\Y-\m-\d'));
nDayOfTheWeek = Mod(DayNo(TimSt(cStartTime, '\Y-\m-\d')) + 5, 7);
nHour = StringToNumber(TimSt(cStartTime, '\h'));
nMinute = StringToNumber(TimSt(cStartTime, '\i'));

nQuit = 0;

If((pDayOfTheMonthStart < 0) & (pDayOfTheMonthEnd >= 0));
    nCond1 = 0;
    nCond2 = 0;
    
    sMonth = TimSt(cStartTime, '\m');
    sYear = TimSt(cStartTime, '\Y');
    sFirstDayOfTheMonth = sYear | '-' | sMonth | '-' | '01';
    nFirstDayOfTheMonth = DayNo(sFirstDayOfTheMonth);
    nDayOfTheMonthStart = nFirstDayOfTheMonth + pDayOfTheMonthStart;
    nDayOfTheMonthEnd = nFirstDayOfTheMonth + pDayOfTheMonthEnd;
    If((nDayOfTheMonth < nDayOfTheMonthStart) % (nDayOfTheMonth > nDayOfTheMonthEnd));
        nCond1 = 1;
    EndIf;
    
    sMonth = IF(TimSt(cStartTime, '\m') @= '12', '01', Fill('0', 2 - Long(NumberToString(StringToNumber(TimSt(cStartTime, '\m')) + 1))) | NumberToString(StringToNumber(TimSt(cStartTime, '\m')) + 1));
    sYear = IF(TimSt(cStartTime, '\m') @= '12', Fill('0', 4 - Long(NumberToString(StringToNumber(TimSt(cStartTime, '\Y')) + 1))) | NumberToString(StringToNumber(TimSt(cStartTime, '\Y')) + 1), TimSt(cStartTime, '\Y'));
    sFirstDayOfTheMonth = sYear | '-' | sMonth | '-' | '01';
    nFirstDayOfTheMonth = DayNo(sFirstDayOfTheMonth);
    nDayOfTheMonthStart = nFirstDayOfTheMonth + pDayOfTheMonthStart;
    nDayOfTheMonthEnd = nFirstDayOfTheMonth + pDayOfTheMonthEnd;
    If((nDayOfTheMonth < nDayOfTheMonthStart) % (nDayOfTheMonth > nDayOfTheMonthEnd));
        nCond2 = 1;
    EndIf;
    
    If((nCond1 = 1) & (nCond2 = 1));
        nQuit = 1;
    EndIf;
    
ElseIf((pDayOfTheMonthStart >= 0) & (pDayOfTheMonthEnd < 0));
    sMonth = TimSt(cStartTime, '\m');
    sYear = TimSt(cStartTime, '\Y');
    sFirstDayOfTheMonth = sYear | '-' | sMonth | '-' | '01';
    nFirstDayOfTheMonth = DayNo(sFirstDayOfTheMonth);
    nDayOfTheMonthStart = nFirstDayOfTheMonth + pDayOfTheMonthStart;
    sMonth = IF(TimSt(cStartTime, '\m') @= '12', '01', Fill('0', 2 - Long(NumberToString(StringToNumber(TimSt(cStartTime, '\m')) + 1))) | NumberToString(StringToNumber(TimSt(cStartTime, '\m')) + 1));
    sYear = IF(TimSt(cStartTime, '\m') @= '12', Fill('0', 4 - Long(NumberToString(StringToNumber(TimSt(cStartTime, '\Y')) + 1))) | NumberToString(StringToNumber(TimSt(cStartTime, '\Y')) + 1), TimSt(cStartTime, '\Y'));
    sFirstDayOfTheMonth = sYear | '-' | sMonth | '-' | '01';
    nFirstDayOfTheMonth = DayNo(sFirstDayOfTheMonth);
    nDayOfTheMonthEnd = nFirstDayOfTheMonth + pDayOfTheMonthEnd;
    If((nDayOfTheMonth < nDayOfTheMonthStart) % (nDayOfTheMonth > nDayOfTheMonthEnd));
        nQuit = 1;
    EndIf;

ElseIf((pDayOfTheMonthStart >= 0) & (pDayOfTheMonthEnd >= 0));
    sMonth = TimSt(cStartTime, '\m');
    sYear = TimSt(cStartTime, '\Y');
    sFirstDayOfTheMonth = sYear | '-' | sMonth | '-' | '01';
    nFirstDayOfTheMonth = DayNo(sFirstDayOfTheMonth);
    nDayOfTheMonthStart = nFirstDayOfTheMonth + pDayOfTheMonthStart;
    nDayOfTheMonthEnd = nFirstDayOfTheMonth + pDayOfTheMonthEnd;
    If((nDayOfTheMonth < nDayOfTheMonthStart) % (nDayOfTheMonth > nDayOfTheMonthEnd));
        nQuit = 1;
    EndIf;
    
ElseIf((pDayOfTheMonthStart < 0) & (pDayOfTheMonthEnd < 0));
    sMonth = IF(TimSt(cStartTime, '\m') @= '12', '01', Fill('0', 2 - Long(NumberToString(StringToNumber(TimSt(cStartTime, '\m')) + 1))) | NumberToString(StringToNumber(TimSt(cStartTime, '\m')) + 1));
    sYear = IF(TimSt(cStartTime, '\m') @= '12', Fill('0', 4 - Long(NumberToString(StringToNumber(TimSt(cStartTime, '\Y')) + 1))) | NumberToString(StringToNumber(TimSt(cStartTime, '\Y')) + 1), TimSt(cStartTime, '\Y'));
    sFirstDayOfTheMonth = sYear | '-' | sMonth | '-' | '01';
    nFirstDayOfTheMonth = DayNo(sFirstDayOfTheMonth);
    nDayOfTheMonthStart = nFirstDayOfTheMonth + pDayOfTheMonthStart;
    nDayOfTheMonthEnd = nFirstDayOfTheMonth + pDayOfTheMonthEnd;
    If((nDayOfTheMonth < nDayOfTheMonthStart) % (nDayOfTheMonth > nDayOfTheMonthEnd));
        nQuit = 1;
    EndIf;
    
EndIf;

If((nDayOfTheWeek < pDayOfTheWeekStart) % (nDayOfTheWeek > pDayOfTheWeekEnd));
    nQuit = 1;
EndIf;

If((nHour < pHourStart) % (nHour > pHourEnd));
    nQuit = 1;
EndIf;

If((nMinute < pMinuteStart) % (nHour > pMinuteEnd));
    nQuit = 1;
EndIf;

If(nQuit = 1);
    ChoreQuit;
EndIf;

573,3

#****Begin: Generated Statements***
#****End: Generated Statements****
574,3

#****Begin: Generated Statements***
#****End: Generated Statements****
575,33

#****Begin: Generated Statements***
#****End: Generated Statements****

If(sErrorMsg @= '');
    #<Put your epilog code here>
EndIf;


# === EXIT
# ====================================================================================================
If((pDebugMode = 1) % (pDebugMode = 2));
    sProcessErrorFilePath = GetProcessErrorFileDirectory | GetProcessErrorFilename;
    If(FileExists(GetProcessErrorFilename) <> 0);
        ExecuteProcess('}izi.process.message.add'
                        , 'pProcess', cProcessName
                        , 'pMessage', sProcessErrorFilePath
                        , 'pMessageType', 'Error'
                        ); 
    EndIf;
    
    sNewMsg = Expand('Process finished with : PrologMinorErrorCount=%PrologMinorErrorCount%, MetadataMinorErrorCount=%MetadataMinorErrorCount%, DataMinorErrorCount=%DataMinorErrorCount%.');
    If((sErrorMsg @<> '') % (PrologMinorErrorCount + MetadataMinorErrorCount + DataMinorErrorCount > 0));
        sMessageType = 'Error';
    Else;
        sMessageType = 'Info';
    EndIf;
    ExecuteProcess('}izi.process.message.add'
                , 'pProcess', cProcessName
                , 'pMessage', sNewMsg
                , 'pMessageType', sMessageType
                );
EndIf;
576,CubeAction=1511DataAction=1503CubeLogChanges=0
930,0
638,1
804,0
1217,1
900,
901,
902,
938,0
937,
936,
935,
934,
932,0
933,0
903,
906,
929,
907,
908,
904,0
905,0
909,0
911,
912,
913,
914,
915,
916,
917,0
918,1
919,0
920,50000
921,""
922,""
923,0
924,""
925,""
926,""
927,""
