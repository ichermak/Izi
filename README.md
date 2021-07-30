# Izi

A library of objects for IBM Planning Analytics (TM1) applications. This library gives a standard approach to common implementations.  
This project does not aim to compete with Bedrock library but to be complementary with it.  

The particularities of this project are:

* The usage of Powershell instead of Windows command, to ease the portability to Linux environement, as the core version of Powershell is now supported by Linux.
* The usage of a cube for process return messages instead of logging them to the server log. The purpose is to be able to send messages back within PA user interfaces.

# Global considerations

All tests were performed with:

* TM1 11.7
* Powershell 5.1
* Windows 10
  
# Content description

## Dimensions

### }izi.Year

#### Description

This dimension contains year elements from 2020 to 2060.

#### Sample

![Image](Image/}izi.Year.dim.png?raw=true)

### }izi.Date

#### Description

This dimension contains date elements in the format 'MM-DD'.

#### Sample

![Image](Image/}izi.Date.dim.png?raw=true)

### }izi.Time

#### Description

This dimension contains time elements in the format 'hh:mm:ss'.

#### Sample

![Image](Image/}izi.Time.dim.png?raw=true)

### }izi.Millisecond

#### Description

This dimension contains millisecond elements in the format '000'.

#### Sample

![Image](Image/}izi.Millisecond.dim.png?raw=true)

### }izi.ProcessMessage

#### Description

This dimension contains measure elements for process messages management:

* Timestamp: Contains the timestamp of the message returned by the process.
* User: Contains the name of the user who executed the process.
* User Display Value: Contains the display name of a user. Based on the value of the user's }TM1_DefaultDisplayValue attribute.
* Message Type: Contains the type of message returned by the process.
* Message: Contains The message returned by the process.

#### Sample

![Image](Image/}izi.ProcessMessage.dim.png?raw=true)

## Cubes

### }izi.ProcessMessage.cub

#### Description

This cube is feed by the process '}izi.process.message.add'. It contains process return messages.  
It can be used in the user interface to indicate for example, errors that have occurred during the execution of a process.

#### Dimensions

* }izi.Year
* }izi.Date
* }izi.Time
* }izi.Millisecond
* }Processes
* }izi.ProcessMessage

#### Sample

![Image](Image/}izi.ProcessMessage.cub.png?raw=true)

## Processes

### }izi.common.email.send.pro

#### Description

Sends an email using 'Send-MailMessage' powershell cmdlets.

#### Parameters

|Name|Type|Description|Default value
|--------|--------|--------|----------------
|pDebugMode|Numeric|[Optional] 0 = Nothing \| 1 = Write to }izi.ProcessMessage cube \| 2 = 1 + Keep temporary objects|0
|pScriptDirectory|String|[Optional] Directory where the script called by this process will be exported (Example : 'C:\Applications\Tm1\Izi\Script'). If blank, the data directory will be used|
|pSmtpServer|String|[Mandatory] Smtp server address (Example : 'smtp.gmail.com')|
|pPort|Numeric|[Mandatory] Port number of the smtp server (Example : 587)|0
|pUseSsl|Numeric|[Optional] 0 = Do not use SSL \| 1 = Use SSL|0
|pUser|String|[Optional] User name|
|pPassword|String|[Optional] User password|
|pFrom|String|[Mandatory] Sender email address (Example : 'sender@gmail.com')|
|pTo|String|[Mandatory] Recipient email addresses separated by comma (Example : 'recipient1@gmail.com , ecipient2@gmail.com')|
|pCc|String|[Optional] Carbon copy email addresses separated by comma (Example : 'cc1@gmail.com , cc2@gmail.com')|
|pSubject|String|[Optional] Email subject|
|pPriority|Numeric|[Optional] 0 = Low \| 1 = Normal \| 2 = High|1
|pBody|String|[Optional] Email body|
|pBodyAsHtml|Numeric|[Optional] 0 = Body as Text \| 1 = Body as HTML|0
|pEncoding|Numeric|[Optional] 0 = ascii \| 1 = bigendianunicode \| 2 = bigendianutf32 \| 3 = oem \| 4 = unicode \| 5 = utf7 \| 6 = utf8 \| 7 = utf8BOM \| 8 = utf8NoBOM \| 9 = utf32|6
|pAttachments|String|[Optional] Path of a file to be attached to the email|
|pWaitForExecution|Numeric|[Optional] 0 = Asynchronous execution \| 1 = Synchronous execution|1

