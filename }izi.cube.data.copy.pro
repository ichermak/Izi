601,100
602,"}izi.cube.data.copy"
562,"VIEW"
586,"Template"
585,"Template"
564,
565,"bMa2HZr?4uwd[cEYEBC0l6R45QA2kYObwZS9Zrz636GQCI5iKs76of3?<B\lr2Re5XbPYE=ub]sl@:gn43^LF=atLEUhw`HyZLCu[OJGsoE?IrSL]qs>zb7S2GAJBjOe5fidza:Roi=v0urqSsd=;?d_:@P2t`WB^RfnT8TsMrBi11[KfPxklP6NWMQkyyh>6UcQQ62Z"
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
570,SourceView
571,
569,0
592,0
599,1000
560,14
pDebugMode
pSetUseActiveSandbox
pCube
pMappingElement
pMappingDelimiter
pDimensionDelimiter
pElementDelimiter
pSkipRuleValues
pSkipCalcs
pSkipZeroes
pZeroOut
pCoefficient
pIncrement
pSubtractFromSource
561,14
1
1
2
2
2
2
2
1
1
1
1
1
1
1
590,14
pDebugMode,0
pSetUseActiveSandbox,0
pCube,""
pMappingElement,""
pMappingDelimiter,"&"
pDimensionDelimiter,":"
pElementDelimiter,"->"
pSkipRuleValues,0
pSkipCalcs,0
pSkipZeroes,1
pZeroOut,1
pCoefficient,1
pIncrement,0
pSubtractFromSource,0
637,14
pDebugMode,"[Optional] 0 = Nothing | 1 = Write to }izi.ProcessMessage cube | 2 = 1 + Keep temporary objects"
pSetUseActiveSandbox,"[Optional] 0 = Reads and writes to the base data | 1 = Reads and writes to the user's active sandbox"
pCube,"[Mandatory] Cube name"
pMappingElement,"[Mandatory] Map source elements to target elements using format 'DimName1 : SourceElement -> TargetElement & DimName2 : SourceElement -> TargetElement'"
pMappingDelimiter,"[Optional] Delimiter between mapping specifications in pMappingElement"
pDimensionDelimiter,"[Optional] Delimiter between dimensions names and source elements in pMappingElement"
pElementDelimiter,"[Optional] Delimiter between source elements and target elements in pMappingElement"
pSkipRuleValues,"[Optional] 0 = Nothing | 1 = Skip rule values in source view"
pSkipCalcs,"[Optional] 0 = Nothing | 1 = Skip consolidated values in source view"
pSkipZeroes,"[Optional] 0 = Nothing | 1 = Skip zero values in source view"
pZeroOut,"[Optional] 0 = Nothing | 1 = Zero out target view"
pCoefficient,"[Optional] Multiply source value by coefficient. To keeps the value as is, put this parameter value to 1"
pIncrement,"[Optional] 0 = Use CellPutN | 1 = Use CellIncrementN"
pSubtractFromSource,"[Optional] 0 = Nothing | 1 = Subtract the copied value from the source"
577,20
V1
V2
V3
V4
V5
V6
V7
V8
V9
V10
V11
V12
V13
V14
V15
V16
V17
V18
V19
V20
578,20
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
579,20
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
580,20
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
581,20
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
582,21
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
IgnoredInputVarName=ValeurVarType=32ColType=1165
603,0
572,819

#****Begin: Generated Statements***
#****End: Generated Statements****

# ######  ######  ######
#   ##       ##     ##
#   ##      ##      ##
#   ##     ##       ##
# ######  ######  ######
# https://github.com/ichermak/Izi

# ====================================================================================================
# Description : Intra cube data copy for a given cube using a parametrable element mapping.
#               This process supports only cubes having at maximum 20 dimensions.
#
# Updates :
# 	- 2019/11/27 - Ifthen CHERMAK (www.linkedin.com/in/ichermak) : Creation 
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
If(DimIx('}Clients', Tm1User) = 0); cTM1User = 'Admin'; Else; cTM1User = Tm1User; EndIf;
cStartTime = Now;
cProcessName = GetProcessName;
cUserCode = ''; nMax = Long(cTM1User); nChar = 1; While(nChar <= nMax); If((Code(cTM1User, nChar) = 45) % ((Code(cTM1User, nChar) >= 65) & (Code(cTM1User, nChar) <= 90)) % ((Code(cTM1User, nChar) >= 97) & (Code(cTM1User, nChar) <= 122))); cUserCode = cUserCode | Subst(cTM1User, nChar, 1); EndIf; nChar = nChar + 1; End;
cIdExecution = cProcessName | '_' | TimSt(cStartTime, '\Y\m\d\h\i\s') | '_' | cUserCode  | '_' | Fill('0', 5 - Long(NumberToString(Int(Rand * 65536)))) | NumberToString(Int(Rand * 65536));
cDebugFile = GetProcessErrorFileDirectory | cIdExecution | '.dbg';
cTemporaryObject = 1;
If(pDebugMode > 1); cTemporaryObject = 0; EndIf;

# *** Source variables
# ****************************************
cSourceCube = pCube;
cSourceView = '}TI-Source-' | cIdExecution;
cSourceSub = cSourceView;

# *** Target variables
# ****************************************
cTargetCube = cSourceCube;
cTargetView = '}TI-Target-' | cIdExecution;
cTargetSub = cTargetView;


# === PARAMETERS VERIFICATION AND OTHER CHECKS
# ====================================================================================================
If((pDebugMode = 1) % (pDebugMode = 2));
    sNewMsg = Expand('Process started with : pCube=%pCube%, pMappingElement=%pMappingElement%, pMappingDelimiter=%pMappingDelimiter%, pDimensionDelimiter=%pDimensionDelimiter%, pElementDelimiter=%pElementDelimiter%, pSkipRuleValues=%pSkipRuleValues%, pSkipCalcs=%pSkipCalcs%, pSkipZeroes=%pSkipZeroes%, pZeroOut=%pZeroOut%, pCoefficient=%pCoefficient%, pIncrement=%pIncrement%, pSubtractFromSource=%pSubtractFromSource%.');
    ExecuteProcess('}izi.process.message.add'
                    , 'pProcess', cProcessName
                    , 'pMessage', sNewMsg
                    , 'pMessageType', 'Info'
                    );
EndIf;

sErrorMsg = '';
pCube = Trim(pCube);
pMappingDelimiter = Trim(pMappingDelimiter);
pDimensionDelimiter = Trim(pDimensionDelimiter);
pElementDelimiter = Trim(pElementDelimiter);

If(CubeExists(pCube) = 0);
    sNewMsg = Expand('Invalid parameter : pCube=%pCube%.'); 
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If(pMappingDelimiter @= '');
    sNewMsg = Expand('Invalid parameter : pMappingDelimiter=%pMappingDelimiter%.');
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If(pDimensionDelimiter @= '');
    sNewMsg = Expand('Invalid parameter : pDimensionDelimiter=%pDimensionDelimiter%.');
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If(pElementDelimiter @= '');
    sNewMsg = Expand('Invalid parameter : pElementDelimiter=%pElementDelimiter%.'); 
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

If( (pMappingDelimiter @= pDimensionDelimiter) % (pDimensionDelimiter @= pElementDelimiter) % (pMappingDelimiter @= pElementDelimiter));
    sNewMsg = Expand('Invalid parameter combination : (pMappingDelimiter=%pMappingDelimiter%, pDimensionDelimiter=%pDimensionDelimiter%, pElementDelimiter=%pElementDelimiter%).');
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
EndIf;

