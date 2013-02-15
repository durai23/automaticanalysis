function segMask = mvpaa_getSegmentations(aap)

%% TASKS:
% @@@@@ IMPOVE THIS! @@@@@

%% Do we grey/white/CSF matter mask the data?
% Get segmentation masks we wish to use, if any

SEGimg = aas_findstream(aap, 'mask', aap.subj);
Mimg = [];

if ~isempty(SEGimg)
    if aap.tasklist.currenttask.settings.native
        % Select the Segmentation mask we wish to use...
        for m = 1:size(SEGimg,1)
            if strfind(SEGimg(m,:), sprintf('rc%d', aap.tasklist.currenttask.settings.maskNum))
                Mimg = deblank(SEGimg(m,:));
                break
            end
        end
    else
        % Select the Segmentation mask we wish to use...
        for m = 1:size(SEGimg,1)
            if strfind(SEGimg(m,:), sprintf('rwc%d', aap.tasklist.currenttask.settings.maskNum))
                Mimg = deblank(SEGimg(m,:));
                break
            end
        end
    end
    % The mask is not based on segmentations (e.g. brain mask)
    if isempty(Mimg)
        Mimg = SEGimg(1,:);
    end
    
    segMask = spm_read_vols(spm_vol(Mimg));
    % If mask is exclusive, invert it...
    if aap.tasklist.currenttask.settings.maskInclusive == 0;
        segMask = ~segMask;
        aas_log(aap, 0, sprintf('Using %s image as an exclusive mask for the data', Mimg))
    else
        aas_log(aap, 0, sprintf('Using %s image as an inclusive mask for the data', Mimg))
    end
else
    segMask = [];
end