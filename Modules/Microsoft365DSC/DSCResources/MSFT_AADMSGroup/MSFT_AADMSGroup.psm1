function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.String]
        $DisplayName,

        [Parameter()]
        [System.String]
        $Description,

        [Parameter()]
        [System.String[]]
        $GroupTypes,

        [Parameter()]
        [System.String]
        $MembershipRule,

        [Parameter()]
        [ValidateSet('On', 'Paused')]
        [System.String]
        $MembershipRuleProcessingState,

        [Parameter()]
        [System.Boolean]
        $SecurityEnabled,

        [Parameter()]
        [System.Boolean]
        $MailEnabled,

        [Parameter()]
        [System.String]
        $MailNickname,

        [Parameter()]
        [ValidateSet('Public', 'Private', 'HiddenMembership')]
        [System.String]
        $Visibility,

        [Parameter()]
        [ValidateSet('Present', 'Absent')]
        [System.String]
        $Ensure = 'Present',

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $GlobalAdminAccount,

        [Parameter()]
        [System.String]
        $ApplicationId,

        [Parameter()]
        [System.String]
        $TenantId,

        [Parameter()]
        [System.String]
        $CertificateThumbprint
    )

    Write-Verbose -Message "Getting configuration of AzureAD Group"
    #region Telemetry
    $data = [System.Collections.Generic.Dictionary[[String], [String]]]::new()
    $data.Add("Resource", $MyInvocation.MyCommand.ModuleName)
    $data.Add("Method", $MyInvocation.MyCommand)
    Add-M365DSCTelemetryEvent -Data $data
    #endregion

    $ConnectionMode = New-M365DSCConnection -Platform 'AzureAD' -InboundParameters $PSBoundParameters

    $Group = Get-AzureADMSGroup -Filter "DisplayName eq '$DisplayName'"

    if ($null -eq $Group)
    {
        $currentValues = $PSBoundParameters
        $currentValues.Ensure = "Absent"
        return $currentValues
    }
    else
    {
        Write-Verbose -Message "Found existing AzureAD Group"

        $result = @{
            DisplayName                   = $Group.DisplayName
            Description                   = $Group.Description
            GroupTypes                    = [System.String[]]$Group.GroupTypes
            MembershipRule                = $Group.MembershipRule
            MembershipRuleProcessingState = $Group.MembershipRuleProcessingState
            SecurityEnabled               = $Group.SecurityEnabled
            MailEnabled                   = $Group.MailEnabled
            MailNickname                  = $Group.MailNickname
            Visibility                    = $Group.Visibility
            Ensure                        = "Present"
            GlobalAdminAccount            = $GlobalAdminAccount
            ApplicationId                 = $ApplicationId
            TenantId                      = $TenantId
            CertificateThumbprint         = $CertificateThumbprint
        }
        Write-Verbose -Message "Get-TargetResource Result: `n $(Convert-M365DscHashtableToString -Hashtable $result)"
        return $result
    }
}

function Set-TargetResource
{
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.String]
        $DisplayName,

        [Parameter()]
        [System.String]
        $Description,

        [Parameter()]
        [System.String[]]
        $GroupTypes,

        [Parameter()]
        [System.String]
        $MembershipRule,

        [Parameter()]
        [ValidateSet('On', 'Paused')]
        [System.String]
        $MembershipRuleProcessingState,

        [Parameter()]
        [System.Boolean]
        $SecurityEnabled,

        [Parameter()]
        [System.Boolean]
        $MailEnabled,

        [Parameter()]
        [System.String]
        $MailNickname,

        [Parameter()]
        [ValidateSet('Public', 'Private', 'HiddenMembership')]
        [System.String]
        $Visibility,

        [Parameter()]
        [ValidateSet('Present', 'Absent')]
        [System.String]
        $Ensure = 'Present',

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $GlobalAdminAccount,

        [Parameter()]
        [System.String]
        $ApplicationId,

        [Parameter()]
        [System.String]
        $TenantId,

        [Parameter()]
        [System.String]
        $CertificateThumbprint
    )

    Write-Verbose -Message "Setting configuration of Azure AD Groups"
    #region Telemetry
    $data = [System.Collections.Generic.Dictionary[[String], [String]]]::new()
    $data.Add("Resource", $MyInvocation.MyCommand.ModuleName)
    $data.Add("Method", $MyInvocation.MyCommand)
    Add-M365DSCTelemetryEvent -Data $data
    #endregion

    $currentGroup = Get-TargetResource @PSBoundParameters
    $currentParameters = $PSBoundParameters
    $currentParameters.Remove("ApplicationId")
    $currentParameters.Remove("TenantId")
    $currentParameters.Remove("CertificateThumbprint")
    $currentParameters.Remove("GlobalAdminAccount")
    $currentParameters.Remove("Ensure")

    if ($Ensure -eq 'Present' -and $GroupTypes.Contains("Unified") -and $MailEnabled -eq $false)
    {
        Write-Verbose -Message "Cannot set mailenabled to false if GroupTypes is set to Unified when creating group."
        throw "Cannot set mailenabled to false if GroupTypes is set to Unified when creating a group."
    }

    if ($Ensure -eq 'Present' -and $currentGroup.Ensure -eq 'Present')
    {
        $Group = Get-AzureADMSGroup -Filter "DisplayName eq '$DisplayName'"
        Set-AzureADMSGroup @currentParameters -id $Group.ID
    }
    elseif ($Ensure -eq 'Present' -and $currentGroup.Ensure -eq 'Absent')
    {
        New-AzureADMSGroup @currentParameters
    }
    elseif ($Ensure -eq 'Absent' -and $currentGroup.Ensure -eq 'Present')
    {
        $Group = Get-AzureADMSGroup -Filter "DisplayName eq '$DisplayName'"
        Remove-AzureADMSGroup -Id $Group.ID
    }
}