# Check pMappingElement
sMsg = '';
sDelimitedText = pMappingElement;
sDelimiter = pMappingDelimiter;
While(sDelimitedText @<> '');
    If(Scan(sDelimiter, sDelimitedText) = 0);
        sText = sDelimitedText;
        sDelimitedText = '';
    Else;  
        sText = Trim(Subst(sDelimitedText, 1, Scan(sDelimiter, sDelimitedText) - 1));
        sDelimitedText = Trim(Subst(sDelimitedText, Scan(sDelimiter, sDelimitedText) + 1, Long(sDelimitedText)));
    EndIf;
    
    sDimenion = Trim(Subst(sText, 1,Scan(pDimensionDelimiter, sText) - Long(pDimensionDelimiter)));
    If(DimensionExists(sDimenion) = 0);
        sNewMsg = Expand('Invalid parameter : pMappingElement=%pMappingElement%. The dimension %sDimenion% does not exist.'); 
        sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
    Else;
        sSourceElement =  Trim(Subst(sText, Scan(pDimensionDelimiter, sText) + Long(pDimensionDelimiter), Scan(pElementDelimiter, sText) - Scan(pDimensionDelimiter, sText) -1));
        If(DimIx(sDimenion, sSourceElement) = 0);
            sNewMsg = Expand('Invalid parameter : pMappingElement=%pMappingElement%. The dimension %sDimenion% does not contain %sSourceElement%.'); 
            sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
        EndIf;
        
        sTargetElement =  Trim(Subst(sText, Scan(pElementDelimiter, sText) + Long(pElementDelimiter), Long(sText)));
        If(DimIx(sDimenion, sTargetElement) = 0);
            sNewMsg = Expand('Invalid parameter : pMappingElement=%pMappingElement%. The dimension %sDimenion% does not contain %sTargetElement%.'); 
            sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', cCrLf) | sNewMsg;
        EndIf;
    EndIf;
End;

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

# *** Source dimensions and mapping variables
# ****************************************
cSourceDim1 = TABDIM(pCube,1);
cSourceElement1 = '';
cTargetElement1 = '';
If(cSourceDim1 @<> '');
    # Loop through delimited text
    nStop = 0;
    sDelimitedText = pMappingElement;
    sDelimiter = pMappingDelimiter;
    While( (sDelimitedText @<> '') & (nStop = 0) );
        If(Scan(sDelimiter, sDelimitedText) = 0);
            sText = sDelimitedText;
            sDelimitedText = '';
        Else;  
            sText = Trim(Subst(sDelimitedText, 1, Scan(sDelimiter, sDelimitedText) - 1));
            sDelimitedText = Trim(Subst(sDelimitedText, Scan(sDelimiter, sDelimitedText) + 1, Long(sDelimitedText)));
        EndIf;
        
        sDimenion = Trim(Subst(sText, 1,Scan(pDimensionDelimiter, sText) - Long(pDimensionDelimiter)));
        If(sDimenion @= cSourceDim1); 
            cSourceElement1 =  Trim(Subst(sText, Scan(pDimensionDelimiter, sText) + Long(pDimensionDelimiter), Scan(pElementDelimiter, sText) - Scan(pDimensionDelimiter, sText) -1));
            cTargetElement1 =  Trim(Subst(sText, Scan(pElementDelimiter, sText) + Long(pElementDelimiter), Long(sText)));
            nStop = 1;
        endIf;
    End;
EndIf;

cSourceDim2 = TABDIM(pCube,2);
cSourceElement2 = '';
cTargetElement2 = '';
If(cSourceDim1 @<> '');
    # Loop through delimited text
    nStop = 0;
    sDelimitedText = pMappingElement;
    sDelimiter = pMappingDelimiter;
    While( (sDelimitedText @<> '') & (nStop = 0) );
        If(Scan(sDelimiter, sDelimitedText) = 0);
            sText = sDelimitedText;
            sDelimitedText = '';
        Else;  
            sText = Trim(Subst(sDelimitedText, 1, Scan(sDelimiter, sDelimitedText) - 1));
            sDelimitedText = Trim(Subst(sDelimitedText, Scan(sDelimiter, sDelimitedText) + 1, Long(sDelimitedText)));
        EndIf;
        
        sDimenion = Trim(Subst(sText, 1,Scan(pDimensionDelimiter, sText) - Long(pDimensionDelimiter)));
        If(sDimenion @= cSourceDim2); 
            cSourceElement2 =  Trim(Subst(sText, Scan(pDimensionDelimiter, sText) + Long(pDimensionDelimiter), Scan(pElementDelimiter, sText) - Scan(pDimensionDelimiter, sText) -1));
            cTargetElement2 =  Trim(Subst(sText, Scan(pElementDelimiter, sText) + Long(pElementDelimiter), Long(sText)));
            nStop = 1;
        endIf;
    End;
EndIf;

cSourceDim3 = TABDIM(pCube,3);
cSourceElement3 = '';
cTargetElement3 = '';
If(cSourceDim1 @<> '');
    # Loop through delimited text
    nStop = 0;
    sDelimitedText = pMappingElement;
    sDelimiter = pMappingDelimiter;
    While( (sDelimitedText @<> '') & (nStop = 0) );
        If(Scan(sDelimiter, sDelimitedText) = 0);
            sText = sDelimitedText;
            sDelimitedText = '';
        Else;  
            sText = Trim(Subst(sDelimitedText, 1, Scan(sDelimiter, sDelimitedText) - 1));
            sDelimitedText = Trim(Subst(sDelimitedText, Scan(sDelimiter, sDelimitedText) + 1, Long(sDelimitedText)));
        EndIf;
        
        sDimenion = Trim(Subst(sText, 1,Scan(pDimensionDelimiter, sText) - Long(pDimensionDelimiter)));
        If(sDimenion @= cSourceDim3); 
            cSourceElement3 =  Trim(Subst(sText, Scan(pDimensionDelimiter, sText) + Long(pDimensionDelimiter), Scan(pElementDelimiter, sText) - Scan(pDimensionDelimiter, sText) -1));
            cTargetElement3 =  Trim(Subst(sText, Scan(pElementDelimiter, sText) + Long(pElementDelimiter), Long(sText)));
            nStop = 1;
        endIf;
    End;
EndIf;

cSourceDim4 = TABDIM(pCube,4);
cSourceElement4 = '';
cTargetElement4 = '';
If(cSourceDim1 @<> '');
    # Loop through delimited text
    nStop = 0;
    sDelimitedText = pMappingElement;
    sDelimiter = pMappingDelimiter;
    While( (sDelimitedText @<> '') & (nStop = 0) );
        If(Scan(sDelimiter, sDelimitedText) = 0);
            sText = sDelimitedText;
            sDelimitedText = '';
        Else;  
            sText = Trim(Subst(sDelimitedText, 1, Scan(sDelimiter, sDelimitedText) - 1));
            sDelimitedText = Trim(Subst(sDelimitedText, Scan(sDelimiter, sDelimitedText) + 1, Long(sDelimitedText)));
        EndIf;
        
        sDimenion = Trim(Subst(sText, 1,Scan(pDimensionDelimiter, sText) - Long(pDimensionDelimiter)));
        If(sDimenion @= cSourceDim4); 
            cSourceElement4 =  Trim(Subst(sText, Scan(pDimensionDelimiter, sText) + Long(pDimensionDelimiter), Scan(pElementDelimiter, sText) - Scan(pDimensionDelimiter, sText) -1));
            cTargetElement4 =  Trim(Subst(sText, Scan(pElementDelimiter, sText) + Long(pElementDelimiter), Long(sText)));
            nStop = 1;
        endIf;
    End;
EndIf;

