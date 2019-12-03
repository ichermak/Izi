601,100
602,"}3ds.cube.data.populaterandomly"
562,"VIEW"
586,"Z_TEMPLATE"
585,"Z_TEMPLATE"
564,
565,"kf<we3BZ@l6aKBsXsDEyV?vN\647iM384ae?IGTa;1p7e?d6SFz\`NFgsE:2xHRvsQp9o?3X92Ip7C8T:Jc2^UXgzt[hdxR^r\pHuBku>?IWXXEJZidLNN@n2YYYn1Vk_7R:t=:CfgqcF1V]EiYx3mTNC4M_MJqIDAX^62FlymqB[^DcMtH[SRR6A;G@_WuKkDruvJ9_"
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
570,SourceView
571,
569,0
592,0
599,1000
560,7
pLogOutput
pTargetCube
pFilter
pDimensionDelimiter
pElementStartDelimiter
pElementDelimiter
pRecordLimit
561,7
1
2
2
2
2
2
1
590,7
pLogOutput,0
pTargetCube,""
pFilter,""
pDimensionDelimiter,"&"
pElementStartDelimiter,":"
pElementDelimiter,"+"
pRecordLimit,0
637,7
pLogOutput,"[Optional] 0 = Nothing | 1 = Write to server message log | 2 = 1 + Keep temporary objects"
pTargetCube,"[Required] Target cube"
pFilter,"[Optional] Filter on target cube in format (Year: 2006 + 2007 & Scenario: Actual + Budget). Blank for whole cube"
pDimensionDelimiter,"[Optional] Delimiter for start of Dimension/Element set"
pElementStartDelimiter,"[Optional] Delimiter for start of element list"
pElementDelimiter,"[Optional] Delimiter between elements"
pRecordLimit,"[Optional] Limitation for the number of processed records"
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
572,250

#****Begin: Generated Statements***
#****End: Generated Statements****

# ====================================================================================================
# Description : Populate a cube randomly. It works only with cubes having at maximum 20 dimensions 
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
If(DimIx('}Clients', Tm1User()) = 0); cTM1User = 'Chore'; Else; cTM1User = Tm1User(); EndIf;
cTime = TimSt(Now, '\Y\m\d\h\i\s');
cProcessName = GetProcessName();
cIdExecution = cProcessName | '_' | cTime | '_' | cTM1User  | '_' | Fill( '0', 5 - Long(NumberToString(Int(Rand() * 65536)))) | NumberToString(Int(Rand() * 65536));
cDebugFile = GetProcessErrorFileDirectory | cIdExecution | '.dbg';
cTemporaryObject = 1;
If(pLogOutput > 1); cTemporaryObject = 0; EndIf;


# === PARAMETERS VERIFICATION AND OTHER CHECKS
# ====================================================================================================
sNewMsg = '';
sMsg = '';

pTargetCube = Trim(pTargetCube);
pFilter = Trim(pFilter);
pDimensionDelimiter = Trim(pDimensionDelimiter);
pElementStartDelimiter = Trim(pElementStartDelimiter);
pElementDelimiter = Trim(pElementDelimiter);

If(CubeExists(pTargetCube) = 0);
	sNewMsg = Expand('Invalid parameter : pTargetCube=%pTargetCube%.The specified cube does not exist.');
	sMsg = sMsg | IF(sMsg @= '', '', Char(10)) | sNewMsg;
	  
ElseIf( (pFilter @<> '') & (pDimensionDelimiter @= '') );
	sNewMsg = Expand('Invalid parameter : pDimensionDelimiter=%pDimensionDelimiter%.'); 
	sMsg = sMsg | IF(sMsg @= '', '', Char(10)) | sNewMsg;
	  
ElseIf( (pFilter @<> '') & (pElementStartDelimiter @= '') );
	sNewMsg = Expand('Invalid parameter : pElementStartDelimiter=%pElementStartDelimiter%.'); 
	sMsg = sMsg | IF(sMsg @= '', '', Char(10)) | sNewMsg;

