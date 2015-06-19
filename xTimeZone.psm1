[DscResource()]
class xTimeZone
{
   [ValidateSet('Yes')]
   [DscProperty(Key)] 
   [ValidateNotNullorEmpty()]
   [String] $IsSingleInstance

   [DscProperty(Mandatory)] 
   [ValidateNotNullorEmpty()]
   [String] $TimeZone = $null
 
   #Set function similar to Set-TargetResource
   [void] Set()
   {
      #Output the result of Get-TargetResource function.
      $CurrentTimeZone = Get-TimeZone

      If($PSCmdlet.ShouldProcess("'$($This.TimeZone)'","Replace the System Time Zone"))
      {
        Try{
            if($CurrentTimeZone -ne $This.TimeZone){
                Write-Verbose "Setting the TimeZone"
                Set-TimeZone -TimeZone $This.TimeZone}
            else{
                Write-Verbose "TimeZone already set to $($this.TimeZone)"
            }
        }
        Catch{
            $ErrorMsg = $_.Exception.Message
            Write-Verbose $ErrorMsg
        }
      }
   }
 
   #Test function similar to Test-TargetResource
   [bool] Test()
   {
      #Output from Get-TargetResource
      $CurrentTimeZone = Get-TimeZone

      If($This.TimeZone -eq $CurrentTimeZone){
          return $true
      }
      Else{
          return $false
      }
   }
 
   #Get function similar to Get-TargetResource
   [xTimeZone] Get()
   {
      #Get the current TimeZone
      $CurrentTimeZone = Get-TimeZone

          $this.TimeZone = $CurrentTimeZone

      #Output the target resource
      return $this
   }
}
