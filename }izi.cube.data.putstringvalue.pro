601,100
602,"}izi.cube.data.putstringvalue"
562,"NULL"
586,
585,
564,
565,"fmM1H]a13To4^<FE\q=sPQ:1^vDbzD2dbnPJhKdY\9BBpBzw:E[2tf_L`Y4;?KI]uA>zAf3bQRW:EQNT0s;@yX;`3A[C1^BB_oez=2k8eP=d;9g<fb:w>f]saEgzUe0dh`4\w`Boxis]IHs^3iTQi?uH0cganF\eBs`u^q@l5ckD77Ie;qult9bGmx_X@YI[TqR8R4gK"
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
560,34
pDebugMode
pSetUseActiveSandbox
pValue
pCube
pElement1
pElement2
pElement3
pElement4
pElement5
pElement6
pElement7
pElement8
pElement9
pElement10
pElement11
pElement12
pElement13
pElement14
pElement15
pElement16
pElement17
pElement18
pElement19
pElement20
pElement21
pElement22
pElement23
pElement24
pElement25
pElement26
pElement27
pElement28
pElement29
pElement30
561,34
1
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
590,34
pDebugMode,0
pSetUseActiveSandbox,0
pValue,""
pCube,""
pElement1,""
pElement2,""
pElement3,""
pElement4,""
pElement5,""
pElement6,""
pElement7,""
pElement8,""
pElement9,""
pElement10,""
pElement11,""
pElement12,""
pElement13,""
pElement14,""
pElement15,""
pElement16,""
pElement17,""
pElement18,""
pElement19,""
pElement20,""
pElement21,""
pElement22,""
pElement23,""
pElement24,""
pElement25,""
pElement26,""
pElement27,""
pElement28,""
pElement29,""
pElement30,""
637,34
pDebugMode,"[Optional] 0 = Nothing | 1 = Write to server message log | 2 = 1 + Keep temporary objects"
pSetUseActiveSandbox,"[Optional] 0 = Reads and writes to the base data | 1 = Reads and writes to the user's active sandbox"
pValue,"[Mandatory] Value to put"
pCube,"[Mandatory] Cube name"
pElement1,"[Mandatory] Dimension element name"
pElement2,"[Mandatory] Dimension element name"
pElement3,"[Optional] Dimension element name"
pElement4,"[Optional] Dimension element name"
pElement5,"[Optional] Dimension element name"
pElement6,"[Optional] Dimension element name"
pElement7,"[Optional] Dimension element name"
pElement8,"[Optional] Dimension element name"
pElement9,"[Optional] Dimension element name"
pElement10,"[Optional] Dimension element name"
pElement11,"[Optional] Dimension element name"
pElement12,"[Optional] Dimension element name"
pElement13,"[Optional] Dimension element name"
pElement14,"[Optional] Dimension element name"
pElement15,"[Optional] Dimension element name"
pElement16,"[Optional] Dimension element name"
pElement17,"[Optional] Dimension element name"
pElement18,"[Optional] Dimension element name"
pElement19,"[Optional] Dimension element name"
pElement20,"[Optional] Dimension element name"
pElement21,"[Optional] Dimension element name"
pElement22,"[Optional] Dimension element name"
pElement23,"[Optional] Dimension element name"
pElement24,"[Optional] Dimension element name"
pElement25,"[Optional] Dimension element name"
pElement26,"[Optional] Dimension element name"
pElement27,"[Optional] Dimension element name"
pElement28,"[Optional] Dimension element name"
pElement29,"[Optional] Dimension element name"
pElement30,"[Optional] Dimension element name"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,415

#****Begin: Generated Statements***
#****End: Generated Statements****

# ######  ######  ######
#   ##       ##     ##
#   ##      ##      ##
#   ##     ##       ##
# ######  ######  ######
# https://github.com/ichermak/Izi

