# Izi

A library of objects for IBM Planning Analytics (TM1) applications. This library gives a standard approach to common implementations and tasks.  
This project does not aim to compete with Bedrock library but to be complementary with it.  

The particularities of this project are:

* The usage of Powershell instead of Windwos Command, to ease the portability to Linux environement as the core version of Powershell, is now supported by Linux.
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

### }izi.ProcessMessage

#### Description

This dimension contains measure elements for process messages management:

* Timestamp: Contains the timestamp of the message returned by the process.
* User: Contains the name of the user who executed the process.
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
* }Processes
* }izi.ProcessMessage

#### Sample

![Image](Image/}izi.ProcessMessage.cub.png?raw=true)

## Processes

### }izi.common.email.send.pro

#### Description

Send an email using 'Send-MailMessage' powershell cmdlets.

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

`ExecuteProcess('}izi.common.email.send',
     'pDebugMode', 0,
     'pScriptDirectory', '',
     'pSmtpServer', 'smtp.gmail.com',
     'pPort', 587,
     'pUseSsl', 1,
     'pUser', 'Test',
     'pPassword', 'Test1234$',
     'pFrom', 'test.from@gmail.com',
     'pTo', 'test.to.1@gmail.com, test.to.2@gmail.com',
     'pCc', 'test.cc@gmail.com',
     'pSubject', 'Subject',
     'pPriority', 1,
     'pBody', 'Body',
     'pBodyAsHtml', 0,
     'pEncoding', 6,
     'pAttachments', '',
     'pWaitForExecution', 1
    );`

### }izi.common.url.encode.pro

#### Description

Encode an Url.

#### Parameters

|Name|Type|Description|Default value
|--------|--------|--------|--------
|pDebugMode|Numeric|[Optional] 0 = Nothing | 1 = Write to }izi.ProcessMessage cube | 2 = 1 + Keep temporary objects|0
|pUrl|String|[Mandatory] Url|

#### Dependencies

* }izi.process.message.add

#### Example

`StringGlobalVariable('sProcessReturn');
sProcessReturn = '';
ExecuteProcess('}izi.common.url.encode',
     'pDebugMode', 0,
     'pUrl', 'http://localhost:9510/tm1web/UrlApi.jsp#Action=Open&AdminHost=localhost&TM1Server=Test&AccessType=Public&Type=Websheet&Workbook=Test report 1'
    );
sUrl = sProcessReturn;`