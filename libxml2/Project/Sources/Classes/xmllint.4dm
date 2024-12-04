Class extends _CLI

Class constructor($controller : 4D:C1709.Class)
	
	Super:C1705("xmllint"; $controller=Null:C1517 ? cs:C1710._xmllint_Controller : $controller)
	
	This:C1470.controller.timeout:=5
	
Function get worker() : 4D:C1709.SystemWorker
	
	return This:C1470.controller.worker
	
Function get controller() : cs:C1710._xmllint_Controller
	
	return This:C1470._controller
	
Function terminate()
	
	This:C1470.controller.terminate()
	
Function c14n($xml : Text) : cs:C1710.xmllint
	
	This:C1470.perform(["--c14n"; "-"])
	
	CONVERT FROM TEXT:C1011($xml; "utf-8"; $data)
	
	This:C1470.worker.postMessage($data)
	This:C1470.worker.closeInput()
	This:C1470.worker.wait()
	
	return This:C1470
	
Function version() : Text
	
	$command:=This:C1470.escape(This:C1470.executablePath)
	$command+=" --version"
	
	This:C1470.controller.execute($command)
	This:C1470.worker.wait()
	
	$version:=Split string:C1554(This:C1470.error; This:C1470.EOL; sk trim spaces:K86:2 | sk ignore empty strings:K86:1)
	
	$library:=$version.length#0 ? $version[0] : ""
	
	ARRAY LONGINT:C221($pos; 0)
	ARRAY LONGINT:C221($len; 0)
	If (Match regex:C1019("using\\slibxml\\sversion\\s(\\d+)"; $library; 1; $pos; $len))
		return Substring:C12($library; $pos{1}; $len{1})
	End if 
	
Function perform($options : Collection) : cs:C1710.xmllint
	
	$command:=This:C1470.escape(This:C1470.executablePath)
	
	var $option : Variant
	For each ($option; $options)
		
		Case of 
			: (Value type:C1509($option)=Is collection:K8:32)
				
				This:C1470.perform($option)
				
			: (Value type:C1509($option)=Is object:K8:27)
				Case of 
					: (OB Instance of:C1731($option; 4D:C1709.File)) || (OB Instance of:C1731($option; 4D:C1709.Folder))
						$command+=" "+This:C1470.escape(This:C1470.expand($option).path)
				End case 
				
			: (Value type:C1509($option)=Is text:K8:3)
				Case of 
					: ($option="--@") || (Match regex:C1019("-[a-z]"; $option))
						$command+=" "+$option
					Else 
						$command+=" "+This:C1470.escape($option)
				End case 
				
			Else 
				$command+=" "+This:C1470.escape(String:C10($option))
		End case 
		
	End for each 
	
	This:C1470.controller.init().execute($command)
	
	return This:C1470