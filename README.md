Notes on stimulator code for visual stimulus generation

1. Setup
Master:
-	Windows or Ubuntu machine
-	Matlab
-	No specific requirements for graphics card or monitor
-	Can be running acquisition as well (depending on demands of acquisition)

Slave:
-	Ubuntu
-	Matlab
-	Psychtoolbox-compatible graphics card (most recently, we’ve used NVidia Geforce GTX 1050)
  Notes on configuration for NVidia graphics card for Psychtoolbox:
  -- Make sure graphics card is set to optimal power setting (using power mizer interface for NVidia driver)
  -- Disable dithering
-	2 screens suitable for visual stimulus display, set up in mirroring mode (i.e. not extended desktop)
-	Psychtoolbox
  Need to ensure that Psychtoolbox can run without dropping frames by running Psychtoolbox test scrips (in particular, VBLSyncTest)

