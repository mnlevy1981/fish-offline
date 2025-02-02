% FEISTY DPLE outputs saved as NetCDF
% Initialized 2015
% CCLME only

clear all
close all

%% Map data
cpath = '/Volumes/MIP/GCM_DATA/CESM/FOSI/';
load([cpath 'gridspec_POP_gx1v6_noSeas.mat']);
load([cpath 'Data_grid_POP_gx1v6_noSeas.mat']);
load([cpath 'LME-mask-POP_gx1v6.mat']);

[ni,nj]=size(TLONG);
ID = GRD.ID;

%% Fish data
cfile = 'Dc_Lam700_enc70-b200_m400-b175-k086_c20-b250_D075_A050_sMZ090_mMZ045_nmort1_BE08_CC80_RE00100';
pp = '/Users/cpetrik/Dropbox/Princeton/FEISTY/CODE/Figs/PNG/CESM_MAPP/DPLE/';
fpath=['/Volumes/MIP/NC/CESM_MAPP/' cfile '/'];
ppath = [pp cfile '/'];
if (~isfolder(ppath))
    mkdir(ppath)
end

%pick year
StartYr = 2015;
%loop over members
submem = 1:40;
%%
for mem=1:length(submem) %will loop over
    %%
    Member = submem(mem);
    exper = ['v14_Y' num2str(StartYr) '_M' num2str(Member) '_All_fish03_' ];
    
    load([fpath 'CESM_DPLE_CCLME_outputs_monthly_' exper cfile '.mat'])
    
    AllFish = AllF + AllP + AllD;
    
    %% nans to a small number
    AllF(isnan(AllF)) = 1.000000020040877e-20;
    AllP(isnan(AllP)) = 1.000000020040877e-20;
    AllD(isnan(AllD)) = 1.000000020040877e-20;
    AllB(isnan(AllB)) = 1.000000020040877e-20;
    AllS(isnan(AllS)) = 1.000000020040877e-20;
    AllM(isnan(AllM)) = 1.000000020040877e-20;
    AllL(isnan(AllL)) = 1.000000020040877e-20;
    AllFish(isnan(AllFish)) = 1.000000020040877e-20;
    
    %% Quick look
