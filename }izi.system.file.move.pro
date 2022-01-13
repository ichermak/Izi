601,100
602,"}izi.system.file.move"
562,"NULL"
586,
585,
564,
565,"y[@fX:hx3psYVJnEnwwIAv[OHa_B@_m^oTz3Em12lQEFT=uarj;uDCE^x8R0]ch@IOE52Xn@bqaU<Np=wW3;`OCLPpBC8gNX>U4[8pB^zMq`BY;qGuonGQD;H4xd7_JyH6TWqQvY@EghZ4Y=ap?uInW33<cAgBFcoVoXLBu^IVx\EV2QJ<@vbccSacWOH7Pq`o@<]rNj"
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
588,"."
589,","
568,""""
570,
571,
569,0
592,0
599,1000
560,6
pDebugMode
pFileDirectory
pFileName
pDestination
pRecurse
pWaitForExecution
561,6
1
2
2
2
1
1
590,6
pDebugMode,0
pFileDirectory,""
pFileName,""
pDestination,""
pRecurse,0
pWaitForExecution,1
637,6
pDebugMode,"[Optional] 0 = Nothing | 1 = Write to }izi.ProcessMessage cube | 2 = 1 + Keep temporary objects"
pFileDirectory,"[Mandatory] File directory (Example : 'C:\Applications\Tm1\Izi\Temp')"
pFileName,"[Mandatory] File name. Wildcard expressions are supported (Example : '*_2020.csv')"
pDestination,"[Mandatory] Destination directory (Example : 'C:\Applications\Sources')"
pRecurse,"[Optional] 0 = Nothing | 1 = Search files recursively within the given directory 'pFileDirectory'"
pWaitForExecution,"[Optional] 0 = Asynchronous execution | 1 = Synchronous execution"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,113

#****Begin: Generated Statements***
#****End: Generated Statements****

# ######  ######  ######
#   ##       ##     ##
#   ##      ##      ##
#   ##     ##       ##
# ######  ######  ######
# https://github.com/ichermak/Izi

# ====================================================================================================
# Description : Move a file from a given directory to a specified destination
#
# Updates :
# 	- 2022/01/13 - Ifthen CHERMAK (www.linkedin.com/in/ichermak) : Creation
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
    sNewMsg = Expand('Process started with : pFileDirectory=%pFileDirectory%, pFileName=%pFileName%, pDestination=%pDestination%, pRecurse=%pRecurse%, pWaitForExecution=%pWaitForExecution%.');
    ExecuteProcess('}izi.process.message.add'
                , 'pProcess', cProcessName
                , 'pMessage', sNewMsg
                , 'pMessageType', 'Info'
                );
EndIf;

sErrorMsg = '';
pFileDirectory = Trim(pFileDirectory);
pFileDirectory = IF(Subst(pFileDirectory, Long(pFileDirectory), 1) @= '\', pFileDirectory, pFileDirectory | '\');
pFileName = Trim(pFileName);
pDestination = Trim(pDestination);
pRecurse = INT(pRecurse);
pWaitForExecution = INT(pWaitForExecution);

If(FileExists(pFileDirectory) = 0);
    sNewMsg = Expand('Invalid parameter : pFileDirectory=%pFileDirectory%.'); 
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If(pFileName @= '');
    sNewMsg = Expand('Invalid parameter : pFileName=%pFileName%.'); 
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If(Trim(pDestination) @= '');
    sNewMsg = Expand('Invalid parameter : pDestination=%pDestination%.'); 
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If( (pRecurse <> 0) & (pRecurse <> 1) );
    sNewMsg = Expand('Invalid parameter : pRecurse=%pRecurse%.'); 
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If( (pWaitForExecution <> 0) & (pWaitForExecution <> 1) );
    sNewMsg = Expand('Invalid parameter : pWaitForExecution=%pWaitForExecution%.'); 
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


# === FILES DELETION
# ====================================================================================================
If(pRecurse = 0);
    sPsCmd = Expand('Move-Item -Path ''%pFileDirectory%%pFileName%'' -Destination ''%pDestination%''');
Else;
    sPsCmd = Expand('Get-ChildItem -Path ''%pFileDirectory%'' -Filter ''%pFileName%'' -Recurse | Move-Item -Destination ''%pDestination%''');
EndIf;
sCmd = Expand('Powershell -ExecutionPolicy Bypass -command "%sPsCmd%"');
ExecuteCommand(sCmd, pWaitForExecution);
573,3

#****Begin: Generated Statements***
#****End: Generated Statements****
574,3

#****Begin: Generated Statements***
#****End: Generated Statements****
575,28

#****Begin: Generated Statements***
#****End: Generated Statements****

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
