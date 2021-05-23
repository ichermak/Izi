601,100
602,"}izi.template"
562,"NULL"
586,
585,
564,
565,"sI5Hr@9EXvKURCG@ojsa@gAIgzTzEX=BC:Z00:ndt`14ZUcrRV^o6XZl0YQYhbnMDW0Wg2Yjt<ln\qCmj<L4_]rskO]MT;ibs@Zop5f]8IB:sS8eV[>jCm8hqQ=2s_AzRWXQm`Z[Fk>`tjTKo1atFRYK=>w6rAY_01`<w9=F8mKn2d1H2Y_b^ts1z>^BJu5P[sp@ph5G"
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
pSetUseActiveSandbox
pParameter1
pParameter2
561,4
1
1
2
1
590,4
pDebugMode,0
pSetUseActiveSandbox,1
pParameter1,""
pParameter2,1
637,4
pDebugMode,"[Optional] 0 = Nothing | 1 = Write to server message log | 2 = 1 + Keep temporary objects"
pSetUseActiveSandbox,"[Optional] 0 = Reads and writes to the base data | 1 = Reads and writes to the user's active sandbox"
pParameter1,"[Mandatory / Optional] <Brief description> (Example : <Example value>)"
pParameter2,"[Mandatory / Optional] <Brief description> (Example : <Example value>)"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,99

#****Begin: Generated Statements***
#****End: Generated Statements****

# ######  ######  ######
#   ##       ##     ##
#   ##      ##      ##
#   ##     ##       ##
# ######  ######  ######
# https://github.com/ichermak/Izi

# ====================================================================================================
# Description : <Brief description of what this process does>
#
# Updates :
# 	- YYYY/MM/DD - <Your name> (<Your profile page>) : Creation
# 	- YYYY/MM/DD - <Your name> (<Your profile page>) : <Brief description of the changes concerned by this update>
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
If(DimIx('}Clients', Tm1User) = 0); cTM1User = 'Chore'; Else; cTM1User = Tm1User; EndIf;
cStartTime = Now;
cProcessName = GetProcessName;
cIdExecution = cProcessName | '_' | TimSt(cStartTime, '\Y\m\d\h\i\s') | '_' | cTM1User  | '_' | Fill( '0', 5 - Long(NumberToString(Int(Rand * 65536)))) | NumberToString(Int(Rand * 65536));
cDebugFile = GetProcessErrorFileDirectory | cIdExecution | '.dbg';
cTemporaryObject = 1;
If(pDebugMode > 1); cTemporaryObject = 0; EndIf;

# *** Source variables
# ****************************************
#<Put your source variables here>

# *** Target variables
# ****************************************
#<Put your target variables here>

# *** Other variables
# ****************************************  
#<Put other variables here>


# === PARAMETERS VERIFICATION AND OTHER CHECKS
# ====================================================================================================
If((pDebugMode = 1) % (pDebugMode = 2));
    sNewMsg = Expand('Process started with : pParameter1=%pParameter1%, pParameter2=%pParameter2%.');
    ExecuteProcess('}izi.process.message.add'
                , 'pProcess', cProcessName
                , 'pMessage', sNewMsg
                );
EndIf;

sErrorMsg = '';
pParameter1 = Trim(pParameter1);

If(pParameter1 @= '');
	sNewMsg = Expand('Invalid parameter : pParameter1=%pParameter1%.'); 
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If(pParameter2 = 0);
	sNewMsg = Expand('Invalid parameter : pParameter2=%pParameter2%.'); 
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
#<Put your prolog code here>
573,3

#****Begin: Generated Statements***
#****End: Generated Statements****
574,3

#****Begin: Generated Statements***
#****End: Generated Statements****
575,26

#****Begin: Generated Statements***
#****End: Generated Statements****

If(sErrorMsg @= '');
    #<Put your epilog code here>
EndIf;


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
