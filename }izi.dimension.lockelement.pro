601,100
602,"}izi.dimension.lockelement"
562,"NULL"
586,
585,
564,
565,"gsFBPIAaJIn=28aAY=[TC=?T_ke\Wt=bmvxEMaSg6PK0^YvXq<Ny?4bDJmwU\rF6NLuoq>>Xz9@dAar=CW@DIEkTmcFFbu9l<bw4=5]:qG6FG?SfUrb@`Jr:U<MiTr>=qTTeinOwi9Xm@3FVBxV\[s7m]?LFHNXPg<Htc\9NK^F^Lv=U:ukVg9g4mpCdIK^KJn:<]VjE"
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
560,4
pLogOutput
pLockingValue
pDimension
pElement
561,4
1
2
2
2
590,4
pLogOutput,0
pLockingValue,""
pDimension,"Scenario"
pElement,"Actual"
637,4
pLogOutput,"[Optional] 0 = Nothing | 1 = Write to server message log | 2 = 1 + Keep temporary objects"
pLockingValue,"[Optional] User name or blank to unlock the element"
pDimension,"[Required] Dimension name"
pElement,"[Required] Element name"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,97

#****Begin: Generated Statements***
#****End: Generated Statements****

# ######  ######  ######
#   ##       ##     ##
#   ##      ##      ##
#   ##     ##       ##
# ######  ######  ######
# https://github.com/ichermak/Izi

# ====================================================================================================
# Description : ...
#
# Parameters : 
# 	- pLogOutput : [Optional] 0 = Nothing | 1 = Write to server message log | 2 = 1 + Keep temporary objects
# 	- pLockingValue : [Optional] User name or blank to unlock the element
# 	- pDimension : [Required] Dimension name
# 	- pElement : [Required] Element name
#
# Updates :
# 	- 2019/10/24 - ICH (www.linkedin.com/in/ichermak) : Creation    
# ====================================================================================================

pDebugMode = pLogOutput;

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

pLockingValue = Trim(pLockingValue);
pDimension = Trim(pDimension);
pElement = Trim(pElement);

If( (pLockingValue @<> '') & (DimIx('}Clients', pLockingValue) = 0) );
	sNewMsg = Expand('Invalid parameter : pLockingValue=%pLockingValue%.');
 	sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', Char(10)) | sNewMsg;
 	nError = 1;
EndIf;

If(DimIx('}Dimensions', pDimension) = 0);
	sNewMsg = Expand('Invalid parameter : pDimension=%pDimension%'); 
 	sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', Char(10)) | sNewMsg;
 	nError = 1;
EndIf;

If(DimIx(pDimension, pElement) = 0);
	sNewMsg = Expand('Invalid parameter : pElement=%pElement%'); 
 	sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', Char(10)) | sNewMsg;
 	nError = 1;
EndIf;

If(nError <> 0); ProcessBreak; EndIf;

If(pLockingValue @<> ''); pLockingValue = DimensionElementPrincipalName('}Clients', pLockingValue); EndIf;
pDimension = DimensionElementPrincipalName('}Dimensions', pDimension);
pElement = DimensionElementPrincipalName(pDimension, pElement);


# === OPERATIONS
# ====================================================================================================
sTargetCube = '}ElementProperties_' | pDimension;
CubeLockOverride(1);
CellPutS(pLockingValue, sTargetCube, pElement, 'LOCK');
CubeLockOverride(0);


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
