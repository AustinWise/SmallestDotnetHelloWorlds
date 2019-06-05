
//  Microsoft (R) .NET Framework IL Disassembler.  Version 4.6.1055.0
//  Copyright (c) Microsoft Corporation.  All rights reserved.



// Metadata version: v4.0.30319
.assembly extern mscorlib
{
  .publickeytoken = (B7 7A 5C 56 19 34 E0 89 )                         // .z\V.4..
  .ver 4:0:0:0
}
.assembly Hello
{
  .hash algorithm 0x00008004
  .ver 0:0:0:0
}
.module Hello.exe
.imagebase 0x0000000140000000
.file alignment 0x00000200
.stackreserve 0x0000000000400000
.subsystem 0x0003       // WINDOWS_CUI
.corflags 0x00000001    //  ILONLY
// Image base: 0x00310000


// =============== CLASS MEMBERS DECLARATION ===================

.class private auto ansi abstract sealed beforefieldinit Program
       extends [mscorlib]System.Object
{
  .method private hidebysig static void Main() cil managed
  {
    .entrypoint
    // Code size       11 (0xb)
    .maxstack  8
    IL_0000:  ldstr      "Hello World!"
    IL_0005:  call       void [mscorlib]System.Console::WriteLine(string)
    IL_000a:  ret
  }

}
