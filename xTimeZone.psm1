enum Ensure
{
   Absent
   Present
}


[DscResource()]
class xTimeZone
{
   [ValidateSet('True')]
   [DscProperty(Key)] 
   [ValidateNotNullorEmpty()]
   [String] $SingleInstance = 'True'

   [DscProperty(Mandatory)] 
   [ValidateNotNullorEmpty()]
   [String] $TimeZone = $null
 
   #Set function similar to Set-TargetResource
   [void] Set()
   {
      if($this.SingleInstance -ne 'Singleton')
      {
         throw 'SingleInstance must be "True"'
      }
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
      if($This.SingleInstance -ne 'Singleton')
      {
         throw 'SingleInstance must be "True"'
      }
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
      if($This.SingleInstance -ne 'Singleton')
      {
         throw 'SingleInstance must be "True"'
      }
      #Get the current TimeZone
      $CurrentTimeZone = Get-TimeZone

          $this.TimeZone = $CurrentTimeZone

      #Output the target resource
      return $this
   }
}