# ====================================================================================================
# Description : Sends a string value to a cube cell.
#               This process supports only cubes having at maximum 30 dimensions.
#
# Updates :
# 	- 2020/01/02 - Ifthen CHERMAK (www.linkedin.com/in/ichermak) : Creation 
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
    sNewMsg = Expand('Process started with : pSetUseActiveSandbox=%pSetUseActiveSandbox%, pValue=%pValue%, pCube=%pCube%, pElement1=%pElement1%, pElement2=%pElement2%, pElement3=%pElement3%, pElement4=%pElement4%, pElement5=%pElement5%, pElement6=%pElement6%, pElement7=%pElement7%, pElement8=%pElement8%, pElement9=%pElement9%, pElement10=%pElement10%, pElement11=%pElement11%, pElement12=%pElement12%, pElement13=%pElement13%, pElement14=%pElement14%, pElement15=%pElement15%, pElement16=%pElement16%, pElement17=%pElement17%, pElement18=%pElement18%, pElement19=%pElement19%, pElement20=%pElement20%, pElement21=%pElement21%, pElement22=%pElement22%, pElement23=%pElement23%, pElement24=%pElement24%, pElement25=%pElement25%, pElement26=%pElement26%, pElement27=%pElement27%, pElement28=%pElement28%, pElement29=%pElement29%, pElement30=%pElement30%.');
    ExecuteProcess('}izi.process.message.add'
                , 'pProcess', cProcessName
                , 'pMessage', sNewMsg
                );
EndIf;

sErrorMsg = '';
pCube = Trim(pCube);
pElement1 = Trim(pElement1);
pElement2 = Trim(pElement2);
pElement3 = Trim(pElement3);
pElement4 = Trim(pElement4);
pElement5 = Trim(pElement5);
pElement6 = Trim(pElement6);
pElement7 = Trim(pElement7);
pElement8 = Trim(pElement8);
pElement9 = Trim(pElement9);
pElement10 = Trim(pElement10);
pElement11 = Trim(pElement11);
pElement12 = Trim(pElement12);
pElement13 = Trim(pElement13);
pElement14 = Trim(pElement14);
pElement15 = Trim(pElement15);
pElement16 = Trim(pElement16);
pElement17 = Trim(pElement17);
pElement18 = Trim(pElement18);
pElement19 = Trim(pElement19);
pElement20 = Trim(pElement20);
pElement21 = Trim(pElement21);
pElement22 = Trim(pElement22);
pElement23 = Trim(pElement23);
pElement24 = Trim(pElement24);
pElement25 = Trim(pElement25);
pElement26 = Trim(pElement26);
pElement27 = Trim(pElement27);
pElement28 = Trim(pElement28);
pElement29 = Trim(pElement29);
pElement30 = Trim(pElement30);

