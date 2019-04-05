function startAcq

%code for acqstart should go here

%global setupDefault

%if ~isempty(strfind(setupDefault.setupID,'2P'))
%    updateAcqName   %Send expt info to acquisition
%    send_sbserver('G'); %start microscope
%end

