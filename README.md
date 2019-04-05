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


# Initial setup - General

- ensure that master and slave can communicate via TCP (use ping to test); may have to adjust firewall settings
- copy correct part of stimulator code onto each machine
- measure LUT for gamma calibration for monitor (if required)



# Initial setup - Master

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


# Initial setup - Slave


# Basic use


# Add a new module

- delete history files if parameters for an existing/previously used module have changed

# Module parameters