cSourceDim5 = TABDIM(pCube,5);
cSourceElement5 = '';
cTargetElement5 = '';
If(cSourceDim1 @<> '');
    # Loop through delimited text
    nStop = 0;
    sDelimitedText = pMappingElement;
    sDelimiter = pMappingDelimiter;
    While( (sDelimitedText @<> '') & (nStop = 0) );
        If(Scan(sDelimiter, sDelimitedText) = 0);
            sText = sDelimitedText;
            sDelimitedText = '';
        Else;  
            sText = Trim(Subst(sDelimitedText, 1, Scan(sDelimiter, sDelimitedText) - 1));
            sDelimitedText = Trim(Subst(sDelimitedText, Scan(sDelimiter, sDelimitedText) + 1, Long(sDelimitedText)));
        EndIf;
        
        sDimenion = Trim(Subst(sText, 1,Scan(pDimensionDelimiter, sText) - Long(pDimensionDelimiter)));
        If(sDimenion @= cSourceDim5); 
            cSourceElement5 =  Trim(Subst(sText, Scan(pDimensionDelimiter, sText) + Long(pDimensionDelimiter), Scan(pElementDelimiter, sText) - Scan(pDimensionDelimiter, sText) -1));
            cTargetElement5 =  Trim(Subst(sText, Scan(pElementDelimiter, sText) + Long(pElementDelimiter), Long(sText)));
            nStop = 1;
        endIf;
    End;
EndIf;

cSourceDim6 = TABDIM(pCube,6);
cSourceElement6 = '';
cTargetElement6 = '';
If(cSourceDim1 @<> '');
    # Loop through delimited text
    nStop = 0;
    sDelimitedText = pMappingElement;
    sDelimiter = pMappingDelimiter;
    While( (sDelimitedText @<> '') & (nStop = 0) );
        If(Scan(sDelimiter, sDelimitedText) = 0);
            sText = sDelimitedText;
            sDelimitedText = '';
        Else;  
            sText = Trim(Subst(sDelimitedText, 1, Scan(sDelimiter, sDelimitedText) - 1));
            sDelimitedText = Trim(Subst(sDelimitedText, Scan(sDelimiter, sDelimitedText) + 1, Long(sDelimitedText)));
        EndIf;
        
        sDimenion = Trim(Subst(sText, 1,Scan(pDimensionDelimiter, sText) - Long(pDimensionDelimiter)));
        If(sDimenion @= cSourceDim6); 
            cSourceElement6 =  Trim(Subst(sText, Scan(pDimensionDelimiter, sText) + Long(pDimensionDelimiter), Scan(pElementDelimiter, sText) - Scan(pDimensionDelimiter, sText) -1));
            cTargetElement6 =  Trim(Subst(sText, Scan(pElementDelimiter, sText) + Long(pElementDelimiter), Long(sText)));
            nStop = 1;
        endIf;
    End;
EndIf;

cSourceDim7 = TABDIM(pCube,7);
cSourceElement7 = '';
cTargetElement7 = '';
If(cSourceDim1 @<> '');
    # Loop through delimited text
    nStop = 0;
    sDelimitedText = pMappingElement;
    sDelimiter = pMappingDelimiter;
    While( (sDelimitedText @<> '') & (nStop = 0) );
        If(Scan(sDelimiter, sDelimitedText) = 0);
            sText = sDelimitedText;
            sDelimitedText = '';
        Else;  
            sText = Trim(Subst(sDelimitedText, 1, Scan(sDelimiter, sDelimitedText) - 1));
            sDelimitedText = Trim(Subst(sDelimitedText, Scan(sDelimiter, sDelimitedText) + 1, Long(sDelimitedText)));
        EndIf;
        
        sDimenion = Trim(Subst(sText, 1,Scan(pDimensionDelimiter, sText) - Long(pDimensionDelimiter)));
        If(sDimenion @= cSourceDim7); 
            cSourceElement7 =  Trim(Subst(sText, Scan(pDimensionDelimiter, sText) + Long(pDimensionDelimiter), Scan(pElementDelimiter, sText) - Scan(pDimensionDelimiter, sText) -1));
            cTargetElement7 =  Trim(Subst(sText, Scan(pElementDelimiter, sText) + Long(pElementDelimiter), Long(sText)));
            nStop = 1;
        endIf;
    End;
EndIf;

cSourceDim8 = TABDIM(pCube,8);
cSourceElement8 = '';
cTargetElement8 = '';
If(cSourceDim1 @<> '');
    # Loop through delimited text
    nStop = 0;
    sDelimitedText = pMappingElement;
    sDelimiter = pMappingDelimiter;
    While( (sDelimitedText @<> '') & (nStop = 0) );
        If(Scan(sDelimiter, sDelimitedText) = 0);
            sText = sDelimitedText;
            sDelimitedText = '';
        Else;  
            sText = Trim(Subst(sDelimitedText, 1, Scan(sDelimiter, sDelimitedText) - 1));
            sDelimitedText = Trim(Subst(sDelimitedText, Scan(sDelimiter, sDelimitedText) + 1, Long(sDelimitedText)));
        EndIf;
        
        sDimenion = Trim(Subst(sText, 1,Scan(pDimensionDelimiter, sText) - Long(pDimensionDelimiter)));
        If(sDimenion @= cSourceDim8); 
            cSourceElement8 =  Trim(Subst(sText, Scan(pDimensionDelimiter, sText) + Long(pDimensionDelimiter), Scan(pElementDelimiter, sText) - Scan(pDimensionDelimiter, sText) -1));
            cTargetElement8 =  Trim(Subst(sText, Scan(pElementDelimiter, sText) + Long(pElementDelimiter), Long(sText)));
            nStop = 1;
        endIf;
    End;
EndIf;

cSourceDim9 = TABDIM(pCube,9);
cSourceElement9 = '';
cTargetElement9 = '';
If(cSourceDim1 @<> '');
    # Loop through delimited text
    nStop = 0;
    sDelimitedText = pMappingElement;
    sDelimiter = pMappingDelimiter;
    While( (sDelimitedText @<> '') & (nStop = 0) );
        If(Scan(sDelimiter, sDelimitedText) = 0);
            sText = sDelimitedText;
            sDelimitedText = '';
        Else;  
            sText = Trim(Subst(sDelimitedText, 1, Scan(sDelimiter, sDelimitedText) - 1));
            sDelimitedText = Trim(Subst(sDelimitedText, Scan(sDelimiter, sDelimitedText) + 1, Long(sDelimitedText)));
        EndIf;
        
        sDimenion = Trim(Subst(sText, 1,Scan(pDimensionDelimiter, sText) - Long(pDimensionDelimiter)));
        If(sDimenion @= cSourceDim9); 
            cSourceElement9 =  Trim(Subst(sText, Scan(pDimensionDelimiter, sText) + Long(pDimensionDelimiter), Scan(pElementDelimiter, sText) - Scan(pDimensionDelimiter, sText) -1));
            cTargetElement9 =  Trim(Subst(sText, Scan(pElementDelimiter, sText) + Long(pElementDelimiter), Long(sText)));
            nStop = 1;
        endIf;
    End;
EndIf;

cSourceDim10 = TABDIM(pCube,10);
cSourceElement10 = '';
cTargetElement10 = '';
If(cSourceDim1 @<> '');
    # Loop through delimited text
    nStop = 0;
    sDelimitedText = pMappingElement;
    sDelimiter = pMappingDelimiter;
    While( (sDelimitedText @<> '') & (nStop = 0) );
        If(Scan(sDelimiter, sDelimitedText) = 0);
            sText = sDelimitedText;
            sDelimitedText = '';
        Else;  
            sText = Trim(Subst(sDelimitedText, 1, Scan(sDelimiter, sDelimitedText) - 1));
            sDelimitedText = Trim(Subst(sDelimitedText, Scan(sDelimiter, sDelimitedText) + 1, Long(sDelimitedText)));
        EndIf;
        
        sDimenion = Trim(Subst(sText, 1,Scan(pDimensionDelimiter, sText) - Long(pDimensionDelimiter)));
        If(sDimenion @= cSourceDim10); 
            cSourceElement10 =  Trim(Subst(sText, Scan(pDimensionDelimiter, sText) + Long(pDimensionDelimiter), Scan(pElementDelimiter, sText) - Scan(pDimensionDelimiter, sText) -1));
            cTargetElement10 =  Trim(Subst(sText, Scan(pElementDelimiter, sText) + Long(pElementDelimiter), Long(sText)));
            nStop = 1;
        endIf;
    End;
