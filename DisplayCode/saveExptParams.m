function saveExptParams

global Mstate Pstate Lstate looperInfo 

%Save the analzer file

Analyzer.M = Mstate;
Analyzer.P = Pstate;
Analyzer.L = Lstate;
Analyzer.loops = looperInfo;
Analyzer.modID = getmoduleID;


title = [Mstate.anim '_' sprintf('u%s',Mstate.unit) '_' Mstate.expt];

roots = strtrim(strsplit(Mstate.analyzerRoot,';'));

%Save each root:
for i = 1:length(roots)

    dd = fullfile(roots{i},Mstate.anim);

    if(~exist(dd))
        mkdir(dd);  %if there is a new animal
    end

    dd = strtrim(fullfile(dd,[title '.analyzer']));

    disp(['Saving analyzer file at location:  ' dd])

    save(dd ,'Analyzer')
    
end
