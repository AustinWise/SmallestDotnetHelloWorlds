
# Smallest Dotnet Hello Worlds

This repo contains several implementations of "Hello World" for different .NET platforms. The
purpose this exercise is to see how th binary size differs. I wrote up my findings
about.NET 6 in [a blog post](https://www.awise.us/2021/06/05/smallest-dotnet.html).

All experiments are done on Windows x64. For .NET 6, the relative sizes are in
about the same ballpark for Linux and macOS.

For the non .NET Framework versions, the output is generated by running `dotnet publish -c release`.

## Sizes

|Folder|Target Framework|Size (KB)|
|--|--|--|
| [1. Visual Studio File -> New Project](1.VisualStudioProjectNew) | .NET Framework 4.7.2 | 4.5 |
| [2. Visual Studio Trimmed (fewer attributes)](2.VisualStudioTrimmed) | .NET Framework 4.7.2 | 2.5 |
| [3. IlAsm](3.IlAsm) | .NET Framework 4.7.2 | 1.0 |
| [4. `dotnet new console` (framework dependent)](4.DotNetCoreNew) | .NET SDK 8.0.100-preview.1.23115.2 | 158 |
| [4.1. `dotnet new console` with no app host (framework dependent)](4.1.NoAppHost) | .NET SDK 8.0.100-preview.1.23115.2 | 5.2 |
| [5. `dotnet new console` publish self contained](5.SelfContained) | .NET SDK 8.0.100-preview.1.23115.2 | 69,468 |
| [6. `dotnet new console` publish single file](6.SingleFile) | .NET SDK 8.0.100-preview.1.23115.2 | 63,749 |
| [7. `dotnet new console` publish single file trimmed](7.SingleFileTrimmed) | .NET SDK 8.0.100-preview.1.23115.2 | 11,424 |
| [7.1. `dotnet new console` publish single file trimmed and compressed](7.1.SingleFileTrimmedCompressed) | .NET SDK 8.0.100-preview.1.23115.2 | 10,063 |
| [8. `dotnet new console` publish single file trimmed AOT compiled (Ready to Run)](8.SingleFileTrimmedR2R) | .NET SDK 8.0.100-preview.1.23115.2 | 14,637 |
| [9. Native AOT](9.NativeAOT) | .NET SDK 8.0.100-preview.1.23115.2 NativeAOT | 1,815 |
| [10. Native AOT no reflection or internationalization](10.NativeAOTSmaller) | .NET SDK 8.0.100-preview.1.23115.2 NativeAOT | 1,147 |

If you want a Native AOT Hello World smaller still, see [bflat by Michal Strehovský](https://flattened.net/).

## Windows Forms Sizes

While not strictly Hello World, here are the sizes of some GUI programs that
display a single empty form.

As of .NET 7, trimming a Windows Forms project is
[not officially supported](https://docs.microsoft.com/en-us/dotnet/core/deploying/trim-self-contained#components-that-cause-trimming-problems).
[Andrii Kurdiumov](https://github.com/kant2002) has contributed fixes to make
to more features of Windows Forms compatable with NativeAOT ( [example](https://github.com/dotnet/winforms/pull/4971) )
and has a [nuget package](https://github.com/kant2002/WinFormsComInterop) that fixes more issues.
Work is [ongoing](https://github.com/dotnet/winforms/issues/4649) to add make
WinForms fully compatible with NativeAOT.

|Folder|Target Framework|Size (KB)|
|--|--|--|
| [11. Windows Forms](11.WindowsFormsNetFramework) | .NET Framework 4.7.2 | 6.5 |
| [12. `dotnet new winforms` Self Contained](12.WindowsFormsSelfContained) | .NET SDK 8.0.100-preview.1.23115.2 | 160,296 |
| [14. `dotnet new winforms` AOT](14.WindowsFormsAot) | .NET SDK 8.0.100-preview.1.23115.2 NativeAOT | 28,007 |

Note that all these `dotnet new winforms` examples include some
[files related to WPF](https://github.com/dotnet/winforms/issues/3723)
as well. If your interested in how you can exclude extra files during
publishing, see my [IlLinkerExample repo](https://github.com/AustinWise/IlLinkerExample).

## Comparison to other languages and frameworks

|System|Version|Size (KB)|
|--|--|--|
|Go, following [getting started](https://go.dev/doc/tutorial/getting-started) instructions|1.20.0|1,885|
|Rust, doing `cargo init && cargo build --release`|1.67.1|156|
|[Electron](electron)|13.1.1|186,857|
|Java .JAR file||0.75|
|[Graal Native Image](graal-native-image)|21.1.0|8978|

## Notes

* [Native AOT](https://github.com/dotnet/runtimelab/blob/feature/NativeAOT/samples/HelloWorld/README.md)