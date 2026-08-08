$ErrorActionPreference = 'Stop';

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
Remove-Item -Recurse -Force $toolsDir -ErrorAction SilentlyContinue
