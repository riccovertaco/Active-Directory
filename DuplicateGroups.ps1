###########################DuplicateGroups.ps1#########################
# AUTHOR  : Eric PELLOUX 
# DATE    : 11-28-2017
# WEB     : www.groupe-folder.fr
# VERSION : 1.0
#
# COMMENT :  This script is a property of Groupe folder, verify is authenticity with the get-filehash cmdlet
# 
#####################################################################
#############################VERY IMPORTANT:##########################
# Verifiy the presence of the duplicategroupshash.txt and check the hash
#This script has the following functionalities:#######################

#1 Remove members from each GD
#2 Add-members in each GD from its GF associated
#######################################################################

Import-module Activedirectory
$csv=import-csv C:\scripts\DuplicateGroups\groups.csv

foreach ($a in $csv)
{
Get-ADGroupMember -Identity $a.GD |ForEach-Object {Remove-ADGroupMember $a.gd $_ -Confirm:$false}
Add-ADGroupMember -Identity $a.gd -Members (Get-ADGroupMember $a.GF)
}