EndIf;

cSourceDim11 = TABDIM(pCube,11);
cSourceElement11 = '';
cTargetElement11 = '';
If(cSourceDim1 @<> '');
    # Loop through delimited text
    nStop = 0;
    sDelimitedText = pMappingElement;
    sDelimiter = pMappingDelimiter;
    While( (sDelimitedText @<> '') & (nStop = 0) );
        If(Scan(sDelimiter, sDelimitedText) = 0);
            sText = sDelimitedText;
            sDelimitedText = '';
        Else;  
            sText = Trim(Subst(sDelimitedText, 1, Scan(sDelimiter, sDelimitedText) - 1));
            sDelimitedText = Trim(Subst(sDelimitedText, Scan(sDelimiter, sDelimitedText) + 1, Long(sDelimitedText)));
        EndIf;
        
        sDimenion = Trim(Subst(sText, 1,Scan(pDimensionDelimiter, sText) - Long(pDimensionDelimiter)));
        If(sDimenion @= cSourceDim11); 
            cSourceElement11 =  Trim(Subst(sText, Scan(pDimensionDelimiter, sText) + Long(pDimensionDelimiter), Scan(pElementDelimiter, sText) - Scan(pDimensionDelimiter, sText) -1));
            cTargetElement11 =  Trim(Subst(sText, Scan(pElementDelimiter, sText) + Long(pElementDelimiter), Long(sText)));
            nStop = 1;
        endIf;
    End;
EndIf;

cSourceDim12 = TABDIM(pCube,12);
cSourceElement12 = '';
cTargetElement12 = '';
If(cSourceDim1 @<> '');
    # Loop through delimited text
    nStop = 0;
    sDelimitedText = pMappingElement;
    sDelimiter = pMappingDelimiter;
    While( (sDelimitedText @<> '') & (nStop = 0) );
        If(Scan(sDelimiter, sDelimitedText) = 0);
            sText = sDelimitedText;
            sDelimitedText = '';
        Else;  
            sText = Trim(Subst(sDelimitedText, 1, Scan(sDelimiter, sDelimitedText) - 1));
            sDelimitedText = Trim(Subst(sDelimitedText, Scan(sDelimiter, sDelimitedText) + 1, Long(sDelimitedText)));
        EndIf;
        
        sDimenion = Trim(Subst(sText, 1,Scan(pDimensionDelimiter, sText) - Long(pDimensionDelimiter)));
        If(sDimenion @= cSourceDim12); 
            cSourceElement12 =  Trim(Subst(sText, Scan(pDimensionDelimiter, sText) + Long(pDimensionDelimiter), Scan(pElementDelimiter, sText) - Scan(pDimensionDelimiter, sText) -1));
            cTargetElement12 =  Trim(Subst(sText, Scan(pElementDelimiter, sText) + Long(pElementDelimiter), Long(sText)));
            nStop = 1;
        endIf;
    End;
EndIf;

cSourceDim13 = TABDIM(pCube,13);
cSourceElement13 = '';
cTargetElement13 = '';
If(cSourceDim1 @<> '');
    # Loop through delimited text
    nStop = 0;
    sDelimitedText = pMappingElement;
    sDelimiter = pMappingDelimiter;
    While( (sDelimitedText @<> '') & (nStop = 0) );
        If(Scan(sDelimiter, sDelimitedText) = 0);
            sText = sDelimitedText;
            sDelimitedText = '';
        Else;  
            sText = Trim(Subst(sDelimitedText, 1, Scan(sDelimiter, sDelimitedText) - 1));
            sDelimitedText = Trim(Subst(sDelimitedText, Scan(sDelimiter, sDelimitedText) + 1, Long(sDelimitedText)));
        EndIf;
        
        sDimenion = Trim(Subst(sText, 1,Scan(pDimensionDelimiter, sText) - Long(pDimensionDelimiter)));
        If(sDimenion @= cSourceDim13); 
            cSourceElement13 =  Trim(Subst(sText, Scan(pDimensionDelimiter, sText) + Long(pDimensionDelimiter), Scan(pElementDelimiter, sText) - Scan(pDimensionDelimiter, sText) -1));
            cTargetElement13 =  Trim(Subst(sText, Scan(pElementDelimiter, sText) + Long(pElementDelimiter), Long(sText)));
            nStop = 1;
        endIf;
    End;
EndIf;

cSourceDim14 = TABDIM(pCube,14);
cSourceElement14 = '';
cTargetElement14 = '';
If(cSourceDim1 @<> '');
    # Loop through delimited text
    nStop = 0;
    sDelimitedText = pMappingElement;
    sDelimiter = pMappingDelimiter;
    While( (sDelimitedText @<> '') & (nStop = 0) );
        If(Scan(sDelimiter, sDelimitedText) = 0);
            sText = sDelimitedText;
            sDelimitedText = '';
        Else;  
            sText = Trim(Subst(sDelimitedText, 1, Scan(sDelimiter, sDelimitedText) - 1));
            sDelimitedText = Trim(Subst(sDelimitedText, Scan(sDelimiter, sDelimitedText) + 1, Long(sDelimitedText)));
        EndIf;
        
        sDimenion = Trim(Subst(sText, 1,Scan(pDimensionDelimiter, sText) - Long(pDimensionDelimiter)));
        If(sDimenion @= cSourceDim14); 
            cSourceElement14 =  Trim(Subst(sText, Scan(pDimensionDelimiter, sText) + Long(pDimensionDelimiter), Scan(pElementDelimiter, sText) - Scan(pDimensionDelimiter, sText) -1));
            cTargetElement14 =  Trim(Subst(sText, Scan(pElementDelimiter, sText) + Long(pElementDelimiter), Long(sText)));
            nStop = 1;
        endIf;
    End;
EndIf;

cSourceDim15 = TABDIM(pCube,15);
cSourceElement15 = '';
cTargetElement15 = '';
If(cSourceDim1 @<> '');
    # Loop through delimited text
    nStop = 0;
    sDelimitedText = pMappingElement;
    sDelimiter = pMappingDelimiter;
    While( (sDelimitedText @<> '') & (nStop = 0) );
        If(Scan(sDelimiter, sDelimitedText) = 0);
            sText = sDelimitedText;
            sDelimitedText = '';
        Else;  
            sText = Trim(Subst(sDelimitedText, 1, Scan(sDelimiter, sDelimitedText) - 1));
            sDelimitedText = Trim(Subst(sDelimitedText, Scan(sDelimiter, sDelimitedText) + 1, Long(sDelimitedText)));
        EndIf;
        
        sDimenion = Trim(Subst(sText, 1,Scan(pDimensionDelimiter, sText) - Long(pDimensionDelimiter)));
        If(sDimenion @= cSourceDim15); 
            cSourceElement15 =  Trim(Subst(sText, Scan(pDimensionDelimiter, sText) + Long(pDimensionDelimiter), Scan(pElementDelimiter, sText) - Scan(pDimensionDelimiter, sText) -1));
            cTargetElement15 =  Trim(Subst(sText, Scan(pElementDelimiter, sText) + Long(pElementDelimiter), Long(sText)));
            nStop = 1;
        endIf;
    End;
EndIf;

