601,100
602,"}izi.cube.overfeedingcheckcube.create"
562,"NULL"
586,
585,
564,
565,"braeK]JDXInkPXcFDjBs6wHH<]]kA`8<h5Azvaw:BraVlwa2LgNzhp\4P3oB9wehqnI=dH\Vy^koExn@WCtlclq8g1A1zifWvgmqzY1>WmRSnyTmQ7_FXEfUyiGQFGXS^cm1DNXhFOfAf6p>6F7kGfvqw4<U^LS5Tq4a:Qa65Qc7NEG]UG_N=n6B?Z5FlRkL?D:5CuKq"
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
560,2
pDebugMode
pCube
561,2
1
2
590,2
pDebugMode,0
pCube,""
637,2
pDebugMode,"[Optional] 0 = Nothing | 1 = Write to }izi.ProcessMessage cube | 2 = 1 + Keep temporary objects"
pCube,"[Mandatory] Cube name"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,289
#****Begin: Generated Statements***
#****End: Generated Statements****

# ######  ######  ######
#   ##       ##     ##
#   ##      ##      ##
#   ##     ##       ##
# ######  ######  ######
# https://github.com/ichermak/Izi

# ====================================================================================================
# Description : Creates a new cube '<CubeName> - OverfeedingCheck' cloning a given one to check the overfed cells. 
#               This process has been inspired by the Cubewise article below
#               https://code.cubewise.com/blog/how-to-find-out-where-you-overfeed-and-fix-it
#               This process supports only cubes having at maximum 30 dimensions.
#
# Updates :
# 	- 2019/10/24 - Ifthen CHERMAK (www.linkedin.com/in/ichermak) : Creation    
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
cUserCode = ''; nMax = Long(cTM1User); nChar = 1; While(nChar <= nMax); If((Code(cTM1User, nChar) = 45) % ((Code(cTM1User, nChar) >= 65) & (Code(cTM1User, nChar) <= 90)) % ((Code(cTM1User, nChar) >= 97) & (Code(cTM1User, nChar) <= 122))); cUserCode = cUserCode | Subst(cTM1User, nChar, 1); EndIf; nChar = nChar + 1; End;
cIdExecution = cProcessName | '_' | TimSt(cStartTime, '\Y\m\d\h\i\s') | '_' | cUserCode  | '_' | Fill('0', 5 - Long(NumberToString(Int(Rand * 65536)))) | NumberToString(Int(Rand * 65536));
cDebugFile = GetProcessErrorFileDirectory | cIdExecution | '.dbg';
cTemporaryObject = 1;
If(pDebugMode > 1); cTemporaryObject = 0; EndIf;

# *** Other variables 
# **************************************** 
cRulesFileName = Trim(pCube) | '.RUX';


# === PARAMETERS VERIFICATION AND OTHER CHECKS
# ====================================================================================================
If((pDebugMode = 1) % (pDebugMode = 2));
    sNewMsg = Expand('Process started with : pCube=%pCube%.');
    ExecuteProcess('}izi.process.message.add'
                , 'pProcess', cProcessName
                , 'pMessage', sNewMsg
                , 'pMessageType', 'Info'
                );
EndIf;

sErrorMsg = '';
pCube = Trim(pCube);

If(CubeExists(pCube) = 0);
	sNewMsg = Expand('Invalid parameter : pCube=%pCube%.'); 
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

sProcessName = '}izi.system.file.getcontent';
nProcessReturnCode = ExecuteProcess(sProcessName,
                              'pDebugMode', pDebugMode,
                              'pFileDirectory', '.\',
                              'pFileName', cRulesFileName);
If(nProcessReturnCode <> ProcessExitNormal);
    sNewMsg = Expand('Invalid parameter : pCube=%pCube%. This cube does not have rules.'); 
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;
cRulesContent = sProcessReturn;

