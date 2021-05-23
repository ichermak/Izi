601,100
602,"}izi.dimension.importfromfile"
562,"CHARACTERDELIMITED"
586,"C:\Template.csv"
585,"C:\Template.csv"
564,
565,"lE[_q`Ygq:joa3@xlRNm6bhTSbU4nnQA5jTTw?xxKG^6R7;Jq_;CLMZ[b4;eGgQ1?t[1lg8nMZbQf^m@t]0k_n^YrPC4O6TSxwgjUbdiZxLh3<oK3FS0r>yK;cnIGi:Gr\1_O^4?4rYqbwAcuW26:^jHywwrnWuoJNy;XNjoEEKQqOy?j:6b6GGKgsA2aD``^i4;h>>i"
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
560,11
pDebugMode
pDimension
pAlias1
pAlias2
pObsolete
pFileDirectory
pFileName
pDelimiter
pQuoteCharacter
pDecimalSeparator
pThousandSeparator
561,11
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
2
590,11
pDebugMode,0
pDimension,""
pAlias1,""
pAlias2,""
pObsolete,"Obsolete"
pFileDirectory,""
pFileName,""
pDelimiter,";"
pQuoteCharacter,""
pDecimalSeparator,","
pThousandSeparator,""
637,11
pDebugMode,"[Optional] 0 = Nothing | 1 = Write to }izi.ProcessMessage cube | 2 = 1 + Keep temporary objects"
pDimension,"[Mandatory] Dimension name"
pAlias1,"[Optional] First alias name. If empty the process will skip the creation and update of this alias"
pAlias2,"[Optional] Second alias name. If empty the process will skip the creation and update of this alias"
pObsolete,"[Optional] Root element name of the obsolete elements hierarchy. When specified, the process will create a consolidated element with the value of this parameter as name and add the obsolete elements to this consolidated element. If empty the process will delete all dimension's elements and recreate the dimension from scratch"
pFileDirectory,"[Mandatory] File directory (Example : 'C:\Applications\Tm1\Izi\Interface\Inbound\Dimension')"
pFileName,"[Mandatory] File name (Example : 'Test.csv')"
pDelimiter,"[Optional] Source delimiter"
pQuoteCharacter,"[Optional] Quote character"
pDecimalSeparator,"[Optional] Decimal separator"
pThousandSeparator,"[Optional] Thousand separator"
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
572,189

#****Begin: Generated Statements***
#****End: Generated Statements****

# ######  ######  ######
#   ##       ##     ##
#   ##      ##      ##
#   ##     ##       ##
# ######  ######  ######
# https://github.com/ichermak/Izi

# ====================================================================================================
# Description : Create dimension from a given csv file.
#               This process supports only dimension having at maximum 10 levels (see the template).
#
# Updates :
# 	- 2019/07/30 - Ifthen CHERMAK (www.linkedin.com/in/ichermak) : Creation 
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
If(DimIx('}Clients', Tm1User) = 0); cTM1User = 'Chore'; Else; cTM1User = Tm1User; EndIf;
cStartTime = Now;
cProcessName = GetProcessName;
cIdExecution = cProcessName | '_' | TimSt(cStartTime, '\Y\m\d\h\i\s') | '_' | cTM1User  | '_' | Fill( '0', 5 - Long(NumberToString(Int(Rand * 65536)))) | NumberToString(Int(Rand * 65536));
cDebugFile = GetProcessErrorFileDirectory | cIdExecution | '.dbg';
cTemporaryObject = 1;
If(pDebugMode > 1); cTemporaryObject = 0; EndIf;

# *** Other variables
# ****************************************
cElementAttributes = '}ElementAttributes_' | Trim(pDimension);

cAlias1Name = Trim(pAlias1);
cAlias2Name = Trim(pAlias2);
cObsolete = Trim(pObsolete);


# === PARAMETERS VERIfICATION AND OTHER CHECKS
# ====================================================================================================
If((pDebugMode = 1) % (pDebugMode = 2));
    sNewMsg = Expand('Process started with : pDimension=%pDimension%, pAlias1=%pAlias1%, pAlias2=%pAlias2%, pObsolete=%pObsolete%, pFileDirectory=%pFileDirectory%, pFileName=%pFileName%, pDelimiter=%pDelimiter%, pQuoteCharacter=%pQuoteCharacter%, pDecimalSeparator=%pDecimalSeparator%, pThousandSeparator=%pThousandSeparator%.');
    ExecuteProcess('}izi.process.message.add'
                , 'pProcess', cProcessName
                , 'pMessage', sNewMsg
                );
EndIf;