If(CubeExists(pCube) = 0);
	sNewMsg = Expand('Invalid parameter : pCube=%pCube%.'); 
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If((TabDim(pCube, 1) @<> '') & (DimIx(TabDim(pCube, 1), pElement1) = 0));
	sNewMsg = Expand('Invalid parameter : pElement1=%pElement1%.'); 
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If((TabDim(pCube, 2) @<> '') & (DimIx(TabDim(pCube, 2), pElement2) = 0));
	sNewMsg = Expand('Invalid parameter : pElement2=%pElement2%.'); 
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If((TabDim(pCube, 3) @<> '') & (DimIx(TabDim(pCube, 3), pElement3) = 0));
	sNewMsg = Expand('Invalid parameter : pElement3=%pElement3%.'); 
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If((TabDim(pCube, 4) @<> '') & (DimIx(TabDim(pCube, 4), pElement4) = 0));
	sNewMsg = Expand('Invalid parameter : pElement4=%pElement4%.'); 
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If((TabDim(pCube, 5) @<> '') & (DimIx(TabDim(pCube, 5), pElement5) = 0));
	sNewMsg = Expand('Invalid parameter : pElement5=%pElement5%.'); 
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If((TabDim(pCube, 6) @<> '') & (DimIx(TabDim(pCube, 6), pElement6) = 0));
	sNewMsg = Expand('Invalid parameter : pElement6=%pElement6%.'); 
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If((TabDim(pCube, 7) @<> '') & (DimIx(TabDim(pCube, 7), pElement7) = 0));
	sNewMsg = Expand('Invalid parameter : pElement7=%pElement7%.'); 
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If((TabDim(pCube, 8) @<> '') & (DimIx(TabDim(pCube, 8), pElement8) = 0));
	sNewMsg = Expand('Invalid parameter : pElement8=%pElement8%.'); 
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If((TabDim(pCube, 9) @<> '') & (DimIx(TabDim(pCube, 9), pElement9) = 0));
	sNewMsg = Expand('Invalid parameter : pElement9=%pElement9%.'); 
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If((TabDim(pCube, 10) @<> '') & (DimIx(TabDim(pCube, 10), pElement10) = 0));
	sNewMsg = Expand('Invalid parameter : pElement10=%pElement10%.'); 
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If((TabDim(pCube, 11) @<> '') & (DimIx(TabDim(pCube, 11), pElement11) = 0));
	sNewMsg = Expand('Invalid parameter : pElement11=%pElement11%.'); 
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If((TabDim(pCube, 12) @<> '') & (DimIx(TabDim(pCube, 12), pElement12) = 0));
	sNewMsg = Expand('Invalid parameter : pElement12=%pElement12%.'); 
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If((TabDim(pCube, 13) @<> '') & (DimIx(TabDim(pCube, 13), pElement13) = 0));
	sNewMsg = Expand('Invalid parameter : pElement13=%pElement13%.'); 
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If((TabDim(pCube, 14) @<> '') & (DimIx(TabDim(pCube, 14), pElement14) = 0));
	sNewMsg = Expand('Invalid parameter : pElement14=%pElement14%.'); 
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If((TabDim(pCube, 15) @<> '') & (DimIx(TabDim(pCube, 15), pElement15) = 0));
	sNewMsg = Expand('Invalid parameter : pElement15=%pElement15%.'); 
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If((TabDim(pCube, 16) @<> '') & (DimIx(TabDim(pCube, 16), pElement16) = 0));
	sNewMsg = Expand('Invalid parameter : pElement16=%pElement16%.'); 
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If((TabDim(pCube, 17) @<> '') & (DimIx(TabDim(pCube, 17), pElement17) = 0));
	sNewMsg = Expand('Invalid parameter : pElement17=%pElement17%.'); 
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If((TabDim(pCube, 18) @<> '') & (DimIx(TabDim(pCube, 18), pElement18) = 0));
	sNewMsg = Expand('Invalid parameter : pElement18=%pElement18%.'); 
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If((TabDim(pCube, 19) @<> '') & (DimIx(TabDim(pCube, 19), pElement19) = 0));
	sNewMsg = Expand('Invalid parameter : pElement19=%pElement19%.'); 
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If((TabDim(pCube, 20) @<> '') & (DimIx(TabDim(pCube, 20), pElement20) = 0));
	sNewMsg = Expand('Invalid parameter : pElement20=%pElement20%.'); 
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If((TabDim(pCube, 21) @<> '') & (DimIx(TabDim(pCube, 21), pElement21) = 0));
	sNewMsg = Expand('Invalid parameter : pElement21=%pElement21%.'); 
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If((TabDim(pCube, 22) @<> '') & (DimIx(TabDim(pCube, 22), pElement22) = 0));
	sNewMsg = Expand('Invalid parameter : pElement22=%pElement22%.'); 
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If((TabDim(pCube, 23) @<> '') & (DimIx(TabDim(pCube, 23), pElement23) = 0));
	sNewMsg = Expand('Invalid parameter : pElement23=%pElement23%.'); 
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If((TabDim(pCube, 24) @<> '') & (DimIx(TabDim(pCube, 24), pElement24) = 0));
	sNewMsg = Expand('Invalid parameter : pElement24=%pElement24%.'); 
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If((TabDim(pCube, 25) @<> '') & (DimIx(TabDim(pCube, 25), pElement25) = 0));
	sNewMsg = Expand('Invalid parameter : pElement25=%pElement25%.'); 
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If((TabDim(pCube, 26) @<> '') & (DimIx(TabDim(pCube, 26), pElement26) = 0));
	sNewMsg = Expand('Invalid parameter : pElement26=%pElement26%.'); 
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If((TabDim(pCube, 27) @<> '') & (DimIx(TabDim(pCube, 27), pElement27) = 0));
	sNewMsg = Expand('Invalid parameter : pElement27=%pElement27%.'); 
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If((TabDim(pCube, 28) @<> '') & (DimIx(TabDim(pCube, 28), pElement28) = 0));
	sNewMsg = Expand('Invalid parameter : pElement28=%pElement28%.'); 
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If((TabDim(pCube, 29) @<> '') & (DimIx(TabDim(pCube, 29), pElement29) = 0));
	sNewMsg = Expand('Invalid parameter : pElement29=%pElement29%.'); 
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If((TabDim(pCube, 30) @<> '') & (DimIx(TabDim(pCube, 30), pElement30) = 0));
	sNewMsg = Expand('Invalid parameter : pElement30=%pElement30%.'); 
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
nDimensionCount = 1;
sDimenion = TabDim(pCube, nDimensionCount);
While(sDimenion @<> '');
    nDimensionCount = nDimensionCount + 1;
    sDimenion = TabDim(pCube, nDimensionCount);
