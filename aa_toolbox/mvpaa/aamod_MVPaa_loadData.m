% AA module - MVPaa 1st level (ROI based)
%
% Modified for aa4 by Alejandro Vicente-Grabovetsky Feb-2011

function [aap,resp] = aamod_MVPaa_loadData(aap,task,subj)

resp='';

switch task
    case 'doit'
        
        aap.subj = subj;
        
        %% PREPARATIONS...        
        mriname = aas_prepare_diagnostic(aap);
        
        fprintf('Working with data from participant %s. \n', mriname)
                
        % Load the data into a single big structure...
        [aap MVPaa_data] = mvpaa_loadData(aap);
        MVPaa_settings = aap.tasklist.currenttask.settings;
        
        %% DIAGNOSTICS?
        
        %% DESCRIBE OUTPUTS
        % And save it all to disk
        save(fullfile(aas_getsubjpath(aap,subj), 'MVPaa_data.mat'), 'MVPaa_data');
        save(fullfile(aas_getsubjpath(aap,subj), 'MVPaa_settings.mat'), 'MVPaa_settings');
        
        aap=aas_desc_outputs(aap,subj,'MVPaa_data', fullfile(aas_getsubjpath(aap,subj), 'MVPaa_data.mat'));
        aap=aas_desc_outputs(aap,subj,'MVPaa_settings', fullfile(aas_getsubjpath(aap,subj), 'MVPaa_settings.mat'));
end