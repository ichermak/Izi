601,100
602,"}izi.process.message.add"
562,"NULL"
586,
585,
564,
565,"zuG7bIkesug:WYygO2h@^IOai2aC?aQCzOg0[Jgz`y[fevydUpobrW_JG[azR9LMCRClNQr0yjlO?uKGKPKR6TO<S=NRr3>_nof]eW?1YOHcsHr978MottjuJp9OLhN:F]oISTg1@iWEuA7z;G4O3wS6sehB]c=YKo=i:zx?lu;B9_7Ql85]aEQG_]6Vi>OsxV1bdk]v"
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
560,3
pDebugMode
pProcess
pMessage
561,3
1
2
2
590,3
pDebugMode,0
pProcess,""
pMessage,""
637,3
pDebugMode,"[Optional] 0 = Nothing | 1 = Write to }izi.ProcessMessage cube | 2 = 1 + Keep temporary objects"
pProcess,"[Mandatory] Process name"
pMessage,"[Mandatory] Could be a text or a path to a text file"
577,1
vMessage
578,1
2
579,1
1
580,1
0
581,1
0
582,1
VarType=32ColType=827
603,0
572,111
#****Begin: Generated Statements***
#****End: Generated Statements****

# ######  ######  ######
#   ##       ##     ##
#   ##      ##      ##
#   ##     ##       ##
# ######  ######  ######
# https://github.com/ichermak/Izi

# ====================================================================================================
# Description : Add a message to '}izi.ProcessMessage' cube
#
# Updates :
# 	- 2020/05/26 - Ifthen CHERMAK (www.linkedin.com/in/ichermak) : Creation
# ====================================================================================================


# === GLOBAL VARIABLES 
# ====================================================================================================
NumericGlobalVariable('PrologMinorErrorCount');
NumericGlobalVariable('MetadataMinorErrorCount');
NumericGlobalVariable('DataMinorErrorCount');


# === CONSTANT VARIABLES 
# ====================================================================================================

# *** Standard variables 
# **************************************** 
cCrLf = Char(13) | Char(10);
If(DimIx('}Clients', Tm1User) = 0); cTM1User = 'Chore'; Else; cTM1User = Tm1User; EndIf;
cStartTime = Now;
cProcessName = GetProcessName;
cIdExecution = cProcessName | '_' | TimSt(cStartTime, '\Y\m\d\h\i\s') | '_' | cTM1User  | '_' | Fill( '0', 5 - Long(NumberToString(Int(Rand * 65536)))) | NumberToString(Int(Rand * 65536));
cDebugFile = GetProcessErrorFileDirectory | cIdExecution | '.dbg';
cTemporaryObject = 1;
If(pDebugMode > 1); cTemporaryObject = 0; EndIf;

# *** Other variables
# ****************************************
cCube = '}izi.ProcessMessage';

cYear = TimSt(cStartTime, '\Y');
cDate = TimSt(cStartTime, '\m-\d');
cTime = TimSt(cStartTime, '\h:\i:\s');

cTotalYear = 'Total Year';
cTotalDate = 'Total Date';
cTotalTime = 'Total Time';

cMaxErrorMessage = 100;


# === PARAMETERS VERIFICATION AND OTHER CHECKS
# ====================================================================================================
sErrorMsg = '';
pProcess = Trim(pProcess);
pMessage = Trim(pMessage);

If(ProcessExists(pProcess) = 0);
	sNewMsg = Expand('Invalid parameter : pProcess=%pProcess%.'); 
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If(pMessage @= '');
	sNewMsg = Expand('Invalid parameter : pMessage=%pMessage%.'); 
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If(sErrorMsg @<> '');
    ProcessBreak;
EndIf;


# === SOURCE DEFINITION
# ====================================================================================================

# *** Source values
# ****************************************
sTimestamp = TimSt(cStartTime, '\Y-\m-\d \h:\i:\s');
sUser = cTM1User;
If(CubeExists('}ElementAttributes_}Clients') = 1);
    If(DimIx('}ElementAttributes_}Clients', '}TM1_DefaultDisplayValue') > 0);
        sUser = CellGetS('}ElementAttributes_}Clients', cTM1User, '}TM1_DefaultDisplayValue');
    EndIf;
EndIf;
sMessage = '';

# *** Source settings
# ****************************************
If((FileExists(pMessage) = 1) & (Scan('.', pMessage) > 0));
    DataSourceType ='CHARACTERDELIMITED';
    DatasourceNameForServer = pMessage;
    DatasourceASCIIHeaderRecords = 0;
    DatasourceASCIIDelimiter = '§';
    nMetadataRecordCount = 0;
    nDataRecordCount = 0;
Else;
    DataSourceType ='NULL';
    sMessage = pMessage;
EndIf;


# === TARGET DEFINITION
# ====================================================================================================

# *** Target settings
# ****************************************
cCube_LoggingValue = CellGetS('}CubeProperties', cCube, 'LOGGING');
CellPutS('', '}CubeProperties', cCube, 'LOGGING');
573,2
#****Begin: Generated Statements***
#****End: Generated Statements****
574,13
#****Begin: Generated Statements***
#****End: Generated Statements****

nDataRecordCount = nDataRecordCount + 1;