function Test-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.String]
        $DisplayName,

        [Parameter()]
        [System.String]
        $Description,

        [Parameter()]
        [System.String[]]
        $GroupTypes,

        [Parameter()]
        [System.String]
        $MembershipRule,

        [Parameter()]
        [ValidateSet('On', 'Paused')]
        [System.String]
        $MembershipRuleProcessingState,

        [Parameter()]
        [System.Boolean]
        $SecurityEnabled,

        [Parameter()]
        [System.Boolean]
        $MailEnabled,

        [Parameter()]
        [System.String]
        $MailNickname,

        [Parameter()]
        [ValidateSet('Public', 'Private', 'HiddenMembership')]
        [System.String]
        $Visibility,

        [Parameter()]
        [ValidateSet('Present', 'Absent')]
        [System.String]
        $Ensure = 'Present',

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $GlobalAdminAccount,

        [Parameter()]
        [System.String]
        $ApplicationId,

        [Parameter()]
        [System.String]
        $TenantId,

        [Parameter()]
        [System.String]
        $CertificateThumbprint
    )

    Write-Verbose -Message "Testing configuration of AzureAD Groups"

    $CurrentValues = Get-TargetResource @PSBoundParameters

    Write-Verbose -Message "Target Values: $(Convert-M365DscHashtableToString -Hashtable $PSBoundParameters)"

    $ValuesToCheck = $PSBoundParameters
    $ValuesToCheck.Remove('GlobalAdminAccount') | Out-Null

    $TestResult = Test-Microsoft365DSCParameterState -CurrentValues $CurrentValues `
        -Source $($MyInvocation.MyCommand.Source) `
        -DesiredValues $PSBoundParameters `
        -ValuesToCheck $ValuesToCheck.Keys

    Write-Verbose -Message "Test-TargetResource returned $TestResult"

    return $TestResult
}

function Export-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.String])]
    param
    (
        [Parameter()]
        [System.Management.Automation.PSCredential]
        $GlobalAdminAccount,

        [Parameter()]
        [System.String]
        $ApplicationId,

        [Parameter()]
        [System.String]
        $TenantId,

        [Parameter()]
        [System.String]
        $CertificateThumbprint
    )
    $InformationPreference = 'Continue'
    #region Telemetry
    $data = [System.Collections.Generic.Dictionary[[String], [String]]]::new()
    $data.Add("Resource", $MyInvocation.MyCommand.ModuleName)
    $data.Add("Method", $MyInvocation.MyCommand)
    Add-M365DSCTelemetryEvent -Data $data
    #endregion

    $ConnectionMode = New-M365DSCConnection -Platform 'AzureAD' -InboundParameters $PSBoundParameters

    $groups = Get-AzureADMSGroup
    $i = 1
    $content = ''
    foreach ($group in $groups)
    {
        if ($ConnectionMode -eq 'Credential')
        {
            $params = @{
                GlobalAdminAccount = $GlobalAdminAccount
                DisplayName        = $group.DisplayName
            }
        }
        else
        {
            $params = @{
                ApplicationId         = $ApplicationId
                TenantId              = $TenantId
                CertificateThumbprint = $CertificateThumbprint
                DisplayName           = $group.DisplayName
            }
        }
        $result = Get-TargetResource @params
        if ($ConnectionMode -eq 'Credential')
        {
            $result.GlobalAdminAccount = Resolve-Credentials -UserName "globaladmin"
            $result.Remove("ApplicationId")
            $result.Remove("TenantId")
            $result.Remove("CertificateThumbprint")
        }
        else
        {
            $result.Remove("GlobalAdminAccount")
        }

        if ($null -eq $result.MembershipRuleProcessingState)
        {
            $result.Remove('MembershipRuleProcessingState') | Out-Null
        }
        if ($null -eq $result.Visibility)
        {
            $result.Remove('Visibility') | Out-Null
        }
        $content += "        AADMSGroup " + (New-GUID).ToString() + "`r`n"
        $content += "        {`r`n"
        $currentDSCBlock = Get-DSCBlock -Params $result -ModulePath $PSScriptRoot
        if ($ConnectionMode -eq 'Credential')
        {
            $content += Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName "GlobalAdminAccount"
        }
        else
        {
            $content += $currentDSCBlock
        }
        $content += "        }`r`n"
        $i++
    }
    return $content
}

Export-ModuleMember -Function *-TargetResource
