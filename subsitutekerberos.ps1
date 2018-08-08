###########################Scriptname.ps1#########################
# AUTHOR  : Eric PELLOUX 
# DATE    : 08-08-2018
# WEB     : www.groupe-folder.fr
# VERSION : 1.0
#
# COMMENT :  This script is a property of Groupe folder, verify is authenticity with the get-filehash cmdlet
# 
#####################################################################
#############################VERY IMPORTANT:##########################
# Verifiy the presence of the subsitutekerberos.txt and check the hash
#This script has the following functionalities:#######################

#1 Subsitute the kerberos decypher key 

#######################################################################

#Source https://docs.microsoft.com/fr-fr/azure/active-directory/connect/active-directory-aadconnect-sso-faq#how-can-i-roll-over-the-kerberos-decryption-key-of-the-azureadssoacc-computer-account
#Source Assistant de connexion Microsoft Online Services pour les professionnels des technologies de l'information RTW  https://www.microsoft.com/fr-fr/download/details.aspx?id=41950
Install-PackageProvider Nuget –Force
Save-Module PowerShellGet -Path C:\scripts
Copy-Item "C:\scripts\PowerShellGet\*" "$env:ProgramFiles\WindowsPowerShell\Modules\PowerShellGet\" -Recurse -Force
Install-Module -Name AzureADPreview 
Install-Module -Name AzureAD
cd 'C:\Program Files\Microsoft Azure Active Directory Connect'
Import-Module .\AzureADSSO.psd1
New-AzureADSSOAuthenticationContext
Get-AzureADSSOStatus
#Entrer les credentials admin office 365
$creds = Get-Credential
#Entrer les credentials admin du domaine local cible (SamAccountName)
Update-AzureADSSOForest -OnPremCredentials $creds
#Le résultat doit ressemble à cela:
#[10:43:35.180] [  9] [INFORMATIONAL] UpdateComputerAccount: Locating SSO computer account in adroot...
#[10:43:36.727] [  9] [INFORMATIONAL] UpdateComputerAccount: Found SSO computer account at CN=AZUREADSSOACC,CN=Computers,DC=ADROOT,DC=LAN. Updating its properties...
#[10:43:37.696] [  9] [INFORMATIONAL] UpdateComputerAccount: Successfully updated SSO computer account properties.
#The operation completed successfully
