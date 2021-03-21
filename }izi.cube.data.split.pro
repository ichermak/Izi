601,100
602,"}izi.cube.data.split"
562,"CHARACTERDELIMITED"
586,"C:\Template.csv"
585,"C:\Template.csv"
564,
565,"aaJmuCt<D4XtWeDNeVv@CKY<RL@@NH?kJeklmLrTSGxV?=yiOz2I2>dwVsdX=EomIp`K:;iZDx;r_GD_wSG^\jPR`e_^lw9NoVpaJqKk:=IZ:7GRNQ;A34GD7=C?w:XMWpQ>wgF]oAUTen^:XQ><Fqv?kG`9z@ZYx?0;1fFsE[6mv:buYHZW>m`hfdks;Mp8KB6<\t]9"
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
569,0
592,0
599,1000
560,8
pDebugMode
pCubeList
pCubeDelimiter
pFilePath
pFileDelimiter
pQuoteCharacter
pDecimalSeparator
pThousandsSeparator
561,8
1
2
2
2
2
2
2
2
590,8
pDebugMode,0
pCubeList,"CubeName1 ; CubeName2 ; CubeName3"
pCubeDelimiter,";"
pFilePath,"C:\Template.csv"
pFileDelimiter,";"
pQuoteCharacter,""
pDecimalSeparator,"."
pThousandsSeparator,""
637,8
pDebugMode,"[Optional] 0 = Nothing | 1 = Write to server message log | 2 = 1 + Keep temporary objects"
pCubeList,"[Required] Target cube list"
pCubeDelimiter,"[Required] Cube delimiter"
pFilePath,"[Required] Source file path"
pFileDelimiter,"[Required] Source delimiter"
pQuoteCharacter,"[Required] Quote character"
pDecimalSeparator,"[Required] Decimal separator"
pThousandsSeparator,"[Required] Thousands separator"
577,41
V1
V2
V3
V4
V5
V6
V7
V8
V9
V10
V11
V12
V13
V14
V15
V16
V17
V18
V19
V20
V21
V22
V23
V24
V25
V26
V27
V28
V29
V30
V31
V32
V33
V34
V35
V36
V37
V38
V39
V40
V41
578,41
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
579,41
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
40
41
580,41
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
0
0
581,41
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
0
0
582,41
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
603,0
572,192

#****Begin: Generated Statements***
#****End: Generated Statements****

# ######  ######  ######
#   ##       ##     ##
#   ##      ##      ##
#   ##     ##       ##
# ######  ######  ######
# https://github.com/ichermak/Izi

# ====================================================================================================
# Description : Copy data from a source intersections to target ones, applying weights. 
#               The sources, targets and there related weights are defined in the source csv file. 
#               Note that the file must have the same name as the target cube
#
# Parameters : 
# 	- pDebugMode : [Optional] 0 = Nothing | 1 = Write to server message log | 2 = 1 + Keep temporary objects
# 	- pTargetCube : [Required] Target cube name
# 	- pTargetDimension : [Required] Target dimension name
# 	- pTargetMeasure : [Required] Target measure dimension name
# 	- pFilePath : [Required] Source file path
# 	- pFileDelimiter : [Required] Source delimiter
# 	- pQuoteCharacter : [Required] Quote character
# 	- pDecimalSeparator : [Required] Decimal separator
# 	- pThousandsSeparator : [Required] Thousands separator
#
# Updates :
# 	- 2019/12/19 - ICH (www.linkedin.com/in/ichermak) : Creation 
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
cMaxVar = 41;
cHeaderWeight = '<Weight>';
cMappingDelimiter = '&';
cDimensionDelimiter = ':';
cElementDelimiter = '->';

cMappingDimension1 = '';
cMappingDimension2 = '';
cMappingDimension3 = '';
cMappingDimension4 = '';
cMappingDimension5 = '';
cMappingDimension6 = '';
cMappingDimension7 = '';
cMappingDimension8 = '';
cMappingDimension9 = '';
cMappingDimension10 = '';
cMappingDimension11 = '';
cMappingDimension12 = '';
cMappingDimension13 = '';
cMappingDimension14 = '';
cMappingDimension15 = '';
cMappingDimension16 = '';
cMappingDimension17 = '';
cMappingDimension18 = '';
cMappingDimension19 = '';
cMappingDimension20 = '';


# === LOG / AUDIT
# ====================================================================================================
sErrorMsg = '';
# <Do something here>
# sNewMsg = Expand('Process started with : pParameter1=%pParameter1%, pParameter2=%pParameter2%.');


# === PARAMETERS VERIFICATION AND OTHER CHECKS
# ====================================================================================================
nError = 0;

