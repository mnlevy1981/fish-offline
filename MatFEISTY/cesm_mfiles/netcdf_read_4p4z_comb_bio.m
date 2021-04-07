% FEISTY output at all locations

clear all
close all

cfile = 'Dc_Lam700_enc70-b200_m400-b175-k086_c20-b250_D075_A050_nmort1_BE08_noCC_RE00100';

fpath=['/Volumes/MIP/NC/CESM_MAPP/' cfile '/'];
harv = 'All_fish03';

%% SP
ncid = netcdf.open([fpath '4P4Z_comb_' harv '_sml_p.nc'],'NC_NOWRITE');
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
ncid = netcdf.open([fpath '4P4Z_comb_' harv '_sml_f.nc'],'NC_NOWRITE');
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
ncid = netcdf.open([fpath '4P4Z_comb_' harv '_sml_d.nc'],'NC_NOWRITE');
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
ncid = netcdf.open([fpath '4P4Z_comb_' harv '_med_p.nc'],'NC_NOWRITE');
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
ncid = netcdf.open([fpath '4P4Z_comb_' harv '_med_f.nc'],'NC_NOWRITE');
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
ncid = netcdf.open([fpath '4P4Z_comb_' harv '_med_d.nc'],'NC_NOWRITE');
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
ncid = netcdf.open([fpath '4P4Z_comb_' harv '_lrg_p.nc'],'NC_NOWRITE');
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
ncid = netcdf.open([fpath '4P4Z_comb_' harv '_lrg_d.nc'],'NC_NOWRITE');
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
ncid = netcdf.open([fpath '4P4Z_comb_' harv '_bent.nc'],'NC_NOWRITE');
[ndims,nvars,ngatts,unlimdimid] = netcdf.inq(ncid);
for i = 1:nvars
    varname = netcdf.inqVar(ncid, i-1);
    eval([ varname ' = netcdf.getVar(ncid,i-1);']);
    eval([ varname '(' varname ' == 99999) = NaN;']);
end
netcdf.close(ncid);

Bent.bio = biomass;
clear biomass

%% Zoop loss
% MZ loss
ncid = netcdf.open([fpath '4P4Z_comb_' harv '_mzoo.nc'],'NC_NOWRITE');
[ndims,nvars,ngatts,unlimdimid] = netcdf.inq(ncid);
for i = 1:nvars
    varname = netcdf.inqVar(ncid, i-1);
    eval([ varname ' = netcdf.getVar(ncid,i-1);']);
    eval([ varname '(' varname ' == 99999) = NaN;']);
end
netcdf.close(ncid);

MZ.frac = fraction;
clear fraction

%% Take means for my own visualization

%Time
sp_tmean=nanmean(SP.bio,1);
sf_tmean=nanmean(SF.bio,1);
sd_tmean=nanmean(SD.bio,1);
mp_tmean=nanmean(MP.bio,1);
mf_tmean=nanmean(MF.bio,1);
md_tmean=nanmean(MD.bio,1);
lp_tmean=nanmean(LP.bio,1);
ld_tmean=nanmean(LD.bio,1);
b_tmean=nanmean(Bent.bio,1);
mz_tmfrac=nanmean(MZ.frac,1);

%% Space
sp_sbio=nanmean(SP.bio,2);
sf_sbio=nanmean(SF.bio,2);
sd_sbio=nanmean(SD.bio,2);
mp_sbio=nanmean(MP.bio,2);
mf_sbio=nanmean(MF.bio,2);
md_sbio=nanmean(MD.bio,2);
lp_sbio=nanmean(LP.bio,2);
ld_sbio=nanmean(LD.bio,2);
b_sbio =nanmean(Bent.bio,2);
mz_smfrac= nanmean(MZ.frac,2);

%% Total times overcon happens in last year
MZ.over = nan*ones(size(MZ.frac));
MZ.over(MZ.frac > 1) = ones;
MZ.over(MZ.frac <= 1) = zeros;

% Time
mz_ttf=nansum(MZ.over,1);
% Space
mz_stf=nansum(MZ.over,2);

%% Annual means
nyr = nt/12;
st=1:12:length(time);
en=12:12:length(time);
mz_mtf = nan*ones(ni,nyr);

for n=1:length(st)
    % total overcon
    mz_mtf(:,n)=nansum(MZ.over(:,st(n):en(n)),2);
    
    % mean biomass
    sp_abio(:,n)=nanmean(SP.bio(:,st(n):en(n)),2);
    sf_abio(:,n)=nanmean(SF.bio(:,st(n):en(n)),2);
    sd_abio(:,n)=nanmean(SD.bio(:,st(n):en(n)),2);
    mp_abio(:,n)=nanmean(MP.bio(:,st(n):en(n)),2);
    mf_abio(:,n)=nanmean(MF.bio(:,st(n):en(n)),2);
    md_abio(:,n)=nanmean(MD.bio(:,st(n):en(n)),2);
    lp_abio(:,n)=nanmean(LP.bio(:,st(n):en(n)),2);
    ld_abio(:,n)=nanmean(LD.bio(:,st(n):en(n)),2);
    b_abio(:,n)=nanmean(Bent.bio(:,st(n):en(n)),2);
end

%%
save([fpath 'Time_Means_4P4Z_comb_' cfile '.mat'],'time',...
    'sf_tmean','sp_tmean','sd_tmean',...
    'mf_tmean','mp_tmean','md_tmean',...
    'lp_tmean','ld_tmean','b_tmean',...
    'mz_tmfrac','mz_ttf')

save([fpath 'Space_Means_4P4Z_comb_' cfile '.mat'],'time',...
    'sf_sbio','sp_sbio','sd_sbio',...
    'mf_sbio','mp_sbio','md_sbio',...
    'lp_sbio','ld_sbio','b_sbio',...
    'mz_smfrac','mz_stf')

save([fpath 'Annual_Means_4P4Z_comb_' cfile '.mat'],'time',...
    'sf_abio','sp_abio','sd_abio',...
    'mf_abio','mp_abio','md_abio',...
    'lp_abio','ld_abio','b_abio',...
    'mz_mtf')

%%
mo = (1:nt)/12;
figure
plot(mo,log10(lp_tmean),'b'); hold on;
plot(mo,log10(mf_tmean),'r'); hold on;
plot(mo,log10(ld_tmean),'k'); hold on;

%%
[nid,nt] = size(MZ.frac);
figure
plot(mo,mz_ttf/nid,'b'); hold on; 

mean(mz_ttf/nid) %~43%
