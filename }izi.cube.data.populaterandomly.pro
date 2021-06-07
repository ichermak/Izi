601,100
602,"}izi.cube.data.populaterandomly"
562,"VIEW"
586,"Template"
585,"Template"
564,
565,"qSk9tyU\2iaW@m_t[a;Db1CfZeAX6yvdOg=5hdZq9lyD6Z>>Y:VfdVixaJ431I4VbF^m8PHDO1>SKp\Ho@ES?Yen1G8CYvnY:ntN0_iyDrYsG5K^mRxQyBOOzZaYF_tQhHJI>J9e9rxfKYgsSq68VH9hCDsVk\bgqddHPU0g[NNCoqTm2bSsh[i?_U:XsRM7Sad1Bw2W"
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
570,SourceView
571,
569,0
592,0
599,1000
560,8
pDebugMode
pSetUseActiveSandbox
pCube
pFilter
pFilterDelimiter
pDimensionDelimiter
pElementDelimiter
pMaxRecord
561,8
1
1
2
2
2
2
2
1
590,8
pDebugMode,0
pSetUseActiveSandbox,0
pCube,""
pFilter,""
pFilterDelimiter,"&"
pDimensionDelimiter,":"
pElementDelimiter,"+"
pMaxRecord,0
637,8
pDebugMode,"[Optional] 0 = Nothing | 1 = Write to }izi.ProcessMessage cube | 2 = 1 + Keep temporary objects"
pSetUseActiveSandbox,"[Optional] 0 = Reads and writes to the base data | 1 = Reads and writes to the user's active sandbox"
pCube,"[Mandatory] Cube name"
pFilter,"[Optional] Filter on cube in format 'Year: 2006 + 2007 & Scenario: Actual + Budget'. Blank for whole cube"
pFilterDelimiter,"[Optional] Filter delimiter"
pDimensionDelimiter,"[Optional] Dimension delimiter"
pElementDelimiter,"[Optional] Element delimiter"
pMaxRecord,"[Optional] Maximum number of cells to populate. 0 = The whole cube"
577,20
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
578,20
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
579,20
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
580,20
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
581,20
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
582,20
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
572,269

#****Begin: Generated Statements***
#****End: Generated Statements****

# ######  ######  ######
#   ##       ##     ##
#   ##      ##      ##
#   ##     ##       ##
# ######  ######  ######
# https://github.com/ichermak/Izi

# ====================================================================================================
# Description : Populates a cube with random data. 
#               This process supports only cubes having at maximum 20 dimensions.
#
# Updates :
# 	- 2019/07/31 - Ifthen CHERMAK (www.linkedin.com/in/ichermak) : Creation    
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

SetUseActiveSandboxProperty(pSetUseActiveSandbox);


# === CONSTANT VARIABLES 
# ====================================================================================================

# *** Standard variables 
# **************************************** 
cCrLf = Char(13) | Char(10);
If(DimIx('}Clients', Tm1User) = 0); cTM1User = 'Chore'; Else; cTM1User = Tm1User; EndIf;
cStartTime = Now;
cProcessName = GetProcessName;
cIdExecution = cProcessName | '_' | TimSt(cStartTime, '\Y\m\d\h\i\s') | '_' | cTM1User  | '_' | Fill('0', 5 - Long(NumberToString(Int(Rand * 65536)))) | NumberToString(Int(Rand * 65536));
cDebugFile = GetProcessErrorFileDirectory | cIdExecution | '.dbg';
cTemporaryObject = 1;
If(pDebugMode > 1); cTemporaryObject = 0; EndIf;

# *** Source variables
# ****************************************
cSourceCube = pCube;
cSourceView = 'TI-Temp-Source-' | cIdExecution;
cSourceSub = cSourceView;

# *** Target variables
# ****************************************
cTargetCube = cSourceCube;

cTargetDimCount = 0;
nIndexDim = 1;
If(CubeExists(cTargetCube) <> 0);
    sDim = TABDIM(cTargetCube, nIndexDim);
    While(sDim @<> '');
        nIndexDim = nIndexDim + 1;
        sDim = TABDIM(cTargetCube, nIndexDim);   
    End;
    cTargetDimCount = nIndexDim - 1;