If((Trim(cRulesContent) @<> '') & (Scan('SKIPCHECK', Upper(cRulesContent)) = 0));
    sNewMsg = Expand('Invalid parameter : pCube=%pCube%. This cube does not have rules with feeders.'); 
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If(sErrorMsg @<> '');
    If((pDebugMode = 1) % (pDebugMode = 2));
    sNewMsg = sErrorMsg;
        ExecuteProcess('}izi.process.message.add'
                    , 'pProcess', cProcessName
                    , 'pMessage', sNewMsg
                    , 'pMessageType', 'Error'
                    );
    EndIf;
    ProcessBreak;
EndIf;


# === OPERATIONS
# ====================================================================================================

# *** Get cube dimensions
# **************************************** 
sOverfeedingCheckCube = pCube | ' - OverfeedingCheck';

sDim01 = TabDim(pCube, 1);
sDim02 = TabDim(pCube, 2);
sDim03 = TabDim(pCube, 3);
sDim04 = TabDim(pCube, 4);
sDim05 = TabDim(pCube, 5);
sDim06 = TabDim(pCube, 6);
sDim07 = TabDim(pCube, 7);
sDim08 = TabDim(pCube, 8);
sDim09 = TabDim(pCube, 9);
sDim10 = TabDim(pCube, 10);
sDim11 = TabDim(pCube, 11);
sDim12 = TabDim(pCube, 12);
sDim13 = TabDim(pCube, 13);
sDim14 = TabDim(pCube, 14);
sDim15 = TabDim(pCube, 15);
sDim16 = TabDim(pCube, 16);
sDim17 = TabDim(pCube, 17);
sDim18 = TabDim(pCube, 18);
sDim19 = TabDim(pCube, 19);
sDim20 = TabDim(pCube, 20);
sDim21 = TabDim(pCube, 21);
sDim22 = TabDim(pCube, 22);
sDim23 = TabDim(pCube, 23);
sDim24 = TabDim(pCube, 24);
sDim25 = TabDim(pCube, 25);
sDim26 = TabDim(pCube, 26);
sDim27 = TabDim(pCube, 27);
sDim28 = TabDim(pCube, 28);
sDim29 = TabDim(pCube, 29);
sDim30 = TabDim(pCube, 30);

# *** Create the overfeeding check cube
# **************************************** 
If(CubeExists(sOverfeedingCheckCube) = 1);
    CubeDestroy(sOverfeedingCheckCube);
EndIf;

If(sDim03 @= '');
    CubeCreate(sOverfeedingCheckCube, sDim01, sDim02);
ElseIf(sDim04 @= '');
    CubeCreate(sOverfeedingCheckCube, sDim01, sDim02, sDim03);
ElseIf(sDim05 @= '');
    CubeCreate(sOverfeedingCheckCube, sDim01, sDim02, sDim03, sDim04);
ElseIf(sDim06 @= '');
    CubeCreate(sOverfeedingCheckCube, sDim01, sDim02, sDim03, sDim04, sDim05);
ElseIf(sDim07 @= '');
    CubeCreate(sOverfeedingCheckCube, sDim01, sDim02, sDim03, sDim04, sDim05, sDim06);
ElseIf(sDim08 @= '');
    CubeCreate(sOverfeedingCheckCube, sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07);
ElseIf(sDim09 @= '');
    CubeCreate(sOverfeedingCheckCube, sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08);
ElseIf(sDim10 @= '');
    CubeCreate(sOverfeedingCheckCube, sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09);
ElseIf(sDim11 @= '');
    CubeCreate(sOverfeedingCheckCube, sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10);
ElseIf(sDim12 @= '');
    CubeCreate(sOverfeedingCheckCube, sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11);
ElseIf(sDim13 @= '');
    CubeCreate(sOverfeedingCheckCube, sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12);
ElseIf(sDim14 @= '');
    CubeCreate(sOverfeedingCheckCube, sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13);
ElseIf(sDim15 @= '');
    CubeCreate(sOverfeedingCheckCube, sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14);
ElseIf(sDim16 @= '');
    CubeCreate(sOverfeedingCheckCube, sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15);
ElseIf(sDim17 @= '');
    CubeCreate(sOverfeedingCheckCube, sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16);
ElseIf(sDim18 @= '');
    CubeCreate(sOverfeedingCheckCube, sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17);
ElseIf(sDim19 @= '');
    CubeCreate(sOverfeedingCheckCube, sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18);
