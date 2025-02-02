%% FEISTY Make file

clear all
close all

%%%%!! EXPERIMENTS
testc = true;
spinup_cesm = false;
fosi_cesm = false;
dple_cesm = false;

tic

if testc
    %test_case()
    test_locs3()
end
if spinup_cesm
%     Locs_CESM_4p4z_spinup()
    Spinup_cesm()
    Spinup_FOSI_climatol()
    Spinup_FOSI_varFood()
    Spinup_FOSI_varTemp()
%     Spinup_4p4z()
%     Spinup_4p4z_comb()
end
if fosi_cesm
%     Locs_CESM_4p4z()
    FOSI_cesm()
    FOSI_cesm_catch()
    FOSI_cesm_climatol()
    FOSI_cesm_varFood()
    FOSI_cesm_varTemp()
%     FOSI_cesm_search()
%     CESM_4p4z()
%     CESM_4p4z_comb()
end
if dple_cesm
    DPLE_cesm()
end

toc
