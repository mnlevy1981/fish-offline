% FEISTY output at all locations

clear all
close all

cfile = 'Dc_Lam700_enc70-b200_m400-b175-k086_c20-b250_D075_A050_nmort1_BE08_noCC_RE00100';

fpath=['/Volumes/MIP/NC/CESM_MAPP/' cfile '/'];
harv = 'quad_All_fish03';

%% SP
ncid = netcdf.open([fpath 'Spinup_' harv '_sml_p.nc'],'NC_NOWRITE');
[ndims,nvars,ngatts,unlimdimid] = netcdf.inq(ncid);
for i = 1:nvars
    varname = netcdf.inqVar(ncid, i-1);
    eval([ varname ' = netcdf.getVar(ncid,i-1);']);
    eval([ varname '(' varname ' == 99999) = NaN;']);
end
netcdf.close(ncid);

%%
[ni,nt] = size(biomass);

SP.bio = biomass;
clear biomass

%% SF
ncid = netcdf.open([fpath 'Spinup_' harv '_sml_f.nc'],'NC_NOWRITE');
[ndims,nvars,ngatts,unlimdimid] = netcdf.inq(ncid);
for i = 1:nvars
    varname = netcdf.inqVar(ncid, i-1);
    eval([ varname ' = netcdf.getVar(ncid,i-1);']);
    eval([ varname '(' varname ' == 99999) = NaN;']);
end
netcdf.close(ncid);

SF.bio = biomass(:,1:nt);
clear biomass 

% SD
ncid = netcdf.open([fpath 'Spinup_' harv '_sml_d.nc'],'NC_NOWRITE');
[ndims,nvars,ngatts,unlimdimid] = netcdf.inq(ncid);
for i = 1:nvars
    varname = netcdf.inqVar(ncid, i-1);
    eval([ varname ' = netcdf.getVar(ncid,i-1);']);
    eval([ varname '(' varname ' == 99999) = NaN;']);
end
netcdf.close(ncid);

SD.bio = biomass;
clear biomass 

% MP
ncid = netcdf.open([fpath 'Spinup_' harv '_med_p.nc'],'NC_NOWRITE');
[ndims,nvars,ngatts,unlimdimid] = netcdf.inq(ncid);
for i = 1:nvars
    varname = netcdf.inqVar(ncid, i-1);
    eval([ varname ' = netcdf.getVar(ncid,i-1);']);
    eval([ varname '(' varname ' == 99999) = NaN;']);
end
netcdf.close(ncid);

MP.bio = biomass;
clear biomass

% MF
ncid = netcdf.open([fpath 'Spinup_' harv '_med_f.nc'],'NC_NOWRITE');
[ndims,nvars,ngatts,unlimdimid] = netcdf.inq(ncid);
for i = 1:nvars
    varname = netcdf.inqVar(ncid, i-1);
    eval([ varname ' = netcdf.getVar(ncid,i-1);']);
    eval([ varname '(' varname ' == 99999) = NaN;']);
end
netcdf.close(ncid);

MF.bio = biomass;
clear biomass

% MD
ncid = netcdf.open([fpath 'Spinup_' harv '_med_d.nc'],'NC_NOWRITE');
[ndims,nvars,ngatts,unlimdimid] = netcdf.inq(ncid);
for i = 1:nvars
    varname = netcdf.inqVar(ncid, i-1);
    eval([ varname ' = netcdf.getVar(ncid,i-1);']);
    eval([ varname '(' varname ' == 99999) = NaN;']);
end
netcdf.close(ncid);

MD.bio = biomass;
clear biomass

% LP
ncid = netcdf.open([fpath 'Spinup_' harv '_lrg_p.nc'],'NC_NOWRITE');
[ndims,nvars,ngatts,unlimdimid] = netcdf.inq(ncid);
for i = 1:nvars
    varname = netcdf.inqVar(ncid, i-1);
    eval([ varname ' = netcdf.getVar(ncid,i-1);']);
    eval([ varname '(' varname ' == 99999) = NaN;']);