ElseIf(sDim20 @= '');
    CubeCreate(sOverfeedingCheckCube, sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19);
ElseIf(sDim21 @= '');
    CubeCreate(sOverfeedingCheckCube, sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20);
ElseIf(sDim22 @= '');
    CubeCreate(sOverfeedingCheckCube, sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21);
ElseIf(sDim23 @= '');
    CubeCreate(sOverfeedingCheckCube, sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22);
ElseIf(sDim24 @= '');
    CubeCreate(sOverfeedingCheckCube, sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23);
ElseIf(sDim25 @= '');
    CubeCreate(sOverfeedingCheckCube, sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24);
ElseIf(sDim26 @= '');
    CubeCreate(sOverfeedingCheckCube, sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25);
ElseIf(sDim27 @= '');
    CubeCreate(sOverfeedingCheckCube, sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26);
ElseIf(sDim28 @= '');
    CubeCreate(sOverfeedingCheckCube, sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27);
ElseIf(sDim29 @= '');
    CubeCreate(sOverfeedingCheckCube, sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28);
ElseIf(sDim30 @= '');
    CubeCreate(sOverfeedingCheckCube, sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29);
Else;
    CubeCreate(sOverfeedingCheckCube, sDim01, sDim02, sDim03, sDim04, sDim05, sDim06, sDim07, sDim08, sDim09, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30);
EndIf;

# *** Add rule to the overfeeding check cube
# **************************************** 
sRules = 'SKIPCHECK;';
CubeRuleAppend(sOverfeedingCheckCube, sRules, 1);

sRules = Expand('[] = N: IF(DB(''%pCube%''')
    | IF(sDim01 @<> '', Expand(',!%sDim01%'), '')
    | IF(sDim02 @<> '', Expand(',!%sDim02%'), '')
    | IF(sDim03 @<> '', Expand(',!%sDim03%'), '')
    | IF(sDim04 @<> '', Expand(',!%sDim04%'), '')
    | IF(sDim05 @<> '', Expand(',!%sDim05%'), '')
    | IF(sDim06 @<> '', Expand(',!%sDim06%'), '')
    | IF(sDim07 @<> '', Expand(',!%sDim07%'), '')
    | IF(sDim08 @<> '', Expand(',!%sDim08%'), '')
    | IF(sDim09 @<> '', Expand(',!%sDim09%'), '')
    | IF(sDim10 @<> '', Expand(',!%sDim10%'), '')
    | IF(sDim11 @<> '', Expand(',!%sDim11%'), '')
    | IF(sDim12 @<> '', Expand(',!%sDim12%'), '')
    | IF(sDim13 @<> '', Expand(',!%sDim13%'), '')
    | IF(sDim14 @<> '', Expand(',!%sDim14%'), '')
    | IF(sDim15 @<> '', Expand(',!%sDim15%'), '')
    | IF(sDim16 @<> '', Expand(',!%sDim16%'), '')
    | IF(sDim17 @<> '', Expand(',!%sDim17%'), '')
    | IF(sDim18 @<> '', Expand(',!%sDim18%'), '')
    | IF(sDim19 @<> '', Expand(',!%sDim19%'), '')
    | IF(sDim20 @<> '', Expand(',!%sDim20%'), '')
    | IF(sDim21 @<> '', Expand(',!%sDim21%'), '')
    | IF(sDim22 @<> '', Expand(',!%sDim22%'), '')
    | IF(sDim23 @<> '', Expand(',!%sDim23%'), '')
    | IF(sDim24 @<> '', Expand(',!%sDim24%'), '')
    | IF(sDim25 @<> '', Expand(',!%sDim25%'), '')
    | IF(sDim26 @<> '', Expand(',!%sDim26%'), '')
    | IF(sDim27 @<> '', Expand(',!%sDim27%'), '')
    | IF(sDim28 @<> '', Expand(',!%sDim28%'), '')
    | IF(sDim29 @<> '', Expand(',!%sDim29%'), '')
    | IF(sDim30 @<> '', Expand(',!%sDim30%'), '')
    | ') = 0, 1, 0);';
