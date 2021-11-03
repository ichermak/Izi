601,100
602,"}izi.process.message.add"
562,"NULL"
586,
585,
564,
565,"elIraa^3uNYbP]DeRzb1?XHZLHHl8Z[ukerjn:TR0CpF<QnCZgyKmJbg3ZnHqVcWzA]amU??cNklP8<=Ur5`ZLBik14OjrWcan2G>BinfKt8qsX^d9I[U^v>OHK8la_L=dUBiWH=[M5SVmZK4o2D_0dxeZ9h8[jpWSK5[ureyXsg7=vb=:WbxepV^SIeJo_\Qxlm02Nj"
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
560,5
pDebugMode
pProcess
pMessage
pMessageType
pMaxErrorMessage
561,5
1
2
2
2
1
590,5
pDebugMode,0
pProcess,""
pMessage,""
pMessageType,"Info"
pMaxErrorMessage,100
637,5
pDebugMode,"[Optional] 0 = Nothing | 1 = Write to }izi.ProcessMessage cube | 2 = 1 + Keep temporary objects"
pProcess,"[Mandatory] Process name"
pMessage,"[Mandatory] Could be a text or a path to a text file"
pMessageType,"[Optional] Type of message (Example: 'Error')"
pMaxErrorMessage,"[Optional] Maximum error to be retrieved from TM1ProcessError_*.log"
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
572,131
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
# 	- 2021/11/03 - Ifthen CHERMAK (www.linkedin.com/in/ichermak) : Avoid using DimensionTimeLastUpdated to get milliseconds due to contention issues
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
If(DimIx('}Clients', Tm1User) = 0); cTM1User = 'Admin'; Else; cTM1User = Tm1User; EndIf;
cStartTime = Now;
cProcessName = GetProcessName;
cUserCode = ''; nMax = Long(cTM1User); nChar = 1; While(nChar <= nMax); If((Code(cTM1User, nChar) = 45) % ((Code(cTM1User, nChar) >= 65) & (Code(cTM1User, nChar) <= 90)) % ((Code(cTM1User, nChar) >= 97) & (Code(cTM1User, nChar) <= 122))); cUserCode = cUserCode | Subst(cTM1User, nChar, 1); EndIf; nChar = nChar + 1; End;
cIdExecution = cProcessName | '_' | TimSt(cStartTime, '\Y\m\d\h\i\s') | '_' | cUserCode  | '_' | Fill('0', 5 - Long(NumberToString(Int(Rand * 65536)))) | NumberToString(Int(Rand * 65536));
cDebugFile = GetProcessErrorFileDirectory | cIdExecution | '.dbg';
cTemporaryObject = 1;
If(pDebugMode > 1); cTemporaryObject = 0; EndIf;

# *** Other variables
# ****************************************
cCube = '}izi.ProcessMessage';

cTempDimName = '}TI-Dimension-' | cIdExecution;
cTempHierName = '}TI-Hierarchy-' | cIdExecution;

cTotalYear = 'Total Year';
cTotalDate = 'Total Date';
cTotalTime = 'Total Time';
cTotalMillisecond = 'Total Millisecond';

nMaxMillisecond = 999;


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
nDateTime = Now;

sUser = cTM1User;
sUserDisplayValue = '';
If(CubeExists('}ElementAttributes_}Clients') = 1);
    If(DimIx('}ElementAttributes_}Clients', '}TM1_DefaultDisplayValue') > 0);
        sUserDisplayValue = CellGetS('}ElementAttributes_}Clients', sUser, '}TM1_DefaultDisplayValue');
    EndIf;
EndIf;

sYear = TimSt(nDateTime, '\Y');
sDate = TimSt(nDateTime, '\m-\d');
sTime = TimSt(nDateTime, '\h:\i:\s');

nMillisecond = CellGetN(cCube, pProcess, sUser, sYear, sDate, sTime, cTotalMillisecond, 'Message Count');
nMillisecond = IF(nMillisecond <= nMaxMillisecond, nMillisecond, nMaxMillisecond);
sMillisecond = Fill('0', Long(NumberToString(nMaxMillisecond)) - Long(NumberToString(nMillisecond))) | NumberToString(nMillisecond);

sTimeStamp = TimSt(nDateTime, '\Y-\m-\d \h:\i:\s') | '.' | sMillisecond;
sMessageType = Trim(pMessageType);
If(sMessageType @= '');
    sMessageType = 'Info';
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
If(CubeExists('}CubeProperties') = 1);
    cCube_LoggingValue = CellGetS('}CubeProperties', cCube, 'LOGGING');
    CellPutS('', '}CubeProperties', cCube, 'LOGGING');
EndIf;
573,2
#****Begin: Generated Statements***
#****End: Generated Statements****
574,13
#****Begin: Generated Statements***
#****End: Generated Statements****

nDataRecordCount = nDataRecordCount + 1;

If(nDataRecordCount <= pMaxErrorMessage);
    sMessage = sMessage | IF(sMessage @= '', '', cCrLf) | vMessage;
