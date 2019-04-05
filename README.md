# Notes on stimulator code for visual stimulus generation

# Setup components
## Master:
- Windows or Ubuntu machine
- Matlab
- no specific requirements for graphics card or monitor
- can be running acquisition as well (depending on demands of acquisition)

## Slave:
- Ubuntu
- Matlab
- Psychtoolbox-compatible graphics card (most recently, we’ve used NVidia Geforce GTX 1050)  
  *Notes on configuration for NVidia graphics card for Psychtoolbox:*  
    - *make sure graphics card is set to optimal power setting (using power mizer interface for NVidia driver)*  
    - *disable dithering*
- 2 screens suitable for visual stimulus display, set up in mirroring mode (i.e. not extended desktop)
- Psychtoolbox  
  *need to ensure that Psychtoolbox can run without dropping frames by running Psychtoolbox test scripts (in particular, VBLSyncTest)*
- if stimulus triggers are required: USB-1208FS from Measurement Computing  
  *note that USB-1208FS-Plus is not compatible with Psychtoolbox*


# Initial setup
## General

- ensure that master and slave can communicate via TCP (use ping to test); may have to adjust firewall settings
- copy correct part of stimulator code onto each machine, execute steps described below
- measure LUT for gamma calibration for monitor (if required)
- set up trigger channels (if required):  
  - Channel 0: usually used to indicate trial start/stop; USB-1208FS port A0, channel 21
  - Channel 1: usually used to indicate stimulus start/stop; USB-1208FS port A1, channel 22 
  - check playstimulus code to check for particular module



## Master

- generate the following directories:  
  - analyzer root directory  
  - directory for history files  
  - params & looper file - on windows expected to be c:\params looper  
- generate setupDefault file:
  - copy setupDefaultEx.txt to c:\params looper (windows) or \usr\local (ubuntu)  
  - rename to setupDefault.txt  
  - edit directory names to match new directories (analyzerRoot, MstateHistoryFile & ExperimentMasterFile)  
  - edit IP number to match IP number of slave  
  - edit setupID if required  
  - note: there can be multiple setupID entries if required (setupIDs matter for setting acquisition specific parameters/GUIs); there also can be multiple analyzerRoot entries if the analyzer file is to be saved in multiple locations; in both cases, each entry should be a separate line (as shown for the monitor entries)
  - update monitor list: defaultMonitor is the first monitor shown; alternativeMonitors cover the case of using the same system with different monitors (these are the monitors placed in front of the subject, not the control monitor)  
  - set useMCDaq: 1- use USB-1208FS to generate trigger events; 0- do not generate trigger events
  - if necessary, add variable acqDataRoot - this will preset the acquisition root field in the Main Window (only used if acquisition happens on the master)
- edit monitorList file:  
  - contains information (including location of gamma calibration file) for each monitor  
  - one entry per monitor  
  - the long name is used on the master, the 3 letter name on the slave  
  - calibration files containing LUT need to be saved on the slave; edit file names here  
  - linear LUT is set as the default and does not produce gamma calibration  


## Slave
- generate a directory for the log files
- generate setupDefault file:  
  - copy setupDefaultEx.txt to /usr/local/
  - rename to setupDefault.txt
  - edit logRoot to match new directory
  - edit all other parameters to match settings on master
- in more complicated setups, make sure that screenNum is set correctly in screenconfig


# Basic use


# Add a new module 


## General module
The following applies to modules that should be listed in the params window

- on Slave:  
  - write new makeTexture file  
    - this contains all stimulus generation code that can be performed in the intertrial period  
    - should be saved in maxeTextures folder
  - write new playTexgture file
    - this contains all of the stimulus presentation & timing code, as well as any stimulus generation that cannot be handled in the intertrial period  
    - should be saved in playTextures folder
  - write configPstate file  
    - should contain all parameters that can be changed by the user
    - saved in configFiles
    - function should include global Pstate
    - structure of config file:  
      - one cell per parameter gets added to Pstate
      - for every parameter, cell contains 5 entries:  
        - parameter name (string)  
        - parameter type (string; can be float, int, string)  
        - default value (number or string)  
        - legacy field (unused; can be set to 0)  
        - unit (string, used for display in params window only)  
    - to call parameters defined in the config file in the makeTexture/playTexture files for the module, include 'P=getParamStruct'. Parameters can then be refered to as P.*parameterName*, with *parameterName* corresponding to the first string in a parameter's cell in the configFile
  - add module to moduleListSlave:  
    - one cell per module in Mlist  
    - for every module, there are 4 entries:  
      - module code: 2 letters (used for communication between master & slave)  
      - name of config file  
      - name of makeTexture file  
      - name of playTexture file  
- on Master:  
  - copy configPstate file from slave into configFiles folder on master  
  - add module to moduleListMaster:  
    - one cell per module in Plist  
    - for every module, there are 4 entries  
      - module code: 2 letters (used for communication between master & slave)  
      - name of module (to be displayed in dropdown list in params window)  
      - name of config file
      - 4th field allows to add a module-specific initialization file
- *Note: delete history files if parameters for an existing/previously used module have changed*

## Module for manual mapper

# Module parameters

The first section lists parameters found in most modules; the following section then list additional module-specific parameters. Note that the screen distance needs to be set correctly in the main window for any of the visual deg values to be correct.

## General parameters
Parameter | Description 
--- | ---
predelay |
postdelay |
stim_time |
x_pos |
y_pos |
x_size |
y_size | 
background | 

## Bar
Parameter | Description 
--- | ---
max_posdelta
offset
ori
speed
background
redgun
greengun
bluegun