ElseIf( (pFilter @<> '') & (pElementDelimiter @= '') );
	sNewMsg = Expand('Invalid parameter : pElementDelimiter=%pElementDelimiter%.'); 
	sMsg = sMsg | IF(sMsg @= '', '', Char(10)) | sNewMsg;
	  
ElseIf( (pFilter @<> '') & ( (pDimensionDelimiter @= pElementStartDelimiter) % (pDimensionDelimiter @= pElementDelimiter) % (pElementStartDelimiter @= pElementDelimiter) ) );
	sNewMsg = Expand('Invalid parameter combination : (pDimensionDelimiter=%pDimensionDelimiter%, pElementStartDelimiter=%pElementStartDelimiter%, pElementDelimiter=%pElementDelimiter%).Those parameters must have different values'); 
	sMsg = sMsg | IF(sMsg @= '', '', Char(10)) | sNewMsg;

EndIf;

If(sMsg @<> ''); ProcessBreak; EndIf;

pTargetCube = DimensionElementPrincipalName('}Cubes', pTargetCube);


# === CONSTANT VARIABLES 
# ====================================================================================================

# *** Source
# ****************************************
cSourceCube = pTargetCube;
cSourceView = '}TI-Temp-Source-' | cIdExecution;
cSourceSub = cSourceView;

# *** Target
# ****************************************
cTargetCube = cSourceCube;

# Dimension count
cTargetDimCount = 0;
nIndexDim = 1;
sDim = TABDIM(cTargetCube, nIndexDim);
While(sDim @<> '');
  nIndexDim = nIndexDim + 1;
  sDim = TABDIM(cTargetCube, nIndexDim);   
End;
cTargetDimCount = nIndexDim - 1;

If(cTargetDimCount > 20);
  sNewMsg = Expand('Invalid number of dimension for the target cube : %cTargetDimCount%'); 
	sMsg = sMsg | IF(sMsg @= '', '', Char(10)) | sNewMsg;
	ProcessBreak;
EndIf;

# *** Other
# ****************************************
nDataRecordCount = 0;


# === SOURCE DEFINITION
# ====================================================================================================

# *** Source dimensions
# ****************************************
cSourceDim1 	= TABDIM(cSourceCube,1);
cSourceDim2 	= TABDIM(cSourceCube,2);
cSourceDim3 	= TABDIM(cSourceCube,3);
cSourceDim4 	= TABDIM(cSourceCube,4);
cSourceDim5 	= TABDIM(cSourceCube,5);
cSourceDim6 	= TABDIM(cSourceCube,6);
cSourceDim7 	= TABDIM(cSourceCube,7);
cSourceDim8 	= TABDIM(cSourceCube,8);
cSourceDim9 	= TABDIM(cSourceCube,9);
cSourceDim10 	= TABDIM(cSourceCube,10);
cSourceDim11 	= TABDIM(cSourceCube,11);
cSourceDim12 	= TABDIM(cSourceCube,12);
cSourceDim13 	= TABDIM(cSourceCube,13);
cSourceDim14 	= TABDIM(cSourceCube,14);
cSourceDim15 	= TABDIM(cSourceCube,15);
cSourceDim16 	= TABDIM(cSourceCube,16);
cSourceDim17 	= TABDIM(cSourceCube,17);
cSourceDim18 	= TABDIM(cSourceCube,18);
cSourceDim19 	= TABDIM(cSourceCube,19);
cSourceDim20 	= TABDIM(cSourceCube,20);

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
  While( (sFilter @<> '') & (bFilterStop = 0) );
    sFilterDim = Subst(sFilter, 1, Scan(pElementStartDelimiter, sFilter) - 1);
    sFilterDim = Trim(sFilterDim);
    If(Scan(pDimensionDelimiter, sFilter) = 0);
      sFilterDimElement = Subst(sFilter, Scan(pElementStartDelimiter, sFilter) + 1, Long(sFilter));
    Else;
      sFilterDimElement = Subst(sFilter, Scan(pElementStartDelimiter, sFilter) + 1, Scan(pDimensionDelimiter, sFilter) - Scan(pElementStartDelimiter, sFilter) - 1);
    EndIf;
    sFilterDimElement = Trim(sFilterDimElement);
    
    If(Scan(pDimensionDelimiter, sFilter) = 0);
      sFilter = Subst(sFilter, 1, Long(pFilter));
      bFilterStop = 1;   
    Else;
      sFilter = Subst(sFilter, Scan(pDimensionDelimiter, sFilter) + 1, Long(pFilter));
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
      While( (sFilterElement @<> '') & (bFilterElementStop = 0) );
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
ViewExtractSkipCalcsSet(cSourceCube, cSourceView, 0);
ViewExtractSkipRuleValuesSet(cSourceCube, cSourceView, 0);