ElseIf(nDataRecordCount = pMaxErrorMessage + 1);
    sNewMsg = Expand('...%cCrLf%The rest of error messages are available within %pMessage%.');
    sMessage = sMessage | IF(sMessage @= '', '', cCrLf) | sNewMsg;
Else;
    ProcessBreak;
EndIf;
575,160
#****Begin: Generated Statements***
#****End: Generated Statements****

If(sErrorMsg @= '');
    
    # === OPERATIONS
    # ==================================================================================================== 
    sOldMsg = CellGetS(cCube, pProcess, sUser, sYear, sDate, sTime, sMillisecond, 'Message');
    sNewMsg = sOldMsg | IF(sOldMsg @= '', '', cCrLf) | sMessage;
    
    # *** Message logging
    # ****************************************
    sMeasure = 'Timestamp';
    If(CellIsUpdateable(cCube, pProcess, sUser, sYear, sDate, sTime, sMillisecond, sMeasure) = 1);
        CellPutS(sTimestamp, cCube, pProcess, sUser, sYear, sDate, sTime, sMillisecond, sMeasure);
    EndIf;
    
    sMeasure = 'User';
    If(CellIsUpdateable(cCube, pProcess, sUser, sYear, sDate, sTime, sMillisecond, sMeasure) = 1);
        CellPutS(sUser, cCube, pProcess, sUser, sYear, sDate, sTime, sMillisecond, sMeasure);
    EndIf;
    
    sMeasure = 'User Display Value';
    If(CellIsUpdateable(cCube, pProcess, sUser, sYear, sDate, sTime, sMillisecond, sMeasure) = 1);
        CellPutS(sUserDisplayValue, cCube, pProcess, sUser, sYear, sDate, sTime, sMillisecond, sMeasure);
    EndIf;
    
    sMeasure = 'Message Count';
    If(CellIsUpdateable(cCube, pProcess, sUser, sYear, sDate, sTime, sMillisecond, sMeasure) = 1);
        CellPutN(1, cCube, pProcess, sUser, sYear, sDate, sTime, sMillisecond, sMeasure);
    EndIf;
    
    sMeasure = 'Message Type';
    If(CellIsUpdateable(cCube, pProcess, sUser, sYear, sDate, sTime, sMillisecond, sMeasure) = 1);
        CellPutS(sMessageType, cCube, pProcess, sUser, sYear, sDate, sTime, sMillisecond, sMeasure);
    EndIf;
    
    sMeasure = 'Message';
    If(CellIsUpdateable(cCube, pProcess, sUser, sYear, sDate, sTime, sMillisecond, sMeasure) = 1);
        CellPutS(sNewMsg, cCube, pProcess, sUser, sYear, sDate, sTime, sMillisecond, sMeasure);
    EndIf;

    # *** Latest message logging
    # ****************************************
    sMeasure = 'Timestamp';
    If(CellIsUpdateable(cCube, pProcess, sUser, cTotalYear, cTotalDate, cTotalTime, cTotalMillisecond, sMeasure) = 1);
        CellPutS(sTimestamp, cCube, pProcess, sUser, cTotalYear, cTotalDate, cTotalTime, cTotalMillisecond, sMeasure);
    EndIf;
    
    sMeasure = 'User';
    If(CellIsUpdateable(cCube, pProcess, sUser, cTotalYear, cTotalDate, cTotalTime, cTotalMillisecond, sMeasure) = 1);
        CellPutS(sUser, cCube, pProcess, sUser, cTotalYear, cTotalDate, cTotalTime, cTotalMillisecond, sMeasure);
    EndIf;
    
    sMeasure = 'User Display Value';
    If(CellIsUpdateable(cCube, pProcess, sUser, cTotalYear, cTotalDate, cTotalTime, cTotalMillisecond, sMeasure) = 1);
        CellPutS(sUserDisplayValue, cCube, pProcess, sUser, cTotalYear, cTotalDate, cTotalTime, cTotalMillisecond, sMeasure);
    EndIf;
    
    sMeasure = 'Message Type';
    If(CellIsUpdateable(cCube, pProcess, sUser, cTotalYear, cTotalDate, cTotalTime, cTotalMillisecond, sMeasure) = 1);
        CellPutS(sMessageType, cCube, pProcess, sUser, cTotalYear, cTotalDate, cTotalTime, cTotalMillisecond, sMeasure);
    EndIf;
    
    sMeasure = 'Message';
    If(CellIsUpdateable(cCube, pProcess, sUser, cTotalYear, cTotalDate, cTotalTime, cTotalMillisecond, sMeasure) = 1);
        CellPutS(sMessage, cCube, pProcess, sUser, cTotalYear, cTotalDate, cTotalTime, cTotalMillisecond, sMeasure);
    EndIf;
    
    
    # === CUBE LOGGING REACTIVATION
    # ====================================================================================================
    If(CubeExists('}CubeProperties') = 1);
        CellPutS(cCube_LoggingValue, '}CubeProperties', cCube, 'LOGGING');
    EndIf;
    