pCubeList = Trim(pCubeList);
pCubeDelimiter = Trim(pCubeDelimiter);
pFilePath = Trim(pFilePath);
pFileDelimiter = Trim(pFileDelimiter);
pQuoteCharacter = Trim(pQuoteCharacter);
pDecimalSeparator = Trim(pDecimalSeparator);

If(pCubeList @= '');
     sNewMsg = Expand('Invalid parameter : pCubeList=%pCubeList%.'); 
     sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', Char(10)) | sNewMsg;
     nError = 1;
EndIf;

If( (pCubeDelimiter @= '') % (LONG(pCubeDelimiter) > 1) );
     sNewMsg = Expand('Invalid parameter : pCubeDelimiter=%pCubeDelimiter%.');
     sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', Char(10)) | sNewMsg;
     nError = 1;
EndIf;

# Loop through delimited text
sDelimitedText = pCubeList;
sDelimiter = pCubeDelimiter;
While(sDelimitedText @<> '');
     If(Scan(sDelimiter, sDelimitedText) = 0);
          sText = sDelimitedText;
          sDelimitedText = '';
     Else;  
          sText = Trim(Subst(sDelimitedText, 1, Scan(sDelimiter, sDelimitedText) - 1));
          sDelimitedText = Trim(Subst(sDelimitedText, Scan(sDelimiter, sDelimitedText) + 1, Long(sDelimitedText)));
     EndIf;

     sCube = sText;
     
     If(CubeExists(sCube) = 0);
          sNewMsg = Expand('Invalid parameter : pCubeList=%pCubeList%. The cube ''%sCube%'' doesn''t exist.'); 
          sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', Char(10)) | sNewMsg;
          nError = 1;
     EndIf;
End;

If(pFilePath @= '');
     sNewMsg = Expand('Invalid parameter : pFilePath=%pFilePath%.'); 
     sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', Char(10)) | sNewMsg;
     nError = 1;
EndIf;

