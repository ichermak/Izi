601,100
602,"}ICH.cube.overfeeding.create"
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
pSrcCube
561,2
1
2
590,2
pLogOutput,0
pSrcCube,"ELAB_COUT"
637,2
pLogOutput,"OPTIONAL: write parameters and action summary to server message log (Boolean True = 1)"
pSrcCube,"REQUIRED: Source Cube"
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

cSrcCube = Trim(pSrcCube);
cTgtCube = cSrcCube | ' - Overfeeding';

# Create the overfeeding cube
If(CubeExists(cTgtCube) = 1);
  CubeDestroy(cTgtCube);
EndIf;
nReturn = ExecuteProcess('}bedrock.cube.clone',
                            'pLogOutput', pLogOutput,
                            'pSrcCube', cSrcCube,
                            'pTgtCube', cTgtCube,
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
cDim01 = TabDim(cTgtCube, 1);
cDim02 = TabDim(cTgtCube, 2);
cDim03 = TabDim(cTgtCube, 3);
cDim04 = TabDim(cTgtCube, 4);
cDim05 = TabDim(cTgtCube, 5);
cDim06 = TabDim(cTgtCube, 6);
cDim07 = TabDim(cTgtCube, 7);
cDim08 = TabDim(cTgtCube, 8);
cDim09 = TabDim(cTgtCube, 9);
cDim10 = TabDim(cTgtCube, 10);
cDim11 = TabDim(cTgtCube, 11);
cDim12 = TabDim(cTgtCube, 12);
cDim13 = TabDim(cTgtCube, 13);
cDim14 = TabDim(cTgtCube, 14);
cDim15 = TabDim(cTgtCube, 15);
cDim16 = TabDim(cTgtCube, 16);
cDim17 = TabDim(cTgtCube, 17);
cDim18 = TabDim(cTgtCube, 18);
cDim19 = TabDim(cTgtCube, 19);
cDim20 = TabDim(cTgtCube, 20);
cDim21 = TabDim(cTgtCube, 21);
cDim22 = TabDim(cTgtCube, 22);
cDim23 = TabDim(cTgtCube, 23);
cDim24 = TabDim(cTgtCube, 24);
cDim25 = TabDim(cTgtCube, 25);
cDim26 = TabDim(cTgtCube, 26);
cDim27 = TabDim(cTgtCube, 27);
cDim28 = TabDim(cTgtCube, 28);
cDim29 = TabDim(cTgtCube, 29);
cDim30 = TabDim(cTgtCube, 30);

sRuleText = 'SKIPCHECK;';
CubeRuleAppend(cTgtCube, sRuleText, 1);

sRuleText = Expand('[] = N: IF(DB(''%cTgtCube%''')
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
CubeRuleAppend(cTgtCube, sRuleText, 1);

sRuleText = 'FEEDERS;';
CubeRuleAppend(cTgtCube, sRuleText, 1);

# Create the feeder to add to the source cube 
sFeederText = Expand('[] => DB(''%cTgtCube%''')
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
CubeRuleAppend(cSrcCube, sFeederText, 0);

# Reprocess feeders for the source cube
CubeProcessFeeders(cSrcCube);
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
