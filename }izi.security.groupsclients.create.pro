601,100
602,"}izi.security.groupsclients.create"
562,"NULL"
586,
585,
564,
565,"nK1F\1h6iPFdb>a]xAA?<wTGxx[P0d[h2d?MdWEjW8Q1oP9SNX`kWANW`O[4[TZHom<pqJh?RqOWq`H38>7wcn5^6hDl1i_QcOj^k>FBxh<c7tZB73f1t8M:v4No?=X05T2k4Rc75Kkhk?GATrq3:CKci4Ya6hckW]eZpmBxSu7tSX:]SKlp`A19wnQ6?1e^_nXyna_["
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
570,
571,
569,0
592,0
599,1000
560,1
pDebugMode
561,1
1
590,1
pDebugMode,0
637,1
pDebugMode,"[Optional] 0 = Nothing | 1 = Write to server message log | 2 = 1 + Keep temporary objects"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,83

#****Begin: Generated Statements***
#****End: Generated Statements****

# ######  ######  ######
#   ##       ##     ##
#   ##      ##      ##
#   ##     ##       ##
# ######  ######  ######
# https://github.com/ichermak/Izi

# ====================================================================================================
# Description : Create security croups with clients names
#
# Parameters : 
# 	- pDebugMode : [Optional] 0 = Nothing | 1 = Write to server message log | 2 = 1 + Keep temporary objects
#
# Updates :
# 	- 2019/12/13 - ICH (www.linkedin.com/in/ichermak) : Creation
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

# <Do something here>
# If(Condition);
# 	sNewMsg = Expand('Invalid parameter : pParameter1=%pParameter1%.'); 
# 	sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', Char(10)) | sNewMsg;
# 	nError = 1;
# EndIf

If(nError <> 0); ProcessBreak; EndIf;


# === OPERATIONS
# ====================================================================================================
sDim = '}Clients';
nCtr = DimSiz( sDim );
While( nCtr > 0 );
     sEle = DimNm( sDim, nCtr );
     If(sEle @<> 'Admin');
          DeleteGroup(sEle);
          AddGroup(sEle);
          SecurityRefresh;
          AssignClientToGroup(sEle, sEle);
     EndIf;
     nCtr = nCtr - 1;
End;
SecurityRefresh;


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