#### Dependencies

* }izi.process.message.add

#### Example

`ExecuteProcess('}izi.common.email.send', 'pDebugMode', 0, 'pScriptDirectory', '', 'pSmtpServer', 'smtp.gmail.com', 'pPort', 587, 'pUseSsl', 1, 'pUser', 'Test', 'pPassword', 'Test1234$', 'pFrom', 'test.from@gmail.com', 'pTo', 'test.to.1@gmail.com, test.to.2@gmail.com', 'pCc', 'test.cc@gmail.com', 'pSubject', 'Subject', 'pPriority', 1, 'pBody', 'Body', 'pBodyAsHtml', 0, 'pEncoding', 6, 'pAttachments', '', 'pWaitForExecution', 1);`

### }izi.common.url.encode.pro

#### Description

Encodes an Url.

#### Parameters

|Name|Type|Description|Default value
|--------|--------|--------|--------
|pDebugMode|Numeric|[Optional] 0 = Nothing \| 1 = Write to }izi.ProcessMessage cube \| 2 = 1 + Keep temporary objects|0
|pUrl|String|[Mandatory] Url|

#### Dependencies

* }izi.process.message.add

#### Example

`StringGlobalVariable('sProcessReturn'); sProcessReturn = ''; ExecuteProcess('}izi.common.url.encode', 'pDebugMode', 0, 'pUrl', 'http://localhost:9510/tm1web/UrlApi.jsp#Action=Open&AdminHost=localhost&TM1Server=Test&AccessType=Public&Type=Websheet&Workbook=Test report 1'); sUrl = sProcessReturn;`

### }izi.cube.data.copy.pro

#### Description

Intra cube data copy for a given cube using a parametrable element mapping.  
This process supports only cubes having at maximum 20 dimensions.

#### Parameters

|Name|Type|Description|Default value
|--------|--------|--------|--------
|pDebugMode|Numeric|[Optional] 0 = Nothing \| 1 = Write to }izi.ProcessMessage cube \| 2 = 1 + Keep temporary objects|0
|pSetUseActiveSandbox|Numeric|[Optional] 0 = Reads and writes to the base data \| 1 = Reads and writes to the user's active sandbox|0
|pCube|String|[Mandatory] Cube name|
|pMappingElement|String|[Mandatory] Map source elements to target elements using format 'DimName1 : SourceElement -> TargetElement & DimName2 : SourceElement -> TargetElement'|
|pMappingDelimiter|String|[Optional] Delimiter between mapping specifications in pMappingElement|&
|pDimensionDelimiter|String|[Optional] Delimiter between dimensions names and source elements in pMappingElement|:
|pElementDelimiter|String|[Optional] Delimiter between source elements and target elements in pMappingElement|->
|pSkipRuleValues|Numeric|[Optional] 0 = Nothing \| 1 = Skip rule values in source view|0
|pSkipCalcs|Numeric|[Optional] 0 = Nothing \| 1 = Skip consolidated values in source view|0
|pSkipZeroes|Numeric|[Optional] 0 = Nothing \| 1 = Skip zero values in source view|1
|pZeroOut|Numeric|[Optional] 0 = Nothing \| 1 = Zero out target view|1
|pCoefficient|Numeric|[Optional] Multiply source value by coefficient. To keeps the value as is, put this parameter value to 1|1
|pIncrement|Numeric|[Optional] 0 = Use CellPutN \| 1 = Use CellIncrementN|0
|pSubtractFromSource|Numeric|[Optional] 0 = Nothing \| 1 = Subtract the copied value from the source|0

#### Dependencies

* }izi.process.message.add

#### Example

`...`

### }izi.cube.data.populaterandomly.pro

#### Description

Populates a cube with random data.  
This process supports only cubes having at maximum 20 dimensions.

#### Parameters

