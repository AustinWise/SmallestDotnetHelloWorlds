
# Smallest Dotnet Hello Worlds

This repo contains several implementations of "Hello World" for different .NET platforms. The
purpose this exercise is to see how th binary size differs. I wrote up my findings in [a blog post](https://www.awise.us/2021/06/05/smallest-dotnet.html).

All experiments are done on Windows x64. For .NET 6, the reletive sizes are in
about the same ballpark for Linux and macOS.

For the non .NET Framework versions, the output is generated by running `dotnet publish -c release`.

## Sizes

|Folder|Target Framework|Size (KB)|
|--|--|--|
| [1. Visual Studio File -> New Project](1.VisualStudioProjectNew) | .NET Framework 4.7.2 | 4.5 |
| [2. Visual Studio Trimmed (fewer attributes)](2.VisualStudioTrimmed) | .NET Framework 4.7.2 | 2.5 |
| [3. IlAsm](3.IlAsm) | .NET Framework 4.7.2 | 1.0 |
| [4. `dotnet new console` (framework dependent)](4.DotNetCoreNew) | .NET 6.0.100-preview.5.21302.13 | 146.1 |
| [4.1. `dotnet new console` with no app host (framework dependent)](4.1.NoAppHost) | .NET 6.0.100-preview.5.21302.13 | 5.1 |
| [5. `dotnet new console` publish self contained](5.SelfContained) | .NET 6.0.100-preview.5.21302.13 | 66,816 |
| [6. `dotnet new console` publish single file](6.SingleFile) | .NET 6.0.100-preview.5.21302.13 | 60,176 |
| [7. `dotnet new console` publish single file trimmed](7.SingleFileTrimmed) | .NET 6.0.100-preview.5.21302.13 | 10,995 |
| [7.1. `dotnet new console` publish single file trimmed and compressed](7.1.SingleFileTrimmedCompressed) | .NET 6.0.100-preview.5.21302.13 | 9,844 |
| [8. `dotnet new console` publish single file trimmed AOT compiled (Ready to Run)](8.SingleFileTrimmedR2R) | .NET 6.0.100-preview.5.21302.13 | 13,849 |
| [9. Native AOT](9.NativeAOT) | CoreCLR Native AOT 6.0.0-preview.7.21327.1 | 4,357 |
| [10. Native AOT no reflection or internationalization](10.NativeAOTSmaller) | CoreCLR Native AOT 6.0.0-preview.7.21327.1 | 1,037 |

If you want a Native AOT Hello World smaller still, see [zerosharp by Michal Strehovský](https://github.com/MichalStrehovsky/zerosharp).

## Windows Forms Sizes

While not strictly Hello World, here are the sizes of some GUI programs that
display a single empty form.

As of .NET 6, trimming a Windows Forms project is
[not officially supported](https://docs.microsoft.com/en-us/dotnet/core/deploying/trim-self-contained#components-that-cause-trimming-problems).
[Andrii Kurdiumov](https://github.com/kant2002) has done a lot of work to
[add COM supported in NativeAOT](https://github.com/dotnet/runtimelab/issues/306),
which enables enables AOT Windows Forms!

|Folder|Target Framework|Size (KB)|
|--|--|--|
| [11. Windows Forms](11.WindowsFormsNetFramework) | .NET Framework 4.7.2 | 6.5 |
| [12. `dotnet new winforms` Self Contained](12.WindowsFormsSelfContained) | .NET 6.0.100-preview.5.21302.13 | 153,614 |
| [13. `dotnet new winforms` Self-Contained, Trimmed, ReadyToRun](13.WinFormsSelfContainedTrimmedR2R) | .NET 6.0.100-preview.5.21302.13 | 127,617 |
| [14. `dotnet new winforms` AOT](14.WindowsFormsAot) | CoreCLR Native AOT 6.0.0-preview.7.21327.1 | 52,840 |

Note that all these `dotnet new winforms` examples include some files related
to WPF as well. If your interested in how you can exclude extra files during
publishing, see my [IlLinkerExample repo](https://github.com/AustinWise/IlLinkerExample).

## Comparison to other languages and frameworks

|System|Version|Size (KB)|
|--|--|--|
|Go, following [getting started](https://golang.org/doc/tutorial/getting-started) instructions|1.16.5|2,044|
|Rust, doing `cargo init && cargo build --release`|1.52.1|141|
|[Electron](electron)|13.1.1|186,857|
|Java .JAR file||0.75|
|[Graal Native Image](graal-native-image)|21.1.0|8978|

## Notes

* [Native AOT](https://github.com/dotnet/runtimelab/blob/feature/NativeAOT/samples/HelloWorld/README.md)