end
netcdf.close(ncid);

LP.bio = biomass;
clear biomass

% LD
ncid = netcdf.open([fpath 'Spinup_' harv '_lrg_d.nc'],'NC_NOWRITE');
[ndims,nvars,ngatts,unlimdimid] = netcdf.inq(ncid);
for i = 1:nvars
    varname = netcdf.inqVar(ncid, i-1);
    eval([ varname ' = netcdf.getVar(ncid,i-1);']);
    eval([ varname '(' varname ' == 99999) = NaN;']);
end
netcdf.close(ncid);

LD.bio = biomass;
clear biomass

% Benthic material
ncid = netcdf.open([fpath 'Spinup_' harv '_bent.nc'],'NC_NOWRITE');
[ndims,nvars,ngatts,unlimdimid] = netcdf.inq(ncid);
for i = 1:nvars
    varname = netcdf.inqVar(ncid, i-1);
    eval([ varname ' = netcdf.getVar(ncid,i-1);']);
    eval([ varname '(' varname ' == 99999) = NaN;']);
end
netcdf.close(ncid);

Bent.bio = biomass;
clear biomass


%% Save last year for initializing forecast runs
Sml_f.bio = nanmean(SF.bio(:,nt-11:nt),2);
Sml_p.bio = nanmean(SP.bio(:,nt-11:nt),2);
Sml_d.bio = nanmean(SD.bio(:,nt-11:nt),2);
Med_f.bio = nanmean(MF.bio(:,nt-11:nt),2);
Med_p.bio = nanmean(MP.bio(:,nt-11:nt),2);
Med_d.bio = nanmean(MD.bio(:,nt-11:nt),2);
Lrg_p.bio = nanmean(LP.bio(:,nt-11:nt),2);
Lrg_d.bio = nanmean(LD.bio(:,nt-11:nt),2);
BENT.bio  = nanmean(Bent.bio(:,nt-11:nt),2);

save([fpath 'Last_mo_spin_quad_' cfile '.mat'],'Sml_f','Sml_p','Sml_d',... 
    'Med_f','Med_p','Med_d','Lrg_p','Lrg_d','BENT')

%% Take means for my own visualization

%Time
sp_tmean=mean(SP.bio,1);
sf_tmean=mean(SF.bio,1);
sd_tmean=mean(SD.bio,1);
mp_tmean=mean(MP.bio,1);
mf_tmean=mean(MF.bio,1);
md_tmean=mean(MD.bio,1);
lp_tmean=mean(LP.bio,1);
ld_tmean=mean(LD.bio,1);
b_tmean=mean(Bent.bio,1);

%% Space
yrP=[nt-11:nt]; 

sp_mean=mean(SP.bio(:,yrP),2);
sf_mean=mean(SF.bio(:,yrP),2);
sd_mean=mean(SD.bio(:,yrP),2);
mp_mean=mean(MP.bio(:,yrP),2);
mf_mean=mean(MF.bio(:,yrP),2);
md_mean=mean(MD.bio(:,yrP),2);
lp_mean=mean(LP.bio(:,yrP),2);
ld_mean=mean(LD.bio(:,yrP),2);
b_mean =mean(Bent.bio(:,yrP),2);

save([fpath 'Means_Spinup_quad_' cfile '.mat'],'time','yrP',...
    'sf_tmean','sp_tmean','sd_tmean',...
    'mf_tmean','mp_tmean','md_tmean',...
    'lp_tmean','ld_tmean','b_tmean',...
    'sf_mean','sp_mean','sd_mean',...
    'mf_mean','mp_mean','md_mean',...
    'lp_mean','ld_mean','b_mean')

%%
mo = (1:nt)/12;
figure
plot(mo,log10(lp_tmean),'b'); hold on;
plot(mo,log10(mf_tmean),'r'); hold on;
plot(mo,log10(ld_tmean),'k'); hold on;