sErrorMsg = '';
pDimension = Trim(pDimension);
pFileDirectory = Trim (pFileDirectory);
pFileDirectory = If(Subst(pFileDirectory, Long(pFileDirectory), 1) @= '\', pFileDirectory, pFileDirectory | '\');
pFileName = Trim (pFileName);
pDelimiter = Trim(pDelimiter);

If(pDimension @= '');
 	sNewMsg = Expand('Invalid parameter : pDimension=%pDimension%.'); 
    sErrorMsg = sErrorMsg | If(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If(pFileDirectory @= '');
 	sNewMsg = Expand('Invalid parameter : pFileDirectory=%pFileDirectory%.'); 
    sErrorMsg = sErrorMsg | If(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If((pFileName @= '') % (FileExists(pFileDirectory | pFileName) = 0));
    sNewMsg = Expand('Invalid parameter : pFileName=%pFileName%.'); 
    sErrorMsg = sErrorMsg | If(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If( (pDelimiter @= '') % (LONG(pDelimiter) > 1) );
 	sNewMsg = Expand('Invalid parameter : pDelimiter=%pDelimiter%.'); 
    sErrorMsg = sErrorMsg | If(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If(LONG(pQuoteCharacter) > 1);
 	sNewMsg = Expand('Invalid parameter : pQuoteCharacter=%pQuoteCharacter%.'); 
    sErrorMsg = sErrorMsg | If(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If(LONG(pDecimalSeparator) > 1);
 	sNewMsg = Expand('Invalid parameter : pDecimalSeparator=%pDecimalSeparator%.'); 
    sErrorMsg = sErrorMsg | If(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If(Long(pThousandSeparator) > 1);
 	sNewMsg = Expand('Invalid parameter : pThousandSeparator=%pThousandSeparator%.'); 
    sErrorMsg = sErrorMsg | If(sErrorMsg @= '', '', cCrLf) | sNewMsg;
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


# === SOURCE DEFINITION
# ====================================================================================================

# *** Source settings
# ****************************************
sFilePath = pFileDirectory | pFileName;
DataSourceType = 'CHARACTERDELIMITED';
DatasourceAsciiDelimiter = pDelimiter;
DatasourceAsciiQuoteCharacter = pQuoteCharacter;
DatasourceAsciiHeaderRecords = 1;
DatasourceNameForServer = sFilePath;
DatasourceNameForClient = sFilePath;


# === TARGET DEFINITION
# ====================================================================================================

# *** Create target dimension If doesn't exist
# ****************************************
If(DimensionExists(pDimension) = 0) ;
	DimensionCreate(pDimension);
EndIf;

# *** Target dimension settings
# ****************************************
DimensionSortOrder(pDimension,'BYINPUT','ASCENDING','BYHIERARCHY','ASCENDING');

# *** Create obsolete hierarchy If requested
# ****************************************
If(cObsolete @= '');
 	DimensionDeleteAllElements(pDimension);
 	
Else;
 	If(DimIx(pDimension, cObsolete) = 0);
 	 	If(DimSiz(pDimension) = 0);
 	 	 	DimensionElementInsert(pDimension, '', cObsolete, 'C');
 	 	Else;
 	 	 	DimensionElementInsert(pDimension, DimNm(pDimension, 1), cObsolete, 'C');
 	 	EndIf;
 	EndIf;
 	nMax = DimSiz(pDimension);
 	nCtr = 1;
 	While(nCtr <= nMax);
 	 	sElement = DimNm(pDimension, nCtr);
 	 	If(sElement @<> cObsolete);
 	 	 	DimensionElementComponentAdd(pDimension, cObsolete, sElement, 0);
 	 	EndIf;
 	 	nCtr = nCtr + 1;
 	End;
 	
EndIf;

# *** Create Alias 1 for target dimension If requested and If doesn't exist
# ****************************************
If( (cAlias1Name @<> '') & (DimIx(cElementAttributes, cAlias1Name) = 0) );
 	AttrInsert(pDimension,'',cAlias1Name,'A'); 
EndIf;

# *** Create Alias 2 for target dimension If requested and If doesn't exist
# ****************************************
If( (cAlias2Name @<> '') & (DimIx(cElementAttributes, cAlias2Name) = 0) );
 	AttrInsert(pDimension,'',cAlias2Name,'A'); 
EndIf;

# *** Target settings
# ****************************************
If(CubeExists(cElementAttributes) = 1);
    cElementAttributes_LoggingValue = CellGetS('}CubeProperties', cElementAttributes, 'LOGGING');
    CellPutS('', '}CubeProperties', cElementAttributes, 'LOGGING');
EndIf;
573,72

#****Begin: Generated Statements***
#****End: Generated Statements****

# === ELEMENTS
# ====================================================================================================
nIndex = 9;
nLeaf = 0;
While(nIndex >= 1);
 	sElement = Expand('%' | 'Level_' | NumberToString(nIndex) | '%');
 	sWeight = Trim(Expand('%' | 'Weight_' | NumberToString(nIndex) | '%'));
 	nWeight = StringToNumberEx(sWeight, pDecimalSeparator, pThousandSeparator);
 	sParent = Expand('%' | 'Level_' | NumberToString(nIndex - 1) | '%');
 	If(sElement @<> '');
 	 	If(nLeaf = 0);
 	 	 	If(ElIsPar(pDimension, cObsolete, sElement) = 0);
 	 	 	 	DimensionElementInsert(pDimension, '', sElement, 'N');
 	 	 	 	
 	 	 	Else;
 	 	 	 	DimensionElementDelete(pDimension, sElement);
 	 	 	 	DimensionElementInsert(pDimension, '', sElement, 'N');
 	 	 	 	
 	 	 	EndIf;

 	 	 	If(ElIsPar(pDimension, cObsolete, sParent) = 0);
 	 	 	 	DimensionElementInsert(pDimension, '', sParent, 'C');
 	 	 	 	
 	 	 	Else;
 	 	 	 	DimensionElementDelete(pDimension, sParent);
 	 	 	 	DimensionElementInsert(pDimension, '', sParent, 'C');
 	 	 	 	
 	 	 	EndIf;
 	 	 	DimensionElementComponentAdd(pDimension, sParent, sElement, nWeight);
 	 	 	nLeaf = nLeaf + 1;
 	 	 	
 	 	Else;
 	 	 	If(ElIsPar(pDimension, cObsolete, sElement) = 0);
 	 	 	 	DimensionElementInsert(pDimension, '', sElement, 'C');
 	 	 	 	
 	 	 	Else;
 	 	 	 	DimensionElementDelete(pDimension, sElement);
 	 	 	 	DimensionElementInsert(pDimension, '', sElement, 'C');
 	 	 	 	
 	 	 	EndIf;

 	 	 	If(ElIsPar(pDimension, cObsolete, sParent) = 0);
 	 	 	 	DimensionElementInsert(pDimension, '', sParent, 'C');
 	 	 	 	
 	 	 	Else;
 	 	 	 	DimensionElementDelete(pDimension, sParent);
 	 	 	 	DimensionElementInsert(pDimension, '', sParent, 'C');
 	 	 	 	
 	 	 	EndIf;
 	 	 	DimensionElementComponentAdd(pDimension, sParent, sElement, nWeight);
 	 	 	
 	 	EndIf;
 	EndIf;
nIndex = nIndex - 1;
End;

# If N element at the root of the diemsnion
sElement = Expand('%' | 'Level_' | NumberToString(nIndex) | '%');
If(nLeaf = 0);
 	If(ElIsPar(pDimension, cObsolete, sElement) = 0);
 	 	DimensionElementInsert(pDimension, '', sElement, 'N');
 	 	
 	Else;
 	 	DimensionElementDelete(pDimension, sElement);
 	 	DimensionElementInsert(pDimension, '', sElement, 'N');
 	 	
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
 	 	 	CellPuts(sAlias, cElementAttributes, sElement, cAlias1Name);
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
 	 	 	CellPuts(sAlias, cElementAttributes, sElement, cAlias2Name);
 	 	EndIf;
 	 	nIndex = nIndex - 1;
 	End;
EndIf;
575,49

#****Begin: Generated Statements***
#****End: Generated Statements****

If(sErrorMsg @= '');
    
    # === SECURITY UPDATE FOR OBSOLETE HIERARCHY
    # ====================================================================================================
    If(DimIx(pDimension, pObsolete) <> 0);
        sDim = '}Groups';
        nMax = DimSiz( sDim );
        nCtr = 1;
        While( nCtr <= nMax );
     	    sEle = DimNm( sDim, nCtr );
     	    If( (sEle @<> 'ADMIN') & (sEle @<> 'SecurityAdmin') & (sEle @<> 'DataAdmin') & (sEle @<> 'OperationsAdmin') );
     	 	    ElementSecurityPut('None', pDimension, pObsolete, sEle);
     	    EndIf;
     	    nCtr = nCtr + 1;
        End;
        SecurityRefresh;
    EndIf;
    
    
    # === CUBE LOGGING REACTIVATION
    # ====================================================================================================
    If(CubeExists(cElementAttributes) = 1);
        CellPutS(cElementAttributes_LoggingValue, '}CubeProperties', cElementAttributes, 'LOGGING');
    EndIf;
    
EndIf;


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
