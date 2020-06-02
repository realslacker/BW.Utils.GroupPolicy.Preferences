using namespace System.Collections


# .ExternalHelp BW.Utils.GroupPolicy.Preferences-help.xml
function Get-FilePreferenceXml {

    param(

        [Parameter( Mandatory, Position=1 )]
        [string]
        $Source,

        [string]
        $Destination,

        [hashtable]
        $SourceReplacements,

        [hashtable]
        $DestinationReplacements

    )

    '<?xml version="1.0"?>'
    '<Files clsid="{215B2E53-57CE-475c-80FE-9EEC14635851}">'
    
    Resolve-Path -Path $Source -ErrorAction Stop |
        Get-ChildItem -Recurse -File |
        ForEach-Object {

            $Name = $_.Name

            $SourceFile = $_.FullName

            $DestinationFile = $_.FullName.Replace( $Source, $Destination )

            $Changed = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

            $Guid = (New-Guid).ToString('B')

            if ( $SourceReplacements.Count ) {

                foreach ( $SearchString in $SourceReplacements.Keys ) {

                    $SourceFile = $SourceFile.Replace( $SearchString, $SourceReplacements[$SearchString] )

                }

            }

            if ( $DestinationReplacements.Count ) {

                foreach ( $SearchString in $DestinationReplacements.Keys ) {

                    $DestinationFile = $DestinationFile.Replace( $SearchString, $DestinationReplacements[$SearchString] )

                }

            }


            "<File clsid=`"{50BE44C8-567A-4ed1-B1D0-9234FE1F38AF}`" name=`"$Name`" status=`"$Name`" image=`"0`" changed=`"$Changed`" uid=`"$Guid`" bypassErrors=`"1`"><Properties action=`"C`" fromPath=`"$SourceFile`" targetPath=`"$DestinationFile`" readOnly=`"0`" archive=`"1`" hidden=`"0`"/></File>"

            }

    '</Files>'

}
