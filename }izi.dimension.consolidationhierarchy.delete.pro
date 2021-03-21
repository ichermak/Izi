601,100
602,"}izi.dimension.consolidationhierarchy.delete"
562,"NULL"
586,
585,
564,
565,"lH=_eS4WSAl9aCXaLvurSC[a6yjad7hFPv8VPkNhT74MC5l3kX;?FZEg0oO1Qtk?@waGy=QDiq9TSc6l7tVNCMAo78EkmBWJpGka<]vHw?^WQ=kl]FzD4=r_l0eYD5D^<qmvOPSR4I;hyjR=FxyBpuIZyIsO08V5pZL^9XBG<V:\DMBL;8bY=pnD33LXD>PVBYvr\q=8"
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
589,","
568,""""
570,
571,
569,0
592,0
599,1000
560,3
pDebugMode
pDimenion
pConsolidationHierarchy
561,3
1
2
2
590,3
pDebugMode,0
pDimenion,""
pConsolidationHierarchy,""
637,3
pDebugMode,"[Optional] 0 = Nothing | 1 = Write to server message log | 2 = 1 + Keep temporary objects"
pDimenion,"[Optional] Dimension name. If blank, the process will be executed for all dimensions"
pConsolidationHierarchy,"[Required] Consolidation hierarchy name"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,109

#****Begin: Generated Statements***
#****End: Generated Statements****

# ######  ######  ######
#   ##       ##     ##
#   ##      ##      ##
#   ##     ##       ##
# ######  ######  ######
# https://github.com/ichermak/Izi

# ====================================================================================================
# Description : Delete a specified consolidation hierarchy with all its content
#
# Parameters : 
# 	- pDebugMode : [Optional] 0 = Nothing | 1 = Write to server message log | 2 = 1 + Keep temporary objects
# 	- pDimenion : [Optional] Dimension name. If blank, the process will be executed for all dimensions
# 	- pConsolidationHierarchy : [Required] Consolidation hierarchy name
#
# Updates :
# 	- 2020/06/18 - ICH (www.linkedin.com/in/ichermak) : Creation 
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
cTemporarySub = '}TI-Temp-' | cIdExecution;


# === LOG / AUDIT
# ====================================================================================================
sErrorMsg = '';
# <Do something here>
# sNewMsg = Expand('Process started with : pParameter1=%pParameter1%, pParameter2=%pParameter2%.');


# === PARAMETERS VERIFICATION AND OTHER CHECKS
# ====================================================================================================
nError = 0;

pDimenion = Trim(pDimenion);
pConsolidationHierarchy = Trim(pConsolidationHierarchy);

If( (pDimenion @<> '') & (DimensionExists(pDimenion) = 0) );
     sNewMsg = Expand('Invalid parameter : pDimenion=%pDimenion%.'); 
     sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', Char(10)) | sNewMsg;
     nError = 1;
EndIf;

If(pConsolidationHierarchy @= '');
     sNewMsg = Expand('Invalid parameter : pConsolidationHierarchy=%pConsolidationHierarchy%.');
     sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', Char(10)) | sNewMsg;
     nError = 1;
EndIf;

If(nError <> 0); ProcessBreak; EndIf;


# === OPERATIONS
# ====================================================================================================
If(pDimenion @<> '');
    If(DimIx(pDimenion, pConsolidationHierarchy) <> 0);
        SubsetDestroy(pDimenion, cTemporarySub); 
        sMdx = '{TM1DRILLDOWNMEMBER( {[' | pDimenion | '].[' | pConsolidationHierarchy | ']}, ALL, RECURSIVE )}';
        SubsetCreatebyMDX(cTemporarySub, sMdx, cTemporaryObject);
        DimensionDeleteElements (pDimenion, cTemporarySub);
        SubsetDestroy(pDimenion, cTemporarySub);
    EndIf;
    
Else;
    sDim = '}Dimensions';
    nMax = DimSiz( sDim );
    nCtr = 1;
    While( nCtr <= nMax );
        sDimension = DimNm(sDim, nCtr);
        If(DimIx(sDimension, pConsolidationHierarchy) <> 0);        
            SubsetDestroy(sDimension, cTemporarySub); 
            sMdx = '{TM1DRILLDOWNMEMBER( {[' | sDimension | '].[' | pConsolidationHierarchy | ']}, ALL, RECURSIVE )}';
            SubsetCreatebyMDX(cTemporarySub, sMdx, cTemporaryObject);
            DimensionDeleteElements (sDimension, cTemporarySub);
            SubsetDestroy(sDimension, cTemporarySub);
        EndIf;
        nCtr = nCtr + 1;
    End;

EndIf;


# === PROLOG ERRORS
# ====================================================================================================
If(sErrorMsg @<> '');
     ItemReject(sErrorMsg);
     sErrorMsg = '';
EndIf;
573,3

#****Begin: Generated Statements***
#****End: Generated Statements****
574,3

#****Begin: Generated Statements***
#****End: Generated Statements****
575,16

#****Begin: Generated Statements***
#****End: Generated Statements****

# === LOG / AUDIT
# ====================================================================================================
If(sErrorMsg @<> '');
     ItemReject(sErrorMsg);
EndIf;
cProcessErrorFilename = GetProcessErrorFileDirectory | GetProcessErrorFilename;
If(FileExists(cProcessErrorFilename) <> 0);
     # <Do something here>
EndIf;

# <Do something here>
# sNewMsg = Expand('Process finished with : PrologMinorErrorCount=%PrologMinorErrorCount%, MetadataMinorErrorCount=%MetadataMinorErrorCount%, DataMinorErrorCount=%DataMinorErrorCount%.');
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