End;
nDimensionCount = nDimensionCount - 1;

If(nDimensionCount = 2);
    If(CellIsUpdateable(pCube, pElement1, pElement2) = 1);
        CellPutS(pValue, pCube, pElement1, pElement2);
    EndIf;
    
ElseIf(nDimensionCount = 3);
    If(CellIsUpdateable(pCube, pElement1, pElement2, pElement3) = 1);
        CellPutS(pValue, pCube, pElement1, pElement2, pElement3);
    EndIf;
    
ElseIf(nDimensionCount = 4);
    If(CellIsUpdateable(pCube, pElement1, pElement2, pElement3, pElement4) = 1);
        CellPutS(pValue, pCube, pElement1, pElement2, pElement3, pElement4);
    EndIf;
    
ElseIf(nDimensionCount = 5);
    If(CellIsUpdateable(pCube, pElement1, pElement2, pElement3, pElement4, pElement5) = 1);
        CellPutS(pValue, pCube, pElement1, pElement2, pElement3, pElement4, pElement5);
    EndIf;
    
ElseIf(nDimensionCount = 6);
    If(CellIsUpdateable(pCube, pElement1, pElement2, pElement3, pElement4, pElement5, pElement6) = 1);
        CellPutS(pValue, pCube, pElement1, pElement2, pElement3, pElement4, pElement5, pElement6);
    EndIf;
    
ElseIf(nDimensionCount = 7);
    If(CellIsUpdateable(pCube, pElement1, pElement2, pElement3, pElement4, pElement5, pElement6, pElement7) = 1);
        CellPutS(pValue, pCube, pElement1, pElement2, pElement3, pElement4, pElement5, pElement6, pElement7);
    EndIf;
    
ElseIf(nDimensionCount = 8);
    If(CellIsUpdateable(pCube, pElement1, pElement2, pElement3, pElement4, pElement5, pElement6, pElement7, pElement8) = 1);
        CellPutS(pValue, pCube, pElement1, pElement2, pElement3, pElement4, pElement5, pElement6, pElement7, pElement8);
    EndIf;
    
ElseIf(nDimensionCount = 9);
    If(CellIsUpdateable(pCube, pElement1, pElement2, pElement3, pElement4, pElement5, pElement6, pElement7, pElement8, pElement9) = 1);
        CellPutS(pValue, pCube, pElement1, pElement2, pElement3, pElement4, pElement5, pElement6, pElement7, pElement8, pElement9);
    EndIf;
    
ElseIf(nDimensionCount = 10);
    If(CellIsUpdateable(pCube, pElement1, pElement2, pElement3, pElement4, pElement5, pElement6, pElement7, pElement8, pElement9, pElement10) = 1);
        CellPutS(pValue, pCube, pElement1, pElement2, pElement3, pElement4, pElement5, pElement6, pElement7, pElement8, pElement9, pElement10);
    EndIf;
    
ElseIf(nDimensionCount = 11);
    If(CellIsUpdateable(pCube, pElement1, pElement2, pElement3, pElement4, pElement5, pElement6, pElement7, pElement8, pElement9, pElement10, pElement11) = 1);
        CellPutS(pValue, pCube, pElement1, pElement2, pElement3, pElement4, pElement5, pElement6, pElement7, pElement8, pElement9, pElement10, pElement11);
    EndIf;
    
ElseIf(nDimensionCount = 12);
    If(CellIsUpdateable(pCube, pElement1, pElement2, pElement3, pElement4, pElement5, pElement6, pElement7, pElement8, pElement9, pElement10, pElement11, pElement12) = 1);
        CellPutS(pValue, pCube, pElement1, pElement2, pElement3, pElement4, pElement5, pElement6, pElement7, pElement8, pElement9, pElement10, pElement11, pElement12);
    EndIf;
    
