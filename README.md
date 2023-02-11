# Empty Maya plug-in framework

This is a self-contained framework to facilitate the creation of plug-ins in Autodesk Maya.

After configuration (see [Usage](#Usage)), the framework will build plugins using _CMake_ and add the folder of the repository to the _Maya_ environment paths as a module, so that _Maya_ can automatically find the files in the _scripts_, _icons_ and _plug-ins_ folders.

## Requirements

* [CMAKE](https://cmake.org/download/) 3.1+
* [Maya](https://www.autodesk.com/products/maya/overview) 2017+
* [Visual Studio](https://visualstudio.microsoft.com/) 2017, 2019, 2022 (Community, Professional, Enterprise)

## Usage

1. Clone the repository where you want to have your plug-in and source files
2. Replace "pluginName" with the name of your plug-in in the following files
    * _pluginName.mod_ (in the content for each supported _Maya_ version and also the file name)
    * _CMakeLists.txt_ (at the beginning: project(_pluginName_))
3. Run the _buildWindowsDebug.bat_ to create the _Visual Studio Solution_ and build the plug-in for the version of _Maya_ that you are using
4. Once built, open _Maya_
5. Drag and drop the _install.mel_ file into the Maya viewport
6. Restart _Maya_ 
7. Load your plug-in from the Plug-in Manager (Windows->Settings/Preferences->Plug-in Manager)
    * Or run the following mel script: `loadPlugin YOURPLUGINNAME`

If your plugin is loaded and you want to compile a new version, 
1. Unload the plugin first: `unloadPlugin YOURPLUGINNAME`
2. Build your project
3. Load the plugin again: `loadPlugin YOURPLUGINNAME`
