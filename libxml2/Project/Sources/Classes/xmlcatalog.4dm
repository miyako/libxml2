Class extends _CLI

Class constructor()
	
	Super:C1705("xmlcatalog"; cs:C1710._xmlcatalog_Controller)
	
Function get worker() : 4D:C1709.SystemWorker
	
	return This:C1470._controller.worker
	
Function get controller()->$controller : cs:C1710._xmlcatalog_Controller
	
	$controller:=This:C1470._controller
	
Function _terminate()
	
	This:C1470.controller.terminate()
	
Function perform($options : Collection) : cs:C1710.xmlcatalog
	
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
					: ($option="--@")
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