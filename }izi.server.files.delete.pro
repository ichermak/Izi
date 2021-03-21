601,100
602,"}izi.server.files.delete"
562,"NULL"
586,"Template"
585,"Template"
564,
565,"aaFq?9hwx\<3akU3i>mH<>_N4@Zl8>;EmukLTQqPt\nz9H@fV\6Aykxg2;b4YwA\SjH<9\x9Ws^0yyA^_?J>vb_q:c88kwp9E^Cd0Kj_m2XZziY]R1_;3FoSW;L@9MBxbaAKf`c\cW_gK9gUljJbal61m;]ivvr2UqmvZvmNQv6kgS`b6Ov?6Mf7FudGi`fzfGEk6NWI"
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
589,
568,""""
570,SourceView
571,
569,0
592,0
599,1000
560,6
pDebugMode
pFilePath
pFileName
pRecurse
pLastWritetimeMoreThanNbDaysAgo
pWaitForExecution
561,6
1
2
2
1
1
1
590,6
pDebugMode,0
pFilePath,""
pFileName,""
pRecurse,0
pLastWritetimeMoreThanNbDaysAgo,0
pWaitForExecution,1
637,6
pDebugMode,"[Optional] 0 = Nothing | 1 = Write to server message log | 2 = 1 + Keep temporary objects"
pFilePath,"[Required] File path"
pFileName,"[Required] File name. Wildcard expressions are supported (Example : '}TI-Temp-*')"
pRecurse,"[Optional] 0 = Nothing | 1 = Search files recursively within the given path 'pFilePath'"
pLastWritetimeMoreThanNbDaysAgo,"[Optional] 0 = Nothing | <Int> = Age of files to be deleted (Number of days)"
pWaitForExecution,"[Optional] 0 = Asynchronous execution | 1 = Synchronous execution"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,109

#****Begin: Generated Statements***
#****End: Generated Statements****

# ######  ######  ######
#   ##       ##     ##
#   ##      ##      ##
#   ##     ##       ##
# ######  ######  ######
# https://github.com/ichermak/Izi

# ====================================================================================================
# Description : Delete a file in a specified folder path
#
# Parameters : 
# 	- pDebugMode : [Optional] 0 = Nothing | 1 = Write to server message log | 2 = 1 + Keep temporary objects
# 	- pFilePath : [Required] File path
# 	- pFileName : [Required] File name. Wildcard expressions are supported (Example : '}TI-Temp-*')
# 	- pRecurse : [Optional] 0 = Nothing | 1 = Search files recursively within the given path 'pFilePath'
# 	- pLastWritetimeMoreThanNbDaysAgo : [Optional] 0 = Nothing | <Int> = Age of files to be deleted (Number of days)
#
# Updates :
# 	- 2020/01/09 - ICH (www.linkedin.com/in/ichermak) : Creation
# 	- 2020/03/30 - ICH (www.linkedin.com/in/ichermak) : Two additional parameters 'pRecurse' and 'pLastWritetimeMoreThanNbDaysAgo' have been added
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
If(DimIx('}Clients', Tm1User) = 0); cTM1User = 'Chore'; Else; cTM1User = Tm1User; EndIf;
cStartTime = Now;
cProcessName = GetProcessName;
cIdExecution = cProcessName | '_' | TimSt(cStartTime, '\Y\m\d\h\i\s') | '_' | cTM1User  | '_' | Fill( '0', 5 - Long(NumberToString(Int(Rand * 65536)))) | NumberToString(Int(Rand * 65536));
cDebugFile = GetProcessErrorFileDirectory | cIdExecution | '.dbg';
cTemporaryObject = 1;
If(pDebugMode > 1); cTemporaryObject = 0; EndIf;


# === LOG / AUDIT
# ====================================================================================================
sErrorMsg = '';
# <Do something here>
# sNewMsg = Expand('Process started with : pParameter1=%pParameter1%, pParameter2=%pParameter2%.');


# === PARAMETERS VERIFICATION AND OTHER CHECKS
# ====================================================================================================
nError = 0;

pFilePath = Trim(pFilePath);
pFilePath = IF(Subst(pFilePath, Long(pFilePath), 1) @= '\', pFilePath, pFilePath | '\');
pFileName = Trim(pFileName);
pRecurse = INT(pRecurse);
pLastWritetimeMoreThanNbDaysAgo = INT(pLastWritetimeMoreThanNbDaysAgo);
pWaitForExecution = INT(pWaitForExecution);

If(FileExists(pFilePath) = 0);
     sNewMsg = Expand('Invalid parameter : pFilePath=%pFilePath%.'); 
     sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', Char(10)) | sNewMsg;
     nError = 1;
EndIf;

If(pFileName @= '');
     sNewMsg = Expand('Invalid parameter : pFileName=%pFileName%.'); 
     sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', Char(10)) | sNewMsg;
     nError = 1;
EndIf;

If( (pRecurse <> 0) & (pRecurse <> 1) );
     sNewMsg = Expand('Invalid parameter : pRecurse=%pRecurse%.'); 
     sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', Char(10)) | sNewMsg;
     nError = 1;
EndIf;

If(pLastWritetimeMoreThanNbDaysAgo < 0);
     sNewMsg = Expand('Invalid parameter : pLastWritetimeMoreThanNbDaysAgo=%pLastWritetimeMoreThanNbDaysAgo%.'); 
     sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', Char(10)) | sNewMsg;
     nError = 1;
EndIf;

If( (pWaitForExecution <> 0) & (pWaitForExecution <> 1) );
     sNewMsg = Expand('Invalid parameter : pWaitForExecution=%pWaitForExecution%.'); 
     sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', Char(10)) | sNewMsg;
     nError = 1;
EndIf;

If(nError <> 0); ProcessBreak; EndIf;


# === FILES DELETION
# ====================================================================================================
sLastWritetimeMoreThanNbDaysAgo = NumberToString(pLastWritetimeMoreThanNbDaysAgo);
sCmd = Expand('Get-ChildItem -Path ''%pFilePath%'' -Filter ''%pFileName%''') | IF(pRecurse <> 0, ' -Recurse', '') | IF(pLastWritetimeMoreThanNbDaysAgo <> 0, Expand(' | Where-Object LastWriteTime -lt (Get-Date).AddDays(-%sLastWritetimeMoreThanNbDaysAgo%)'), '') | ' | Remove-Item';
sCmd = Expand('Powershell -ExecutionPolicy Bypass -command "%sCmd%"');
ExecuteCommand(sCmd, pWaitForExecution);


# === PROLOG ERRORS
# ====================================================================================================
If(sErrorMsg @<> '');
     sNewMsg = sErrorMsg;
     sErrorMsg = '';
     ItemReject(sNewMsg);
EndIf;
573,3

#****Begin: Generated Statements***
#****End: Generated Statements****
574,3

#****Begin: Generated Statements***
#****End: Generated Statements****
575,17

#****Begin: Generated Statements***
#****End: Generated Statements****

# === LOG / AUDIT
# ====================================================================================================
cProcessErrorFilename = GetProcessErrorFileDirectory | GetProcessErrorFilename;
If(FileExists(cProcessErrorFilename) <> 0);
     # <Do something here>
EndIf;

# sNewMsg = Expand('Process finished with : PrologMinorErrorCount=%PrologMinorErrorCount%, MetadataMinorErrorCount=%MetadataMinorErrorCount%, DataMinorErrorCount=%DataMinorErrorCount%.');
# <Do something here>

If(sErrorMsg @<> '');
     ItemReject(sErrorMsg);
EndIf;
576,CubeAction=1511DataAction=1503CubeLogChanges=0
930,0
638,1
804,0
1217,0
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
