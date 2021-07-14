601,100
602,"}izi.dimension.rollup.delete"
562,"NULL"
586,
585,
564,
565,"v_GsX^ocqJ6RFM_YkfsqfuaOHRQ9?]vdx4LG:6w@JcT>B`l5:J2<VRs8[QXdi@RmtcXg_2xoRS@^xxV@YPidBt4PF5rE>Sh]UPVFOH2g>wo4I?dHjZMQF23S=x`m<dz3R[oqIgN>jQ;axiU[v`g2kjs>vSr=\xPGdA0pBhq1`3y9KlRnKkZ^?`S9AjKvbhyq6D=1vMxH"
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
560,4
pDebugMode
pDimenion
pRollUp
pIncludeChildren
561,4
1
2
2
1
590,4
pDebugMode,0
pDimenion,""
pRollUp,""
pIncludeChildren,0
637,4
pDebugMode,"[Optional] 0 = Nothing | 1 = Write to }izi.ProcessMessage cube | 2 = 1 + Keep temporary objects"
pDimenion,"[Optional] Dimension name. If blank, the process will trait all dimensions"
pRollUp,"[Mandatory] Roll-up name"
pIncludeChildren,"[Optional] 0 = Do not include children | 1 = Include children"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,160

#****Begin: Generated Statements***
#****End: Generated Statements****

# ######  ######  ######
#   ##       ##     ##
#   ##      ##      ##
#   ##     ##       ##
# ######  ######  ######
# https://github.com/ichermak/Izi

# ====================================================================================================
# Description : Delete a given roll-up including or not its children
#
# Updates :
# 	- 2020/06/18 - Ifthen CHERMAK (www.linkedin.com/in/ichermak) : Creation 
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
cTemporarySub = '}izi.temp.' | cIdExecution;


# === PARAMETERS VERIFICATION AND OTHER CHECKS
# ====================================================================================================
If((pDebugMode = 1) % (pDebugMode = 2));
    sNewMsg = Expand('Process started with : pDimenion=%pDimenion%, pRollUp=%pRollUp%, pIncludeChildren=%pIncludeChildren%.');
    ExecuteProcess('}izi.process.message.add'
                , 'pProcess', cProcessName
                , 'pMessage', sNewMsg
                );
EndIf;

sErrorMsg = '';
pDimenion = Trim(pDimenion);
pRollUp = Trim(pRollUp);
pIncludeChildren = INT(pIncludeChildren);

If((pDimenion @<> '') & (DimensionExists(pDimenion) = 0));
    sNewMsg = Expand('Invalid parameter : pDimenion=%pDimenion%.'); 
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If(pRollUp @= '');
    sNewMsg = Expand('Invalid parameter : pRollUp=%pRollUp%.');
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If((pIncludeChildren <> 0) & (pIncludeChildren <> 1));
    sNewMsg = Expand('Invalid parameter : pIncludeChildren=%pIncludeChildren%.');
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


# === OPERATIONS
# ====================================================================================================
If(pDimenion @<> '');
    If(DimIx(pDimenion, pRollUp) <> 0);
        pRollUp = DimensionElementPrincipalName(pDimenion, pRollUp);
        If(pIncludeChildren = 0);
            SubsetDestroy(pDimenion, cTemporarySub);
            sMdx = '{{[' | pDimenion | '].[' | pRollUp | ']}, {[' | pDimenion | '].[' | pRollUp | '].children}}';
            SubsetCreatebyMDX(cTemporarySub, sMdx, cTemporaryObject);
            nSubIndex = SubsetGetSize(pDimenion, cTemporarySub);
            While(nSubIndex > 0);
                sElement = SubsetGetElementName(pDimenion, cTemporarySub, nSubIndex);
                sElement = DimensionElementPrincipalName(pDimenion, sElement);
                If(sElement @<> pRollUp);
                    DimensionElementComponentDelete(pDimenion, pRollUp, sElement);
                EndIf;
                nSubIndex = nSubIndex - 1;
            End;
            SubsetDestroy(pDimenion, cTemporarySub);
            DimensionElementDelete(pDimenion, pRollUp);
            
        ElseIf(pIncludeChildren = 1);
            SubsetDestroy(pDimenion, cTemporarySub);
            sMdx = '{TM1DRILLDOWNMEMBER({[' | pDimenion | '].[' | pRollUp | ']}, ALL, RECURSIVE)}';
            SubsetCreatebyMDX(cTemporarySub, sMdx, cTemporaryObject);
            DimensionDeleteElements (pDimenion, cTemporarySub);
            SubsetDestroy(pDimenion, cTemporarySub);
            
        EndIf;
    EndIf;
    
Else;
    sDim = '}Dimensions';
    nDimnSize = DimSiz(sDim);
    nDimIndex = 1;
    While(nDimIndex <= nDimnSize);
        sDimension = DimNm(sDim, nDimIndex);
        If(DimIx(sDimension, pRollUp) <> 0);
            pRollUp = DimensionElementPrincipalName(sDimension, pRollUp);
            If(pIncludeChildren = 0);
                SubsetDestroy(sDimension, cTemporarySub);
                sMdx = '{[' | sDimension | '].[' | pRollUp | '].children}';
                SubsetCreatebyMDX(cTemporarySub, sMdx, cTemporaryObject);
                nSubIndex = SubsetGetSize(sDimension, cTemporarySub);
                While(nSubIndex > 0);
                    sElement = SubsetGetElementName(sDimension, cTemporarySub, nSubIndex);
                    sElement = DimensionElementPrincipalName(sDimension, sElement);
                    If(sElement @<> pRollUp);
                        DimensionElementComponentDelete(sDimension, pRollUp, sElement);
                    EndIf;
                    nSubIndex = nSubIndex - 1;
                End;
                SubsetDestroy(sDimension, cTemporarySub);
                DimensionElementDelete(sDimension, pRollUp);
                
            ElseIf(pIncludeChildren = 1);
                SubsetDestroy(sDimension, cTemporarySub);
                sMdx = '{TM1DRILLDOWNMEMBER({[' | sDimension | '].[' | pRollUp | ']}, ALL, RECURSIVE)}';
                SubsetCreatebyMDX(cTemporarySub, sMdx, cTemporaryObject);
                DimensionDeleteElements (sDimension, cTemporarySub);
                SubsetDestroy(sDimension, cTemporarySub);
                
            EndIf;
        EndIf;
        nDimIndex = nDimIndex + 1;
    End;

EndIf;
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
