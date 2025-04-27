#   Get-WindowsVersionInfo.ps1
# Author      - Jason Gebhart (Updated)
# Script Name - Get-WindowsVersionInfo.ps1
<#
.SYNOPSIS 
    Gets detailed Windows version information for local.

.DESCRIPTION
    This script retrieves detailed Windows version information including major/minor version, build number, revision, edition, display version and installation date. It works with Windows 7 through Windows 11 and Server versions.

.PARAMETER ComputerName
    Specifies the name of one or more computers to query. Default is the local computer.

.EXAMPLE
    .\Get-WindowsVersionInfo.ps1
    Returns version information for the local computer.

#>
[cmdletbinding()]
param (
  [Parameter(Position=0,Mandatory=$false,ValueFromPipeline = $true)]
  [string]$ComputerName = "$env:COMPUTERNAME"
) 
$DisplayVersion = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion").DisplayVersion
$ReleaseVersion = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion").ReleaseId
$OSVersion = [system.environment]::OSVersion.Version

$Result = [pscustomobject]@{
  "Computer"= $computername
  "Major" = $OSVersion.Major
  "Minor" = $OSVersion.Minor
  "Build" = $OSVersion.Build                         
  "Revision" = $OSVersion.Revision
  "ReleaseVersion" = $ReleaseVersion
  "DisplayVersion" = $DisplayVersion
}
$Result