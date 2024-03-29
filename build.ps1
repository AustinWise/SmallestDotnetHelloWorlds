[cmdletbinding()]
param(
   [switch]$NoBuild
)

if (!$NoBuild)
{
    .\dotnet-install.ps1 -NoPath -InstallDir bin -JSonFile .\global.json
}

$dirs = dir | where {$_.Name -match '^\d'} | select Name, @{  label='Num'; expression = { [double] $_.Name.Substring(0,  $_.Name.LastIndexOf(".")) } } | sort {$_.Num}

$net_version = Get-Content .\global.json | ConvertFrom-Json
$net_version = $net_version.sdk.version

if (!$NoBuild)
{
    foreach ($dir in $dirs)
    {
        echo $dir.Name
        $build_file = $dir.Name + "\build.cmd"
        if (Test-Path $build_file)
        {
            & cmd.exe /c $build_file
        }
        else
        {
            & ./bin/dotnet.exe publish -c release $dir.Name
        }
    }
}

foreach ($dir in $dirs) {
    $skip_file = $dir.Name + "\skip.txt"
    if (Test-Path $skip_file)
    {
        continue
    }

    $desc = Get-Content ($dir.Name + "\desc.txt")
    $framework_file = $dir.Name + "\framework.txt"
    if (Test-Path $framework_file)
    {
        $framework = Get-Content $framework_file
    }
    else
    {
        $csproj_files = dir ($dir.Name + "\*.csproj")
        if (Select-Xml -Path $csproj_files -XPath '/Project/PropertyGroup/PublishAot')
        {
            $framework = ".NET SDK ${net_version} NativeAOT"
        }
        else
        {
            $framework = ".NET SDK ${net_version}"
        }
    }
    $ouput_size = dir -Recurse -Exclude '*.pdb', '*.config' ($dir.Name + '\pub') | Measure-Object -Sum Length
    $ouput_size = $ouput_size.Sum / 1024
    if ($ouput_size -lt 100)
    {
        $fmt_str = '| [{4}. {0}]({1}) | {2} | {3:N1} |'
    }
    else
    {
        $fmt_str = '| [{4}. {0}]({1}) | {2} | {3:N0} |'
    }
    $str = $fmt_str -f $desc, $dir.Name, $framework, $ouput_size, $dir.Num
    echo $str
}