EndIf;

# *** Other variables
# ****************************************
nDataRecordCount = 0;


# === PARAMETERS VERIFICATION AND OTHER CHECKS
# ====================================================================================================
If((pDebugMode = 1) % (pDebugMode = 2));
    sNewMsg = Expand('Process started with : pCube=%pCube%, pFilter=%pFilter%, pFilterDelimiter=%pFilterDelimiter%, pDimensionDelimiter=%pDimensionDelimiter%, pElementDelimiter=%pElementDelimiter%, pMaxRecord=%pMaxRecord%.');
    ExecuteProcess('}izi.process.message.add'
                , 'pProcess', cProcessName
                , 'pMessage', sNewMsg
               );
EndIf;

sErrorMsg = '';
pCube = Trim(pCube);
pFilter = Trim(pFilter);
pFilterDelimiter = Trim(pFilterDelimiter);
pDimensionDelimiter = Trim(pDimensionDelimiter);
pElementDelimiter = Trim(pElementDelimiter);

If(CubeExists(pCube) = 0);
	sNewMsg = Expand('Invalid parameter : pCube=%pCube%.');
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;
	  
If((pFilter @<> '') & (pFilterDelimiter @= ''));
	sNewMsg = Expand('Invalid parameter : pFilterDelimiter=%pFilterDelimiter%.'); 
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If((pFilter @<> '') & (pDimensionDelimiter @= ''));
	sNewMsg = Expand('Invalid parameter : pDimensionDelimiter=%pDimensionDelimiter%.'); 
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If((pFilter @<> '') & (pElementDelimiter @= ''));
	sNewMsg = Expand('Invalid parameter : pElementDelimiter=%pElementDelimiter%.'); 
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If((pFilter @<> '') & ((pFilterDelimiter @= pDimensionDelimiter) % (pFilterDelimiter @= pElementDelimiter) % (pDimensionDelimiter @= pElementDelimiter)));
	sNewMsg = Expand('Invalid parameter combinaison : pFilterDelimiter=%pFilterDelimiter%, pDimensionDelimiter=%pDimensionDelimiter%, pElementDelimiter=%pElementDelimiter%. Those parameters must have different values'); 
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If(cTargetDimCount > 20);
    sNewMsg = Expand('Invalid value : cTargetDimCount=%cTargetDimCount%'); 
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


# === SOURCE DEFINITION
# ====================================================================================================

# *** Source dimensions
# ****************************************
cSourceDim1 = TABDIM(cSourceCube,1);
cSourceDim2 = TABDIM(cSourceCube,2);
cSourceDim3 = TABDIM(cSourceCube,3);
cSourceDim4 = TABDIM(cSourceCube,4);
cSourceDim3 = TABDIM(cSourceCube,5);
cSourceDim6 = TABDIM(cSourceCube,6);
cSourceDim7 = TABDIM(cSourceCube,7);
cSourceDim8 = TABDIM(cSourceCube,8);
cSourceDim9 = TABDIM(cSourceCube,9);
cSourceDim10 = TABDIM(cSourceCube,10);
cSourceDim11 = TABDIM(cSourceCube,11);
cSourceDim12 = TABDIM(cSourceCube,12);
cSourceDim13 = TABDIM(cSourceCube,13);
cSourceDim14 = TABDIM(cSourceCube,14);
cSourceDim15 = TABDIM(cSourceCube,15);
cSourceDim16 = TABDIM(cSourceCube,16);
cSourceDim17 = TABDIM(cSourceCube,17);
cSourceDim18 = TABDIM(cSourceCube,18);
cSourceDim19 = TABDIM(cSourceCube,19);
cSourceDim20 = TABDIM(cSourceCube,20);

# *** Source vue creation
# ****************************************
If(ViewExists(cSourceCube, cSourceView) = 1); ViewDestroy(cSourceCube, cSourceView); EndIf;
ViewCreate(cSourceCube, cSourceView, cTemporaryObject);

