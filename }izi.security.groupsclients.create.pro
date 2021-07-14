601,100
602,"}izi.security.groupsclients.create"
562,"NULL"
586,
585,
564,
565,"wavaN3]ZBc[<23epn4oT_Eba_XeiUWMQ9z@D]Xz^`Hpjrwv9O^mM@@jPBE<@JYslI00ZlP^c42ZJYu]S6M]JTjET9T^xzrya59FUu?OwIpTB>Ua9CjScB9cO`AVux5=M^IHqM9\c_KLEMq0ldZ>1mX53JI@kp6J47]QS=B1TPJcYAD<MoVJb]mHl`POW]JHTn`k1sXU="
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
570,
571,
569,0
592,0
599,1000
560,3
pDebugMode
pClientList
pClientDelimiter
561,3
1
2
2
590,3
pDebugMode,0
pClientList,""
pClientDelimiter,";"
637,3
pDebugMode,"[Optional] 0 = Nothing | 1 = Write to }izi.ProcessMessage cube | 2 = 1 + Keep temporary objects"
pClientList,"[Optional] Client list (Example : 'ClientName1 ; ClientName2 ; ClientName3'). If blank the process will trait all clients"
pClientDelimiter,"[Optional] Client list delimiter"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,137

#****Begin: Generated Statements***
#****End: Generated Statements****

# ######  ######  ######
#   ##       ##     ##
#   ##      ##      ##
#   ##     ##       ##
# ######  ######  ######
# https://github.com/ichermak/Izi

# ====================================================================================================
# Description : Create security croups with clients names
#
# Updates :
# 	- 2019/12/13 - Ifthen CHERMAK (www.linkedin.com/in/ichermak) : Creation
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


# === PARAMETERS VERIFICATION AND OTHER CHECKS
# ====================================================================================================
If((pDebugMode = 1) % (pDebugMode = 2));
    sNewMsg = Expand('Process started with : pClientList=%pClientList%, pClientDelimiter=%pClientDelimiter%.');
    ExecuteProcess('}izi.process.message.add'
                , 'pProcess', cProcessName
                , 'pMessage', sNewMsg
                , 'pMessageType', 'Info'
                );
EndIf;

sErrorMsg = '';
pClientList = Trim(pClientList);
pClientDelimiter = Trim(pClientDelimiter);

sDelimitedText = pClientList;
sDelimiter = pClientDelimiter;
While(sDelimitedText @<> '');
    If(Scan(sDelimiter, sDelimitedText) = 0);
        sText = sDelimitedText;
        sDelimitedText = '';
    Else;  
        sText = Trim(Subst(sDelimitedText, 1, Scan(sDelimiter, sDelimitedText) - 1));
        sDelimitedText = Trim(Subst(sDelimitedText, Scan(sDelimiter, sDelimitedText) + 1, Long(sDelimitedText)));
    EndIf;
    
    sClient = sText;
    If(DimIx('}Clients', sClient) = 0);
        sNewMsg = Expand('Invalid parameter : pClientList=%pClientList%.'); 
        sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
        Break;
    EndIf;
End;

If(Long(pClientDelimiter) > 1);
    sNewMsg = Expand('Invalid parameter : pClientDelimiter=%pClientDelimiter%.'); 
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
If(pClientList @= '');
    sDim = '}Clients';
    nCtr = DimSiz( sDim );
    While( nCtr > 0 );
        sClient = DimNm( sDim, nCtr );
        If(sClient @<> 'Admin');
            If(DimIx('}Groups', sClient) = 0);
                AddGroup(sClient);
            EndIf;
            SecurityRefresh;
            AssignClientToGroup(sClient, sClient);
        EndIf;
        nCtr = nCtr - 1;
    End;
    
Else;
    sDelimitedText = pClientList;
    sDelimiter = pClientDelimiter;
    While(sDelimitedText @<> '');
        If(Scan(sDelimiter, sDelimitedText) = 0);
            sText = sDelimitedText;
            sDelimitedText = '';
        Else;  
            sText = Trim(Subst(sDelimitedText, 1, Scan(sDelimiter, sDelimitedText) - 1));
            sDelimitedText = Trim(Subst(sDelimitedText, Scan(sDelimiter, sDelimitedText) + 1, Long(sDelimitedText)));
        EndIf;
        
        sClient = sText;
        If(DimIx('}Groups', sClient) = 0);
            AddGroup(sClient);
        EndIf;
        SecurityRefresh;
        AssignClientToGroup(sClient, sClient);
    End;
    
EndIf;
SecurityRefresh;
573,3

#****Begin: Generated Statements***
#****End: Generated Statements****
574,3

#****Begin: Generated Statements***
#****End: Generated Statements****
575,28

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
    If(PrologMinorErrorCount + MetadataMinorErrorCount + DataMinorErrorCount > 0);
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
