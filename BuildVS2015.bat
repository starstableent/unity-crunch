echo off
mkdir BuildVS2017
cd BuildVS2017
cmake -G "Visual Studio 15" --build ../
cd..
cmake  --build BuildVS2017 --config Debug
cmake  --build BuildVS2017 --config Release

rem copy BuildVS2015\zlib.dir\Release\zlib.pdb BuildVS2015\lib\release\zlib.pdb