ElseIf(nDimensionCount = 13);
    If(CellIsUpdateable(pCube, pElement1, pElement2, pElement3, pElement4, pElement5, pElement6, pElement7, pElement8, pElement9, pElement10, pElement11, pElement12, pElement13) = 1);
        CellPutS(pValue, pCube, pElement1, pElement2, pElement3, pElement4, pElement5, pElement6, pElement7, pElement8, pElement9, pElement10, pElement11, pElement12, pElement13);
    EndIf;
    
ElseIf(nDimensionCount = 14);
    If(CellIsUpdateable(pCube, pElement1, pElement2, pElement3, pElement4, pElement5, pElement6, pElement7, pElement8, pElement9, pElement10, pElement11, pElement12, pElement13, pElement14) = 1);
        CellPutS(pValue, pCube, pElement1, pElement2, pElement3, pElement4, pElement5, pElement6, pElement7, pElement8, pElement9, pElement10, pElement11, pElement12, pElement13, pElement14);
    EndIf;
    
ElseIf(nDimensionCount = 15);
    If(CellIsUpdateable(pCube, pElement1, pElement2, pElement3, pElement4, pElement5, pElement6, pElement7, pElement8, pElement9, pElement10, pElement11, pElement12, pElement13, pElement14, pElement15) = 1);
        CellPutS(pValue, pCube, pElement1, pElement2, pElement3, pElement4, pElement5, pElement6, pElement7, pElement8, pElement9, pElement10, pElement11, pElement12, pElement13, pElement14, pElement15);
    EndIf;
    
ElseIf(nDimensionCount = 16);
    If(CellIsUpdateable(pCube, pElement1, pElement2, pElement3, pElement4, pElement5, pElement6, pElement7, pElement8, pElement9, pElement10, pElement11, pElement12, pElement13, pElement14, pElement15, pElement16) = 1);
        CellPutS(pValue, pCube, pElement1, pElement2, pElement3, pElement4, pElement5, pElement6, pElement7, pElement8, pElement9, pElement10, pElement11, pElement12, pElement13, pElement14, pElement15, pElement16);
    EndIf;
    
ElseIf(nDimensionCount = 17);
    If(CellIsUpdateable(pCube, pElement1, pElement2, pElement3, pElement4, pElement5, pElement6, pElement7, pElement8, pElement9, pElement10, pElement11, pElement12, pElement13, pElement14, pElement15, pElement16, pElement17) = 1);
        CellPutS(pValue, pCube, pElement1, pElement2, pElement3, pElement4, pElement5, pElement6, pElement7, pElement8, pElement9, pElement10, pElement11, pElement12, pElement13, pElement14, pElement15, pElement16, pElement17);
    EndIf;
    
ElseIf(nDimensionCount = 18);
    If(CellIsUpdateable(pCube, pElement1, pElement2, pElement3, pElement4, pElement5, pElement6, pElement7, pElement8, pElement9, pElement10, pElement11, pElement12, pElement13, pElement14, pElement15, pElement16, pElement17, pElement18) = 1);
        CellPutS(pValue, pCube, pElement1, pElement2, pElement3, pElement4, pElement5, pElement6, pElement7, pElement8, pElement9, pElement10, pElement11, pElement12, pElement13, pElement14, pElement15, pElement16, pElement17, pElement18);
    EndIf;
    
ElseIf(nDimensionCount = 19);
    If(CellIsUpdateable(pCube, pElement1, pElement2, pElement3, pElement4, pElement5, pElement6, pElement7, pElement8, pElement9, pElement10, pElement11, pElement12, pElement13, pElement14, pElement15, pElement16, pElement17, pElement18, pElement19) = 1);
        CellPutS(pValue, pCube, pElement1, pElement2, pElement3, pElement4, pElement5, pElement6, pElement7, pElement8, pElement9, pElement10, pElement11, pElement12, pElement13, pElement14, pElement15, pElement16, pElement17, pElement18, pElement19);
    EndIf;
    
