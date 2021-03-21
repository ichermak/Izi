601,100
602,"}izi.dimension.importfromfile"
562,"CHARACTERDELIMITED"
586,"C:\Template.csv"
585,"C:\Template.csv"
564,
565,"j7VGa3zao2ao6RZCaUqofOmzz9rQ5Kj[TtBp<_2eSDmMVhT=6lI\]Ir=LX=Edx;T3pa1V;pf=DYx77Nzjd7\[PwoKRU3ibCPbnvCBpT^33mO5;\;6m63XkSAJXh>Pm3`11H\zY4iI]wwImNrep<eirZ`?7yBr:]jPj64Q[8Z5FKhLbS^TRsep_[xH7o^c685>OrSzY\="
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
567,";"
588,","
589," "
568,""""
570,
571,
569,1
592,0
599,1000
560,10
pLogOutput
pTargetDimension
pAlias1
pAlias2
pLostHierarchy
pFilePath
pDelimiter
pQuoteCharacter
pDecimalSeparator
pThousandsSeparator
561,10
1
2
2
2
2
2
2
2
2
2
590,10
pLogOutput,0
pTargetDimension,"Test"
pAlias1,"Description"
pAlias2,"New code 2020"
pLostHierarchy,"Old"
pFilePath,"C:\Dimension\"
pDelimiter,";"
pQuoteCharacter,""
pDecimalSeparator,"."
pThousandsSeparator,""
637,10
pLogOutput,"[Optional] 0 = Nothing | 1 = Write to server message log | 2 = 1 + Keep temporary objects"
pTargetDimension,"[Required] Target dimension name"
pAlias1,"[Optional] Alias 1 name. If empty the process will skip creation and update of this alias"
pAlias2,"[Optional] Alias 2 name. If empty the process will skip creation and update of this alias"
pLostHierarchy,"[Optional] Hierarchy name of lost elements. If specified, the process will create a consolidated element with the value of this parameter value and save lost elements under this consolidation. If empty the process will delete all dimension elements and recreate the dimension"
pFilePath,"[Required] Source file path"
pDelimiter,"[Required] Source delimiter"
pQuoteCharacter,"[Required] Quote character"
pDecimalSeparator,"[Required] Decimal separator"
pThousandsSeparator,"[Required] Thousands separator"
577,39
Level_0
Alias1_0
Alias2_0
Weight_1
Level_1
Alias1_1
Alias2_1
Weight_2
Level_2
Alias1_2
Alias2_2
Weight_3
Level_3
Alias1_3
Alias2_3
Weight_4
Level_4
Alias1_4
Alias2_4
Weight_5
Level_5
Alias1_5
Alias2_5
Weight_6
Level_6
Alias1_6
Alias2_6
Weight_7
Level_7
Alias1_7
Alias2_7
Weight_8
Level_8
Alias1_8
Alias2_8
Weight_9
Level_9
Alias1_9
Alias2_9
578,39
2
2
2
1
2
2
2
1
2
2
2
1
2
2
2
1
2
2
2
1
2
2
2
1
2
2
2
1
2
2
2
1
2
2
2
1
2
2
2
579,39
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
29
30
31
32
33
34
35
36
37
38
39
580,39
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
581,39
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
582,39
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=33ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=33ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=33ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=33ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=33ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=33ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=33ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=33ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=33ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
603,0
572,207

#****Begin: Generated Statements***
#****End: Generated Statements****

# ######  ######  ######
#   ##       ##     ##
#   ##      ##      ##
#   ##     ##       ##
# ######  ######  ######
# https://github.com/ichermak/Izi

# ====================================================================================================
# Description : Create dimension from csv file. The file must have the same name as the target dimension
#
# Parameters : 
# 	- pLogOutput : [Optional] 0 = Nothing | 1 = Write to server message log | 2 = 1 + Keep temporary objects
# 	- pTargetDimension : [Required] Target dimension name
# 	- pAlias1 : [Optional] Alias 1 name. If empty the process will skip creation and update of this alias
# 	- pAlias2 : [Optional] Alias 2 name. If empty the process will skip creation and update of this alias
# 	- pLostHierarchy : [Optional] Hierarchy name of lost elements. If specified, the process will create a consolidated element with the value of this parameter value and save lost elements under this consolidation. If empty the process will delete all dimension elements and recreate the dimension
# 	- pFilePath : [Required] Source file path
# 	- pDelimiter : [Required] Source delimiter
# 	- pQuoteCharacter : [Required] Quote character
# 	- pDecimalSeparator : [Required] Decimal separator
# 	- pThousandsSeparator : [Required] Thousands separator
#
# Updates :
# 	- 2019/07/30 - ICH (www.linkedin.com/in/ichermak) : Creation 
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

# *** Other
# ****************************************
cElementAttributesCube = '}ElementAttributes_' | Trim(pTargetDimension);
cElementAttributesDimension = cElementAttributesCube;

cAlias1Name = Trim(pAlias1);
cAlias2Name = Trim(pAlias2);
cLostHierarchy = Trim(pLostHierarchy);


# === LOG / AUDIT
# ====================================================================================================
sErrorMsg = '';
# <Do something here>
# sNewMsg = Expand('Process started with : pParameter1=%pParameter1%, pParameter2=%pParameter2%.');


# === PARAMETERS VERIFICATION AND OTHER CHECKS
# ====================================================================================================
nError = 0;

pTargetDimension = Trim(pTargetDimension);
pFilePath = Trim (pFilePath);
pDelimiter = Trim(pDelimiter);

If(pTargetDimension @= '');
     sNewMsg = Expand('Invalid parameter : pTargetDimension=%pTargetDimension%.'); 
 	sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', Char(10)) | sNewMsg;
     nError = 1;
EndIf;

If(pFilePath @= '');
     sNewMsg = Expand('Invalid parameter : pFilePath=%pFilePath%.'); 
 	sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', Char(10)) | sNewMsg;
     nError = 1;
EndIf;

If( (pDelimiter @= '') % (LONG(pDelimiter) > 1) );
     sNewMsg = Expand('Invalid parameter : pDelimiter=%pDelimiter%.'); 
 	sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', Char(10)) | sNewMsg;
     nError = 1;
EndIf;

If(LONG(pQuoteCharacter) > 1);
     sNewMsg = Expand('Invalid parameter : pQuoteCharacter=%pQuoteCharacter%.'); 
 	sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', Char(10)) | sNewMsg;
     nError = 1;
EndIf;

If(LONG(pDecimalSeparator) > 1);
     sNewMsg = Expand('Invalid parameter : pDecimalSeparator=%pDecimalSeparator%.'); 
 	sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', Char(10)) | sNewMsg;
     nError = 1;
EndIf;

If(Long(pThousandsSeparator) > 1);
     sNewMsg = Expand('Invalid parameter : pThousandsSeparator=%pThousandsSeparator%.'); 
 	sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', Char(10)) | sNewMsg;
     nError = 1;
EndIf;

# Check file paht
cFilePath = IF(Subst(pFilePath, Long(pFilePath), 1) @= '\', pFilePath, pFilePath | '\');
If(FileExists(cFilePath) = 0);
     sNewMsg = Expand('Invalid parameter : pFilePath=%pFilePath%.'); 
 	sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', Char(10)) | sNewMsg;
     nError = 1;
EndIf;

cSourceFileName = pTargetDimension | '.csv';
cDatasourceName = cFilePath | cSourceFileName;

# Check data source file
IF( FileExists(cDatasourceName) = 0 );
     sNewMsg = Expand('Invalid value : cDatasourceName=%cDatasourceName%.'); 
 	sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', Char(10)) | sNewMsg;
     nError = 1;
ENDIF;

If(nError <> 0); ProcessBreak; EndIf;


# === SOURCE DEFINITION
# ====================================================================================================

# *** Source settings
# ****************************************
DataSourceType = 'CHARACTERDELIMITED';
DatasourceAsciiDelimiter = pDelimiter;
DatasourceAsciiQuoteCharacter = pQuoteCharacter;
DatasourceAsciiHeaderRecords = 1;
DatasourceNameForServer = cDatasourceName;
DatasourceNameForClient = cDatasourceName;


# === TARGET DEFINITION
# ====================================================================================================

# *** Create target dimension if doesn't exist
# ****************************************
IF(DimensionExists(pTargetDimension) = 0) ;
	DimensionCreate(pTargetDimension);
ENDIF;

# *** Target dimension settings
# ****************************************
DimensionSortOrder(pTargetDimension,'BYINPUT','ASCENDING','BYHIERARCHY','ASCENDING');

# *** Create Lost hierarchy if requested
# ****************************************
If(cLostHierarchy @= '');
     DimensionDeleteAllElements(pTargetDimension);

Else;
     If(DimIx(pTargetDimension, cLostHierarchy) = 0);
          If(DimSiz(pTargetDimension) = 0);
               DimensionElementInsert(pTargetDimension, '', cLostHierarchy, 'C');
          Else;
               DimensionElementInsert(pTargetDimension, DimNm(pTargetDimension, 1), cLostHierarchy, 'C');
          EndIf;
     EndIf;
     
     nMax = DimSiz(pTargetDimension);
     nCtr = 1;
     While(nCtr <= nMax);
          sElement = DimNm(pTargetDimension, nCtr);
          
          If(sElement @<> cLostHierarchy);
               DimensionElementComponentAdd(pTargetDimension, cLostHierarchy, sElement, 0);
          EndIf;
          
          nCtr = nCtr + 1;
     End;
EndIf;

# *** Create Alias 1 for target dimension if requested and if doesn't exist
# ****************************************
If( (cAlias1Name @<> '') & (DimIx(cElementAttributesDimension, cAlias1Name) = 0) );
     AttrInsert(pTargetDimension,'',cAlias1Name,'A'); 
EndIf;

# *** Create Alias 2 for target dimension if requested and if doesn't exist
# ****************************************
If( (cAlias2Name @<> '') & (DimIx(cElementAttributesDimension, cAlias2Name) = 0) );
     AttrInsert(pTargetDimension,'',cAlias2Name,'A'); 
EndIf;

# *** Target settings
# ****************************************
cOldLoggingValue = CellGetS('}CubeProperties', cElementAttributesCube, 'LOGGING');
CellPutS('', '}CubeProperties', cElementAttributesCube, 'LOGGING');


# === PROLOG ERRORS
# ====================================================================================================
If(sErrorMsg @<> '');
     sNewMsg = sErrorMsg;
     sErrorMsg = '';
     ItemReject(sNewMsg);
EndIf;
573,63

#****Begin: Generated Statements***
#****End: Generated Statements****

# === ELEMENTS
# ====================================================================================================
nIndex = 9;
nLeaf = 0;
While(nIndex >= 1);
     sElement = Expand('%' | 'Level_' | NumberToString(nIndex) | '%');
     sWeight = Trim(Expand('%' | 'Weight_' | NumberToString(nIndex) | '%'));
     nWeight = StringToNumberEx(sWeight, pDecimalSeparator, pThousandsSeparator);
     sParent = Expand('%' | 'Level_' | NumberToString(nIndex - 1) | '%');
     If(sElement @<> '');
          If(nLeaf = 0);
               If(ElIsPar(pTargetDimension, cLostHierarchy, sElement) = 0);
                    DimensionElementInsert(pTargetDimension, '', sElement, 'N');
               Else;
                    DimensionElementDelete(pTargetDimension, sElement);
                    DimensionElementInsert(pTargetDimension, '', sElement, 'N');
               EndIf;

               If(ElIsPar(pTargetDimension, cLostHierarchy, sParent) = 0);
                    DimensionElementInsert(pTargetDimension, '', sParent, 'C');
               Else;
                    DimensionElementDelete(pTargetDimension, sParent);
                    DimensionElementInsert(pTargetDimension, '', sParent, 'C');
               EndIf;

               DimensionElementComponentAdd(pTargetDimension, sParent, sElement, nWeight);

               nLeaf = nLeaf + 1;
          Else;
               If(ElIsPar(pTargetDimension, cLostHierarchy, sElement) = 0);
                    DimensionElementInsert(pTargetDimension, '', sElement, 'C');
               Else;
                    DimensionElementDelete(pTargetDimension, sElement);
                    DimensionElementInsert(pTargetDimension, '', sElement, 'C');
               EndIf;

               If(ElIsPar(pTargetDimension, cLostHierarchy, sParent) = 0);
                    DimensionElementInsert(pTargetDimension, '', sParent, 'C');
               Else;
                    DimensionElementDelete(pTargetDimension, sParent);
                    DimensionElementInsert(pTargetDimension, '', sParent, 'C');
               EndIf;

               DimensionElementComponentAdd(pTargetDimension, sParent, sElement, nWeight);
          EndIf;
     EndIf;
nIndex = nIndex - 1;
End;

# If N element at the root of the diemsnion
sElement = Expand('%' | 'Level_' | NumberToString(nIndex) | '%');
If(nLeaf = 0);
     If(ElIsPar(pTargetDimension, cLostHierarchy, sElement) = 0);
          DimensionElementInsert(pTargetDimension, '', sElement, 'N');
     Else;
          DimensionElementDelete(pTargetDimension, sElement);
          DimensionElementInsert(pTargetDimension, '', sElement, 'N');
     EndIf;
EndIf;
574,36

#****Begin: Generated Statements***
#****End: Generated Statements****

# === ALIAS VALUES
# ==============================================================================

# *** Alias 1
# ****************************************
If(cAlias1Name @<> '');
     nIndex = 9;
     nLeaf = 0;
     While(nIndex >= 0);
          sElement = Expand('%' | 'Level_' | NumberToString(nIndex) | '%');
          sAlias = Expand('%' | 'Alias1_' | NumberToString(nIndex) | '%'); 
          If(sElement @<> '');
               AttrPuts(sAlias, pTargetDimension, sElement, cAlias1Name);
          EndIf;
          nIndex = nIndex - 1;
     End;
EndIf;

# *** Alias 2
# ****************************************
If(cAlias2Name @<> '');
     nIndex = 9;
     nLeaf = 0;
     While(nIndex >= 0);
          sElement = Expand('%' | 'Level_' | NumberToString(nIndex) | '%');
          sAlias = Expand('%' | 'Alias2_' | NumberToString(nIndex) | '%'); 
          If(sElement @<> '');
               AttrPuts(sAlias, pTargetDimension, sElement, cAlias2Name);
          EndIf;
          nIndex = nIndex - 1;
     End;
EndIf;
575,36

#****Begin: Generated Statements***
#****End: Generated Statements****

# === CUBE LOGGING REACTIVATION
# ====================================================================================================
CellPutS(cOldLoggingValue, '}CubeProperties', cElementAttributesCube, 'LOGGING');

# === MANAGE SECURITY
# ====================================================================================================
sDim = '}Groups';
nMax = DimSiz( sDim );
nCtr = 1;
While( nCtr <= nMax );
     sEle = DimNm( sDim, nCtr );
     If( (sEle @<> 'ADMIN') & (sEle @<> 'SecurityAdmin') & (sEle @<> 'DataAdmin') & (sEle @<> 'OperationsAdmin') );
          ElementSecurityPut('None', pTargetDimension, pLostHierarchy, sEle);
     EndIf;
     nCtr = nCtr + 1;
End;
SecurityRefresh;


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
