601,100
602,"}izi.common.email.send"
562,"NULL"
586,
585,
564,
565,"fBz11JaVAET34Kvn\?<CXfbmbd]kgTYBd3CN?K5M3:obunnKyypWFB9[yF^>pFE9G?myjpHL:XmvK0H4b8GcrCbXVPPV<VcPg1j90J?xdxb8vYMsVizTqNzH[kynIamYbqdG06Y^]]KbDaHZFv2]yW6j3I4<eqE0o<lC]IBuGx_tbyLHIV0?udj9vkYZozNMLdKDQO3O"
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
560,15
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
561,15
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
590,15
pDebugMode,0
pScriptDirectory,""
pSmtpServer,""
pPort,""
pUseSsl,""
pUser,""
pPassword,""
pFrom,""
pTo,""
pCc,""
pSubject,""
pPriority,""
pBody,""
pBodyAsHtml,""
pEncoding,""
637,15
pDebugMode,"[Optional] 0 = Nothing | 1 = Write to }izi.ProcessMessage cube | 2 = 1 + Keep temporary objects"
pScriptDirectory,"[Optional]"
pSmtpServer,"[Mandatory]"
pPort,"[Mandatory]"
pUseSsl,"[Optional] 0 = Nothing | 1 = Use SSL"
pUser,"[Optional]"
pPassword,"[Optional]"
pFrom,"[Mandatory]"
pTo,"[Mandatory]"
pCc,"[Optional]"
pSubject,"[Mandatory]"
pPriority,"[Optional] 0 = Nothing | 1 = Write to server message log | 2 = 1 + Keep temporary objects"
pBody,"[Mandatory]"
pBodyAsHtml,"[Optional] 0 = Nothing | 1 = Body as HTML"
pEncoding,"[Optional]"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,89
#****Begin: Generated Statements***
#****End: Generated Statements****

# ######  ######  ######
#   ##       ##     ##
#   ##      ##      ##
#   ##     ##       ##
# ######  ######  ######
# https://github.com/ichermak/Izi

# ====================================================================================================
# Description : Send an email using 'Send-MailMessage' powershell cmdlets
#
# Updates :
# 	- 2021/05/14 - Ifthen CHERMAK (www.linkedin.com/in/ichermak) : Creation
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
cCrLf = Char(13) | Char(10);
If(DimIx('}Clients', Tm1User) = 0); cTM1User = 'Chore'; Else; cTM1User = Tm1User; EndIf;
cStartTime = Now;
cProcessName = GetProcessName;
cIdExecution = cProcessName | '_' | TimSt(cStartTime, '\Y\m\d\h\i\s') | '_' | cTM1User  | '_' | Fill( '0', 5 - Long(NumberToString(Int(Rand * 65536)))) | NumberToString(Int(Rand * 65536));
cDebugFile = GetProcessErrorFileDirectory | cIdExecution | '.dbg';
cTemporaryObject = 1;
If(pDebugMode > 1); cTemporaryObject = 0; EndIf;

# *** Other
# ****************************************
cPowershellFile = cProcessName | '.ps1';
cPowershellFilePath = pScriptDirectory | cPowershellFile;
cPowershellContent = '
PARAM (' | cCrLf | '
    [Parameter(Mandatory=$true)][String]$SmtpServer,' | cCrLf | '
    [Parameter(Mandatory=$true)][String]$Port,' | cCrLf | '
    [Parameter(Mandatory=$true)][String]$UseSsl,' | cCrLf | '
    [Parameter(Mandatory=$true)][String]$User,' | cCrLf | '
    [Parameter(Mandatory=$true)][String]$Password,' | cCrLf | '
    [Parameter(Mandatory=$true)][String]$From,' | cCrLf | '
    [Parameter(Mandatory=$true)][String]$To,' | cCrLf | '
    [Parameter(Mandatory=$true)][String]$Cc,' | cCrLf | '
    [Parameter(Mandatory=$true)][String]$Subject,' | cCrLf | '
    [Parameter(Mandatory=$true)][String]$Priority,' | cCrLf | '
    [Parameter(Mandatory=$true)][String]$Body,' | cCrLf | '
    [Parameter(Mandatory=$true)][String]$BodyAsHtml,' | cCrLf | '
    [Parameter(Mandatory=$true)][String]$Encoding' | cCrLf | '
)' | cCrLf | '
' | cCrLf | '
$BooleanUseSsl = $UseSsl | % {if($_ -eq "True") {$true} else {$false}}' | cCrLf | '
$SecureStringPassword = ConvertTo-SecureString $Password -AsPlainText -Force' | cCrLf | '
$Credential = New-Object System.Management.Automation.PSCredential ($User, $SecureStringPassword)' | cCrLf | '
$BooleanBodyAsHtml = $BodyAsHtml | % {if($_ -eq "True") {$true} else {$false}}' | cCrLf | '
' | cCrLf | '
$Params = @{' | cCrLf | '
    SmtpServer = $SmtpServer' | cCrLf | '
    Port = $Port' | cCrLf | '
    UseSsl = $BooleanUseSsl' | cCrLf | '
    Credential = $Credential' | cCrLf | '
    From = $From' | cCrLf | '
    To = $To' | cCrLf | '
    Cc = $Cc' | cCrLf | '
    Subject = $Subject' | cCrLf | '
    Priority = $Priority' | cCrLf | '
    Body = $Body' | cCrLf | '
    BodyAsHtml = $BooleanBodyAsHtml' | cCrLf | '
    Encoding = $Encoding' | cCrLf | '
}' | cCrLf | '
Send-MailMessage @Params
';

DatasourceASCIIQuoteCharacter='';
ASCIIOutput(cPowershellFilePath, cPowershellContent);

sCmd = Expand('Powershell -ExecutionPolicy Bypass -File "%cPowershellFilePath%" -SmtpServer "%pSmtpServer%" -Port "%pPort%" -UseSsl "%pUseSsl%" -User "%pUser%" -Password "%pPassword%" -From "%pFrom%" -To "%pTo%" -Cc "%pCc%" -Subject "%pSubject%" -Priority "%pPriority%" -Body "%pBody%" -BodyAsHtml "%pBodyAsHtml%" -Encoding "%pEncoding%"');
ExecuteCommand(sCmd, 1);
573,2
#****Begin: Generated Statements***
#****End: Generated Statements****
574,2
#****Begin: Generated Statements***
#****End: Generated Statements****
575,20
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
