echo off
mkdir BuildVS2015
cd BuildVS2015
cmake -G "Visual Studio 14" --build ../
cd..
cmake  --build BuildVS2015 --config Debug
cmake  --build BuildVS2015 --config Release

rem copy BuildVS2015\zlib.dir\Release\zlib.pdb BuildVS2015\lib\release\zlib.pdb