ElseIf(nDimensionCount = 20);
    If(CellIsUpdateable(pCube, pElement1, pElement2, pElement3, pElement4, pElement5, pElement6, pElement7, pElement8, pElement9, pElement10, pElement11, pElement12, pElement13, pElement14, pElement15, pElement16, pElement17, pElement18, pElement19, pElement20) = 1);
        CellPutS(pValue, pCube, pElement1, pElement2, pElement3, pElement4, pElement5, pElement6, pElement7, pElement8, pElement9, pElement10, pElement11, pElement12, pElement13, pElement14, pElement15, pElement16, pElement17, pElement18, pElement19, pElement20);
    EndIf;
    
ElseIf(nDimensionCount = 21);
    If(CellIsUpdateable(pCube, pElement1, pElement2, pElement3, pElement4, pElement5, pElement6, pElement7, pElement8, pElement9, pElement10, pElement11, pElement12, pElement13, pElement14, pElement15, pElement16, pElement17, pElement18, pElement19, pElement20, pElement21) = 1);
        CellPutS(pValue, pCube, pElement1, pElement2, pElement3, pElement4, pElement5, pElement6, pElement7, pElement8, pElement9, pElement10, pElement11, pElement12, pElement13, pElement14, pElement15, pElement16, pElement17, pElement18, pElement19, pElement20, pElement21);
    EndIf;
    
ElseIf(nDimensionCount = 22);
    If(CellIsUpdateable(pCube, pElement1, pElement2, pElement3, pElement4, pElement5, pElement6, pElement7, pElement8, pElement9, pElement10, pElement11, pElement12, pElement13, pElement14, pElement15, pElement16, pElement17, pElement18, pElement19, pElement20, pElement21, pElement22) = 1);
        CellPutS(pValue, pCube, pElement1, pElement2, pElement3, pElement4, pElement5, pElement6, pElement7, pElement8, pElement9, pElement10, pElement11, pElement12, pElement13, pElement14, pElement15, pElement16, pElement17, pElement18, pElement19, pElement20, pElement21, pElement22);
    EndIf;
    
ElseIf(nDimensionCount = 23);
    If(CellIsUpdateable(pCube, pElement1, pElement2, pElement3, pElement4, pElement5, pElement6, pElement7, pElement8, pElement9, pElement10, pElement11, pElement12, pElement13, pElement14, pElement15, pElement16, pElement17, pElement18, pElement19, pElement20, pElement21, pElement22, pElement23) = 1);
        CellPutS(pValue, pCube, pElement1, pElement2, pElement3, pElement4, pElement5, pElement6, pElement7, pElement8, pElement9, pElement10, pElement11, pElement12, pElement13, pElement14, pElement15, pElement16, pElement17, pElement18, pElement19, pElement20, pElement21, pElement22, pElement23);
    EndIf;
    
ElseIf(nDimensionCount = 24);
    If(CellIsUpdateable(pCube, pElement1, pElement2, pElement3, pElement4, pElement5, pElement6, pElement7, pElement8, pElement9, pElement10, pElement11, pElement12, pElement13, pElement14, pElement15, pElement16, pElement17, pElement18, pElement19, pElement20, pElement21, pElement22, pElement23, pElement24) = 1);
        CellPutS(pValue, pCube, pElement1, pElement2, pElement3, pElement4, pElement5, pElement6, pElement7, pElement8, pElement9, pElement10, pElement11, pElement12, pElement13, pElement14, pElement15, pElement16, pElement17, pElement18, pElement19, pElement20, pElement21, pElement22, pElement23, pElement24);
    EndIf;
    
ElseIf(nDimensionCount = 25);
    If(CellIsUpdateable(pCube, pElement1, pElement2, pElement3, pElement4, pElement5, pElement6, pElement7, pElement8, pElement9, pElement10, pElement11, pElement12, pElement13, pElement14, pElement15, pElement16, pElement17, pElement18, pElement19, pElement20, pElement21, pElement22, pElement23, pElement24, pElement25) = 1);
        CellPutS(pValue, pCube, pElement1, pElement2, pElement3, pElement4, pElement5, pElement6, pElement7, pElement8, pElement9, pElement10, pElement11, pElement12, pElement13, pElement14, pElement15, pElement16, pElement17, pElement18, pElement19, pElement20, pElement21, pElement22, pElement23, pElement24, pElement25);
    EndIf;
    
