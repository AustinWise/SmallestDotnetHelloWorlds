@echo off
setlocal

call setup_vs_tools.cmd
if not %ERRORLEVEL%==0 (exit /b 1)
ilasm /X64 /NOCORSTUB hello.il
if not %ERRORLEVEL%==0 (goto :notok)

:ok
echo assembled ok
exit /b 0

:notok
echo failed to assemble
exit /b 1