# === TARGET DEFINITION
# ====================================================================================================

# *** Target settings
# ****************************************
CellPutS('', '}CubeProperties', cTargetCube, 'LOGGING');
573,3

#****Begin: Generated Statements***
#****End: Generated Statements****
574,113

#****Begin: Generated Statements***
#****End: Generated Statements****

If( (nDataRecordCount > pRecordLimit) & (pRecordLimit <> 0) );
	ProcessBreak;
EndIf;

# === DATA
# ====================================================================================================

# 65536 is the limite of tm1 random
nValueToPut = Rand() * 65536;

If(VALUE_IS_STRING = 0);
      If(cTargetDimCount = 2);
          If(CellIsUpdateable(cTargetCube, V1, V2) = 1);
                  CellPutN(nValueToPut, cTargetCube, V1, V2);
          EndIf;
      
      ElseIf(cTargetDimCount = 3);
          If(CellIsUpdateable(cTargetCube, V1, V2, V3) = 1);
                  CellPutN(nValueToPut, cTargetCube, V1, V2, V3);
          EndIf;
      
      ElseIf(cTargetDimCount = 4);
          If(CellIsUpdateable(cTargetCube, V1, V2, V3, V4) = 1);
                  CellPutN(nValueToPut, cTargetCube, V1, V2, V3, V4);
          EndIf;
      
      ElseIf(cTargetDimCount = 5);
          If(CellIsUpdateable(cTargetCube, V1, V2, V3, V4, V5) = 1);
                  CellPutN(nValueToPut, cTargetCube, V1, V2, V3, V4, V5);
          EndIf;
      
      ElseIf(cTargetDimCount = 6);
          If(CellIsUpdateable(cTargetCube, V1, V2, V3, V4, V5, V6) = 1);
                  CellPutN(nValueToPut, cTargetCube, V1, V2, V3, V4, V5, V6);
          EndIf;
      
      ElseIf(cTargetDimCount = 7);
          If(CellIsUpdateable(cTargetCube, V1, V2, V3, V4, V5, V6, V7) = 1);
                  CellPutN(nValueToPut, cTargetCube, V1, V2, V3, V4, V5, V6, V7);
          EndIf;
      
      ElseIf(cTargetDimCount = 8);
          If(CellIsUpdateable(cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8) = 1);
                  CellPutN(nValueToPut, cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8);
          EndIf;
      
      ElseIf(cTargetDimCount = 9);
          If(CellIsUpdateable(cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, V9) = 1);
                  CellPutN(nValueToPut, cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, V9);
          EndIf;
      
      ElseIf(cTargetDimCount = 10);
          If(CellIsUpdateable(cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10) = 1);
                  CellPutN(nValueToPut, cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10);
          EndIf;
      
      ElseIf(cTargetDimCount = 11);
          If(CellIsUpdateable(cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, V11) = 1);
                  CellPutN(nValueToPut, cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, V11);
          EndIf;
      
      ElseIf(cTargetDimCount = 12);
          If(CellIsUpdateable(cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, V11, V12) = 1);
                  CellPutN(nValueToPut, cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, V11, V12);
          EndIf;
      
      ElseIf(cTargetDimCount = 13);
          If(CellIsUpdateable(cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, V11, V12, V13) = 1);
                  CellPutN(nValueToPut, cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, V11, V12, V13);
          EndIf;
      
      ElseIf(cTargetDimCount = 14);
          If(CellIsUpdateable(cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, V11, V12, V13, V14) = 1);
                  CellPutN(nValueToPut, cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, V11, V12, V13, V14);
          EndIf;
      
      ElseIf(cTargetDimCount = 15);
          If(CellIsUpdateable(cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, V11, V12, V13, V14, V15) = 1);
                  CellPutN(nValueToPut, cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, V11, V12, V13, V14, V15);
          EndIf;
      
      ElseIf(cTargetDimCount = 16);
          If(CellIsUpdateable(cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, V11, V12, V13, V14, V15, V16) = 1);
                  CellPutN(nValueToPut, cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, V11, V12, V13, V14, V15, V16);
          EndIf;
      
      ElseIf(cTargetDimCount = 17);
          If(CellIsUpdateable(cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, V11, V12, V13, V14, V15, V16, V17) = 1);
                  CellPutN(nValueToPut, cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, V11, V12, V13, V14, V15, V16, V17);
          EndIf;
      
      ElseIf(cTargetDimCount = 18);
          If(CellIsUpdateable(cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, V11, V12, V13, V14, V15, V16, V17, V18) = 1);
                  CellPutN(nValueToPut, cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, V11, V12, V13, V14, V15, V16, V17, V18);
          EndIf;
      
      ElseIf(cTargetDimCount = 19);
          If(CellIsUpdateable(cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, V11, V12, V13, V14, V15, V16, V17, V18, V19) = 1);
                  CellPutN(nValueToPut, cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, V11, V12, V13, V14, V15, V16, V17, V18, V19);
          EndIf;
      
      ElseIf(cTargetDimCount = 20);
          If(CellIsUpdateable(cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, V11, V12, V13, V14, V15, V16, V17, V18, V19, V20) = 1);
                  CellPutN(nValueToPut, cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, V11, V12, V13, V14, V15, V16, V17, V18, V19, V20);
          EndIf;
      EndIf;
