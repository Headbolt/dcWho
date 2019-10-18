#!/bin/bash
#
###############################################################################################################################################
#
# ABOUT THIS PROGRAM
#
#   This Script is designed for use in JAMF
#
#   - This script will ...
#			Check the preffered AD Domain Controller and reset it if required
#
###############################################################################################################################################
#
# HISTORY
#
#	Version: 1.1 - 15/04/2018
#
#	- 15/04/2018 - V1.0 - Created by Headbolt
#
#   - 18/10/2019 - V1.1 - Updated by Headbolt
#							More comprehensive error checking and notation
#
###############################################################################################################################################
#
# DEFINE VARIABLES & READ IN PARAMETERS
#
###############################################################################################################################################
#
# Grab the Name of the Local DC to be used from JAMF Variable #4 eg. DCNAME
TargetLocalDC=$4
#
CurrentLocalDC=$(dsconfigad -show | grep "Preferred Domain controller" | cut -c 36-)
#
# Set the name of the script for later logging
ScriptName="append prefix here as needed - Site Specific AD Settings - Preferred DC"
#
###############################################################################################################################################
#
# SCRIPT CONTENTS - DO NOT MODIFY BELOW THIS LINE
#
###############################################################################################################################################
#
# Defining Functions
#
###############################################################################################################################################
#
# Section End Function
#
SectionEnd(){
#
# Outputting a Blank Line for Reporting Purposes
/bin/echo
#
# Outputting a Dotted Line for Reporting Purposes
/bin/echo  -----------------------------------------------
#
# Outputting a Blank Line for Reporting Purposes
/bin/echo
#
}
#
###############################################################################################################################################
#
# Script End Function
#
ScriptEnd(){
#
# Outputting a Blank Line for Reporting Purposes
#/bin/echo
#
/bin/echo Ending Script '"'$ScriptName'"'
#
# Outputting a Blank Line for Reporting Purposes
/bin/echo
#
# Outputting a Dotted Line for Reporting Purposes
/bin/echo  -----------------------------------------------
#
# Outputting a Blank Line for Reporting Purposes
/bin/echo
#
}
#
###############################################################################################################################################
#
# End Of Function Definition
#
###############################################################################################################################################
#
# Beginning Processing
#
###############################################################################################################################################
#
# Outputting a Blank Line for Reporting Purposes
/bin/echo
#
SectionEnd
#
# Outputs the Current Preferred Domain Controller
Echo Current Local Domain Controller To Be Set = $CurrentLocalDC
#
# Outputs the Target Preferred Domain Controller
Echo Target Local Domain Controller To Be Set = $TargetLocalDC
#
SectionEnd
#
# Now Compare Current Preffered DC to Traget Preffered DC
if test "$CurrentLocalDC" == "$TargetLocalDC"
	then
		## If LocalDC's Match, Nothing to do
		/bin/echo "Preferred Local DC is Already Correct"
		#
		SectionEnd
		ScriptEnd
		exit 0
	else
		/bin/echo Preferred Local DC Being Changed to "$TargetLocalDC"
		# Outputs a blank line for reporting purposes
		/bin/echo
		dsconfigad -preferred $TargetLocalDC
		#
		SectionEnd
		ScriptEnd
		exit 0
fi
#
SectionEnd
ScriptEnd
