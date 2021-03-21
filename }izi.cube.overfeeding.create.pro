601,100
602,"}izi.cube.overfeeding.create"
562,"NULL"
586,
585,
564,
565,"bDaW80Dfxzqzw`r^l@;;A6MJ=]=>b\Ffl6Uu=KJQ1xHmHPi?0VxsDnXA845r1TctQDwh0Wbuw4GPyBa2FJ=[q2CsLIeohc6vh4@r7_30Ky^yH[UG[vumXQp9>4qMkQ0P8bfTkh?;au<pQe;mysEAo4DwK:<1LdXS^R@I\UYD5mBNeU125WT``nt;`UpXrMU40g?q8;JM"
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
589,
568,""""
570,
571,
569,0
592,0
599,1000
560,2
pLogOutput
pSourceCube
561,2
1
2
590,2
pLogOutput,0
pSourceCube,"Template"
637,2
pLogOutput,"OPTIONAL: write parameters and action summary to server message log (Boolean True = 1)"
pSourceCube,"REQUIRED: Source Cube"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,140
#****Begin: Generated Statements***
#****End: Generated Statements****

# ######  ######  ######
#   ##       ##     ##
#   ##      ##      ##
#   ##     ##       ##
# ######  ######  ######
# https://github.com/ichermak/Izi

# ====================================================================================================
# Description : ...
#
# Parameters : 
# 	- pLogOutput : [Optional] 0 = Nothing | 1 = Write to server message log | 2 = 1 + Keep temporary objects
# 	- pSourceCube : [Required] Source cube name
#
# Updates :
# 	- 2019/06/01 - ICH (www.linkedin.com/in/ichermak) : Creation 
# ====================================================================================================

cSourceCube = Trim(pSourceCube);
cTargetCube = cSourceCube | ' - Overfeeding';

# Create the overfeeding cube
If(CubeExists(cTargetCube) = 1);
  CubeDestroy(cTargetCube);
EndIf;
nReturn = ExecuteProcess('}bedrock.cube.clone',
                            'pLogOutput', pLogOutput,
                            'pSourceCube', cSourceCube,
                            'pTgtCube', cTargetCube,
                            'pIncludeRules', 0,
                            'pIncludeData', 0,
                            'pFilter', '',
                            'pDimDelim', '&',
                            'pEleStartDelim', '¦',
                            'pEleDelim', '+',
                            'pSuppressRules', 1,
                            'pTemp', 1,
                            'pCubeLogging', 0
                            );

If(nReturn <> ProcessExitNormal());
  ItemReject(NumberToString(nReturn));
EndIf;

# Add rule to the overfeeding cube
cDim01 = TabDim(cTargetCube, 1);
cDim02 = TabDim(cTargetCube, 2);
cDim03 = TabDim(cTargetCube, 3);
cDim04 = TabDim(cTargetCube, 4);
cDim05 = TabDim(cTargetCube, 5);
cDim06 = TabDim(cTargetCube, 6);
cDim07 = TabDim(cTargetCube, 7);
cDim08 = TabDim(cTargetCube, 8);
cDim09 = TabDim(cTargetCube, 9);
cDim10 = TabDim(cTargetCube, 10);
cDim11 = TabDim(cTargetCube, 11);
cDim12 = TabDim(cTargetCube, 12);
cDim13 = TabDim(cTargetCube, 13);
cDim14 = TabDim(cTargetCube, 14);
cDim15 = TabDim(cTargetCube, 15);
cDim16 = TabDim(cTargetCube, 16);
cDim17 = TabDim(cTargetCube, 17);
cDim18 = TabDim(cTargetCube, 18);
cDim19 = TabDim(cTargetCube, 19);
cDim20 = TabDim(cTargetCube, 20);
cDim21 = TabDim(cTargetCube, 21);
cDim22 = TabDim(cTargetCube, 22);
cDim23 = TabDim(cTargetCube, 23);
cDim24 = TabDim(cTargetCube, 24);
cDim25 = TabDim(cTargetCube, 25);
cDim26 = TabDim(cTargetCube, 26);
cDim27 = TabDim(cTargetCube, 27);
cDim28 = TabDim(cTargetCube, 28);
cDim29 = TabDim(cTargetCube, 29);
cDim30 = TabDim(cTargetCube, 30);

sRuleText = 'SKIPCHECK;';
CubeRuleAppend(cTargetCube, sRuleText, 1);

sRuleText = Expand('[] = N: IF(DB(''%cTargetCube%''')
                | IF(cDim01 @<> '', Expand(',!%cDim01%'), '')
                | IF(cDim02 @<> '', Expand(',!%cDim02%'), '')
                | IF(cDim03 @<> '', Expand(',!%cDim03%'), '')
                | IF(cDim04 @<> '', Expand(',!%cDim04%'), '')
                | IF(cDim05 @<> '', Expand(',!%cDim05%'), '')
                | IF(cDim06 @<> '', Expand(',!%cDim06%'), '')
                | IF(cDim07 @<> '', Expand(',!%cDim07%'), '')
                | IF(cDim08 @<> '', Expand(',!%cDim08%'), '')
                | IF(cDim09 @<> '', Expand(',!%cDim09%'), '')
                | IF(cDim10 @<> '', Expand(',!%cDim10%'), '')
                | IF(cDim11 @<> '', Expand(',!%cDim11%'), '')
                | IF(cDim12 @<> '', Expand(',!%cDim12%'), '')
                | IF(cDim13 @<> '', Expand(',!%cDim13%'), '')
                | IF(cDim14 @<> '', Expand(',!%cDim14%'), '')
                | IF(cDim15 @<> '', Expand(',!%cDim15%'), '')
                | IF(cDim16 @<> '', Expand(',!%cDim16%'), '')
                | IF(cDim17 @<> '', Expand(',!%cDim17%'), '')
                | IF(cDim18 @<> '', Expand(',!%cDim18%'), '')
                | IF(cDim19 @<> '', Expand(',!%cDim19%'), '')
                | IF(cDim20 @<> '', Expand(',!%cDim20%'), '')
                | IF(cDim21 @<> '', Expand(',!%cDim21%'), '')
                | IF(cDim22 @<> '', Expand(',!%cDim22%'), '')
                | IF(cDim23 @<> '', Expand(',!%cDim23%'), '')
                | IF(cDim24 @<> '', Expand(',!%cDim24%'), '')
                | IF(cDim25 @<> '', Expand(',!%cDim25%'), '')
                | IF(cDim26 @<> '', Expand(',!%cDim26%'), '')
                | IF(cDim27 @<> '', Expand(',!%cDim27%'), '')
                | IF(cDim28 @<> '', Expand(',!%cDim28%'), '')
                | IF(cDim29 @<> '', Expand(',!%cDim29%'), '')
                | IF(cDim30 @<> '', Expand(',!%cDim30%'), '')
                | ') = 0, 1, 0);';
CubeRuleAppend(cTargetCube, sRuleText, 1);

sRuleText = 'FEEDERS;';
CubeRuleAppend(cTargetCube, sRuleText, 1);

# Create the feeder to add to the source cube 
sFeederText = Expand('[] => DB(''%cTargetCube%''')
                | IF(cDim01 @<> '', Expand(',!%cDim01%'), '')
                | IF(cDim02 @<> '', Expand(',!%cDim02%'), '')
                | IF(cDim03 @<> '', Expand(',!%cDim03%'), '')
                | IF(cDim04 @<> '', Expand(',!%cDim04%'), '')
                | IF(cDim05 @<> '', Expand(',!%cDim05%'), '')
                | IF(cDim06 @<> '', Expand(',!%cDim06%'), '')
                | IF(cDim07 @<> '', Expand(',!%cDim07%'), '')
                | IF(cDim08 @<> '', Expand(',!%cDim08%'), '')
                | IF(cDim09 @<> '', Expand(',!%cDim09%'), '')
                | IF(cDim10 @<> '', Expand(',!%cDim10%'), '')
                | IF(cDim11 @<> '', Expand(',!%cDim11%'), '')
                | IF(cDim12 @<> '', Expand(',!%cDim12%'), '')
                | IF(cDim13 @<> '', Expand(',!%cDim13%'), '')
                | IF(cDim14 @<> '', Expand(',!%cDim14%'), '')
                | IF(cDim15 @<> '', Expand(',!%cDim15%'), '')
                | IF(cDim16 @<> '', Expand(',!%cDim16%'), '')
                | IF(cDim17 @<> '', Expand(',!%cDim17%'), '')
                | IF(cDim18 @<> '', Expand(',!%cDim18%'), '')
                | IF(cDim19 @<> '', Expand(',!%cDim19%'), '')
                | IF(cDim20 @<> '', Expand(',!%cDim20%'), '')
                | IF(cDim21 @<> '', Expand(',!%cDim21%'), '')
                | IF(cDim22 @<> '', Expand(',!%cDim22%'), '')
                | IF(cDim23 @<> '', Expand(',!%cDim23%'), '')
                | IF(cDim24 @<> '', Expand(',!%cDim24%'), '')
                | IF(cDim25 @<> '', Expand(',!%cDim25%'), '')
                | IF(cDim26 @<> '', Expand(',!%cDim26%'), '')
                | IF(cDim27 @<> '', Expand(',!%cDim27%'), '')
                | IF(cDim28 @<> '', Expand(',!%cDim28%'), '')
                | IF(cDim29 @<> '', Expand(',!%cDim29%'), '')
                | IF(cDim30 @<> '', Expand(',!%cDim30%'), '')
                | ');';

# Add feeder to the source cube 
CubeRuleAppend(cSourceCube, sFeederText, 0);

# Reprocess feeders for the source cube
CubeProcessFeeders(cSourceCube);
573,2
#****Begin: Generated Statements***
#****End: Generated Statements****
574,2
#****Begin: Generated Statements***
#****End: Generated Statements****
575,2
#****Begin: Generated Statements***
#****End: Generated Statements****
576,
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
