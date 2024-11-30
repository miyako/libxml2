//%attributes = {}
$one:="<tag att1=\"one\" att2=\"two\">\n  content\n</tag>"
$two:="<tag att2=\"two\" att1=\"one\">\n  content\n</tag>"

var $xmllint : cs:C1710.xmllint
$xmllint:=cs:C1710.xmllint.new()

ALERT:C41($xmllint.c14n($one).data=$xmllint.c14n($two).data ? "same" : "not same")

/*
also check .error to be sure
*/