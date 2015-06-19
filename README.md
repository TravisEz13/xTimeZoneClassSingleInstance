[![Build status](https://ci.appveyor.com/api/projects/status/7m4cwgkr5x4igpck/branch/master?svg=true)](https://ci.appveyor.com/project/PowerShell/xtimezone/branch/master)

# xTimeZone

The **xTimeZone** module the **xTimeZone** DSC resource for setting the timezone on a machine. 

## Contributing
Please check out common DSC Resources [contributing guidelines](https://github.com/PowerShell/DscResource.Kit/blob/master/CONTRIBUTING.md).


## Resources

### xTimeZone

* **TimeZone**: Specifies the Time Zone. To discover all valid time zones for this property, use this PowerShell command: `[System.TimeZoneInfo]::GetSystemTimeZones().Id`
* **IsSingleInstance**: Specifies if the resource is a single instance, the value must be 'Yes'

## Versions

### 1.0.0.0

* Initial release with the following resource:
    - xTimeZone 

### vNext

* Changed xTimeZone key to IsSingleInstance
    

## Examples 

### Setting the Time Zone

In the Examples folder, SetTimeZone.ps1 demonstrates how to set the local time zone to "Tonga Standard Time".
