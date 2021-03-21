601,100
602,"}izi.server.folderstructure.create"
562,"NULL"
586,
585,
564,
565,"aa?JnRJ9CFf5;B<sENb:@u[b=7i2CRsk=C7?THm4IB=OClNj:P?zLmP__Sm@07<3:dpS@kavUo>8bDfG32xN0xUKe25Zw`xVntuEUtV1HRkjNo\IG3Rl^4`=ArFC@RnpW=<[:CJkhjvDipU:>@F90Z?8jix9`95ZA>HXh[64hO_T::xg0PXxzB@2ceX3^<WrZS>27Xst"
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
560,2
pDebugMode
pFolderPath
561,2
1
2
590,2
pDebugMode,0
pFolderPath,""
637,2
pDebugMode,"[Optional] 0 = Nothing | 1 = Write to server message log | 2 = 1 + Keep temporary objects"
pFolderPath,"[Required] Folder path (Example: C:\FolderA\FolderB\FolderC)"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,80

#****Begin: Generated Statements***
#****End: Generated Statements****

# ######  ######  ######
#   ##       ##     ##
#   ##      ##      ##
#   ##     ##       ##
# ######  ######  ######
# https://github.com/ichermak/Izi

# ====================================================================================================
# Description : Create a folder structure
#
# Parameters : 
# 	- pDebugMode : [Optional] 0 = Nothing | 1 = Write to server message log | 2 = 1 + Keep temporary objects
# 	- pFolderPath : [Required] Folder path (Example: C:\FolderA\FolderB\FolderC)
#
# Updates :
# 	- 2020/05/26 - ICH (www.linkedin.com/in/ichermak) : Creation
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

pFolderPath = Trim(pFolderPath);

If(pFolderPath @= '');
	sNewMsg = Expand('Invalid parameter : pFolderPath=%pFolderPath%.'); 
 	sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', Char(10)) | sNewMsg;
 	nError = 1;
EndIf;

If(nError <> 0); ProcessBreak; EndIf;


# === OPERATIONS
# ==================================================================================================== 
If(FileExists(pFolderPath) = 0);
     sCmd = Expand('New-Item -ItemType "Directory" -Path "%pFolderPath%" -Force');
     sCmd = Expand('Powershell -ExecutionPolicy Bypass -command "%sCmd%"');
     ExecuteCommand(sCmd, 1);
     If(pDebugMode >= 1);
          sNewMsg = Expand('''%pFolderPath%'' --> Created');
          ASCIIOutput(cDebugFile, sNewMsg);
     EndIf;
EndIf;

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
