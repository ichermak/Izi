601,100
602,"}izi.common.url.encode"
562,"NULL"
586,
585,
564,
565,"e2r11aLjWu\gZ8pfXZpg61XFwWEVmY8zIqovFQB0mOQO`8GbPoe`RwYq6\Td22k^9kiNy\t^t_dp4p<MVawJYoPCl^ufqEcMNIpt<8[rnkQ?Bvn[NvBJhaL1rkKV2q7apvvWKJYgAziZ9w[Dfl^uiQ_XaskRLu6l[`[<e_niKT2o;9;:aqGmZirAmvk>2z60niCQgbRb"
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
560,2
pDebugMode
pUrl
561,2
1
2
590,2
pDebugMode,0
pUrl,""
637,2
pDebugMode,"[Optional] 0 = Nothing | 1 = Write to }izi.ProcessMessage cube | 2 = 1 + Keep temporary objects"
pUrl,"[Mandatory] Url"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,151

#****Begin: Generated Statements***
#****End: Generated Statements****

# ######  ######  ######
#   ##       ##     ##
#   ##      ##      ##
#   ##     ##       ##
# ######  ######  ######
# https://github.com/ichermak/Izi

# ====================================================================================================
# Description : Encodes an Url.
#
# Updates :
# 	- 2020/09/11 - Ifthen CHERMAK (www.linkedin.com/in/ichermak) : Creation
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
cMappingDelimiter = '-';
cCharDelimiter = '=';
cUrlCharsMapping = '% = %25 
                    - & = %26 
                    - `	= %60 
                    - < = %3C 
                    - > = %3E 
                    - [ = %5B 
                    - ] = %5D 
                    - { = %7B 
                    - “ = %22 
                    - + = %2B 
                    - @ = %40 
                    - ; = %3B 
                    - \ = %5C 
                    - ^	= %5E 
                    - | = %7C 
                    - ~	= %7E 
                    - ,	= %2C';


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
pUrl = Trim(pUrl);

If(pUrl @= '');
    sNewMsg = Expand('Invalid parameter : pUrl=%pUrl%.'); 
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

# Loop through url chars mapping
sDelimitedText = cUrlCharsMapping;
sDelimiter = cMappingDelimiter;
While(sDelimitedText @<> '');
    If(Scan(sDelimiter, sDelimitedText) = 0);
        sText = Trim(sDelimitedText);
        sDelimitedText = '';
    Else;  
        sText = Trim(Subst(sDelimitedText, 1, Scan(sDelimiter, sDelimitedText) - 1));
        sDelimitedText = Trim(Subst(sDelimitedText, Scan(sDelimiter, sDelimitedText) + 1, Long(sDelimitedText)));
    EndIf;
    
    sUrlCharsMappingOld = Trim(Subst(sText, 1, Scan(cCharDelimiter, sText) - 1));
    sUrlCharsMappingNew = Trim(Subst(sText, Scan(cCharDelimiter, sText) + 1, Long(sText)));
    
    # Loop through chars to replace them
    sText = '';
    nIndex = 1;
    nMax = Long(pUrl);
    While(nIndex <= nMax);
        sChar = Subst(pUrl, nIndex, 1);
        
        If(sChar @= sUrlCharsMappingOld);
            sChar = sUrlCharsMappingNew;
        EndIf;

        sText = sText | sChar;
        nIndex = nIndex + 1;
    End;
    pUrl = sText;
End;

# Space char must be treated independently
sText = '';
nIndex = 1;
nMax = Long(pUrl);
While(nIndex <= nMax);
    sChar = Subst(pUrl, nIndex, 1);
    
    If(sChar @= ' ');
        sChar = '%20';
    EndIf;
    
    sText = sText | sChar;
    nIndex = nIndex + 1;
End;
pUrl = sText;

# Return the value using the global variable
sProcessReturn = pUrl;
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