Else;
    
    # === ERROR LOGGING
    # ==================================================================================================== 
    If((pDebugMode = 1) % (pDebugMode = 2));
        nDateTime = Now;
        
        pProcess = cProcessName;
        sUser = cTM1User;
        sYear = TimSt(nDateTime, '\Y');
        sDate = TimSt(nDateTime, '\m-\d');
        sTime = TimSt(nDateTime, '\h:\i:\s');
        sMillisecond = '000';
        
        sTimeStamp = TimSt(nDateTime, '\Y-\m-\d \h:\i:\s');
        sUser = cTM1User;
        sMessageType = 'Error';
        sMessage = sErrorMsg;
        
        sOldMsg = CellGetS(cCube, pProcess, sUser, sYear, sDate, sTime, sMillisecond, 'Message');
        sNewMsg = sOldMsg | IF(sOldMsg @= '', '', cCrLf) | sErrorMsg;
    
        # *** Message logging
        # ****************************************
        sMeasure = 'Timestamp';
        If(CellIsUpdateable(cCube, pProcess, sUser, sYear, sDate, sTime, sMillisecond, sMeasure) = 1);
            CellPutS(sTimestamp, cCube, pProcess, sUser, sYear, sDate, sTime, sMillisecond, sMeasure);
        EndIf;
        
        sMeasure = 'User';
        If(CellIsUpdateable(cCube, pProcess, sUser, sYear, sDate, sTime, sMillisecond, sMeasure) = 1);
            CellPutS(sUser, cCube, pProcess, sUser, sYear, sDate, sTime, sMillisecond, sMeasure);
        EndIf;
        
        sMeasure = 'User Display Value';
        If(CellIsUpdateable(cCube, pProcess, sUser, sYear, sDate, sTime, sMillisecond, sMeasure) = 1);
            CellPutS(sUser, cCube, pProcess, sUser, sYear, sDate, sTime, sMillisecond, sMeasure);
        EndIf;
        
        sMeasure = 'Message Count';
        If(CellIsUpdateable(cCube, pProcess, sUser, sYear, sDate, sTime, sMillisecond, sMeasure) = 1);
            CellPutN(1, cCube, pProcess, sUser, sYear, sDate, sTime, sMillisecond, sMeasure);
        EndIf;
        
        sMeasure = 'Message Type';
        If(CellIsUpdateable(cCube, pProcess, sUser, sYear, sDate, sTime, sMillisecond, sMeasure) = 1);
            CellPutS(sMessageType, cCube, pProcess, sUser, sYear, sDate, sTime, sMillisecond, sMeasure);
        EndIf;
        
        sMeasure = 'Message';
        If(CellIsUpdateable(cCube, pProcess, sUser, sYear, sDate, sTime, sMillisecond, sMeasure) = 1);
            CellPutS(sNewMsg, cCube, pProcess, sUser, sYear, sDate, sTime, sMillisecond, sMeasure);
        EndIf;
    
        # *** Latest message logging
        # ****************************************
        sMeasure = 'Timestamp';
        If(CellIsUpdateable(cCube, pProcess, sUser, cTotalYear, cTotalDate, cTotalTime, cTotalMillisecond, sMeasure) = 1);
            CellPutS(sTimestamp, cCube, pProcess, sUser, cTotalYear, cTotalDate, cTotalTime, cTotalMillisecond, sMeasure);
        EndIf;
        
        sMeasure = 'User';
        If(CellIsUpdateable(cCube, pProcess, sUser, cTotalYear, cTotalDate, cTotalTime, cTotalMillisecond, sMeasure) = 1);
            CellPutS(sUser, cCube, pProcess, sUser, cTotalYear, cTotalDate, cTotalTime, cTotalMillisecond, sMeasure);
        EndIf;
        
        sMeasure = 'User Display Value';
        If(CellIsUpdateable(cCube, pProcess, sUser, cTotalYear, cTotalDate, cTotalTime, cTotalMillisecond, sMeasure) = 1);
            CellPutS(sUser, cCube, pProcess, sUser, cTotalYear, cTotalDate, cTotalTime, cTotalMillisecond, sMeasure);
        EndIf;
        
        sMeasure = 'Message Type';
        If(CellIsUpdateable(cCube, pProcess, sUser, cTotalYear, cTotalDate, cTotalTime, cTotalMillisecond, sMeasure) = 1);
            CellPutS(sMessageType, cCube, pProcess, sUser, cTotalYear, cTotalDate, cTotalTime, cTotalMillisecond, sMeasure);
        EndIf;
        
        sMeasure = 'Message';
        If(CellIsUpdateable(cCube, pProcess, sUser, cTotalYear, cTotalDate, cTotalTime, cTotalMillisecond, sMeasure) = 1);
            CellPutS(sMessage, cCube, pProcess, sUser, cTotalYear, cTotalDate, cTotalTime, cTotalMillisecond, sMeasure);
        EndIf;
        
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
