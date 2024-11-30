![version](https://img.shields.io/badge/version-20%2B-E23089)
![platform](https://img.shields.io/static/v1?label=platform&message=mac-intel%20|%20mac-arm%20|%20win-64&color=blue)
[![license](https://img.shields.io/github/license/miyako/libxml2)](LICENSE)
![downloads](https://img.shields.io/github/downloads/miyako/libxml2/total)

### Licensing

* the source code of this component is licensed under the [MIT license](https://github.com/miyako/cpdf/blob/master/LICENSE).
* see [gnome.org](https://gitlab.gnome.org/GNOME/libxml2/-/wikis/home) for the licensing of **libxml2**.

# libxml2

## dependencies.json

 ```json
{
    "dependencies": {
        "libxml2": {
            "github": "miyako/libxml2",
            "version": "*"
        }
    }
}
```
# libxml2

## Usage - `xmllint`

```4d
$one:="<tag att1=\"one\" att2=\"two\">\n  content\n</tag>"
$two:="<tag att2=\"two\" att1=\"one\">\n  content\n</tag>"

var $xmllint : cs.libxml2.xmllint
$xmllint:=cs.libxml2.xmllint.new()

ALERT($xmllint.c14n($one).data=$xmllint.c14n($two).data ? "same" : "not same")

/*
	also check .error to be sure
*/
```
