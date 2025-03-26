AJ's NFS3/HS TGA Converter Python Script for GIMP
______________________________________________________
A small script that quickly converts the alpha channel between NFS3 and HS CAR00.tga files.

Features:
-----------
-Converts between NFS3 and NFSHS TGA spec files
-Additional options to flip texture vertically and keeping the file opened for further editing
-Tailored scripts for 2.8 and 2.10 since both handle alpha channel colors differently (2.10 uses linear precision instead of perceptual gamma, which pushes the values way up)

How to use:
-----------
-Extract the files to some folder in your hard drive
-Move the .py file that corresponds to your GIMP version file to the plug-ins folder of your GIMP user data (in Windows, it's located in %APPDATA%\.gimp-2.8 for version 2.8 or %APPDATA%\GIMP\2.10 for version 2.10) . The script can be found under File > File Operations > NFS3/HS TGA Converter

