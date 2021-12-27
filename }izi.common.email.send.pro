601,100
602,"}izi.common.email.send"
562,"NULL"
586,
585,
564,
565,"swBWxWs9?fvjQ^TEOlLa1US?LDIrS=2SqAHGz7d5eJJX8L`M@SKK^L1IgfqYe`0eEabMtFv3EUNm:bGmARI^\qwOMo5\kOi\wdl;`>468mitEUE[iyZa4wmoj]15vXh;ztH^bSDYClz;8TfO8;nL6z9vpqxsTKJ^zGIDeoUcOY6I1xgj>WJ1S?GqHTQfk`CpL;G@6W[3"
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
560,17
pDebugMode
pScriptDirectory
pSmtpServer
pPort
pUseSsl
pUser
pPassword
pFrom
pTo
pCc
pSubject
pPriority
pBody
pBodyAsHtml
pEncoding
pAttachments
pWaitForExecution
561,17
1
2
2
1
1
2
2
2
2
2
2
1
2
1
1
2
1
590,17
pDebugMode,0
pScriptDirectory,""
pSmtpServer,""
pPort,0
pUseSsl,0
pUser,""
pPassword,""
pFrom,""
pTo,""
pCc,""
pSubject,""
pPriority,1
pBody,""
pBodyAsHtml,0
pEncoding,6
pAttachments,""
pWaitForExecution,1
637,17
pDebugMode,"[Optional] 0 = Nothing | 1 = Write to }izi.ProcessMessage cube | 2 = 1 + Keep temporary objects"
pScriptDirectory,"[Optional] Directory where the script called by this process will be exported (Example : 'C:\Applications\Tm1\Izi\Script'). If blank, the data directory will be used"
pSmtpServer,"[Mandatory] Smtp server address (Example : 'smtp.gmail.com')"
pPort,"[Mandatory] Port number of the smtp server (Example : 587)"
pUseSsl,"[Optional] 0 = Do not use SSL | 1 = Use SSL"
pUser,"[Optional] User name"
pPassword,"[Optional] User password"
pFrom,"[Mandatory] Sender email address (Example : 'sender@gmail.com')"
pTo,"[Mandatory] Recipient email addresses separated by comma (Example : 'recipient1@gmail.com , ecipient2@gmail.com')"
pCc,"[Optional] Carbon copy email addresses separated by comma (Example : 'cc1@gmail.com , cc2@gmail.com')"
pSubject,"[Optional] Email subject"
pPriority,"[Optional] 0 = Low | 1 = Normal | 2 = High"
pBody,"[Optional] Email body"
pBodyAsHtml,"[Optional] 0 = Body as Text | 1 = Body as HTML"
pEncoding,"[Optional] 0 = ascii | 1 = bigendianunicode | 2 = bigendianutf32 | 3 = oem | 4 = unicode | 5 = utf7 | 6 = utf8 | 7 = utf8BOM | 8 = utf8NoBOM | 9 = utf32"
pAttachments,"[Optional] Path of files to be attached to the email separated by comma (Example : 'C:\file1.csv , C:\file2.csv')"
pWaitForExecution,"[Optional] 0 = Asynchronous execution | 1 = Synchronous execution"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,282
#****Begin: Generated Statements***
#****End: Generated Statements****

# ######  ######  ######
#   ##       ##     ##
#   ##      ##      ##
#   ##     ##       ##
# ######  ######  ######
# https://github.com/ichermak/Izi

# ====================================================================================================
# Description : Sends an email using 'Send-MailMessage' powershell cmdlets.
#
# Updates :
# 	- 2021/05/14 - Ifthen CHERMAK (www.linkedin.com/in/ichermak) : Creation
# 	- 2021/12/27 - Ifthen CHERMAK (www.linkedin.com/in/ichermak) : Add support of multiple file attachments
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
cPowershellFile = cProcessName | '.ps1';

cPowershellContent = '
<#' | cCrLf | '
    .SYNOPSIS' | cCrLf | '
        Linked to }izi.common.email.send' | cCrLf | '
    .DESCRIPTION' | cCrLf | '
        Linked to }izi.common.email.send' | cCrLf | '
    .NOTES' | cCrLf | '
        Updates :' | cCrLf | '
            - 2021/05/14 - Ifthen CHERMAK (www.linkedin.com/in/ichermak) : Creation' | cCrLf | '
            - 2021/12/27 - Ifthen CHERMAK (www.linkedin.com/in/ichermak) : Add support of multiple file attachments' | cCrLf | '