|Name|Type|Description|Default value
|--------|--------|--------|--------
|pDebugMode|Numeric|[Optional] 0 = Nothing \| 1 = Write to }izi.ProcessMessage cube \| 2 = 1 + Keep temporary objects|0
|pSetUseActiveSandbox|Numeric|[Optional] 0 = Reads and writes to the base data \| 1 = Reads and writes to the user's active sandbox|0
|pCube|String|[Mandatory] Cube name|
|pFilter|String|[Optional] Filter on cube in format 'Year: 2006 + 2007 & Scenario: Actual + Budget'. Blank for whole cube|
|pFilterDelimiter|String|[Optional] Filter delimiter|&
|pDimensionDelimiter|String|[Optional] Dimension delimiter|:
|pElementDelimiter|String|[Optional] Element delimiter|+
|pMaxRecord|Numeric|[Optional] Maximum number of cells to populate. 0 = The whole cube|0

#### Dependencies

* }izi.process.message.add

#### Example

`...`

### }izi.cube.data.putnumericvalue.pro

#### Description

Sends or increments a numeric value to a cube cell.  
This process supports only cubes having at maximum 30 dimensions.

#### Parameters

|Name|Type|Description|Default value
|--------|--------|--------|--------
|pDebugMode|Numeric|[Optional] 0 = Nothing \| 1 = Write to }izi.ProcessMessage cube \| 2 = 1 + Keep temporary objects|0
|pSetUseActiveSandbox|Numeric|[Optional] 0 = Reads and writes to the base data \| 1 = Reads and writes to the user's active sandbox|0
|pIncrement|Numeric|[Optional] 0 = Use CellPutN \| 1 = Use CellIncrementN|0
|pValue|Numeric|[Mandatory] Value to put|0
|pCube|String|[Mandatory] Cube name|
|pElement1|String|[Mandatory] Dimension element name|
|pElement2|String|[Mandatory] Dimension element name|
|pElement3|String|[Optional] Dimension element name|
|pElement4|String|[Optional] Dimension element name|
|pElement5|String|[Optional] Dimension element name|
|pElement6|String|[Optional] Dimension element name|
|pElement7|String|[Optional] Dimension element name|
|pElement8|String|[Optional] Dimension element name|
|pElement9|String|[Optional] Dimension element name|
|pElement10|String|[Optional] Dimension element name|
|pElement11|String|[Optional] Dimension element name|
|pElement12|String|[Optional] Dimension element name|
|pElement13|String|[Optional] Dimension element name|
|pElement14|String|[Optional] Dimension element name|
|pElement15|String|[Optional] Dimension element name|
|pElement16|String|[Optional] Dimension element name|
|pElement17|String|[Optional] Dimension element name|
|pElement18|String|[Optional] Dimension element name|
|pElement19|String|[Optional] Dimension element name|
|pElement20|String|[Optional] Dimension element name|
|pElement21|String|[Optional] Dimension element name|
|pElement22|String|[Optional] Dimension element name|
|pElement23|String|[Optional] Dimension element name|
|pElement24|String|[Optional] Dimension element name|
|pElement25|String|[Optional] Dimension element name|
|pElement26|String|[Optional] Dimension element name|
|pElement27|String|[Optional] Dimension element name|
|pElement28|String|[Optional] Dimension element name|
|pElement29|String|[Optional] Dimension element name|
|pElement30|String|[Optional] Dimension element name|

#### Dependencies

* }izi.process.message.add

#### Example

`...`

### }izi.cube.data.putstringvalue.pro

#### Description

Sends a string value to a cube cell.  
This process supports only cubes having at maximum 30 dimensions.

#### Parameters

|Name|Type|Description|Default value
|--------|--------|--------|--------
|pDebugMode|Numeric|[Optional] 0 = Nothing \| 1 = Write to }izi.ProcessMessage cube \| 2 = 1 + Keep temporary objects|0
|pSetUseActiveSandbox|Numeric|[Optional] 0 = Reads and writes to the base data \| 1 = Reads and writes to the user's active sandbox|0
|pValue|String|[Mandatory] Value to put|
|pCube|String|[Mandatory] Cube name|
|pElement1|String|[Mandatory] Dimension element name|
|pElement2|String|[Mandatory] Dimension element name|
|pElement3|String|[Optional] Dimension element name|
|pElement4|String|[Optional] Dimension element name|
|pElement5|String|[Optional] Dimension element name|
|pElement6|String|[Optional] Dimension element name|
|pElement7|String|[Optional] Dimension element name|
|pElement8|String|[Optional] Dimension element name|
|pElement9|String|[Optional] Dimension element name|
|pElement10|String|[Optional] Dimension element name|
|pElement11|String|[Optional] Dimension element name|
|pElement12|String|[Optional] Dimension element name|
|pElement13|String|[Optional] Dimension element name|
|pElement14|String|[Optional] Dimension element name|
|pElement15|String|[Optional] Dimension element name|
|pElement16|String|[Optional] Dimension element name|
|pElement17|String|[Optional] Dimension element name|
|pElement18|String|[Optional] Dimension element name|
|pElement19|String|[Optional] Dimension element name|
|pElement20|String|[Optional] Dimension element name|
|pElement21|String|[Optional] Dimension element name|
|pElement22|String|[Optional] Dimension element name|
|pElement23|String|[Optional] Dimension element name|
|pElement24|String|[Optional] Dimension element name|
|pElement25|String|[Optional] Dimension element name|
|pElement26|String|[Optional] Dimension element name|
|pElement27|String|[Optional] Dimension element name|
|pElement28|String|[Optional] Dimension element name|
|pElement29|String|[Optional] Dimension element name|
|pElement30|String|[Optional] Dimension element name|

