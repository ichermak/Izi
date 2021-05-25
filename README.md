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
...

## Cubes
...

## Processes

### }izi.common.email.send.pro

#### Description:
Send an email using 'Send-MailMessage' powershell cmdlets.

#### Parameters: 
|Name|Type|Description|Default value
|--------|--------|--------|----------------
|pDebugMode|Numeric|[Optional] 0 = Nothing \| 1 = Write to }izi.ProcessMessage cube \| 2 = 1 + Keep temporary objects|0
|pScriptDirectory|Numeric|[Optional] Directory where the script called by this process will be exported (Example : 'C:\Applications\Tm1\Izi\Script'). If blank, the data directory will be used|0
|pSmtpServer|Numeric|[Mandatory] Smtp server address (Example : 'smtp.gmail.com')|0
|pPort|Numeric|[Mandatory] Port number of the smtp server (Example : 587)|0
|pUseSsl|Numeric|[Optional] 0 = Do not use SSL \| 1 = Use SSL|0
|pUser|Numeric|[Optional] User name|0
|pPassword|Numeric|[Optional] User password|0
|pFrom|Numeric|[Mandatory] Sender email address (Example : 'sender@gmail.com')|0
|pTo|Numeric|[Mandatory] Recipient email addresses separated by comma (Example : 'recipient1@gmail.com , ecipient2@gmail.com')|0
|pCc|Numeric|[Optional] Carbon copy email addresses separated by comma (Example : 'cc1@gmail.com , cc2@gmail.com')|0
|pSubject|Numeric|[Optional] Email subject|0
|pPriority|Numeric|[Optional] 0 = Low \| 1 = Normal \| 2 = High|0
|pBody|Numeric|[Optional] Email body|0
|pBodyAsHtml|Numeric|[Optional] 0 = Body as Text \| 1 = Body as HTML|0
|pEncoding|Numeric|[Optional] 0 = ascii \| 1 = bigendianunicode \| 2 = bigendianutf32 \| 3 = oem \| 4 = unicode \| 5 = utf7 \| 6 = utf8 \| 7 = utf8BOM \| 8 = utf8NoBOM \| 9 = utf32|0
|pAttachments|Numeric|[Optional] Path of a file to be attached to the email|0
|pWaitForExecution|Numeric|[Optional] 0 = Asynchronous execution \| 1 = Synchronous execution|0

#### Dependencies:
* }izi.process.message.add

#### Examples: 
`...`


### }izi.common.url.encode.pro

#### Description:
...

#### Parameters: 
|Name|Type|Description|Default value
|--------|--------|--------|--------
|pParam1|Numeric|[Optional] ...|0
|pParam1|String|[Mandatory] ...|0
  
#### Dependencies:
...

#### Examples: 
`...`
  
### }izi.cube.data.copy.pro

#### Description:
...

#### Parameters: 
|Name|Type|Description|Default value
|--------|--------|--------|--------
|pParam1|Numeric|[Optional] ...|0
|pParam1|String|[Mandatory] ...|0
  
#### Dependencies:
...

#### Examples: 
`...`
  
### }izi.cube.data.populaterandomly.pro

#### Description:
...

#### Parameters: 
|Name|Type|Description|Default value
|--------|--------|--------|--------
|pParam1|Numeric|[Optional] ...|0
|pParam1|String|[Mandatory] ...|0
  
#### Dependencies:
...

#### Examples: 
`...`
  
### }izi.cube.data.split.pro

#### Description:
...

#### Parameters: 
|Name|Type|Description|Default value
|--------|--------|--------|--------
|pParam1|Numeric|[Optional] ...|0
|pParam1|String|[Mandatory] ...|0
  
#### Dependencies:
...

#### Examples: 
`...`
  
### }izi.cube.overfeedingcheckcube.create.pro

#### Description:
...

#### Parameters: 
|Name|Type|Description|Default value
|--------|--------|--------|--------
|pParam1|Numeric|[Optional] ...|0
|pParam1|String|[Mandatory] ...|0
  
#### Dependencies:
...

#### Examples: 
`...`
  
### }izi.dimension.consolidationhierarchy.createfromattribute.pro

#### Description:
...

#### Parameters: 
|Name|Type|Description|Default value
|--------|--------|--------|--------
|pParam1|Numeric|[Optional] ...|0
|pParam1|String|[Mandatory] ...|0
  
#### Dependencies:
...

#### Examples: 
`...`
  
### }izi.dimension.consolidationhierarchy.delete.pro

#### Description:
...

#### Parameters: 
|Name|Type|Description|Default value
|--------|--------|--------|--------
|pParam1|Numeric|[Optional] ...|0
|pParam1|String|[Mandatory] ...|0
  
#### Dependencies:
...

#### Examples: 
`...`
  
### }izi.dimension.element.lock.pro

#### Description:
...

#### Parameters: 
|Name|Type|Description|Default value
|--------|--------|--------|--------
|pParam1|Numeric|[Optional] ...|0
|pParam1|String|[Mandatory] ...|0
  
#### Dependencies:
...

#### Examples: 
`...`
  
### }izi.dimension.importfromfile.pro

#### Description:
...

#### Parameters: 
|Name|Type|Description|Default value
|--------|--------|--------|--------
|pParam1|Numeric|[Optional] ...|0
|pParam1|String|[Mandatory] ...|0
  
#### Dependencies:
...

#### Examples: 
`...`
  
### }izi.process.message.add.pro

#### Description:
...

#### Parameters: 
|Name|Type|Description|Default value
|--------|--------|--------|--------
|pParam1|Numeric|[Optional] ...|0
|pParam1|String|[Mandatory] ...|0
  
#### Dependencies:
...

#### Examples: 
`...`
  