cSourceDim16 = TABDIM(pCube,16);
cSourceElement16 = '';
cTargetElement16 = '';
If(cSourceDim1 @<> '');
    # Loop through delimited text
    nStop = 0;
    sDelimitedText = pMappingElement;
    sDelimiter = pMappingDelimiter;
    While( (sDelimitedText @<> '') & (nStop = 0) );
        If(Scan(sDelimiter, sDelimitedText) = 0);
            sText = sDelimitedText;
            sDelimitedText = '';
        Else;  
            sText = Trim(Subst(sDelimitedText, 1, Scan(sDelimiter, sDelimitedText) - 1));
            sDelimitedText = Trim(Subst(sDelimitedText, Scan(sDelimiter, sDelimitedText) + 1, Long(sDelimitedText)));
        EndIf;
        
        sDimenion = Trim(Subst(sText, 1,Scan(pDimensionDelimiter, sText) - Long(pDimensionDelimiter)));
        If(sDimenion @= cSourceDim16); 
            cSourceElement16 =  Trim(Subst(sText, Scan(pDimensionDelimiter, sText) + Long(pDimensionDelimiter), Scan(pElementDelimiter, sText) - Scan(pDimensionDelimiter, sText) -1));
            cTargetElement16 =  Trim(Subst(sText, Scan(pElementDelimiter, sText) + Long(pElementDelimiter), Long(sText)));
            nStop = 1;
        endIf;
    End;
EndIf;

cSourceDim17 = TABDIM(pCube,17);
cSourceElement17 = '';
cTargetElement17 = '';
If(cSourceDim1 @<> '');
    # Loop through delimited text
    nStop = 0;
    sDelimitedText = pMappingElement;
    sDelimiter = pMappingDelimiter;
    While( (sDelimitedText @<> '') & (nStop = 0) );
        If(Scan(sDelimiter, sDelimitedText) = 0);
            sText = sDelimitedText;
            sDelimitedText = '';
        Else;  
            sText = Trim(Subst(sDelimitedText, 1, Scan(sDelimiter, sDelimitedText) - 1));
            sDelimitedText = Trim(Subst(sDelimitedText, Scan(sDelimiter, sDelimitedText) + 1, Long(sDelimitedText)));
        EndIf;
        
        sDimenion = Trim(Subst(sText, 1,Scan(pDimensionDelimiter, sText) - Long(pDimensionDelimiter)));
        If(sDimenion @= cSourceDim17); 
            cSourceElement17 =  Trim(Subst(sText, Scan(pDimensionDelimiter, sText) + Long(pDimensionDelimiter), Scan(pElementDelimiter, sText) - Scan(pDimensionDelimiter, sText) -1));
            cTargetElement17 =  Trim(Subst(sText, Scan(pElementDelimiter, sText) + Long(pElementDelimiter), Long(sText)));
            nStop = 1;
        endIf;
    End;
EndIf;

cSourceDim18 = TABDIM(pCube,18);
cSourceElement18 = '';
cTargetElement18 = '';
If(cSourceDim1 @<> '');
    # Loop through delimited text
    nStop = 0;
    sDelimitedText = pMappingElement;
    sDelimiter = pMappingDelimiter;
    While( (sDelimitedText @<> '') & (nStop = 0) );
        If(Scan(sDelimiter, sDelimitedText) = 0);
            sText = sDelimitedText;
            sDelimitedText = '';
        Else;  
            sText = Trim(Subst(sDelimitedText, 1, Scan(sDelimiter, sDelimitedText) - 1));
            sDelimitedText = Trim(Subst(sDelimitedText, Scan(sDelimiter, sDelimitedText) + 1, Long(sDelimitedText)));
        EndIf;
        
        sDimenion = Trim(Subst(sText, 1,Scan(pDimensionDelimiter, sText) - Long(pDimensionDelimiter)));
        If(sDimenion @= cSourceDim18); 
            cSourceElement18 =  Trim(Subst(sText, Scan(pDimensionDelimiter, sText) + Long(pDimensionDelimiter), Scan(pElementDelimiter, sText) - Scan(pDimensionDelimiter, sText) -1));
            cTargetElement18 =  Trim(Subst(sText, Scan(pElementDelimiter, sText) + Long(pElementDelimiter), Long(sText)));
            nStop = 1;
        endIf;
    End;
EndIf;

cSourceDim19 = TABDIM(pCube,19);
cSourceElement19 = '';
cTargetElement19 = '';
If(cSourceDim1 @<> '');
    # Loop through delimited text
    nStop = 0;
    sDelimitedText = pMappingElement;
    sDelimiter = pMappingDelimiter;
    While( (sDelimitedText @<> '') & (nStop = 0) );
        If(Scan(sDelimiter, sDelimitedText) = 0);
            sText = sDelimitedText;
            sDelimitedText = '';
        Else;  
            sText = Trim(Subst(sDelimitedText, 1, Scan(sDelimiter, sDelimitedText) - 1));
            sDelimitedText = Trim(Subst(sDelimitedText, Scan(sDelimiter, sDelimitedText) + 1, Long(sDelimitedText)));
        EndIf;
        
        sDimenion = Trim(Subst(sText, 1,Scan(pDimensionDelimiter, sText) - Long(pDimensionDelimiter)));
        If(sDimenion @= cSourceDim19); 
            cSourceElement19 =  Trim(Subst(sText, Scan(pDimensionDelimiter, sText) + Long(pDimensionDelimiter), Scan(pElementDelimiter, sText) - Scan(pDimensionDelimiter, sText) -1));
            cTargetElement19 =  Trim(Subst(sText, Scan(pElementDelimiter, sText) + Long(pElementDelimiter), Long(sText)));
            nStop = 1;
        endIf;
    End;
EndIf;

cSourceDim20 = TABDIM(pCube,20);
cSourceElement20 = '';
cTargetElement20 = '';
If(cSourceDim1 @<> '');
    # Loop through delimited text
    nStop = 0;
    sDelimitedText = pMappingElement;
    sDelimiter = pMappingDelimiter;
    While( (sDelimitedText @<> '') & (nStop = 0) );
        If(Scan(sDelimiter, sDelimitedText) = 0);
            sText = sDelimitedText;
            sDelimitedText = '';
        Else;  
            sText = Trim(Subst(sDelimitedText, 1, Scan(sDelimiter, sDelimitedText) - 1));
            sDelimitedText = Trim(Subst(sDelimitedText, Scan(sDelimiter, sDelimitedText) + 1, Long(sDelimitedText)));
        EndIf;
        
        sDimenion = Trim(Subst(sText, 1,Scan(pDimensionDelimiter, sText) - Long(pDimensionDelimiter)));
        If(sDimenion @= cSourceDim20); 
            cSourceElement20 =  Trim(Subst(sText, Scan(pDimensionDelimiter, sText) + Long(pDimensionDelimiter), Scan(pElementDelimiter, sText) - Scan(pDimensionDelimiter, sText) -1));
            cTargetElement20 =  Trim(Subst(sText, Scan(pElementDelimiter, sText) + Long(pElementDelimiter), Long(sText)));
            nStop = 1;
        endIf;
    End;
EndIf;

# *** Source vue creation
# ****************************************
sCube = cSourceCube;
sView = cSourceView;
If(ViewExists(sCube, sView) = 1); ViewDestroy(sCube, sView); EndIf;
ViewCreate(sCube, sView, cTemporaryObject);

# *** Source subsets initialization
# ****************************************
sCube = cSourceCube;
sSub = cSourceSub;
sElementPrefix = 'cSourceElement';
nIndex = 1;
While(TabDim(sCube, nIndex) @<> '');
    sIndex = NumberToString(nIndex);
    
    sDim = TabDim(sCube, nIndex);
    If(SubsetExists(sDim,sSub) = 1);
        SubsetDestroy(sDim, sSub);
    EndIf;
    
    sElement = Expand('%' | sElementPrefix | sIndex | '%');
    If(sElement @<> '');
        SubsetCreate(sDim, sSub, cTemporaryObject);
        SubsetElementInsert(sDim, sSub, sElement, 1);
    Else;
        sMdx = '{TM1SUBSETALL([' | sDim | '])}';
        sMdx = '{TM1FILTERBYLEVEL(' | sMdx | ', 0)}';
        SubsetCreatebyMDX(sSub, '{{[' | sDim | '].MEMBERS.ITEM(0)}, ' | sMdx | '}', cTemporaryObject);
        SubsetElementDelete(sDim, sSub, 1);
    EndIf;
    nIndex = nIndex + 1;