If(nDataRecordCount <= cMaxErrorMessage);
    sMessage = sMessage | IF(sMessage @= '', '', cCrLf) | vMessage;
ElseIf(nDataRecordCount = cMaxErrorMessage + 1);
    sNewMsg = Expand('...%cCrLf%The rest of error messages are available within %pMessage%.');
    sMessage = sMessage | IF(sMessage @= '', '', cCrLf) | sNewMsg;
Else;
    ProcessBreak;
EndIf;
575,90
#****Begin: Generated Statements***
#****End: Generated Statements****

If(sErrorMsg @= '');
    
    # === OPERATIONS
    # ==================================================================================================== 
    sOldMsg = CellGetS(cCube, cYear, cDate, cTime, pProcess, 'Message');
    sMessage = sOldMsg | IF(sOldMsg @= '', '', cCrLf) | sMessage;
    
    # *** Message logging
    # ****************************************
    sMeasure = 'Timestamp';
    If(CellIsUpdateable(cCube, cYear, cDate, cTime, pProcess, sMeasure) = 1);
        CellPutS(sTimestamp, cCube, cYear, cDate, cTime, pProcess, sMeasure);
    EndIf;
    
    sMeasure = 'User';
    If(CellIsUpdateable(cCube, cYear, cDate, cTime, pProcess, sMeasure) = 1);
        CellPutS(sUser, cCube, cYear, cDate, cTime, pProcess, sMeasure);
    EndIf;
    
    sMeasure = 'Message';
    If(CellIsUpdateable(cCube, cYear, cDate, cTime, pProcess, sMeasure) = 1);
        CellPutS(sMessage, cCube, cYear, cDate, cTime, pProcess, sMeasure);
    EndIf;

    # *** Latest message logging
    # ****************************************
    sMeasure = 'Timestamp';
    If(CellIsUpdateable(cCube, cTotalYear, cTotalDate, cTotalTime, pProcess, sMeasure) = 1);
        CellPutS(sTimestamp, cCube, cTotalYear, cTotalDate, cTotalTime, pProcess, sMeasure);
    EndIf;
    
    sMeasure = 'User';
    If(CellIsUpdateable(cCube, cTotalYear, cTotalDate, cTotalTime, pProcess, sMeasure) = 1);
        CellPutS(sUser, cCube, cTotalYear, cTotalDate, cTotalTime, pProcess, sMeasure);
    EndIf;
    
    sMeasure = 'Message';
    If(CellIsUpdateable(cCube, cTotalYear, cTotalDate, cTotalTime, pProcess, sMeasure) = 1);
        CellPutS(sMessage, cCube, cTotalYear, cTotalDate, cTotalTime, pProcess, sMeasure);
    EndIf;
    
    
    # === CUBE LOGGING REACTIVATION
    # ====================================================================================================
    CellPutS(cCube_LoggingValue, '}CubeProperties', cCube, 'LOGGING');
    
Else;
    sTimestamp = TimSt(cStartTime, '\Y-\m-\d \h:\i:\s');
    sUser = cTM1User;
    sOldMsg = CellGetS(cCube, cYear, cDate, cTime, cProcessName, 'Message');
    sErrorMsg = sOldMsg | IF(sOldMsg @= '', '', cCrLf) | sErrorMsg;
    
    # *** Message logging
    # ****************************************
    sMeasure = 'Timestamp';
    If(CellIsUpdateable(cCube, cYear, cDate, cTime, cProcessName, sMeasure) = 1);
        CellPutS(sTimestamp, cCube, cYear, cDate, cTime, cProcessName, sMeasure);
    EndIf;
    
    sMeasure = 'User';
    If(CellIsUpdateable(cCube, cYear, cDate, cTime, cProcessName, sMeasure) = 1);
        CellPutS(sUser, cCube, cYear, cDate, cTime, cProcessName, sMeasure);
    EndIf;
    
    sMeasure = 'Message';
    If(CellIsUpdateable(cCube, cYear, cDate, cTime, cProcessName, sMeasure) = 1);
        CellPutS(sErrorMsg, cCube, cYear, cDate, cTime, cProcessName, sMeasure);
    EndIf;

    # *** Latest message logging
    # ****************************************
    sMeasure = 'Timestamp';
    If(CellIsUpdateable(cCube, cTotalYear, cTotalDate, cTotalTime, cProcessName, sMeasure) = 1);
        CellPutS(sTimestamp, cCube, cTotalYear, cTotalDate, cTotalTime, cProcessName, sMeasure);
    EndIf;
    
    sMeasure = 'User';
    If(CellIsUpdateable(cCube, cTotalYear, cTotalDate, cTotalTime, cProcessName, sMeasure) = 1);
        CellPutS(sUser, cCube, cTotalYear, cTotalDate, cTotalTime, cProcessName, sMeasure);
    EndIf;
    
    sMeasure = 'Message';
    If(CellIsUpdateable(cCube, cTotalYear, cTotalDate, cTotalTime, cProcessName, sMeasure) = 1);
        CellPutS(sErrorMsg, cCube, cTotalYear, cTotalDate, cTotalTime, cProcessName, sMeasure);
    EndIf;
    
EndIf;
576,
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