# *** Source subsets creation
# ****************************************
sSub = cSourceSub;

# Create basic subsets
nIndexDim = 1;
nMaxDim = cTargetDimCount;
While(nIndexDim <= nMaxDim);
    sDim = TABDIM(cSourceCube, nIndexDim);
    If(SubsetExists(sDim, sSub) = 1); 
        SubsetDestroy(sDim, sSub);
    EndIf;
    sMdx = '{TM1SUBSETALL([' | sDim | '])}';
    sMdx = '{TM1FILTERBYLEVEL(' | sMdx | ', 0)}';
    SubsetCreatebyMDX(sSub, '{{[' | sDim | '].MEMBERS.ITEM(0)}, ' | sMdx | '}', cTemporaryObject);
    SubsetElementDelete(sDim, sSub, 1);
    nIndexDim = nIndexDim + 1;
End;

# Loop dimensions
nIndexDim = 1;
nMaxDim = cTargetDimCount;
While(nIndexDim <= nMaxDim);
    sDim = TABDIM(cSourceCube, nIndexDim);
    
    sFilter = pFilter;
    bFilterStop = 0;
    While((sFilter @<> '') & (bFilterStop = 0));
        sFilterDim = Subst(sFilter, 1, Scan(pDimensionDelimiter, sFilter) - 1);
        sFilterDim = Trim(sFilterDim);
        If(Scan(pFilterDelimiter, sFilter) = 0);
            sFilterDimElement = Subst(sFilter, Scan(pDimensionDelimiter, sFilter) + 1, Long(sFilter));
        Else;
            sFilterDimElement = Subst(sFilter, Scan(pDimensionDelimiter, sFilter) + 1, Scan(pFilterDelimiter, sFilter) - Scan(pDimensionDelimiter, sFilter) - 1);
        EndIf;
        sFilterDimElement = Trim(sFilterDimElement);
        
        If(Scan(pFilterDelimiter, sFilter) = 0);
            sFilter = Subst(sFilter, 1, Long(pFilter));
            bFilterStop = 1;
        Else;
            sFilter = Subst(sFilter, Scan(pFilterDelimiter, sFilter) + 1, Long(pFilter));
        EndIf;
        
        sFilter = Trim(sFilter);
        If(sDim @= sFilterDim);
            If(SubsetExists(sDim, sSub) = 1);
                SubsetDestroy(sDim, sSub);
            EndIf;
            SubsetCreate(sDim, sSub, cTemporaryObject);
            
            sFilterElement = sFilterDimElement;
            bFilterElementStop = 0;
            nIndexElement = 1;
            While((sFilterElement @<> '') & (bFilterElementStop = 0));
                If(Scan(pElementDelimiter, sFilterElement) = 0);
                    sElement = sFilterElement;
                    bFilterElementStop = 1;
                Else;
                    sElement = Subst(sFilterElement, 1, Scan(pElementDelimiter, sFilterElement) - 1);
                EndIf;
                
                sElement = Trim(sElement);
                If(Scan(pElementDelimiter, sFilterElement) = 0);
                    sFilterElement = '';
                Else;
                    sFilterElement = Subst(sFilterElement, Scan(pElementDelimiter, sFilterElement) + 1, Long(sFilterDimElement));
                    sFilterElement = Trim(sFilterElement);
                EndIf;
                
                SubsetElementInsert(sDim, sSub, sElement, 1);
                nIndexElement = nIndexElement + 1;
            End;
        EndIf;
    End;
    nIndexDim = nIndexDim + 1;
End;

# *** Source vue subsets assignement
# ****************************************
nIndex = 1;
While(TabDim(cSourceCube, nIndex) @<> '');
	sSourceDim = TabDim(cSourceCube, nIndex);
	If(ViewExists(cSourceCube, cSourceView) = 1); ViewSubsetAssign(cSourceCube, cSourceView, sSourceDim, cSourceSub); EndIf;
	nIndex = nIndex + 1;
