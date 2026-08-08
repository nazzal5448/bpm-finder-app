$ErrorActionPreference = 'Stop';

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64    = 'https://github.com/nazzal5448/bpm-finder-app/archive/refs/tags/v1.0.0.zip'

$packageArgs = @{
  packageName   = 'bpm-finder-app'
  unzipLocation = $toolsDir
  url64Bit      = $url64
  checksum64    = 'E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855'
  checksumType64= 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