CubeRuleAppend(sOverfeedingCheckCube, sRules, 1);

sRules = 'FEEDERS;';
CubeRuleAppend(sOverfeedingCheckCube, sRules, 1);

# *** Add the feeder to the checked cube
# **************************************** 
If((Trim(cRulesContent) @<> '') & (Scan('FEEDERS', Upper(cRulesContent)) = 0));
    sFeeders = 'FEEDERS;';
    CubeRuleAppend(pCube, sFeeders, 0);
EndIf;

sFeeders = Expand('[] => DB(''%sOverfeedingCheckCube%''')
    | IF(sDim01 @<> '', Expand(',!%sDim01%'), '')
    | IF(sDim02 @<> '', Expand(',!%sDim02%'), '')
    | IF(sDim03 @<> '', Expand(',!%sDim03%'), '')
    | IF(sDim04 @<> '', Expand(',!%sDim04%'), '')
    | IF(sDim05 @<> '', Expand(',!%sDim05%'), '')
    | IF(sDim06 @<> '', Expand(',!%sDim06%'), '')
    | IF(sDim07 @<> '', Expand(',!%sDim07%'), '')
    | IF(sDim08 @<> '', Expand(',!%sDim08%'), '')
    | IF(sDim09 @<> '', Expand(',!%sDim09%'), '')
    | IF(sDim10 @<> '', Expand(',!%sDim10%'), '')
    | IF(sDim11 @<> '', Expand(',!%sDim11%'), '')
    | IF(sDim12 @<> '', Expand(',!%sDim12%'), '')
    | IF(sDim13 @<> '', Expand(',!%sDim13%'), '')
    | IF(sDim14 @<> '', Expand(',!%sDim14%'), '')
    | IF(sDim15 @<> '', Expand(',!%sDim15%'), '')
    | IF(sDim16 @<> '', Expand(',!%sDim16%'), '')
    | IF(sDim17 @<> '', Expand(',!%sDim17%'), '')
    | IF(sDim18 @<> '', Expand(',!%sDim18%'), '')
    | IF(sDim19 @<> '', Expand(',!%sDim19%'), '')
    | IF(sDim20 @<> '', Expand(',!%sDim20%'), '')
    | IF(sDim21 @<> '', Expand(',!%sDim21%'), '')
    | IF(sDim22 @<> '', Expand(',!%sDim22%'), '')
    | IF(sDim23 @<> '', Expand(',!%sDim23%'), '')
    | IF(sDim24 @<> '', Expand(',!%sDim24%'), '')
    | IF(sDim25 @<> '', Expand(',!%sDim25%'), '')
    | IF(sDim26 @<> '', Expand(',!%sDim26%'), '')
    | IF(sDim27 @<> '', Expand(',!%sDim27%'), '')
    | IF(sDim28 @<> '', Expand(',!%sDim28%'), '')
    | IF(sDim29 @<> '', Expand(',!%sDim29%'), '')
    | IF(sDim30 @<> '', Expand(',!%sDim30%'), '')
    | ');';
CubeRuleAppend(pCube, sFeeders, 0);

CubeProcessFeeders(pCube);
573,2
#****Begin: Generated Statements***
#****End: Generated Statements****
574,2
#****Begin: Generated Statements***
#****End: Generated Statements****
575,27
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
                        , 'pMessageType', 'Error'
                        ); 
    EndIf;
    
    sNewMsg = Expand('Process finished with : PrologMinorErrorCount=%PrologMinorErrorCount%, MetadataMinorErrorCount=%MetadataMinorErrorCount%, DataMinorErrorCount=%DataMinorErrorCount%.');
    If((sErrorMsg @<> '') % (PrologMinorErrorCount + MetadataMinorErrorCount + DataMinorErrorCount > 0));
        sMessageType = 'Error';
    Else;
        sMessageType = 'Info';
    EndIf;
    ExecuteProcess('}izi.process.message.add'
                , 'pProcess', cProcessName
                , 'pMessage', sNewMsg
                , 'pMessageType', sMessageType
                );
EndIf;
576,
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
920,0
921,""
922,""
923,0
924,""
925,""
926,""
927,""