' | '#>' | cCrLf | '
' | cCrLf | '
PARAM (' | cCrLf | '
    [Parameter(Mandatory=$true)][String]$SmtpServer,' | cCrLf | '
    [Parameter(Mandatory=$true)][String]$Port,' | cCrLf | '
    [Parameter(Mandatory=$false)][String]$UseSsl,' | cCrLf | '
    [Parameter(Mandatory=$false)][String]$User,' | cCrLf | '
    [Parameter(Mandatory=$false)][String]$Password,' | cCrLf | '
    [Parameter(Mandatory=$true)][String]$From,' | cCrLf | '
    [Parameter(Mandatory=$true)][String]$To,' | cCrLf | '
    [Parameter(Mandatory=$false)][String]$Cc,' | cCrLf | '
    [Parameter(Mandatory=$false)][String]$Subject,' | cCrLf | '
    [Parameter(Mandatory=$false)][String]$Priority,' | cCrLf | '
    [Parameter(Mandatory=$false)][String]$Body,' | cCrLf | '
    [Parameter(Mandatory=$false)][String]$BodyAsHtml,' | cCrLf | '
    [Parameter(Mandatory=$false)][String]$Encoding,' | cCrLf | '
    [Parameter(Mandatory=$false)][String]$Attachments' | cCrLf | '
)' | cCrLf | '
' | cCrLf | '
Start-Transcript -Path "$PSCommandPath.log"' | cCrLf | '
' | cCrLf | '
[String[]]$ArrayTo = $To.Split('','')' | cCrLf | '
[String[]]$ArrayCc = $Cc.Split('','')' | cCrLf | '
[String[]]$ArrayAttachments = $Attachments.Split('','')' | cCrLf | '
$BooleanUseSsl = $UseSsl | % {if($_ -eq "True") {$true} else {$false}}' | cCrLf | '
If ($Password) {' | cCrLf | '
    $SecureStringPassword = ConvertTo-SecureString $Password -AsPlainText -Force' | cCrLf | '
    $Credential = New-Object System.Management.Automation.PSCredential ($User, $SecureStringPassword)' | cCrLf | '
}' | cCrLf | '
$BooleanBodyAsHtml = $BodyAsHtml | % {if($_ -eq "True") {$true} else {$false}}' | cCrLf | '
' | cCrLf | '
$Params = @{}' | cCrLf | '
$Params.Add(''SmtpServer'', $SmtpServer)' | cCrLf | '
$Params.Add(''Port'', $Port)' | cCrLf | '
$Params.Add(''UseSsl'', $BooleanUseSsl)' | cCrLf | '
If ($Password) {' | cCrLf | '
    $Params.Add(''Credential'', $Credential)' | cCrLf | '
}' | cCrLf | '
$Params.Add(''From'', $From)' | cCrLf | '
$Params.Add(''To'', $ArrayTo)' | cCrLf | '
If ($Cc) {' | cCrLf | '
    $Params.Add(''Cc'', $ArrayCc)' | cCrLf | '
}' | cCrLf | '
If ($Subject) {' | cCrLf | '
    $Params.Add(''Subject'', $Subject)' | cCrLf | '
}' | cCrLf | '
$Params.Add(''Priority'', $Priority)' | cCrLf | '
If ($Body) {' | cCrLf | '
    $Params.Add(''Body'', $Body)' | cCrLf | '
}' | cCrLf | '
$Params.Add(''BodyAsHtml'', $BooleanBodyAsHtml)' | cCrLf | '
$Params.Add(''Encoding'', $Encoding)' | cCrLf | '
If ($Attachments) {' | cCrLf | '
    $Params.Add(''Attachments'', $ArrayAttachments)' | cCrLf | '
}' | cCrLf | '
' | cCrLf | '
Send-MailMessage @Params' | cCrLf | '
' | cCrLf | '
Stop-Transcript' | cCrLf | '
';


# === PARAMETERS VERIFICATION AND OTHER CHECKS
# ====================================================================================================
If((pDebugMode = 1) % (pDebugMode = 2));
    sNewMsg = Expand('Process started with : pScriptDirectory=%pScriptDirectory%, pSmtpServer=%pSmtpServer%, pPort=%pPort%, pUseSsl=%pUseSsl%, pUser=%pUser%, pPassword=*****, pFrom=%pFrom%, pTo=%pTo%, pCc=%pCc%, pSubject=%pSubject%, pPriority=%pPriority%, pBody=%pBody%, pBodyAsHtml=%pBodyAsHtml%, pEncoding=%pEncoding%, pAttachments=%pAttachments%, pWaitForExecution=%pWaitForExecution%.');
    ExecuteProcess('}izi.process.message.add'
                , 'pProcess', cProcessName
                , 'pMessage', sNewMsg
                , 'pMessageType', 'Info'
                );
