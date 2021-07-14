601,100
602,"}izi.dimension.element.lock"
562,"NULL"
586,
585,
564,
565,"pClBYA\6nxqTdd41awUjwO[5SQj^ltSp?u6387zI7vjY[lwGO4wRDVCeN3J<?tbSvR;ui^HiB1cn_TW1wz1Bm]ZKuV^ml_R@6\@=^]Xhn4^2rjZZq5HvQl7IUsQJIpR7Uks71^ts84ZKG[``>SEmCKR2h?bt\Nw\nzlYyVQamey8rjz[fLlVT;Bd;c?Os97Zfebow3mJ"
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
589," "
568,""""
570,
571,
569,0
592,0
599,1000
560,4
pDebugMode
pLocker
pDimension
pElement
561,4
1
2
2
2
590,4
pDebugMode,0
pLocker,""
pDimension,""
pElement,""
637,4
pDebugMode,"[Optional] 0 = Nothing | 1 = Write to }izi.ProcessMessage cube | 2 = 1 + Keep temporary objects"
pLocker,"[Mandatory] Client name or blank to unlock the element (Example : 'Admin')"
pDimension,"[Mandatory] Dimension name (Example : 'Scenario')"
pElement,"[Mandatory] Element name (Example : 'Actual')"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,104

#****Begin: Generated Statements***
#****End: Generated Statements****

# ######  ######  ######
#   ##       ##     ##
#   ##      ##      ##
#   ##     ##       ##
# ######  ######  ######
# https://github.com/ichermak/Izi

# ====================================================================================================
# Description : Locks a dimension element with a given locker name.
#
# Updates :
# 	- 2019/10/24 - Ifthen CHERMAK (www.linkedin.com/in/ichermak) : Creation    
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
cIdExecution = cProcessName | '_' | TimSt(cStartTime, '\Y\m\d\h\i\s') | '_' | cTM1User  | '_' | Fill('0', 5 - Long(NumberToString(Int(Rand * 65536)))) | NumberToString(Int(Rand * 65536));
cDebugFile = GetProcessErrorFileDirectory | cIdExecution | '.dbg';
cTemporaryObject = 1;
If(pDebugMode > 1); cTemporaryObject = 0; EndIf;


# === PARAMETERS VERIFICATION AND OTHER CHECKS
# ====================================================================================================
If((pDebugMode = 1) % (pDebugMode = 2));
    sNewMsg = Expand('Process started with : pLocker=%pLocker%, pDimension=%pDimension%, pElement=%pElement%.');
    ExecuteProcess('}izi.process.message.add'
                , 'pProcess', cProcessName
                , 'pMessage', sNewMsg
                , 'pMessageType', 'Info'
                );
EndIf;

sErrorMsg = '';
pLocker = Trim(pLocker);
pDimension = Trim(pDimension);
pElement = Trim(pElement);

If((pLocker @<> '') & (DimIx('}Clients', pLocker) = 0));
	sNewMsg = Expand('Invalid parameter : pLocker=%pLocker%.');
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If(DimIx('}Dimensions', pDimension) = 0);
	sNewMsg = Expand('Invalid parameter : pDimension=%pDimension%.'); 
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If(DimIx(pDimension, pElement) = 0);
	sNewMsg = Expand('Invalid parameter : pElement=%pElement%.'); 
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

If(pLocker @<> ''); pLocker = DimensionElementPrincipalName('}Clients', pLocker); EndIf;
pDimension = DimensionElementPrincipalName('}Dimensions', pDimension);
pElement = DimensionElementPrincipalName(pDimension, pElement);


# === OPERATIONS
# ====================================================================================================
sElementProperties = '}ElementProperties_' | pDimension;
If(CubeExists(sElementProperties) = 0);
    CubeCreate(sElementProperties, pDimension, '}ElementProperties');
EndIf;

CubeLockOverride(1);
CellPutS(pLocker, sElementProperties, pElement, 'LOCK');
CubeLockOverride(0);
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
