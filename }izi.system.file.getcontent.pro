﻿601,100
602,"}izi.system.file.getcontent"
562,"CHARACTERDELIMITED"
586,"tm1server.log.blb"
585,"tm1server.log.blb"
564,
565,"r91qjEMqnBO6iE9i>Qah<4?m>5q6pn5==vFnGddT;L??sgVXF8Asw^fzh63WYViOU[xD1ZuhFZ_o63\VsO]cgBb4xa:RM@V<^@`bttqy6z]aVHcv\7TpBfGA9yJJnKt`H]uF62I^4ZKtr>iLm`e1Q>RSdKq`Wru;i4lb@KsZzd2E2J[H?8aRfcx7U2]Lhrt>BKxo[rtN"
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
567,"§"
588,"."
589,","
568,""
570,
571,
569,0
592,0
599,1000
560,3
pDebugMode
pFileDirectory
pFileName
561,3
1
2
2
590,3
pDebugMode,0
pFileDirectory,""
pFileName,""
637,3
pDebugMode,"[Optional] 0 = Nothing | 1 = Write to }izi.ProcessMessage cube | 2 = 1 + Keep temporary objects"
pFileDirectory,"[Mandatory] File directory (Example : 'C:\Applications\Tm1\Izi\Interface\Inbound')"
pFileName,"[Mandatory] File name (Example : 'Test.txt')"
577,30
v1
v2
v3
v4
v5
v6
v7
v8
v9
v10
v11
v12
v13
v14
v15
v16
v17
v18
v19
v20
v21
v22
v23
v24
v25
v26
v27
v28
v29
v30
578,30
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
579,30
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
21
22
23
24
25
26
27
28
29
30
580,30
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
581,30
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
582,30
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
572,100

#****Begin: Generated Statements***
#****End: Generated Statements****

# ######  ######  ######
#   ##       ##     ##
#   ##      ##      ##
#   ##     ##       ##
# ######  ######  ######
# https://github.com/ichermak/Izi

# ====================================================================================================
# Description : Get file content and return as text within sProcessReturn
#
# Updates :
# 	- 2021/05/13 - Ifthen CHERMAK (www.linkedin.com/in/ichermak) : Creation
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
cDelimiter = '§';


# === PARAMETERS VERIFICATION AND OTHER CHECKS
# ====================================================================================================
If((pDebugMode = 1) % (pDebugMode = 2));
    sNewMsg = Expand('Process started with : pFileDirectory=%pFileDirectory%, pFileName=%pFileName%.');
    ExecuteProcess('}izi.process.message.add'
                , 'pProcess', cProcessName
                , 'pMessage', sNewMsg
                , 'pMessageType', 'Info'
                );
EndIf;

sErrorMsg = '';
pFileDirectory = Trim(pFileDirectory);
pFileDirectory = IF(Subst(pFileDirectory, Long(pFileDirectory), 1) @= '\', pFileDirectory, pFileDirectory | '\');
pFileName = Trim(pFileName);

If(FileExists(pFileDirectory) = 0);
    sNewMsg = Expand('Invalid parameter : pFileDirectory=%pFileDirectory%.'); 
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If((pFileName @= '') % (FileExists(pFileDirectory | pFileName) = 0));
    sNewMsg = Expand('Invalid parameter : pFileName=%pFileName%.'); 
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


# === SOURCE DEFINITION
# ====================================================================================================

# *** Source settings
# ****************************************
DataSourceType = 'CHARACTERDELIMITED';
DatasourceNameForServer = pFileDirectory | pFileName;
DatasourceASCIIHeaderRecords = 0;
DatasourceASCIIDelimiter = cDelimiter;
DatasourceASCIIQuoteCharacter = '';
573,3

#****Begin: Generated Statements***
#****End: Generated Statements****
574,36

#****Begin: Generated Statements***
#****End: Generated Statements****

sText = v1 
        | IF(v2 @= '', '', cDelimiter | v2)
        | IF(v3 @= '', '', cDelimiter | v3) 
        | IF(v4 @= '', '', cDelimiter | v4) 
        | IF(v5 @= '', '', cDelimiter | v5) 
        | IF(v6 @= '', '', cDelimiter | v6) 
        | IF(v7 @= '', '', cDelimiter | v7) 
        | IF(v8 @= '', '', cDelimiter | v8) 
        | IF(v9 @= '', '', cDelimiter | v9) 
        | IF(v10 @= '', '', cDelimiter | v10)
        | IF(v11 @= '', '', cDelimiter | v11)
        | IF(v12 @= '', '', cDelimiter | v12)
        | IF(v13 @= '', '', cDelimiter | v13)
        | IF(v14 @= '', '', cDelimiter | v14)
        | IF(v15 @= '', '', cDelimiter | v15)
        | IF(v16 @= '', '', cDelimiter | v16)
        | IF(v17 @= '', '', cDelimiter | v17)
        | IF(v18 @= '', '', cDelimiter | v18)
        | IF(v19 @= '', '', cDelimiter | v19)
        | IF(v20 @= '', '', cDelimiter | v20)
        | IF(v21 @= '', '', cDelimiter | v21)
        | IF(v22 @= '', '', cDelimiter | v22)
        | IF(v23 @= '', '', cDelimiter | v23)
        | IF(v24 @= '', '', cDelimiter | v24)
        | IF(v25 @= '', '', cDelimiter | v25)
        | IF(v26 @= '', '', cDelimiter | v26)
        | IF(v27 @= '', '', cDelimiter | v27)
        | IF(v28 @= '', '', cDelimiter | v28)
        | IF(v29 @= '', '', cDelimiter | v29)
        | IF(v30 @= '', '', cDelimiter | v30)
        ;
sProcessReturn = sProcessReturn | IF(sProcessReturn @= '', '', cCrLf) | sText;
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
920,0
921,""
922,""
923,0
924,""
925,""
926,""
927,""
