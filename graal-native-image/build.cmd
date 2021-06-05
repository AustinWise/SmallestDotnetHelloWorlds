rem This batch file needs to be run from the "x64 Native Tools Command Prompt"

rem Downloaded from https://github.com/graalvm/graalvm-ce-builds/releases/tag/vm-21.1.0
rem Also need to run: gu install native-image
rem See https://www.graalvm.org/reference-manual/native-image/
set JAVA_HOME=C:\temp\graalvm-ce-java16-21.1.0
set "PATH=%PATH%;C:\temp\graalvm-ce-java16-21.1.0\bin"

javac Program.java
jar --main-class=Program -c -f Program.jar Program.class
native-image Program
