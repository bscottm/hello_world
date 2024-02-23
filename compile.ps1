## CMake generator info:
class GeneratorInfo
{
    [string]  $Generator
    [bool]    $SingleConfig
    [bool]    $UCRT
    [string]  $UCRTVersion
    [string[]]$ArchArgs

    GeneratorInfo([string]$gen, $configFlag, $ucrtFlag, $ucrtVer, [string[]]$arch)
    {
        $this.Generator = $gen
        $this.SingleConfig = $configFlag
        $this.UCRT = $ucrtFlag
        $this.UCRTVersion = $ucrtVer
        $this.ArchArgs  = $arch
    }
}

## Multiple build configurations selected at compile time
$multiConfig = $false
## Single configuration selected at configuration time
$singleConfig = $true

$cmakeGenMap = @{
    "vs2022"      = [GeneratorInfo]::new("Visual Studio 17 2022", $multiConfig,  $false, "",     @("-A", "Win32"));
    "vs2022-xp"   = [GeneratorInfo]::new("Visual Studio 17 2022", $multiConfig,  $false, "",     @("-A", "Win32", "-T", "v141_xp"));
    "vs2022-x64"  = [GeneratorInfo]::new("Visual Studio 17 2022", $multiConfig,  $false, "",     @("-A", "x64", "-T", "host=x64"));
    "vs2019"      = [GeneratorInfo]::new("Visual Studio 16 2019", $multiConfig,  $false, "",     @("-A", "Win32"));
    "vs2019-xp"   = [GeneratorInfo]::new("Visual Studio 16 2019", $multiConfig,  $false, "",     @("-A", "Win32", "-T", "v141_xp"));
    "vs2019-x64"  = [GeneratorInfo]::new("Visual Studio 17 2022", $multiConfig,  $false, "",     @("-A", "x64", "-T", "host=x64"));
    "vs2017"      = [GeneratorInfo]::new("Visual Studio 15 2017", $multiConfig,  $false, "",     @("-A", "Win32"));
    "vs2017-xp"   = [GeneratorInfo]::new("Visual Studio 15 2017", $multiConfig,  $false, "",     @("-A", "Win32", "-T", "v141_xp"));
    "vs2017-x64"  = [GeneratorInfo]::new("Visual Studio 17 2022", $multiConfig,  $false, "",     @("-A", "x64", "-T", "host=x64"));
    "vs2015"      = [GeneratorInfo]::new("Visual Studio 14 2015", $multiConfig,  $false, "",     @());
    "mingw-make"  = [GeneratorInfo]::new("MinGW Makefiles",       $singleConfig, $false, "",     @());
    "mingw-ninja" = [GeneratorInfo]::new("Ninja",                 $singleConfig, $false, "",     @())
}

function Get-GeneratorInfo([string]$flavor)
{
    return $cmakeGenMap[$flavor]
}

function Quote-Args([string[]]$arglist)
{
    return ($arglist | foreach-object { if ($_ -like "* *") { "`"$_`"" } else { $_ } })
}


$flavor="vs2022"
$genInfo = $(Get-GeneratorInfo $flavor)
$generateArgs = @("-S", ".", "-B", "cmake\build-vs2022", "-G", $genInfo.Generator)
$phaseCommand = "cmake"
$arglist = $(Quote-Args $generateArgs)
& $phaseCommand @generateArgs
& $phaseCommand @arglist
