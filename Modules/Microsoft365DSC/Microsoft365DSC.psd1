#
# Module manifest for module 'Microsoft365DSC'
#
# Generated by: Microsoft Corporation
#
# Generated on: 2020-04-14

@{

    # Script module or binary module file associated with this manifest.
    # RootModule = ''

    # Version number of this module.
    ModuleVersion     = '1.0.5.39'

    # Supported PSEditions
    # CompatiblePSEditions = @()

    # ID used to uniquely identify this module
    GUID              = '39f599a6-d212-4480-83b3-a8ea2124d8cf'

    # Author of this module
    Author            = 'Microsoft Corporation'

    # Company or vendor of this module
    CompanyName       = 'Microsoft Corporation'

    # Copyright statement for this module
    Copyright         = '(c) 2020 Microsoft Corporation. All rights reserved.'

    # Description of the functionality provided by this module
    Description       = 'This DSC module is used to configure and monitor Microsoft tenants, including SharePoint Online, Exchange, Teams, etc.'

    # Minimum version of the PowerShell engine required by this module
    PowerShellVersion = '5.1'

    # Name of the PowerShell host required by this module
    # PowerShellHostName = ''

    # Minimum version of the PowerShell host required by this module
    # PowerShellHostVersion = ''

    # Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
    # DotNetFrameworkVersion = ''

    # Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
    # CLRVersion = ''

    # Processor architecture (None, X86, Amd64) required by this module
    # ProcessorArchitecture = ''

    # Modules that must be imported into the global environment prior to importing this module
    RequiredModules   = @(
        @{
            ModuleName      = "ReverseDSC"
            RequiredVersion = "2.0.0.2"
        },
        @{
            ModuleName      = "SharePointPnPPowerShellOnline"
            RequiredVersion = "3.20.2004.0"
        },
        @{
            ModuleName      = "Microsoft.Online.SharePoint.PowerShell"
            RequiredVersion = "16.0.19515.12000"
        },
        @{
            ModuleName      = "MicrosoftTeams"
            RequiredVersion = "1.0.6"
        },
        @{
            ModuleName      = "AzureADPreview"
            RequiredVersion = "2.0.2.89"
        },
        @{
            ModuleName      = "MSCloudLoginAssistant"
            RequiredVersion = "1.0.10"
        },
        @{
            ModuleName      = "Microsoft.PowerApps.Administration.PowerShell"
            RequiredVersion = "2.0.57"
        }
    )

    # Assemblies that must be loaded prior to importing this module
    # RequiredAssemblies = @()

    # Script files (.ps1) that are run in the caller's environment prior to importing this module.
    # ScriptsToProcess = @()

    # Type files (.ps1xml) to be loaded when importing this module
    # TypesToProcess = @()

    # Format files (.ps1xml) to be loaded when importing this module
    # FormatsToProcess = @()

    # Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
    NestedModules     = @(
        'modules\M365DSCUtil.psm1',
        'modules\M365DSCReverseGUI.psm1',
        'modules\M365DSCReverse.psm1',
        'modules\M365DSCLogEngine.psm1',
        'modules\M365DSCTelemetryEngine.psm1',
        'modules\M365DSCStubsUtility.psm1'
    )

    # Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
    #FunctionsToExport = @()

    # Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
    CmdletsToExport   = @('Export-M365DSCConfiguration',
                          'Assert-M365DSCTemplate')

    # Variables to export from this module
    # VariablesToExport = @()

    # Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
    AliasesToExport   = @()

    # List of all modules packaged with this module
    # ModuleList = @()

    # List of all files packaged with this module
    # FileList = @()

    # Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
    PrivateData       = @{

        PSData = @{

            # Tags applied to this module. These help with module discovery in online galleries.
            Tags         = 'DesiredStateConfiguration', 'DSC', 'DSCResourceKit', 'DSCResource', 'Microsoft365'

            # A URL to the license for this module.
            LicenseUri   = 'https://github.com/Microsoft/Microsoft365DSC/blob/master/LICENSE'

            # A URL to the main website for this project.
            ProjectUri   = 'https://github.com/Microsoft/Microsoft365DSC'

            # A URL to an icon representing this module.
            IconUri      = 'https://github.com/microsoft/Microsoft365DSC/blob/Dev/Modules/Microsoft365DSC/Dependencies/Images/Logo.png?raw=true'

            # ReleaseNotes of this module
            ReleaseNotes = '* Re-branding to Microsoft365DSC
            * All components re-branded;
          * AADMSGroupLifecyclePolicy
            * Initial Release;
          * AADGroupsNamingPolicy
            * Initial Release;
          * AADGroupsSettings
            * Initial Release;
          * AADMSGroupLifecyclePolicy
            * Initial Release;
          * SCAuditConfigurationPolicy
            * Fix issue with the Remove scenario;
          * SCDLPCompliancePolicy
            * Fix issue with the Remove scenario;
          * SCFilePropertyAuthority
            * Fix issue with the Remove scenario;
          * SCFilePlanPropertyCategory
            * Fix issue with the Remove scenario;
          * SCFilePlanPropertyCitation
            * Fix issue with the Remove scenario;
          * SCFilePlanPropertyDepartment
            * Fix issue with the Remove scenario;
          * SCFilePlanPropertyReferenceId
            * Fix issue with the Remove scenario;
          * SCFilePlanPropertySubCategory
            * Fix issue with the Remove scenario;
          * SCRetentionCompliancePolicy
            * Fix issue with Teams Policy in the Get;
          * SPOPropertyBag
            * Fixed an issue where false positive drifts were being detected;
          * SPOSiteAuditSettings
            * Generalized the URL not to capture hardcoded dmomains;
          * SPOSiteGroup
            * Fixed an issue where now, groups with Null owners are not extracted;
            * Generalized the URL not to capture hardcoded dmomains;
          * TeamsCallingPolicy
            * Removed the AllowCalling parameter since it is no longer supported;
            * Fixed an issue with Policies without tags in their name (e.g. Global);
          * TeamsMessagingPolicy
            * Fixed and issue where the Global policy was always flagged as having
              a drift;
          * TeamsUpgradePolicy
            * Initial Release;
          * M365DSCUtil
            * Added the new Assert-M365DSCTemplate cmdlet to assess remote templates;
          * ReverseDSC
            * Change to allow ComponentsToExtract without the chck prefix;
            * Introduction of Extraction Modes and Visual Indicators;
            * Major refactoring, having UI dynamic and items displayed by
              Resources names;
          * Metadata
            * Updated Microsoft.PowerApps.Administration.PowerShell to 2.0.56;
            * Updated MicrosoftTeams dependency to 1.0.5;
            * Updated MSCloudLoginAssistant dependency to 1.0.6;
            * Updated SharePointPnPPowerShellOnline dependency to 3.20.2004.0;'

            # Flag to indicate whether the module requires explicit user acceptance for install/update
            # RequireLicenseAcceptance = $false

            # External dependent modules of this module
            # ExternalModuleDependencies = @()

        } # End of PSData hashtable

    } # End of PrivateData hashtable

    # HelpInfo URI of this module
    # HelpInfoURI = ''

    # Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
    # DefaultCommandPrefix = ''
}
