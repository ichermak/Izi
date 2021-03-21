601,100
602,"}izi.dimension.consolidationhierarchy.createfromattribute"
562,"NULL"
586,"}ElementAttributes_Template"
585,"}ElementAttributes_Template"
564,
565,"urF06HjOfRdf7cS[?xBgYa_BsTww5STs:8N3lTzB8j9lXVR83dX1oF3Yo\hgFR]t3TWGa;eRhyM[8JwZNO\2bVhmUlUGu;V9rk?ZPF\Zm1r]C21<WNlRiemCBj3eRbtggscARWZP9G8>UIHKidUlAqpng]fGnVghxE9uz]1:^DlbRMe?dG8NcC@^I8dx1\Qv;5Ae]<<^"
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
570,Default
571,
569,0
592,0
599,1000
560,6
pDebugMode
pDimension
pAttribute
pRootElementType
pRootElementText
pInsertionPoint
561,6
1
2
2
1
2
2
590,6
pDebugMode,0
pDimension,""
pAttribute,""
pRootElementType,2
pRootElementText,"TOTAL_"
pInsertionPoint,""
637,6
pDebugMode,"[Optional] 0 = Nothing | 1 = Write to server message log | 2 = 1 + Keep temporary objects"
pDimension,"[Required] Dimension name"
pAttribute,"[Required] Attribute name"
pRootElementType,"[Optional] 0 = Nothing | 1 = pRootElementText | 2 = pRootElementText + pAttribute"
pRootElementText,"[Optional] Text for the root element of hierarchy. This parameter is used differently depending on pRootElementType"
pInsertionPoint,"[Optional] An existing dimension element. The element being added to the dimension will be inserted immediately before this existing element"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,171

#****Begin: Generated Statements***
#****End: Generated Statements****

# ######  ######  ######
#   ##       ##     ##
#   ##      ##      ##
#   ##     ##       ##
# ######  ######  ######
# https://github.com/ichermak/Izi

# ====================================================================================================
# Description : Create a secondary consolidation hierarchy based on attribute values
#
# Parameters : 
# 	- pDebugMode : [Optional] 0 = Nothing | 1 = Write to server message log | 2 = 1 + Keep temporary objects
# 	- pDimension : [Required] Dimension name
# 	- pAttribute : [Required] Attribute name
# 	- pRootElementType : [Optional] 0 = Nothing | 1 = pRootElementText | 2 = pRootElementText + pAttribute
# 	- pRootElementText : [Optional] Text for the root element of hierarchy. This parameter is used differently depending on pRootElementType
# 	- pInsertionPoint : [Optional] An existing dimension element. The element being added to the dimension will be inserted immediately before this existing element
#
# Updates :
# 	- 2020/01/27 - ICH (www.linkedin.com/in/ichermak) : Creation 
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

# *** Other
# ****************************************
cElementAttributesDimension = ' }ElementAttributes_' | Trim(pDimension);
cElementAttributesCube = cElementAttributesDimension;
If(pRootElementType = 1);
  cRootElement = Trim(pRootElementText);
ElseIf(pRootElementType = 2);
  cRootElement = Trim(pRootElementText) | Trim(pAttribute);
EndIf;


# === LOG / AUDIT
# ====================================================================================================
sErrorMsg = '';
# <Do something here>
# sNewMsg = Expand('Process started with : pParameter1=%pParameter1%, pParameter2=%pParameter2%.');


# === PARAMETERS VERIFICATION AND OTHER CHECKS
# ====================================================================================================
nError = 0;

pDimension = Trim(pDimension);
pAttribute = Trim(pAttribute);
pRootElementText = Trim(pRootElementText);
pInsertionPoint = Trim(pInsertionPoint);

If(pDimension @= '');
     sNewMsg = Expand('Invalid parameter : pDimension=%pDimension%.');
     sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', Char(10)) | sNewMsg;
     nError = 1;
EndIf;

If(DimensionExists(pDimension) = 0);
     sNewMsg = Expand('Invalid parameter : pDimension=%pDimension%.');
     sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', Char(10)) | sNewMsg;
     nError = 1;
EndIf;

If(CubeExists(cElementAttributesCube) = 0);
     sNewMsg = Expand('Invalid parameter : pDimension=%pDimension%. The dimension has no attributes.'); 
     sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', Char(10)) | sNewMsg;
     nError = 1;
EndIf;

If(pAttribute @= '');
     sNewMsg = Expand('Invalid parameter : pAttribute=%pAttribute%.'); 
     sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', Char(10)) | sNewMsg;
     nError = 1;
EndIf;

If(DimIx(cElementAttributesDimension, pAttribute) = 0);
     sNewMsg = Expand('Invalid parameter : pAttribute=%pAttribute%.'); 
     sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', Char(10)) | sNewMsg;
     nError = 1;
EndIf;

If(DType(cElementAttributesDimension, pAttribute) @<> 'AS');
     sNewMsg = Expand('Invalid parameter : pAttribute=%pAttribute%. Only string attributes are allowed.'); 
     sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', Char(10)) | sNewMsg;
     nError = 1;
EndIf;

If( (pRootElementType <> 0) & (pRootElementType <> 1) & (pRootElementType <> 2) );
     sNewMsg = Expand('Invalid parameter : pRootElementType=%pRootElementType%.'); 
     sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', Char(10)) | sNewMsg;
     nError = 1;
EndIf;

If( ((pRootElementType = 1) % (pRootElementType = 2)) & (pRootElementText @= '') );
     sNewMsg = Expand('Invalid parameter : pRootElementText=%pRootElementText%.'); 
     sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', Char(10)) | sNewMsg;
     nError = 1;
EndIf;

If( (pInsertionPoint @<> '') & (DimIx(pDimension, pInsertionPoint) = 0) );
     sNewMsg = Expand('Invalid parameter : pInsertionPoint=%pInsertionPoint%.'); 
     sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', Char(10)) | sNewMsg;
     nError = 1;
EndIf;

If(nError <> 0); ProcessBreak; EndIf;


# === MAIN PROCESSING
# ====================================================================================================

# *** Dimension settings
# ****************************************
DimensionSortOrder(pDimension, 'BYINPUT', 'ASCENDING', 'BYHIERARCHY', 'ASCENDING');

# *** Root element insertion
# ****************************************
cInitialDimensionElementCount = DimSiz(pDimension);

If( (pRootElementType <> 0) & (DimIx(pDimension, cRootElement) = 0) );
     DimensionElementInsertDirect(pDimension, pInsertionPoint, cRootElement, 'C');
EndIf;

# *** Other elements insertion
# ****************************************
nMax = cInitialDimensionElementCount;
nCtr = 1;
While(nCtr <= nMax);
     sElement = DimNm(pDimension, nCtr);
     sParent = CellGetS(cElementAttributesCube, sElement, pAttribute);
     If(Trim(sParent) @<> '');
          If(DimIx(pDimension, sParent) = 0);
               DimensionElementInsertDirect(pDimension, pInsertionPoint, sParent, 'C');
          EndIf;
          
          If(DimIx(pDimension, cRootElement) <> 0);
               DimensionElementComponentAddDirect(pDimension, cRootElement, sParent, 1);
          EndIf;
          
          DimensionElementComponentAddDirect(pDimension, sParent, sElement, 1);
     EndIf;
     
     nCtr = nCtr + 1;
End;


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
575,18

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