%     pb = AllP(:,:,50);
%     db = AllD(:,:,50);
%     cb = AllF(:,:,50);
%     bp30 = AllB(:,:,50);
%     
%     figure(1)
%     pcolor(log10(pb'))
%     shading flat
%     colormap('jet')
%     colorbar
%     caxis([-2 2])
%     title('allP')
%     
%     figure(2)
%     pcolor(log10(db'))
%     shading flat
%     colormap('jet')
%     colorbar
%     caxis([-2 2])
%     title('allD')
%     
%     figure(3)
%     pcolor(log10(cb'))
%     shading flat
%     colormap('jet')
%     colorbar
%     caxis([-2 2])
%     title('all F')
%     
%     figure(4)
%     pcolor(log10(bp30'))
%     shading flat
%     colormap('jet')
%     colorbar
%     caxis([-2 2])
%     title('All B')
%     
%     figure(5)
%     pcolor(lat2)
%     shading flat
%     title('Lat')
%     
%     figure(6)
%     pcolor(lon2)
%     shading flat
%     title('Lon')
    
    %% 
    close all
    
    %% Setup netcdf path to store to
    fname1 = 'feisty_cesm-dple_';
    fname2 = ['Y' num2str(StartYr) '_M' num2str(Member) '_' ];
    fname3 = '_CCE_monthly_2015_2025.nc';
    
    file_tfb = [fpath fname1 fname2 'tfb' fname3];
    file_tpb = [fpath fname1 fname2 'tpb' fname3];
    file_tdb = [fpath fname1 fname2 'tdb' fname3];
    file_tbb = [fpath fname1 fname2 'tbb' fname3];
    file_tsb = [fpath fname1 fname2 'tsb' fname3];
    file_tmb = [fpath fname1 fname2 'tmb' fname3];
    file_tlb = [fpath fname1 fname2 'tlb' fname3];
    file_tvb = [fpath fname1 fname2 'tvb' fname3];
    
    [ni,nj,nt] = size(AllP);
    
    %%
    LAT = lat2;
    LON = lon2;
    
    %Use Netcdf4 classic
    cmode = netcdf.getConstant('NETCDF4');
    cmode = bitor(cmode,netcdf.getConstant('CLASSIC_MODEL'));
    
    %% tfb
    ncidFB = netcdf.create(file_tfb,cmode);
    
    time_dim = netcdf.defDim(ncidFB,'time',nt);
    lon_dim = netcdf.defDim(ncidFB,'lon',ni);
    lat_dim = netcdf.defDim(ncidFB,'lat',nj);
    
    vidtFB = netcdf.defVar(ncidFB,'time','NC_DOUBLE',time_dim);
    netcdf.putAtt(ncidFB,vidtFB,'long_name','time');
    netcdf.putAtt(ncidFB,vidtFB,'standard_name','time');
    netcdf.putAtt(ncidFB,vidtFB,'calendar','365_day');
    netcdf.putAtt(ncidFB,vidtFB,'axis','T');
    netcdf.putAtt(ncidFB,vidtFB,'units','year' );
    
    vidlon = netcdf.defVar(ncidFB,'lon','NC_DOUBLE',[lon_dim,lat_dim]);
    netcdf.putAtt(ncidFB,vidlon,'long_name','longitude');
    netcdf.putAtt(ncidFB,vidlon,'standard_name','longitude');
    netcdf.putAtt(ncidFB,vidlon,'axis','X');
    
    vidlat = netcdf.defVar(ncidFB,'lat','NC_DOUBLE',[lon_dim,lat_dim]);
    netcdf.putAtt(ncidFB,vidlat,'long_name','latitude');
    netcdf.putAtt(ncidFB,vidlat,'standard_name','latitude');
    netcdf.putAtt(ncidFB,vidlat,'axis','Y');
    
    vidbioFB = netcdf.defVar(ncidFB,'tfb','NC_FLOAT',[lon_dim,lat_dim,time_dim]);
    netcdf.defVarChunking(ncidFB,vidbioFB,'CHUNKED',[10, 10, 1]);
    netcdf.putAtt(ncidFB,vidbioFB,'long_name','Biomass of Forage Fish');
    netcdf.putAtt(ncidFB,vidbioFB,'units','g m-2' );
    netcdf.defVarFill(ncidFB,vidbioFB,false,1.000000020040877e-20);
    netcdf.putAtt(ncidFB,vidbioFB,'missing value',1.000000020040877e-20);
    
    %% tpb
    vidbioPB = netcdf.defVar(ncidFB,'tpb','NC_FLOAT',[lon_dim,lat_dim,time_dim]);
    netcdf.defVarChunking(ncidFB,vidbioPB,'CHUNKED',[10, 10, 1]);
    netcdf.putAtt(ncidFB,vidbioPB,'long_name','Biomass of Large Pelagic Fish');
    netcdf.putAtt(ncidFB,vidbioPB,'units','g m-2' );
    netcdf.defVarFill(ncidFB,vidbioPB,false,1.000000020040877e-20);
    netcdf.putAtt(ncidFB,vidbioPB,'missing value',1.000000020040877e-20);
    
    %% tdb
    vidbioDB = netcdf.defVar(ncidFB,'tdb','NC_FLOAT',[lon_dim,lat_dim,time_dim]);
    netcdf.defVarChunking(ncidFB,vidbioDB,'CHUNKED',[10, 10, 1]);
    netcdf.putAtt(ncidFB,vidbioDB,'long_name','Biomass of Demersal Fish');
    netcdf.putAtt(ncidFB,vidbioDB,'units','g m-2' );
    netcdf.defVarFill(ncidFB,vidbioDB,false,1.000000020040877e-20);
    netcdf.putAtt(ncidFB,vidbioDB,'missing value',1.000000020040877e-20);
    
    %% tbb
    vidbioBB = netcdf.defVar(ncidFB,'tbb','NC_FLOAT',[lon_dim,lat_dim,time_dim]);
    netcdf.defVarChunking(ncidFB,vidbioBB,'CHUNKED',[10, 10, 1]);
    netcdf.putAtt(ncidFB,vidbioBB,'long_name','Biomass of Benthic Invertebrates');
    netcdf.putAtt(ncidFB,vidbioBB,'units','g  m-2' );
    netcdf.defVarFill(ncidFB,vidbioBB,false,1.000000020040877e-20);
    netcdf.putAtt(ncidFB,vidbioBB,'missing value',1.000000020040877e-20);
    
    %% tsb
    vidbioSB = netcdf.defVar(ncidFB,'tsb','NC_FLOAT',[lon_dim,lat_dim,time_dim]);
    netcdf.defVarChunking(ncidFB,vidbioSB,'CHUNKED',[10, 10, 1]);
    netcdf.putAtt(ncidFB,vidbioSB,'long_name','Biomass of Small Fish');
    netcdf.putAtt(ncidFB,vidbioSB,'units','g m-2' );
    netcdf.defVarFill(ncidFB,vidbioSB,false,1.000000020040877e-20);
    netcdf.putAtt(ncidFB,vidbioSB,'missing value',1.000000020040877e-20);
    
    %% tmb
    vidbioMB = netcdf.defVar(ncidFB,'tmb','NC_FLOAT',[lon_dim,lat_dim,time_dim]);
    netcdf.defVarChunking(ncidFB,vidbioMB,'CHUNKED',[10, 10, 1]);
    netcdf.putAtt(ncidFB,vidbioMB,'long_name','Biomass of Medium Fish');
    netcdf.putAtt(ncidFB,vidbioMB,'units','g m-2' );
    netcdf.defVarFill(ncidFB,vidbioMB,false,1.000000020040877e-20);
    netcdf.putAtt(ncidFB,vidbioMB,'missing value',1.000000020040877e-20);
    
    %% tlb
    vidbioLB = netcdf.defVar(ncidFB,'tlb','NC_FLOAT',[lon_dim,lat_dim,time_dim]);
    netcdf.defVarChunking(ncidFB,vidbioLB,'CHUNKED',[10, 10, 1]);
    netcdf.putAtt(ncidFB,vidbioLB,'long_name','Biomass of Large Fish');
    netcdf.putAtt(ncidFB,vidbioLB,'units','g m-2' );
    netcdf.defVarFill(ncidFB,vidbioLB,false,1.000000020040877e-20);
    netcdf.putAtt(ncidFB,vidbioLB,'missing value',1.000000020040877e-20);
    
    %% All fish
    vidbioVB = netcdf.defVar(ncidFB,'tvb','NC_FLOAT',[lon_dim,lat_dim,time_dim]);
    netcdf.defVarChunking(ncidFB,vidbioVB,'CHUNKED',[10, 10, 1]);
    netcdf.putAtt(ncidFB,vidbioVB,'long_name','Biomass of All Fish');
    netcdf.putAtt(ncidFB,vidbioVB,'units','g  m-2' );
    netcdf.defVarFill(ncidFB,vidbioVB,false,1.000000020040877e-20);
    netcdf.putAtt(ncidFB,vidbioVB,'missing value',1.000000020040877e-20);
    
    varid = netcdf.getConstant('GLOBAL');
    netcdf.putAtt(ncidFB,varid,'creation_date',datestr(now));
    netcdf.putAtt(ncidFB,varid,'_FillValue',1.000000020040877e-20);
    netcdf.putAtt(ncidFB,varid,'contact','C. Petrik <cpetrik@ucsd.edu>');
    netcdf.putAtt(ncidFB,varid,'institution','UCSD');
    netcdf.putAtt(ncidFB,varid,'wet weight:C ratio','9:1');
    
    netcdf.endDef(ncidFB);
    
    %tfb = single(tfb);
    
    netcdf.putVar(ncidFB,vidlat,LAT);
    netcdf.putVar(ncidFB,vidlon,LON);
    netcdf.putVar(ncidFB,vidtFB,mo);
    netcdf.putVar(ncidFB,vidbioFB,AllF);
    netcdf.putVar(ncidFB,vidbioPB,AllP);
    netcdf.putVar(ncidFB,vidbioDB,AllD);
    netcdf.putVar(ncidFB,vidbioBB,AllB);
    netcdf.putVar(ncidFB,vidbioSB,AllS);
    netcdf.putVar(ncidFB,vidbioMB,AllM);
    netcdf.putVar(ncidFB,vidbioLB,AllL);
    netcdf.putVar(ncidFB,vidbioVB,AllFish);
    
    netcdf.close(ncidFB);
    
    %%
    ncdisp(file_tfb)
end