cFilePath = IF(Subst(pFilePath, Long(pFilePath), 1) @= '\', pFilePath, pFilePath | '\');
If(FileExists(cFilePath) = 0);
     sNewMsg = Expand('Invalid parameter : pFilePath=%pFilePath%.'); 
     sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', Char(10)) | sNewMsg;
     nError = 1;
EndIf;

If( (pFileDelimiter @= '') % (LONG(pFileDelimiter) > 1) );
     sNewMsg = Expand('Invalid parameter : pFileDelimiter=%pFileDelimiter%.'); 
     sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', Char(10)) | sNewMsg;
     nError = 1;
EndIf;

If(LONG(pQuoteCharacter) > 1);
     sNewMsg = Expand('Invalid parameter : pQuoteCharacter=%pQuoteCharacter%.'); 
     sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', Char(10)) | sNewMsg;
     nError = 1;
EndIf;

If( (pDecimalSeparator @= '') % (LONG(pDecimalSeparator) > 1) );
     sNewMsg = Expand('Invalid parameter : pDecimalSeparator=%pDecimalSeparator%.');
     sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', Char(10)) | sNewMsg;
     nError = 1;
EndIf;

If(Long(pThousandsSeparator) > 1);
     sNewMsg = Expand('Invalid parameter : pThousandsSeparator=%pThousandsSeparator%.');
     sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', Char(10)) | sNewMsg;
     nError = 1;
EndIf;

If(nError <> 0); ProcessBreak; EndIf;


# === SOURCE DEFINITION
# ====================================================================================================

# *** Source settings
# ****************************************
DataSourceType = 'CHARACTERDELIMITED';
DatasourceAsciiDelimiter = pFileDelimiter;
DatasourceAsciiQuoteCharacter = pQuoteCharacter;
DatasourceAsciiHeaderRecords = 0;
DatasourceNameForServer = pFilePath;
DatasourceNameForClient = pFilePath;

# *** Initialize record count
# ****************************************
nRecordCount = 0;


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
574,244

#****Begin: Generated Statements***
#****End: Generated Statements****

nRecordCount = nRecordCount + 1;

If(nRecordCount = 1);
     
     # === HEADER
     # ====================================================================================================
     nIndexWeight = 0;
     nStop = 0;
     
     nMaxVar = cMaxVar;
     nIndexVar = 1;
     While( (nIndexVar <= nMaxVar) & (nStop = 0) );
          sIndexHeader = NumberToString(nIndexVar);
          sHeader = Expand('%' | 'V' | sIndexHeader | '%');
          If(sHeader @= cHeaderWeight);
               nIndexWeight = nIndexVar;
               nStop = 1;
          EndIf;
          nIndexVar = nIndexVar + 1;
     End;

     nMaxVar = nIndexWeight - 1;
     nIndexVar = 1;
     While(nIndexVar <= nMaxVar);
          sIndexHeader = NumberToString(nIndexVar);
          sHeader = Expand('%' | 'V' | sIndexHeader | '%');
          
          If(nIndexVar = 1);
               cMappingDimension1 = sHeader;
               
          ElseIf(nIndexVar = 2);     
               cMappingDimension2 = sHeader;
               
          ElseIf(nIndexVar = 3);
               cMappingDimension3 = sHeader;
               
          ElseIf(nIndexVar = 4);
               cMappingDimension4 = sHeader;
               
          ElseIf(nIndexVar = 5);
               cMappingDimension5 = sHeader;
               
          ElseIf(nIndexVar = 6);
               cMappingDimension6 = sHeader;
               
          ElseIf(nIndexVar = 7);
               cMappingDimension7 = sHeader;
               
          ElseIf(nIndexVar = 8);
               cMappingDimension8 = sHeader;
               
          ElseIf(nIndexVar = 9);
               cMappingDimension9 = sHeader;
               
          ElseIf(nIndexVar = 10);
               cMappingDimension10 = sHeader;
               
          ElseIf(nIndexVar = 11);
               cMappingDimension11 = sHeader;
               
          ElseIf(nIndexVar = 12);
               cMappingDimension12 = sHeader;
               
          ElseIf(nIndexVar = 13);
               cMappingDimension13 = sHeader;
               
          ElseIf(nIndexVar = 14);
               cMappingDimension14 = sHeader;
               
          ElseIf(nIndexVar = 15);
               cMappingDimension15 = sHeader;
               
          ElseIf(nIndexVar = 16);
               cMappingDimension16 = sHeader;
               
          ElseIf(nIndexVar = 17);
               cMappingDimension17 = sHeader;
               
          ElseIf(nIndexVar = 18);
               cMappingDimension18 = sHeader;
               
          ElseIf(nIndexVar = 19);
               cMappingDimension19 = sHeader;
               
          ElseIf(nIndexVar = 20);
               cMappingDimension20 = sHeader;
          EndIf;
          
          nIndexVar = nIndexVar + 1;
     End;
     
Else;
     
     # === DATA
     # ====================================================================================================
     sMappingElement1 = '';
     sMappingElement2 = '';
     sMappingElement3 = '';
     sMappingElement4 = '';
     sMappingElement5 = '';
     sMappingElement6 = '';
     sMappingElement7 = '';
     sMappingElement8 = '';
     sMappingElement9 = '';
     sMappingElement10 = '';
     sMappingElement11 = '';
     sMappingElement12 = '';
     sMappingElement13 = '';
     sMappingElement14 = '';
     sMappingElement15 = '';
     sMappingElement16 = '';
     sMappingElement17 = '';
     sMappingElement18 = '';
     sMappingElement19 = '';
     sMappingElement20 = '';
     
     nMaxVar = nIndexWeight - 1;
     nIndexVar = 1;
     While(nIndexVar <= nMaxVar);
          sIndexSourceElement = NumberToString(nIndexVar);
          sIndexTargetElement = NumberToString(nIndexWeight + nIndexVar);
          
          sMappingDimension = Expand('%' | 'cMappingDimension' | sIndexSourceElement | '%');
          sSourceElement = Expand('%' | 'V' | sIndexSourceElement | '%');
          sTargetElement = Expand('%' | 'V' | sIndexTargetElement | '%');
          
          If(nIndexVar = 1);
               sMappingElement1 = sMappingDimension | cDimensionDelimiter | sSourceElement | cElementDelimiter | sTargetElement;
               
          ElseIf(nIndexVar = 2);     
               sMappingElement2 = sMappingDimension | cDimensionDelimiter | sSourceElement | cElementDelimiter | sTargetElement;
               
          ElseIf(nIndexVar = 3);
               sMappingElement3 = sMappingDimension | cDimensionDelimiter | sSourceElement | cElementDelimiter | sTargetElement;
               
          ElseIf(nIndexVar = 4);
               sMappingElement4 = sMappingDimension | cDimensionDelimiter | sSourceElement | cElementDelimiter | sTargetElement;
               
          ElseIf(nIndexVar = 5);
               sMappingElement5 = sMappingDimension | cDimensionDelimiter | sSourceElement | cElementDelimiter | sTargetElement;
               
          ElseIf(nIndexVar = 6);
               sMappingElement6 = sMappingDimension | cDimensionDelimiter | sSourceElement | cElementDelimiter | sTargetElement;
               
          ElseIf(nIndexVar = 7);
               sMappingElement7 = sMappingDimension | cDimensionDelimiter | sSourceElement | cElementDelimiter | sTargetElement;
               
          ElseIf(nIndexVar = 8);
               sMappingElement8 = sMappingDimension | cDimensionDelimiter | sSourceElement | cElementDelimiter | sTargetElement;
               
          ElseIf(nIndexVar = 9);
               sMappingElement9 = sMappingDimension | cDimensionDelimiter | sSourceElement | cElementDelimiter | sTargetElement;
               
          ElseIf(nIndexVar = 10);
               sMappingElement10 = sMappingDimension | cDimensionDelimiter | sSourceElement | cElementDelimiter | sTargetElement;
               
          ElseIf(nIndexVar = 11);
               sMappingElement11 = sMappingDimension | cDimensionDelimiter | sSourceElement | cElementDelimiter | sTargetElement;
               
          ElseIf(nIndexVar = 12);
               sMappingElement12 = sMappingDimension | cDimensionDelimiter | sSourceElement | cElementDelimiter | sTargetElement;
               
          ElseIf(nIndexVar = 13);
               sMappingElement13 = sMappingDimension | cDimensionDelimiter | sSourceElement | cElementDelimiter | sTargetElement;
               
          ElseIf(nIndexVar = 14);
               sMappingElement14 = sMappingDimension | cDimensionDelimiter | sSourceElement | cElementDelimiter | sTargetElement;
               
          ElseIf(nIndexVar = 15);
               sMappingElement15 = sMappingDimension | cDimensionDelimiter | sSourceElement | cElementDelimiter | sTargetElement;
               
          ElseIf(nIndexVar = 16);
               sMappingElement16 = sMappingDimension | cDimensionDelimiter | sSourceElement | cElementDelimiter | sTargetElement;
               
          ElseIf(nIndexVar = 17);
               sMappingElement17 = sMappingDimension | cDimensionDelimiter | sSourceElement | cElementDelimiter | sTargetElement;
               
          ElseIf(nIndexVar = 18);
               sMappingElement18 = sMappingDimension | cDimensionDelimiter | sSourceElement | cElementDelimiter | sTargetElement;
               
          ElseIf(nIndexVar = 19);
               sMappingElement19 = sMappingDimension | cDimensionDelimiter | sSourceElement | cElementDelimiter | sTargetElement;
               
          ElseIf(nIndexVar = 20);
               sMappingElement20 = sMappingDimension | cDimensionDelimiter | sSourceElement | cElementDelimiter | sTargetElement;
          EndIf;
          
          nIndexVar = nIndexVar + 1;
     End;
     
     sMappingElement = '';
     nMaxVar = nIndexWeight - 1;
     nIndexVar = 1;
     While(nIndexVar <= nMaxVar);
          sIndexMappingElement = NumberToString(nIndexVar);
          sNewMappingElement = Expand('%' | 'sMappingElement' | sIndexMappingElement | '%');
          sMappingElement = sMappingElement | IF( (sMappingElement @= '') % (sNewMappingElement @= ''), '', cMappingDelimiter) | sNewMappingElement;
          nIndexVar = nIndexVar + 1;
     End;
     
     sCoefficient = Expand('%' | 'V' | NumberToString(nIndexWeight) | '%');
     nCoefficient = StringToNumberEx(sCoefficient, pDecimalSeparator, pThousandsSeparator);
     sProcessName = '}3ds.cube.data.copy';
     
     # Loop through delimited text
     sDelimitedText = pCubeList;
     sDelimiter = pCubeDelimiter;
     While(sDelimitedText @<> '');
          If(Scan(sDelimiter, sDelimitedText) = 0);
               sText = sDelimitedText;
               sDelimitedText = '';
          Else;  
               sText = Trim(Subst(sDelimitedText, 1, Scan(sDelimiter, sDelimitedText) - 1));
               sDelimitedText = Trim(Subst(sDelimitedText, Scan(sDelimiter, sDelimitedText) + 1, Long(sDelimitedText)));
          EndIf;
     
          sCube = sText;
          nProcessReturnCode = ExecuteProcess(sProcessName,
                                                  'pDebugMode', pDebugMode,
                                                  'pCube', sCube,
                                                  'pMappingElement', sMappingElement,
                                                  'pMappingDelimiter', cMappingDelimiter,
                                                  'pDimensionDelimiter', cDimensionDelimiter,
                                                  'pElementDelimiter', cElementDelimiter,
                                                  'pSkipRuleValues', 0,
                                                  'pSkipCalcs', 0,
                                                  'pSkipZeroes', 1,
                                                  'pZeroOut', 0,
                                                  'pCoefficient', nCoefficient,
                                                  'pIncrement', 1,
                                                  'pSubtractFromSource', 1);
                                                 
          If(nProcessReturnCode <> ProcessExitNormal);
            sNewMsg = Expand('Error while executing a subprocess=%sProcessName% : ProcessReturnCode=%nProcessReturnCode%.');
            ItemReject(sNewMsg);
          EndIF;
          
     End;
     
EndIf;
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
