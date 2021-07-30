601,100
602,"}izi.system.directory.backup"
562,"NULL"
586,
585,
564,
565,"d5@TanU2KO;Bo8Kh1C8SVD53x_[sxnlJOd3YWDpISgi^V2I1Y^TccEvuqnNR8LC0h;0\ym7p3>KN>I1Lz7Y[XP;FnGW3AUVz8f2T\wJSP^L^0OBA3xo]vn2SopT;jy\2KoX4WpGOuc6M;mf2Rz]U2G;PiKpBAy@GnkU=sHUOEBW0ywp12zdxdS2UkG`PqwMn1aA29^T@"
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
560,7
pDebugMode
pDirectoryPath
pDestinationPath
pBackupName
pCompress
pCompressionLevel
pWaitForExecution
561,7
1
2
2
2
1
1
1
590,7
pDebugMode,0
pDirectoryPath,""
pDestinationPath,""
pBackupName,""
pCompress,1
pCompressionLevel,0
pWaitForExecution,1
637,7
pDebugMode,"[Optional] 0 = Nothing | 1 = Write to }izi.ProcessMessage cube | 2 = 1 + Keep temporary objects"
pDirectoryPath,"[Mandatory] Directory path (Example : '..\Data')"
pDestinationPath,"[Mandatory] Destination path (Example : '..\Backup')"
pBackupName,"[Optional] Backup name. If blank the backup will named with the format 'Tm1_Backup_YYYYMMDD_hhmmss'"
pCompress,"[Optional] 0 = Nothing | 1 = To compress the backup"
pCompressionLevel,"[Optional] 0 = Fastest | 1 = Optimal | 2 = NoCompression"
pWaitForExecution,"[Optional] 0 = Asynchronous execution | 1 = Synchronous execution"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,142
#****Begin: Generated Statements***
#****End: Generated Statements****

# ######  ######  ######
#   ##       ##     ##
#   ##      ##      ##
#   ##     ##       ##
# ######  ######  ######
# https://github.com/ichermak/Izi

# ====================================================================================================
# Description : Backup a specified folder
#
# Updates :
# 	- 2020/03/30 - Ifthen CHERMAK (www.linkedin.com/in/ichermak) : Creation
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


# === PARAMETERS VERIFICATION AND OTHER CHECKS
# ====================================================================================================
If((pDebugMode = 1) % (pDebugMode = 2));
    sNewMsg = Expand('Process started with : pDirectoryPath=%pDirectoryPath%, pDestinationPath=%pDestinationPath%, pBackupName=%pBackupName%, pCompress=%pCompress%, pCompressionLevel=%pCompressionLevel%, pWaitForExecution=%pWaitForExecution%.');
    ExecuteProcess('}izi.process.message.add'
                , 'pProcess', cProcessName
                , 'pMessage', sNewMsg
                , 'pMessageType', 'Info'
                );
EndIf;

sErrorMsg = '';
pDirectoryPath = Trim(pDirectoryPath);
pDirectoryPath = IF(Subst(pDirectoryPath, Long(pDirectoryPath), 1) @= '\', pDirectoryPath, pDirectoryPath | '\');
pDestinationPath = Trim(pDestinationPath);
pDestinationPath = IF(Subst(pDestinationPath, Long(pDestinationPath), 1) @= '\', pDestinationPath, pDestinationPath | '\');
pBackupName = Trim(pBackupName);
pCompress = INT(pCompress);
pCompressionLevel = INT(pCompressionLevel);
pWaitForExecution = INT(pWaitForExecution);

If(FileExists(pDirectoryPath) = 0);
    sNewMsg = Expand('Invalid parameter : pDirectoryPath=%pDirectoryPath%.'); 
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If(FileExists(pDestinationPath) = 0);
    sNewMsg = Expand('Invalid parameter : pDestinationPath=%pDestinationPath%.'); 
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If( (pCompress <> 0) & (pCompress <> 1) );
    sNewMsg = Expand('Invalid parameter : pCompress=%pCompress%.'); 
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If( (pCompressionLevel <> 0) & (pCompressionLevel <> 1) & (pCompressionLevel <> 2) );
    sNewMsg = Expand('Invalid parameter : pCompressionLevel=%pCompressionLevel%.'); 
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If( (pWaitForExecution <> 0) & (pWaitForExecution <> 1) );
    sNewMsg = Expand('Invalid parameter : pWaitForExecution=%pWaitForExecution%.'); 
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
If(pBackupName @= '');
    pBackupName = 'Tm1_Backup_' | TimSt(cStartTime, '\Y\m\d_\h\i\s');
EndIf;
sDestinationPath = pDestinationPath | pBackupName;

If(pCompress = 0);
    sDelimitedText = pDirectoryPath;
    sDelimiter = '\';
    While(sDelimitedText @<> '');
        If(Scan(sDelimiter, sDelimitedText) = 0);
            sText = sDelimitedText;
            sDelimitedText = '';
        Else;
            sText = Trim(Subst(sDelimitedText, 1, Scan(sDelimiter, sDelimitedText) - 1));
            sDelimitedText = Trim(Subst(sDelimitedText, Scan(sDelimiter, sDelimitedText) + 1, Long(sDelimitedText)));
        EndIf;
        sSourceFolderName = sText;
    End;
    sDestinationPath = sDestinationPath | '\' | sSourceFolderName;
    sPsCmd = Expand('Copy-Item -Path ''%pDirectoryPath%'' -Destination ''%sDestinationPath%'' -Recurse -Container');
    
ElseIf(pCompress = 1);
    If(pCompressionLevel = 0);
        sCompressionLevel = 'Fastest';
    ElseIf(pCompressionLevel = 1);
        sCompressionLevel = 'Optimal';
    ElseIf(pCompressionLevel = 2);
        sCompressionLevel = 'NoCompression';
    EndIf;
    sPsCmd = Expand('Compress-Archive -Path ''%pDirectoryPath%'' -DestinationPath ''%sDestinationPath%'' -CompressionLevel %sCompressionLevel% -Update');
    
EndIf;

sCmd = Expand('Powershell -ExecutionPolicy Bypass -command "%sPsCmd%"');
ExecuteCommand(sCmd, pWaitForExecution);
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
920,50000
921,""
922,""
923,0
924,""
925,""
926,""
927,""