End;
nDimensionCount = nIndex - 1;

If( (nDimensionCount < 2) % (nDimensionCount > 20) );
    sNewMsg = Expand('Invalid parameter : pCube=%pCube%. The cube must contain at least 2 dimensions or at maximum 20 dimensions.'); 
    sErrorMsg = sErrorMsg | IF(sErrorMsg @= '', '', Char(10)) | sNewMsg;
    ProcessBreak;
EndIf;

# *** Source vue subsets assignement
# ****************************************
sCube = cSourceCube;
sView = cSourceView;
sSub = cSourceSub;
nIndex = 1;
While(TabDim(sCube, nIndex) @<> '');
    sDim = TabDim(sCube, nIndex);
    If(ViewExists(sCube, sView) = 1); ViewSubsetAssign(sCube, sView, sDim, sSub); EndIf;
    nIndex = nIndex + 1;
End;

# *** Source settings
# ****************************************
DataSourceType = 'VIEW';
DataSourceNameForServer = cSourceCube;
DataSourceCubeView = cSourceView;

ViewExtractSkipZeroesSet(cSourceCube, cSourceView, pSkipZeroes);
ViewExtractSkipCalcsSet(cSourceCube, cSourceView, pSkipCalcs);
ViewExtractSkipRuleValuesSet(cSourceCube, cSourceView, pSkipRuleValues);


# === TARGET DEFINITION
# ====================================================================================================

# *** Target dimensions
# ****************************************
cTargetDim1 	= cSourceDim1;
cTargetDim2 	= cSourceDim2;
cTargetDim3 	= cSourceDim3;
cTargetDim4 	= cSourceDim4;
cTargetDim5 	= cSourceDim5;
cTargetDim6 	= cSourceDim6;
cTargetDim7 	= cSourceDim7;
cTargetDim8 	= cSourceDim8;
cTargetDim9 	= cSourceDim9;
cTargetDim10 	= cSourceDim10;
cTargetDim11 	= cSourceDim11;
cTargetDim12 	= cSourceDim12;
cTargetDim13 	= cSourceDim13;
cTargetDim14 	= cSourceDim14;
cTargetDim15 	= cSourceDim15;
cTargetDim16 	= cSourceDim16;
cTargetDim17 	= cSourceDim17;
cTargetDim18 	= cSourceDim18;
cTargetDim19 	= cSourceDim19;
cTargetDim20 	= cSourceDim20;

# *** Target vue creation
# ****************************************
sCube = cTargetCube;
sView = cTargetView;
If(ViewExists(sCube, sView) = 1); ViewDestroy(sCube, sView); EndIf;
ViewCreate(sCube, sView, cTemporaryObject);

# *** Target subsets initialization
# ****************************************
sCube = cTargetCube;
sSub = cTargetSub;
sElementPrefix = 'cTargetElement';
nIndex = 1;
While(TabDim(sCube, nIndex) @<> '');
    sIndex = NumberToString(nIndex);
    
    sDim = TabDim(sCube, nIndex);
    If(SubsetExists(sDim,sSub) = 1);
        SubsetDestroy(sDim, sSub);
    EndIf;
    
    sElement = Expand('%' | sElementPrefix | sIndex | '%');
    If(sElement @<> '');
        SubsetCreate(sDim, sSub, cTemporaryObject);
        SubsetElementInsert(sDim, sSub, sElement, 1);
    Else;
        sMdx = '{TM1SUBSETALL([' | sDim | '])}';
        sMdx = '{TM1FILTERBYLEVEL(' | sMdx | ', 0)}';
        SubsetCreatebyMDX(sSub, '{{[' | sDim | '].MEMBERS.ITEM(0)}, ' | sMdx | '}', cTemporaryObject);
        SubsetElementDelete(sDim, sSub, 1);
    EndIf;
    nIndex = nIndex + 1;
End;

# *** Target vue subsets assignement
# ****************************************
sCube = cTargetCube;
sView = cTargetView;
sSub = cTargetSub;
nIndex = 1;
While(TabDim(sCube, nIndex) @<> '');
    sDim = TabDim(sCube, nIndex);
    If(ViewExists(sCube, sView) = 1); ViewSubsetAssign(sCube, sView, sDim, sSub); EndIf;
    nIndex = nIndex + 1;
End;

# *** Target settings
# ****************************************
cTargetCube_LoggingValue = CellGetS('}CubeProperties', cTargetCube, 'LOGGING');
CellPutS('', '}CubeProperties', cTargetCube, 'LOGGING');

If(pZeroOut = 1);
  ViewZeroOut(cTargetCube, cTargetView);
  ViewZeroOut(cTargetCube, cTargetView);
EndIf;
573,3

#****Begin: Generated Statements***
#****End: Generated Statements****
574,438

#****Begin: Generated Statements***
#****End: Generated Statements****

# === MAPPING
# ====================================================================================================
T1 = V1;
T2 = V2;
T3 = V3;
T4 = V4;
T5 = V5;
T6 = V6;
T7 = V7;
T8 = V8;
T9 = V9;
T10 = V10;
T11 = V11;
T12 = V12;
T13 = V13;
T14 = V14;
T15 = V15;
T16 = V16;
T17 = V17;
T18 = V18;
T19 = V19;
T20 = V20;

If(cTargetElement1 @<> '');
    T1 = cTargetElement1;
EndIf;

If(cTargetElement2 @<> '');
    T2 = cTargetElement2;
EndIf;

If(cTargetElement3 @<> '');
    T3 = cTargetElement3;
EndIf;

If(cTargetElement4 @<> '');
    T4 = cTargetElement4;
EndIf;

If(cTargetElement5 @<> '');
    T5 = cTargetElement5;
EndIf;

If(cTargetElement6 @<> '');
    T6 = cTargetElement6;
EndIf;

If(cTargetElement7 @<> '');
    T7 = cTargetElement7;
EndIf;

If(cTargetElement8 @<> '');
    T8 = cTargetElement8;
EndIf;

If(cTargetElement9 @<> '');
    T9 = cTargetElement9;
EndIf;

If(cTargetElement10 @<> '');
    T10 = cTargetElement10;
EndIf;

If(cTargetElement11 @<> '');
    T11 = cTargetElement11;
EndIf;

If(cTargetElement12 @<> '');
    T12 = cTargetElement12;
EndIf;

If(cTargetElement13 @<> '');
    T13 = cTargetElement13;
EndIf;

If(cTargetElement14 @<> '');
    T14 = cTargetElement14;
EndIf;

If(cTargetElement15 @<> '');
    T15 = cTargetElement15;
EndIf;

If(cTargetElement16 @<> '');
    T16 = cTargetElement16;
EndIf;

If(cTargetElement17 @<> '');
    T17 = cTargetElement17;
EndIf;

If(cTargetElement18 @<> '');
    T18 = cTargetElement18;
EndIf;

If(cTargetElement19 @<> '');
    T19 = cTargetElement19;
EndIf;

If(cTargetElement20 @<> '');
    T20 = cTargetElement20;
EndIf;


# === DATA
# ====================================================================================================
sValueToPut = SVALUE;
nValueToPut = NVALUE * pCoefficient;
nValueToSubtract = (-1) * nValueToPut;