#### Dependencies

* }izi.process.message.add

#### Example

`...`

### }izi.cube.data.split.pro

#### Description

Copy data from a source intersections to target ones, applying weights.  
The sources, targets and there weights are defined within a given csv file.  
This process supports only cubes having at maximum 20 dimensions.

#### Parameters

|Name|Type|Description|Default value
|--------|--------|--------|--------
|pDebugMode|Numeric|[Optional] 0 = Nothing \| 1 = Write to }izi.ProcessMessage cube \| 2 = 1 + Keep temporary objects|0
|pSetUseActiveSandbox|Numeric|[Optional] 0 = Reads and writes to the base data \| 1 = Reads and writes to the user's active sandbox|0
|pCubeList|String|[Mandatory] Target cube list (Example : 'CubeName1 ; CubeName2 ; CubeName3')|
|pCubeDelimiter|String|[Optional] Cube delimiter|;
|pFilePath|String|[Mandatory] Source file path (Example : 'C:\Applications\Tm1\Izi\Interface\Inbound\Test.csv'|
|pFileDelimiter|String|[Optional] Source delimiter|;
|pQuoteCharacter|String|[Optional] Quote character|
|pDecimalSeparator|String|[Optional] Decimal separator|,
|pThousandsSeparator|String|[Optional] Thousands separator|
|pWeightHeaderName|String|[Optional] Weight header name|\<Weight>
|pMappingDelimiter|String|[Optional] Mapping delimiter. Must be not used in dimension name or element name.|&
|pDimensionDelimiter|String|[Optional] Dimension delimiter. Must be not used in dimension name or element name.|:
|pElementDelimiter|String|[Optional] Element delimiter. Must be not used in dimension name or element name.|->

#### Dependencies

* }izi.process.message.add
* }izi.cube.data.copy

#### Example

`...`

### }izi.cube.overfeedingcheckcube.create.pro

#### Description

Creates a new cube '\<CubeName> - OverfeedingCheck' cloning a given one to check the overfed cells.  
This process has been inspired by the Cubewise article below:  
https://code.cubewise.com/blog/how-to-find-out-where-you-overfeed-and-fix-it  
This process supports only cubes having at maximum 30 dimensions.

#### Parameters

|Name|Type|Description|Default value
|--------|--------|--------|--------
|pDebugMode|Numeric|[Optional] 0 = Nothing \| 1 = Write to }izi.ProcessMessage cube \| 2 = 1 + Keep temporary objects|0
|pCube|String|[Mandatory] Cube name|

#### Dependencies

* }izi.process.message.add
* }izi.system.file.getcontent

#### Example

`...`

### }izi.dimension.element.lock.pro

#### Description

Locks a dimension element with a given locker name.

#### Parameters

|Name|Type|Description|Default value
|--------|--------|--------|--------
|pDebugMode|Numeric|[Optional] 0 = Nothing \| 1 = Write to }izi.ProcessMessage cube \| 2 = 1 + Keep temporary objects|0
|pLocker|String|[Mandatory] Client name or blank to unlock the element (Example : 'Admin')|
|pDimension|String|[Mandatory] Dimension name (Example : 'Scenario')|
|pElement|String|[Mandatory] Element name (Example : 'Actual')|

#### Dependencies

* }izi.process.message.add

#### Example

`...`