EndIf;

sErrorMsg = '';
pScriptDirectory = Trim(pScriptDirectory);
If(pScriptDirectory @<> '');
    pScriptDirectory = IF(Subst(pScriptDirectory, Long(pScriptDirectory), 1) @= '\', pScriptDirectory, pScriptDirectory | '\');
EndIf;
pSmtpServer = Trim(pSmtpServer);
pPort = Int(pPort);
pUseSsl = Int(pUseSsl);
pUser = Trim(pUser);
pFrom = Trim(pFrom);
pTo = Trim(pTo);
pCc = Trim(pCc);
pSubject = Trim(pSubject);
pPriority = Int(pPriority);
pBody = Trim(pBody);
pBodyAsHtml = Int(pBodyAsHtml);
pEncoding = Int(pEncoding);
pAttachments = Trim(pAttachments);
pWaitForExecution = Int(pWaitForExecution);

If((pScriptDirectory @<> '') & (FileExists(pScriptDirectory) = 0));
    sNewMsg = Expand('Invalid parameter : pScriptDirectory=%pScriptDirectory%.');
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If(pSmtpServer @= '');
    sNewMsg = Expand('Invalid parameter : pSmtpServer=%pSmtpServer%.');
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If(pPort = 0);
    sNewMsg = Expand('Invalid parameter : pPort=%pPort%.');
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If((pUseSsl < 0) % (pUseSsl > 1));
    sNewMsg = Expand('Invalid parameter : pUseSsl=%pUseSsl%.');
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If(pSubject @= '');
    sNewMsg = Expand('Invalid parameter : pSubject=%pSubject%.');
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If((pPriority < 0) % (pPriority > 2));
    sNewMsg = Expand('Invalid parameter : pPriority=%pPriority%.');
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If((pBodyAsHtml < 0) % (pBodyAsHtml > 1));
    sNewMsg = Expand('Invalid parameter : pBodyAsHtml=%pBodyAsHtml%.');
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If((pEncoding < 0) % (pEncoding > 9));
    sNewMsg = Expand('Invalid parameter : pEncoding=%pEncoding%.');
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If((pWaitForExecution < 0) % (pWaitForExecution > 1));
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
sPowershellFilePath = pScriptDirectory | cPowershellFile;

sPort = NumberToString(pPort);

If(pUseSsl = 0);
    sUseSsl = 'False';
    
ElseIf(pUseSsl = 1);
    sUseSsl = 'True';
    
EndIf;

If(pPriority = 0);
    sPriority = 'Low';
    
ElseIf(pPriority = 1);
    sPriority = 'Normal';

ElseIf(pPriority = 2);
    sPriority = 'High';
    
EndIf;

If(pBodyAsHtml = 0);
    sBodyAsHtml = 'False';
    
ElseIf(pBodyAsHtml = 1);
    sBodyAsHtml = 'True';
    
EndIf;

If(pEncoding = 0);
    sEncoding = 'ascii';
    
ElseIf(pEncoding = 1);
    sEncoding = 'bigendianunicode';

ElseIf(pEncoding = 2);
    sEncoding = 'bigendianutf32';

ElseIf(pEncoding = 3);
    sEncoding = 'oem';

ElseIf(pEncoding = 4);
    sEncoding = 'unicode';

ElseIf(pEncoding = 5);
    sEncoding = 'utf7';

ElseIf(pEncoding = 6);
    sEncoding = 'utf8';

ElseIf(pEncoding = 7);
    sEncoding = 'utf8BOM';

ElseIf(pEncoding = 8);
    sEncoding = 'utf8NoBOM';

ElseIf(pEncoding = 9);
    sEncoding = 'utf32';
    
EndIf;

DatasourceASCIIQuoteCharacter = '';
ASCIIOutput(sPowershellFilePath, cPowershellContent);

sCmd = Expand('Powershell -NoProfile -NoLogo -NonInteractive -ExecutionPolicy Bypass -File "%sPowershellFilePath%" -SmtpServer "%pSmtpServer%" -Port "%sPort%" -UseSsl "%sUseSsl%" -User "%pUser%" -Password "%pPassword%" -From "%pFrom%" -To "%pTo%" -Cc "%pCc%" -Subject "%pSubject%" -Priority "%sPriority%" -Body "%pBody%" -BodyAsHtml "%sBodyAsHtml%" -Encoding "%sEncoding%" -Attachments "%pAttachments%"');
ExecuteCommand(sCmd, pWaitForExecution);

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
