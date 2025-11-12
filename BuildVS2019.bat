echo off
mkdir BuildVS2019
cd BuildVS2019
cmake -G "Visual Studio 16 2019" -A x64 ../
cd..
cmake  --build BuildVS2019 --config Debug
cmake  --build BuildVS2019 --config Release

rem copy BuildVS2015\zlib.dir\Release\zlib.pdb BuildVS2015\lib\release\zlib.pdb