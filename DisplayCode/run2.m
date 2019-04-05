function run2


%This function now gets called for play sample, as well. Hence the global
%conditional of Mstate.runnind

global GUIhandles  Mstate trialno  

if Mstate.running
    nt = Sgetnotrials;
end



if Mstate.running && trialno<=nt
    
    set(GUIhandles.main.showTrial,'string',['Trial ' num2str(trialno) ' of ' num2str(nt)] ), drawnow

    [c,~] = Sgetcondrep(trialno);  %get cond and rep for this trialno

  
    %%%Organization of commands is important for timing in this part of loop
    tic
    disp(['Building and sending stimulus.']);
    buildStimulus(c,trialno)    %Tell stimulus to buffer the images
    waitforDisplayResp;
    buildSendTime = toc;
    fprintf('\t'); disp(['Computation/communication time: ' num2str(buildSendTime) 's.']) 
    mod = getmoduleID;
    fprintf('\t'); disp('Playing stimulus...');
    startStimulus(mod)      %Tell Display to show its buffered images. 
    
    trialno = trialno+1;

    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
else
    
    %This is executed at the end of experiment and when abort button is hit
    if get(GUIhandles.main.daqflag,'value');
        pause(5);
        stopAcq;
    end
    
    Mstate.running = 0;
    set(GUIhandles.main.runbutton,'string','Run')
 
end