EndIf;

nDataRecordCount = nDataRecordCount + 1;
575,37

#****Begin: Generated Statements***
#****End: Generated Statements****

# === CUBE LOGGING REACTIVATION
# ====================================================================================================
CellPutS('YES', '}CubeProperties', cTargetCube, 'LOGGING');


# === TEMPORARY OBJECTS DESTRUCTION
# ====================================================================================================
If(pLogOutput < 2);
	# *** Source
	# ****************************************
	If(ViewExists(cSourceCube, cSourceView) = 1); ViewDestroy(cSourceCube, cSourceView); EndIf;
	nIndex = 1;
	While(TabDim(cSourceCube, nIndex) @<> '');
  		sSourceDim = TabDim(cSourceCube, nIndex);
  		If(SubsetExists(sSourceDim,cSourceSub) = 1); SubsetDestroy(sSourceDim, cSourceSub); EndIf;
  		nIndex = nIndex + 1;
  	End;

EndIf;

# === LOG / AUDIT
# ====================================================================================================
If(sMsg @<> '');
  	sNewMsg = Expand('Process finished with ProcessReturnCode=ProcessExitByBreak().');
	sMsg = sMsg | IF(sMsg @= '', '', Char(10)) | sNewMsg;
	If(pLogOutput >=1);
    		ASCIIOutput(cDebugFile, sMsg);
	EndIf;

	ItemReject(sMsg);
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
