601,100
602,"}izi.dimension.rollup.createfromattribute"
562,"NULL"
586,
585,
564,
565,"t5XlecorkcnDuJ_GUmY;aAs8=sKgWrXwZbR9Rz98;H7Hsj5x0A@U>fV@oIv`h?euJMg`XzV4RleLayRV285GZ:=?ED\Vc]1<LbO@sv0fq\D?zE?9F_6clg:rcwJ=Rlo6GKXStERECruyp2FJKoN]S]1JR_\rrws_0QEYR8>aD[p]acr?TT6kxf;wa9K=<DFQV1`A8t`0"
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
560,6
pDebugMode
pDimension
pAttribute
pRollUp
pRollUpAsPrefix
pInsertionPoint
561,6
1
2
2
2
1
2
590,6
pDebugMode,0
pDimension,""
pAttribute,""
pRollUp,""
pRollUpAsPrefix,0
pInsertionPoint,""
637,6
pDebugMode,"[Optional] 0 = Nothing | 1 = Write to }izi.ProcessMessage cube | 2 = 1 + Keep temporary objects"
pDimension,"[Mandatory] Dimension name"
pAttribute,"[Mandatory] Attribute name"
pRollUp,"[Optional] Roll-up name. This parameter is used differently depending on pRootElementType"
pRollUpAsPrefix,"[Optional] 0 = Do not use the roll-up name as a prefix | 1 = Use the roll-up name as a prefix to the attribute name"
pInsertionPoint,"[Optional] An existing dimension element. The element being added to the dimension will be inserted immediately before this existing element"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,163

#****Begin: Generated Statements***
#****End: Generated Statements****

# ######  ######  ######
#   ##       ##     ##
#   ##      ##      ##
#   ##     ##       ##
# ######  ######  ######
# https://github.com/ichermak/Izi

# ====================================================================================================
# Description : Create roll-up(s) based on attribute values
#
# Updates :
# 	- 2020/01/27 - Ifthen CHERMAK (www.linkedin.com/in/ichermak) : Creation 
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

# *** Other variables
# ****************************************
cElementAttributes = ' }ElementAttributes_' | Trim(pDimension);

# === PARAMETERS VERIFICATION AND OTHER CHECKS
# ====================================================================================================
If((pDebugMode = 1) % (pDebugMode = 2));
    sNewMsg = Expand('Process started with : pDimension=%pDimension%, pAttribute=%pAttribute%, pRollUp=%pRollUp%, pRollUpAsPrefix=%pRollUpAsPrefix%, pInsertionPoint=%pInsertionPoint%.');
    ExecuteProcess('}izi.process.message.add'
                , 'pProcess', cProcessName
                , 'pMessage', sNewMsg
                );
EndIf;

sErrorMsg = '';
pDimension = Trim(pDimension);
pAttribute = Trim(pAttribute);
pRollUp = Trim(pRollUp);
pInsertionPoint = Trim(pInsertionPoint);

If(pDimension @= '');
    sNewMsg = Expand('Invalid parameter : pDimension=%pDimension%.');
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If(DimensionExists(pDimension) = 0);
    sNewMsg = Expand('Invalid parameter : pDimension=%pDimension%.');
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If(CubeExists(cElementAttributes) = 0);
    sNewMsg = Expand('Invalid parameter : pDimension=%pDimension%. Dimension has no attributes.'); 
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If(pAttribute @= '');
    sNewMsg = Expand('Invalid parameter : pAttribute=%pAttribute%.'); 
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If(DimIx(cElementAttributes, pAttribute) = 0);
    sNewMsg = Expand('Invalid parameter : pAttribute=%pAttribute%.'); 
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If(DType(cElementAttributes, pAttribute) @<> 'AS');
    sNewMsg = Expand('Invalid parameter : pAttribute=%pAttribute%. Only string attributes are allowed.'); 
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If((pRollUpAsPrefix <> 0) & (pRollUpAsPrefix <> 1));
    sNewMsg = Expand('Invalid parameter : pRollUpAsPrefix=%pRollUpAsPrefix%.'); 
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If((pInsertionPoint @<> '') & (DimIx(pDimension, pInsertionPoint) = 0));
    sNewMsg = Expand('Invalid parameter : pInsertionPoint=%pInsertionPoint%.'); 
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If(sErrorMsg @<> '');
    If((pDebugMode = 1) % (pDebugMode = 2));
    sNewMsg = sErrorMsg;
        ExecuteProcess('}izi.process.message.add'
                    , 'pProcess', cProcessName
                    , 'pMessage', sNewMsg
                    );
    EndIf;
    ProcessBreak;
EndIf;

pAttribute = DimensionElementPrincipalName(cElementAttributes, pAttribute);
pInsertionPoint = DimensionElementPrincipalName(pDimension, pInsertionPoint);


# === OPERATIONS
# ====================================================================================================
sDimSize = DimSiz(pDimension);

# *** Dimension settings
# ****************************************
DimensionSortOrder(pDimension, 'BYINPUT', 'ASCENDING', 'BYHIERARCHY', 'ASCENDING');

# *** Root element insertion
# ****************************************
If(Trim(pRollUp) @<> '');
    sRootElement = pRollUp;
    If(pRollUpAsPrefix = 1);
        sRootElement = Expand('%pRollUp% %pAttribute%');
    EndIf;
    
    If(DimIx(pDimension, sRootElement) = 0);
        DimensionElementInsertDirect(pDimension, pInsertionPoint, sRootElement, 'C');
    EndIf;
EndIf;


# *** Other elements insertion
# ****************************************
nMax = sDimSize;
nCtr = 1;
While(nCtr <= nMax);
    sElement = DimNm(pDimension, nCtr);
    If(sElement @<> sRootElement);
        sParent = CellGetS(cElementAttributes, sElement, pAttribute);
        If(Trim(sParent) @<> '');
            If(DimIx(pDimension, sParent) = 0);
                DimensionElementInsertDirect(pDimension, pInsertionPoint, sParent, 'C');
            EndIf;
            DimensionElementComponentAddDirect(pDimension, sParent, sElement, 1);
            
            If(DimIx(pDimension, sRootElement) <> 0);
                DimensionElementComponentAddDirect(pDimension, sRootElement, sParent, 1);
            EndIf;
        EndIf;
    EndIf;
    nCtr = nCtr + 1;
End;
573,3

#****Begin: Generated Statements***
#****End: Generated Statements****
574,3

#****Begin: Generated Statements***
#****End: Generated Statements****
575,21

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
                        ); 
    EndIf;
    
    sNewMsg = Expand('Process finished with : PrologMinorErrorCount=%PrologMinorErrorCount%, MetadataMinorErrorCount=%MetadataMinorErrorCount%, DataMinorErrorCount=%DataMinorErrorCount%.');
    ExecuteProcess('}izi.process.message.add'
                , 'pProcess', cProcessName
                , 'pMessage', sNewMsg
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