If(nDimensionCount = 2);
    If(CellIsUpdateable(cTargetCube, T1, T2) = 1);
        If(VALUE_IS_STRING = 1);
            CellPutS(sValueToPut, cTargetCube, T1, T2);
        ElseIf(VALUE_IS_STRING = 0);
            If(pIncrement = 0);
                CellPutN(nValueToPut, cTargetCube, T1, T2);
            Else;
                CellIncrementN(nValueToPut, cTargetCube, T1, T2);
            EndIf;
            
            If(pSubtractFromSource = 1);
                CellIncrementN(nValueToSubtract, cTargetCube, V1, V2);
            EndIf;
        EndIf;
    EndIf;
        
ElseIf(nDimensionCount = 3);
    If(CellIsUpdateable(cTargetCube, T1, T2, T3) = 1);
        If(VALUE_IS_STRING = 1);
            CellPutS(sValueToPut, cTargetCube, T1, T2, T3);
        ElseIf(VALUE_IS_STRING = 0);
            If(pIncrement = 0);
                CellPutN(nValueToPut, cTargetCube, T1, T2, T3);
            Else;
                CellIncrementN(nValueToPut, cTargetCube, T1, T2, T3); 
            EndIf;
            
            If(pSubtractFromSource = 1);
                CellIncrementN(nValueToSubtract, cTargetCube, V1, V2, V3);
            EndIf;
        EndIf;
    EndIf;
    
ElseIf(nDimensionCount = 4);
    If(CellIsUpdateable(cTargetCube, T1, T2, T3, T4) = 1);
        If(VALUE_IS_STRING = 1);
            CellPutS(sValueToPut, cTargetCube, T1, T2, T3, T4);
        ElseIf(VALUE_IS_STRING = 0);
            If(pIncrement = 0);
                CellPutN(nValueToPut, cTargetCube, T1, T2, T3, T4);
            Else;
                CellIncrementN(nValueToPut, cTargetCube, T1, T2, T3, T4);                
            EndIf;
            
            If(pSubtractFromSource = 1);
                CellIncrementN(nValueToSubtract, cTargetCube, V1, V2, V3, V4);
            EndIf;
        EndIf;
    EndIf;
    
ElseIf(nDimensionCount = 5);
    If(CellIsUpdateable(cTargetCube, T1, T2, T3, T4, T5) = 1);
        If(VALUE_IS_STRING = 1);
            CellPutS(sValueToPut, cTargetCube, T1, T2, T3, T4, T5);
        ElseIf(VALUE_IS_STRING = 0);
            If(pIncrement = 0);
                CellPutN(nValueToPut, cTargetCube, T1, T2, T3, T4, T5);
            Else;
                CellIncrementN(nValueToPut, cTargetCube, T1, T2, T3, T4, T5);                
            EndIf;
            
            If(pSubtractFromSource = 1);
                CellIncrementN(nValueToSubtract, cTargetCube, V1, V2, V3, V4, V5);
            EndIf;
        EndIf;
    EndIf;
    
ElseIf(nDimensionCount = 6);
    If(CellIsUpdateable(cTargetCube, T1, T2, T3, T4, T5, T6) = 1);
        If(VALUE_IS_STRING = 1);
            CellPutS(sValueToPut, cTargetCube, T1, T2, T3, T4, T5, T6);
        ElseIf(VALUE_IS_STRING = 0);
            If(pIncrement = 0);
                CellPutN(nValueToPut, cTargetCube, T1, T2, T3, T4, T5, T6);
            Else;
                CellIncrementN(nValueToPut, cTargetCube, T1, T2, T3, T4, T5, T6);                
            EndIf;
            
            If(pSubtractFromSource = 1);
                CellIncrementN(nValueToSubtract, cTargetCube, V1, V2, V3, V4, V5, V6);
            EndIf;
        EndIf;
    EndIf;
    
ElseIf(nDimensionCount = 7);
    If(CellIsUpdateable(cTargetCube, T1, T2, T3, T4, T5, T6, T7) = 1);
        If(VALUE_IS_STRING = 1);
            CellPutS(sValueToPut, cTargetCube, T1, T2, T3, T4, T5, T6, T7);
        ElseIf(VALUE_IS_STRING = 0);
            If(pIncrement = 0);
                CellPutN(nValueToPut, cTargetCube, T1, T2, T3, T4, T5, T6, T7);
            Else;
                CellIncrementN(nValueToPut, cTargetCube, T1, T2, T3, T4, T5, T6, T7);                
            EndIf;
            
            If(pSubtractFromSource = 1);
                CellIncrementN(nValueToSubtract, cTargetCube, V1, V2, V3, V4, V5, V6, V7);
            EndIf;
        EndIf;
    EndIf;
    
ElseIf(nDimensionCount = 8);
    If(CellIsUpdateable(cTargetCube, T1, T2, T3, T4, T5, T6, T7, T8) = 1);
        If(VALUE_IS_STRING = 1);
            CellPutS(sValueToPut, cTargetCube, T1, T2, T3, T4, T5, T6, T7, T8);
        ElseIf(VALUE_IS_STRING = 0);
            If(pIncrement = 0);
                CellPutN(nValueToPut, cTargetCube, T1, T2, T3, T4, T5, T6, T7, T8);
            Else;
                CellIncrementN(nValueToPut, cTargetCube, T1, T2, T3, T4, T5, T6, T7, T8);                
            EndIf;
            
            If(pSubtractFromSource = 1);
                CellIncrementN(nValueToSubtract, cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8);
            EndIf;
        EndIf;
    EndIf;
    
ElseIf(nDimensionCount = 9);
    If(CellIsUpdateable(cTargetCube, T1, T2, T3, T4, T5, T6, T7, T8, T9) = 1);
        If(VALUE_IS_STRING = 1);
            CellPutS(sValueToPut, cTargetCube, T1, T2, T3, T4, T5, T6, T7, T8, T9);
        ElseIf(VALUE_IS_STRING = 0);
            If(pIncrement = 0);
                CellPutN(nValueToPut, cTargetCube, T1, T2, T3, T4, T5, T6, T7, T8, T9);
            Else;
                CellIncrementN(nValueToPut, cTargetCube, T1, T2, T3, T4, T5, T6, T7, T8, T9);                
            EndIf;
            
            If(pSubtractFromSource = 1);
                CellIncrementN(nValueToSubtract, cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, v9);
            EndIf;
        EndIf;
    EndIf;
    
ElseIf(nDimensionCount = 10);
    If(CellIsUpdateable(cTargetCube, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10) = 1);
        If(VALUE_IS_STRING = 1);
            CellPutS(sValueToPut, cTargetCube, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10);
        ElseIf(VALUE_IS_STRING = 0);
            If(pIncrement = 0);
                CellPutN(nValueToPut, cTargetCube, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10);
            Else;
                CellIncrementN(nValueToPut, cTargetCube, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10);                
            EndIf;
            
            If(pSubtractFromSource = 1);
                CellIncrementN(nValueToSubtract, cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, v9, V10);
            EndIf;
        EndIf;
    EndIf;
    
ElseIf(nDimensionCount = 11);
    If(CellIsUpdateable(cTargetCube, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11) = 1);
        If(VALUE_IS_STRING = 1);
            CellPutS(sValueToPut, cTargetCube, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11);
        ElseIf(VALUE_IS_STRING = 0);
            If(pIncrement = 0);
                CellPutN(nValueToPut, cTargetCube, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11);
            Else;
                CellIncrementN(nValueToPut, cTargetCube, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11);                
            EndIf;
            
            If(pSubtractFromSource = 1);
                CellIncrementN(nValueToSubtract, cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, v9, V10, V11);
            EndIf;
        EndIf;
    EndIf;
    
ElseIf(nDimensionCount = 12);
    If(CellIsUpdateable(cTargetCube, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12) = 1);
        If(VALUE_IS_STRING = 1);
            CellPutS(sValueToPut, cTargetCube, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12);
        ElseIf(VALUE_IS_STRING = 0);
            If(pIncrement = 0);
                CellPutN(nValueToPut, cTargetCube, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12);
            Else;
                CellIncrementN(nValueToPut, cTargetCube, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12);                
            EndIf;
            
            If(pSubtractFromSource = 1);
                CellIncrementN(nValueToSubtract, cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, v9, V10, V11, V12);
            EndIf;
        EndIf;
    EndIf;
    