ElseIf(nDimensionCount = 26);
    If(CellIsUpdateable(pCube, pElement1, pElement2, pElement3, pElement4, pElement5, pElement6, pElement7, pElement8, pElement9, pElement10, pElement11, pElement12, pElement13, pElement14, pElement15, pElement16, pElement17, pElement18, pElement19, pElement20, pElement21, pElement22, pElement23, pElement24, pElement25, pElement26) = 1);
        CellPutS(pValue, pCube, pElement1, pElement2, pElement3, pElement4, pElement5, pElement6, pElement7, pElement8, pElement9, pElement10, pElement11, pElement12, pElement13, pElement14, pElement15, pElement16, pElement17, pElement18, pElement19, pElement20, pElement21, pElement22, pElement23, pElement24, pElement25, pElement26);
    EndIf;
    
ElseIf(nDimensionCount = 27);
    If(CellIsUpdateable(pCube, pElement1, pElement2, pElement3, pElement4, pElement5, pElement6, pElement7, pElement8, pElement9, pElement10, pElement11, pElement12, pElement13, pElement14, pElement15, pElement16, pElement17, pElement18, pElement19, pElement20, pElement21, pElement22, pElement23, pElement24, pElement25, pElement26, pElement27) = 1);
        CellPutS(pValue, pCube, pElement1, pElement2, pElement3, pElement4, pElement5, pElement6, pElement7, pElement8, pElement9, pElement10, pElement11, pElement12, pElement13, pElement14, pElement15, pElement16, pElement17, pElement18, pElement19, pElement20, pElement21, pElement22, pElement23, pElement24, pElement25, pElement26, pElement27);
    EndIf;
    
ElseIf(nDimensionCount = 28);
    If(CellIsUpdateable(pCube, pElement1, pElement2, pElement3, pElement4, pElement5, pElement6, pElement7, pElement8, pElement9, pElement10, pElement11, pElement12, pElement13, pElement14, pElement15, pElement16, pElement17, pElement18, pElement19, pElement20, pElement21, pElement22, pElement23, pElement24, pElement25, pElement26, pElement27, pElement28) = 1);
        CellPutS(pValue, pCube, pElement1, pElement2, pElement3, pElement4, pElement5, pElement6, pElement7, pElement8, pElement9, pElement10, pElement11, pElement12, pElement13, pElement14, pElement15, pElement16, pElement17, pElement18, pElement19, pElement20, pElement21, pElement22, pElement23, pElement24, pElement25, pElement26, pElement27, pElement28);
    EndIf;
    
ElseIf(nDimensionCount = 29);
    If(CellIsUpdateable(pCube, pElement1, pElement2, pElement3, pElement4, pElement5, pElement6, pElement7, pElement8, pElement9, pElement10, pElement11, pElement12, pElement13, pElement14, pElement15, pElement16, pElement17, pElement18, pElement19, pElement20, pElement21, pElement22, pElement23, pElement24, pElement25, pElement26, pElement27, pElement28, pElement29) = 1);
        CellPutS(pValue, pCube, pElement1, pElement2, pElement3, pElement4, pElement5, pElement6, pElement7, pElement8, pElement9, pElement10, pElement11, pElement12, pElement13, pElement14, pElement15, pElement16, pElement17, pElement18, pElement19, pElement20, pElement21, pElement22, pElement23, pElement24, pElement25, pElement26, pElement27, pElement28, pElement29);
    EndIf;
    
ElseIf(nDimensionCount = 30);
    If(CellIsUpdateable(pCube, pElement1, pElement2, pElement3, pElement4, pElement5, pElement6, pElement7, pElement8, pElement9, pElement10, pElement11, pElement12, pElement13, pElement14, pElement15, pElement16, pElement17, pElement18, pElement19, pElement20, pElement21, pElement22, pElement23, pElement24, pElement25, pElement26, pElement27, pElement28, pElement29, pElement30) = 1);
        CellPutS(pValue, pCube, pElement1, pElement2, pElement3, pElement4, pElement5, pElement6, pElement7, pElement8, pElement9, pElement10, pElement11, pElement12, pElement13, pElement14, pElement15, pElement16, pElement17, pElement18, pElement19, pElement20, pElement21, pElement22, pElement23, pElement24, pElement25, pElement26, pElement27, pElement28, pElement29, pElement30);
    EndIf;
    
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