End;

# *** Source settings
# ****************************************
DataSourceType = 'VIEW';
DataSourceNameForServer = cSourceCube;
DataSourceCubeView = cSourceView;

ViewExtractSkipZeroesSet(cSourceCube, cSourceView, 0);
ViewExtractSkipCalcsSet(cSourceCube, cSourceView, 1);
ViewExtractSkipRuleValuesSet(cSourceCube, cSourceView, 1);


# === TARGET DEFINITION
# ====================================================================================================

# *** Target settings
# ****************************************
cTargetCube_LoggingValue = CellGetS('}CubeProperties', cTargetCube, 'LOGGING');
CellPutS('', '}CubeProperties', cTargetCube, 'LOGGING');
573,3

#****Begin: Generated Statements***
#****End: Generated Statements****
574,213

#****Begin: Generated Statements***
#****End: Generated Statements****

If((nDataRecordCount > pMaxRecord) & (pMaxRecord <> 0));
    ProcessBreak;
EndIf;

# === DATA
# ====================================================================================================
If(VALUE_IS_STRING = 0);
    # 65536 is the limite of tm1 random
    nValueToPut = Rand() * 65536;
    
    If(cTargetDimCount = 2);
        If(CellIsUpdateable(cTargetCube, V1, V2)= 1);
            CellPutN(nValueToPut, cTargetCube, V1, V2);
        EndIf;
     
    ElseIf(cTargetDimCount = 3);
        If(CellIsUpdateable(cTargetCube, V1, V2, V3)= 1);
            CellPutN(nValueToPut, cTargetCube, V1, V2, V3);
        EndIf;
     
    ElseIf(cTargetDimCount = 4);
        If(CellIsUpdateable(cTargetCube, V1, V2, V3, V4)= 1);
            CellPutN(nValueToPut, cTargetCube, V1, V2, V3, V4);
        EndIf;
     
    ElseIf(cTargetDimCount = 5);
        If(CellIsUpdateable(cTargetCube, V1, V2, V3, V4, V5)= 1);
            CellPutN(nValueToPut, cTargetCube, V1, V2, V3, V4, V5);
        EndIf;
     
    ElseIf(cTargetDimCount = 6);
        If(CellIsUpdateable(cTargetCube, V1, V2, V3, V4, V5, V6)= 1);
            CellPutN(nValueToPut, cTargetCube, V1, V2, V3, V4, V5, V6);
        EndIf;
     
    ElseIf(cTargetDimCount = 7);
        If(CellIsUpdateable(cTargetCube, V1, V2, V3, V4, V5, V6, V7)= 1);
            CellPutN(nValueToPut, cTargetCube, V1, V2, V3, V4, V5, V6, V7);
        EndIf;
     
    ElseIf(cTargetDimCount = 8);
        If(CellIsUpdateable(cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8)= 1);
            CellPutN(nValueToPut, cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8);
        EndIf;
     
    ElseIf(cTargetDimCount = 9);
        If(CellIsUpdateable(cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, V9)= 1);
            CellPutN(nValueToPut, cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, V9);
        EndIf;
     
    ElseIf(cTargetDimCount = 10);
        If(CellIsUpdateable(cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10)= 1);
            CellPutN(nValueToPut, cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10);
        EndIf;
     
    ElseIf(cTargetDimCount = 11);
        If(CellIsUpdateable(cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, V11)= 1);
            CellPutN(nValueToPut, cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, V11);
        EndIf;
     
    ElseIf(cTargetDimCount = 12);
        If(CellIsUpdateable(cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, V11, V12)= 1);
            CellPutN(nValueToPut, cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, V11, V12);
        EndIf;
     
    ElseIf(cTargetDimCount = 13);
        If(CellIsUpdateable(cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, V11, V12, V13)= 1);
            CellPutN(nValueToPut, cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, V11, V12, V13);
        EndIf;
     
    ElseIf(cTargetDimCount = 14);
        If(CellIsUpdateable(cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, V11, V12, V13, V14)= 1);
            CellPutN(nValueToPut, cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, V11, V12, V13, V14);
        EndIf;
     
    ElseIf(cTargetDimCount = 15);
        If(CellIsUpdateable(cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, V11, V12, V13, V14, V15)= 1);
            CellPutN(nValueToPut, cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, V11, V12, V13, V14, V15);
        EndIf;
     
    ElseIf(cTargetDimCount = 16);
        If(CellIsUpdateable(cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, V11, V12, V13, V14, V15, V16)= 1);
            CellPutN(nValueToPut, cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, V11, V12, V13, V14, V15, V16);
        EndIf;
     
    ElseIf(cTargetDimCount = 17);
        If(CellIsUpdateable(cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, V11, V12, V13, V14, V15, V16, V17)= 1);
            CellPutN(nValueToPut, cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, V11, V12, V13, V14, V15, V16, V17);
        EndIf;
     
    ElseIf(cTargetDimCount = 18);
        If(CellIsUpdateable(cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, V11, V12, V13, V14, V15, V16, V17, V18)= 1);
            CellPutN(nValueToPut, cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, V11, V12, V13, V14, V15, V16, V17, V18);
        EndIf;
     
    ElseIf(cTargetDimCount = 19);
        If(CellIsUpdateable(cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, V11, V12, V13, V14, V15, V16, V17, V18, V19)= 1);
            CellPutN(nValueToPut, cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, V11, V12, V13, V14, V15, V16, V17, V18, V19);
        EndIf;
     
    ElseIf(cTargetDimCount = 20);
        If(CellIsUpdateable(cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, V11, V12, V13, V14, V15, V16, V17, V18, V19, V20)= 1);
            CellPutN(nValueToPut, cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, V11, V12, V13, V14, V15, V16, V17, V18, V19, V20);
        EndIf;
    EndIf;
    