ElseIf(nDimensionCount = 13);
    If(CellIsUpdateable(cTargetCube, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13) = 1);
        If(VALUE_IS_STRING = 1);
            CellPutS(sValueToPut, cTargetCube, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13);
        ElseIf(VALUE_IS_STRING = 0);
            If(pIncrement = 0);
                CellPutN(nValueToPut, cTargetCube, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13);
            Else;
                CellIncrementN(nValueToPut, cTargetCube, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13);                
            EndIf;
            
            If(pSubtractFromSource = 1);
                CellIncrementN(nValueToSubtract, cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, v9, V10, V11, V12, V13);
            EndIf;
        EndIf;
    EndIf;
    
ElseIf(nDimensionCount = 14);
    If(CellIsUpdateable(cTargetCube, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14) = 1);
        If(VALUE_IS_STRING = 1);
            CellPutS(sValueToPut, cTargetCube, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14);
        ElseIf(VALUE_IS_STRING = 0);
            If(pIncrement = 0);
                CellPutN(nValueToPut, cTargetCube, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14);
            Else;
                CellIncrementN(nValueToPut, cTargetCube, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14);                
            EndIf;
            
            If(pSubtractFromSource = 1);
                CellIncrementN(nValueToSubtract, cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, v9, V10, V11, V12, V13, V14);
            EndIf;
        EndIf;
    EndIf;
    
ElseIf(nDimensionCount = 15);
    If(CellIsUpdateable(cTargetCube, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15) = 1);
        If(VALUE_IS_STRING = 1);
            CellPutS(sValueToPut, cTargetCube, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15);
        ElseIf(VALUE_IS_STRING = 0);
            If(pIncrement = 0);
                CellPutN(nValueToPut, cTargetCube, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15);
            Else;
                CellIncrementN(nValueToPut, cTargetCube, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15);                
            EndIf;
            
            If(pSubtractFromSource = 1);
                CellIncrementN(nValueToSubtract, cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, v9, V10, V11, V12, V13, V14, V15);
            EndIf;
        EndIf;
    EndIf;
    
ElseIf(nDimensionCount = 16);
    If(CellIsUpdateable(cTargetCube, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, T16) = 1);
        If(VALUE_IS_STRING = 1);
            CellPutS(sValueToPut, cTargetCube, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, T16);
        ElseIf(VALUE_IS_STRING = 0);
            If(pIncrement = 0);
                CellPutN(nValueToPut, cTargetCube, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, T16);
            Else;
                CellIncrementN(nValueToPut, cTargetCube, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, T16);                
            EndIf;
            
            If(pSubtractFromSource = 1);
                CellIncrementN(nValueToSubtract, cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, v9, V10, V11, V12, V13, V14, V15, V16);
            EndIf;
        EndIf;
    EndIf;
    
ElseIf(nDimensionCount = 17);
    If(CellIsUpdateable(cTargetCube, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, T16, T17) = 1);
        If(VALUE_IS_STRING = 1);
            CellPutS(sValueToPut, cTargetCube, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, T16, T17);
        ElseIf(VALUE_IS_STRING = 0);
            If(pIncrement = 0);
                CellPutN(nValueToPut, cTargetCube, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, T16, T17);
            Else;
                CellIncrementN(nValueToPut, cTargetCube, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, T16, T17);                
            EndIf;
            
            If(pSubtractFromSource = 1);
                CellIncrementN(nValueToSubtract, cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, v9, V10, V11, V12, V13, V14, V15, V16, V17);
            EndIf;
        EndIf;
    EndIf;
    
ElseIf(nDimensionCount = 18);
    If(CellIsUpdateable(cTargetCube, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, T16, T17, T18) = 1);
        If(VALUE_IS_STRING = 1);
            CellPutS(sValueToPut, cTargetCube, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, T16, T17, T18);
        ElseIf(VALUE_IS_STRING = 0);
            If(pIncrement = 0);
                CellPutN(nValueToPut, cTargetCube, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, T16, T17, T18);
            Else;
                CellIncrementN(nValueToPut, cTargetCube, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, T16, T17, T18);                
            EndIf;
            
            If(pSubtractFromSource = 1);
                CellIncrementN(nValueToSubtract, cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, v9, V10, V11, V12, V13, V14, V15, V16, V17, V18);
            EndIf;
        EndIf;
    EndIf;
    
ElseIf(nDimensionCount = 19);
    If(CellIsUpdateable(cTargetCube, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, T16, T17, T18, T19) = 1);
        If(VALUE_IS_STRING = 1);
            CellPutS(sValueToPut, cTargetCube, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, T16, T17, T18, T19);
        ElseIf(VALUE_IS_STRING = 0);
            If(pIncrement = 0);
                CellPutN(nValueToPut, cTargetCube, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, T16, T17, T18, T19);
            Else;
                CellIncrementN(nValueToPut, cTargetCube, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, T16, T17, T18, T19);                
            EndIf;
            
            If(pSubtractFromSource = 1);
                CellIncrementN(nValueToSubtract, cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, v9, V10, V11, V12, V13, V14, V15, V16, V17, V18, V19);
            EndIf;
        EndIf;
    EndIf;
    
ElseIf(nDimensionCount = 20);
    If(CellIsUpdateable(cTargetCube, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, T16, T17, T18, T19, T20) = 1);
        If(VALUE_IS_STRING = 1);
            CellPutS(sValueToPut, cTargetCube, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, T16, T17, T18, T19, T20);
        ElseIf(VALUE_IS_STRING = 0);
            If(pIncrement = 0);
                CellPutN(nValueToPut, cTargetCube, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, T16, T17, T18, T19, T20);
            Else;
                CellIncrementN(nValueToPut, cTargetCube, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, T16, T17, T18, T19, T20);                
            EndIf;
            
            If(pSubtractFromSource = 1);
                CellIncrementN(nValueToSubtract, cTargetCube, V1, V2, V3, V4, V5, V6, V7, V8, v9, V10, V11, V12, V13, V14, V15, V16, V17, V18, V19, V20);
            EndIf;
        EndIf;
    EndIf;
    
EndIf;
575,64

#****Begin: Generated Statements***
#****End: Generated Statements****

If(sErrorMsg @= '');

    # === TEMPORARY OBJECTS DESTRUCTION
    # ====================================================================================================
    If(pDebugMode <> 2);
        
        # *** Source
        # ****************************************
        If(ViewExists(sSub, cSourceView) = 1); ViewDestroy(sSub, cSourceView); EndIf;
        nIndex = 1;
        While(TabDim(sSub, nIndex) @<> '');
            sSourceDim = TabDim(sSub, nIndex);
            If(SubsetExists(sSourceDim,cSourceSub) = 1); SubsetDestroy(sSourceDim, cSourceSub); EndIf;
            nIndex = nIndex + 1;
        End;
    
        # *** Target
        # ****************************************
        If(ViewExists(cTargetCube, cTargetView) = 1); ViewDestroy(cTargetCube, cTargetView); EndIf;
        nIndex = 1;
        While(TabDim(cTargetCube, nIndex) @<> '');
            sTargetDim = TabDim(cTargetCube, nIndex);
            If(SubsetExists(sTargetDim,cTargetSub) = 1); SubsetDestroy(sTargetDim, cTargetSub); EndIf;
            nIndex = nIndex + 1;
        End;
        
    EndIf;
    
    
    # === CUBE LOGGING REACTIVATION
    # ====================================================================================================
    CellPutS(cTargetCube_LoggingValue, '}CubeProperties', cTargetCube, 'LOGGING');
    
EndIf;


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
