
# Smallest Dotnet Hello Worlds

This repo contains several implementations of "Hello World" for different .NET platforms. The
purpose this exercise is to see how th binary size differs.

All experiments are done on Windows x64. For .NET 6, the reletive sizes are in
about the same ballpark for Linux and macOS.

For the non .NET Framework versions, the output is generated by running `dotnet publish -c release`.

## Sizes

|Folder|Target Framework|Size (KB)|
|--|--|--|
|[1  Visual Studio File -> New Project](1.VisualStudioProjectNew)|.NET 4.7.2|4.5|
|[2. Visual Studio Trimmed (fewer attributes)](2.VisualStudioTrimmed)|.NET 4.7.2|2.5|
|[3. IlAsm](3.IlAsm)|.NET 4.7.2|1.0|
|[4. `dotnet new console`](4.DotNetCoreNew)|.NET 6 Preview 4 (framework dependent)|155|
|[4.1. `dotnet new console` with no app host](4.1.NoAppHost)|.NET 6 Preview 4 (framework dependent)|14.5|
|[5. `dotnet new console` publish self contained](5.SelfContained)|.NET 6 Preview 4|66,034|
|[6. `dotnet new console` publish single file](6.SingleFile)|.NET 6 Preview 4|59,423|
|[7. `dotnet new console` publish single file trimmed](7.SingleFileTrimmed)|.NET 6 Preview 4|11,069|
|[7.1. `dotnet new console` publish single file trimmed and compressed](7.1.SingleFileTrimmedCompressed)|.NET 6 Preview 4|9,849|
|[8. `dotnet new console` publish single file trimmed AOT compiled (Ready to Run)](8.SingleFileTrimmedR2R)|.NET 6 Preview 4|13,837|
|[9. Native AOT](9.NativeAOT)|6.0.0-preview.6.21280.1|4,330|
|[10. Native AOT no reflection or internationalization](10.NativeAOTSmaller)|6.0.0-preview.6.21280.1|1,183|

If you want a Native AOT Hello World smaller still, see [zerosharp by Michal Strehovský](https://github.com/MichalStrehovsky/zerosharp).

## Notes

* [Native AOT](https://github.com/dotnet/runtimelab/blob/feature/NativeAOT/samples/HelloWorld/README.md)