Else;
    # Build a fake text with random ascii chars from 65 to 90
    sValueToPut = Char(Int(65 + Rand() * (90 - 65))) | Lower(Fill(Char(Int(65 + Rand() * (90 - 65))), 3)) | ' ' | Lower(Char(Int(65 + Rand() * (90 - 65)))) | Lower(Fill(Char(Int(65 + Rand() * (90 - 65))), 3));
    
    If(cTargetDimCount = 2);
        If(CellIsUpdateable(cTargetCube, V1, V2)= 1);
            CellPutS(sValueToPut, cTargetCube, V1, V2);
        EndIf;
     
    ElseIf(cTargetDimCount = 3);
        If(CellIsUpdateable(cTargetCube, V1, V2, V3)= 1);
            CellPutS(sValueToPut, cTargetCube, V1, V2, V3);
        EndIf;
     
    ElseIf(cTargetDimCount = 4);
        If(CellIsUpdateable(cTargetCube, V1, V2, V3, V4)= 1);
            CellPutS(sValueToPut, cTargetCube, V1, V2, V3, V4);
        EndIf;
     
    ElseIf(cTargetDimCount = 5);
        If(CellIsUpdateable(cTargetCube, V1, V2, V3, V4, V5)= 1);
            CellPutS(sValueToPut, cTargetCube, V1, V2, V3, V4, V5);
        EndIf;
     
    ElseIf(cTargetDimCount = 6);
        If(CellIsUpdateable(cTargetCube, V1, V2, V3, V4, V5, V6)= 1);
            CellPutS(sValueToPut, cTargetCube, V1, V2, V3, V4, V5, V6);
        EndIf;
     
    ElseIf(cTargetDimCount = 7);
        If(CellIsUpdateable(cTargetCube, V1, V2, V3, V4, V5, V6, V7)= 1);
            CellPutS(sValueToPut, cTargetCube, V1, V2, V3, V4, V5, V6, V7);
        EndIf;
     
    ElseIf(cTargetDimCount = 8);
        If(CellIsUpdateable(cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8)= 1);
            CellPutS(sValueToPut, cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8);
        EndIf;
     
    ElseIf(cTargetDimCount = 9);
        If(CellIsUpdateable(cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, V9)= 1);
            CellPutS(sValueToPut, cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, V9);
        EndIf;
     
    ElseIf(cTargetDimCount = 10);
        If(CellIsUpdateable(cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10)= 1);
            CellPutS(sValueToPut, cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10);
        EndIf;
     
    ElseIf(cTargetDimCount = 11);
        If(CellIsUpdateable(cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, V11)= 1);
            CellPutS(sValueToPut, cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, V11);
        EndIf;
     
    ElseIf(cTargetDimCount = 12);
        If(CellIsUpdateable(cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, V11, V12)= 1);
            CellPutS(sValueToPut, cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, V11, V12);
        EndIf;
     
    ElseIf(cTargetDimCount = 13);
        If(CellIsUpdateable(cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, V11, V12, V13)= 1);
            CellPutS(sValueToPut, cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, V11, V12, V13);
        EndIf;
     
    ElseIf(cTargetDimCount = 14);
        If(CellIsUpdateable(cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, V11, V12, V13, V14)= 1);
            CellPutS(sValueToPut, cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, V11, V12, V13, V14);
        EndIf;
     
    ElseIf(cTargetDimCount = 15);
        If(CellIsUpdateable(cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, V11, V12, V13, V14, V15)= 1);
            CellPutS(sValueToPut, cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, V11, V12, V13, V14, V15);
        EndIf;
     
    ElseIf(cTargetDimCount = 16);
        If(CellIsUpdateable(cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, V11, V12, V13, V14, V15, V16)= 1);
            CellPutS(sValueToPut, cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, V11, V12, V13, V14, V15, V16);
        EndIf;
     
    ElseIf(cTargetDimCount = 17);
        If(CellIsUpdateable(cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, V11, V12, V13, V14, V15, V16, V17)= 1);
            CellPutS(sValueToPut, cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, V11, V12, V13, V14, V15, V16, V17);
        EndIf;
     
    ElseIf(cTargetDimCount = 18);
        If(CellIsUpdateable(cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, V11, V12, V13, V14, V15, V16, V17, V18)= 1);
            CellPutS(sValueToPut, cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, V11, V12, V13, V14, V15, V16, V17, V18);
        EndIf;
     
    ElseIf(cTargetDimCount = 19);
        If(CellIsUpdateable(cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, V11, V12, V13, V14, V15, V16, V17, V18, V19)= 1);
            CellPutS(sValueToPut, cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, V11, V12, V13, V14, V15, V16, V17, V18, V19);
        EndIf;
     
    ElseIf(cTargetDimCount = 20);
        If(CellIsUpdateable(cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, V11, V12, V13, V14, V15, V16, V17, V18, V19, V20)= 1);
            CellPutS(sValueToPut, cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, V11, V12, V13, V14, V15, V16, V17, V18, V19, V20);
        EndIf;
    EndIf;
    
EndIf;

nDataRecordCount = nDataRecordCount + 1;
575,51

#****Begin: Generated Statements***
#****End: Generated Statements****

If(sErrorMsg @= '');

    # === TEMPORARY OBJECTS DESTRUCTION
    # ====================================================================================================
    If(pDebugMode <> 2);
        
        # *** Source
        # ****************************************
        If(ViewExists(cSourceCube, cSourceView)= 1); 
            ViewDestroy(cSourceCube, cSourceView); 
        EndIf;
        nIndex = 1;
        While(TabDim(cSourceCube, nIndex)@<> '');
            sSourceDim = TabDim(cSourceCube, nIndex);
            If(SubsetExists(sSourceDim,cSourceSub)= 1); 
                SubsetDestroy(sSourceDim, cSourceSub); 
            EndIf;
            nIndex = nIndex + 1;
        End;
        
    EndIf;
    
    
    # === CUBE LOGGING REACTIVATION
    # ====================================================================================================
    CellPutS(cTargetCube_LoggingValue, '}CubeProperties', cTargetCube, 'LOGGING');
    
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
