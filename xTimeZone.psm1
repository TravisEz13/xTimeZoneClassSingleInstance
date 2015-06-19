[DscResource()]
class xTimeZone
{
   [ValidateSet('Yes')]
   [DscProperty(Key)] 
   [ValidateNotNullorEmpty()]
   [String] $IsSingleInstance

   [DscProperty(Mandatory)] 
   [ValidateNotNullorEmpty()]
   [String] $TimeZone
 
   #Set function similar to Set-TargetResource
   [void] Set()
   {
      #Output the result of Get-TargetResource function.
      $CurrentTimeZone = $This.GetTimeZone()

      If($PSCmdlet.ShouldProcess("'$($This.TimeZone)'","Replace the System Time Zone"))
      {
        Try{
            if($CurrentTimeZone -ne $This.TimeZone){
                Write-Verbose "Setting the TimeZone"
                
                $This.SetTimeZone($This.TimeZone)
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
      Write-Verbose -verbose -Message "Getting TimeZone..."
      $CurrentTimeZone = $This.GetTimeZone()
      Write-Verbose -verbose -Message "TimeZone: $CurrentTimeZone"

      If($This.TimeZone -eq $CurrentTimeZone){
          return $true
      }
      Else{
          return $false
      }
      return $false
   }
 
   #Get function similar to Get-TargetResource
   [xTimeZone] Get()
   {
      #Get the current TimeZone
      $CurrentTimeZone = $This.GetTimeZone()

          $this.TimeZone = $CurrentTimeZone

      #Output the target resource
      return $this
   }

   
   [string] GetTimeZone()
   {
      return & tzutil.exe /g
   }

   [void] SetTimeZone([String] $TimeZone)
   {
      try{
          & tzutil.exe /s $TimeZone    
      }catch{
          $ErrorMsg = $_.Exception.Message
          Write-Verbose $ErrorMsg
      }

   }
}
