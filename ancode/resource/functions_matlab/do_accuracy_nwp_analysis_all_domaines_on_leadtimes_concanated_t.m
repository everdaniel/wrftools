function [ succes ] = do_accuracy_nwp_analysis_all_domaines_on_leadtimes_concanated_turbines( Namelist )
%DO_ACCURACY_NWP_ANALYSIS Summary of this function goes here
%   Detailed explanation goes here

First_time=1

    
    exp_name='Turbine_by_turbine_winter_training_12_months_2011'
    file_path=['C:\Users\jnini\MATLAB\work\AnEn\data\workspace\ETA\out\experiments\',exp_name]
    load([file_path,'\turbine_time_series_for_nr_analogs_20'])
    leadtime_vector=get_leadtime_vector(turbine_time_series,Namelist)'
    obs=[]
    for j=analogs_lead_times
    [m n]=size(turbine_time_series)
        for i=1:n
            % concanate loop
            good_idx{i}=find(turbine_time_series(1,i).data{2,15}~=Namelist{1}.missing_value & leadtime_vector==j)
            
            obs=vertcat(turbine_time_series(1,i).data{2,15}(good_idx{i}),obs)
            model=vertcat
        end
        
            if not(isempty(good_idx{i}))
                if Namelist{10}.normalize_errors
                    
                    [ETA_rmse_20(j) ETA_bias_20(j) ETA_crmse_20(j)] = RMSEdecomp_all(obs/Namelist{10}.rated_capasity_kw, turbine_time_series(1,i).data{2,2}(good_idx{i})/Namelist{10}.rated_capasity_kw);
                    ETA_NMAE_20(j)=mean(abs(obs-turbine_time_series(1,i).data{2,2}(good_idx{i}))/Namelist{10}.rated_capasity_kw);
                    ETA_pearson_20(j)=corr(obs,turbine_time_series(1,i).data{2,2}(good_idx{i}), 'Type', 'Pearson');
                    ETA_spearman_rank_correltion_20(j)=corr(obs,turbine_time_series(1,i).data{2,2}(good_idx{i}), 'Type', 'Spearman');
                else
                    [ETA_rmse_20(j) ETA_bias_20(j) ETA_crmse_20(j)] = RMSEdecomp_all(obs, turbine_time_series(1,i).data{2,2}(good_idx{i}));
                    ETA_NMAE_20(j)=mean(abs(obs-turbine_time_series(1,i).data{2,2}(good_idx{i})))
                    ETA_pearson_20(j)=corr(obs,turbine_time_series(1,i).data{2,2}(good_idx{i}), 'Type', 'Pearson');
                    ETA_spearman_rank_correltion_20(j)=corr(obs,turbine_time_series(1,i).data{2,2}(good_idx{i}), 'Type', 'Spearman');
                end
            else
                if Namelist{10}.normalize_errors
                    ETA_rmse_20(j) =Namelist{1}.missing_value
                    ETA_bias_20(j) =Namelist{1}.missing_value
                    ETA_crmse_20(j) =Namelist{1}.missing_value 
                    ETA_NMAE_20(j)=Namelist{1}.missing_value
                    ETA_pearson_20(j)=Namelist{1}.missing_value
                    ETA_spearman_rank_correltion_20(j)=Namelist{1}.missing_value
                else
                    ETA_rmse_20(j) =Namelist{1}.missing_value
                    ETA_bias_20(j) =Namelist{1}.missing_value
                    ETA_crmse_20(j)= Namelist{1}.missing_value
                    ETA_NMAE_20(j)=Namelist{1}.missing_value
                    ETA_pearson_20(j)=Namelist{1}.missing_value
                    ETA_spearman_rank_correltion_20(j)=Namelist{1}.missing_value
                end

            end
        
    end


    clear turbine_time_series;
    exp_name_wrf='Turbine_by_turbine_winter_1_mslp_wspd_wdir_rho_shear_domaine_3'
    file_path=['C:\Users\jnini\MATLAB\work\AnEn\data\workspace\WRF\out\experiments\',exp_name_wrf]
    load([file_path,'\turbine_time_series_for_nr_analogs_20']);Namelist{4}.nwp_model_domain=3
    leadtime_vector=get_leadtime_vector(turbine_time_series,Namelist)'
    [ analogs_lead_times_d3 ] = get_analog_lead_times( Namelist );

    for j=analogs_lead_times
    % gets the index where obervation are not missing for each turbine 
    [m n]=size(turbine_time_series)    
        for i=1:n
          good_idx{i}=find(turbine_time_series(1,i).data{2,15}~=Namelist{1}.missing_value & leadtime_vector==j)
           if not(isempty(good_idx{i}))
            if Namelist{10}.normalize_errors
                [WRF_d3_rmse_20(j) WRF_d3_bias_20(j) WRF_d3_crmse_20(j)] = RMSEdecomp_all(obs/Namelist{10}.rated_capasity_kw, turbine_time_series(1,i).data{2,2}(good_idx{i})/Namelist{10}.rated_capasity_kw);
                WRF_d3_NMAE_20(j)=mean(abs(obs-turbine_time_series(1,i).data{2,2}(good_idx{i}))/Namelist{10}.rated_capasity_kw)
                WRF_d3_pearson_20(j)=corr(obs,turbine_time_series(1,i).data{2,2}(good_idx{i}), 'Type', 'Pearson');
                WRF_d3_spearman_rank_correltion_20(j)=corr(obs,turbine_time_series(1,i).data{2,2}(good_idx{i}), 'Type', 'Spearman');
            else
                [WRF_d3_rmse_20(j) WRF_d3_bias_20(j) WRF_d3_crmse_20(j)] = RMSEdecomp_all(obs, turbine_time_series(1,i).data{2,2}(good_idx{i}));
                WRF_d3_NMAE_20(j)=mean(abs(obs-turbine_time_series(1,i).data{2,2}(good_idx{i})))
                WRF_d3_pearson_20(j)=corr(obs,turbine_time_series(1,i).data{2,2}(good_idx{i}), 'Type', 'Pearson');
                WRF_d3_spearman_rank_correltion_20(j)=corr(obs,turbine_time_series(1,i).data{2,2}(good_idx{i}), 'Type', 'Spearman');
            end
           end % is empty    
        end % turbine id
    end % lead time

    exp_name_wrf='Turbine_by_turbine_winter_1_mslp_wspd_wdir_rho_shear_domaine_2'
    file_path=['C:\Users\jnini\MATLAB\work\AnEn\data\workspace\WRF\out\experiments\',exp_name_wrf]
    load([file_path,'\turbine_time_series_for_nr_analogs_20'])
    Namelist{4}.nwp_model_domain=2
    leadtime_vector=get_leadtime_vector(turbine_time_series,Namelist)'
    [ analogs_lead_times_d2 ] = get_analog_lead_times( Namelist );

    % gets the index where obervation are not missing for each turbine 
    for j=analogs_lead_times_d2
    % gets the index where obervation are not missing for each turbine 
    [m n]=size(turbine_time_series)    
        for i=1:n
          good_idx{i}=find(turbine_time_series(1,i).data{2,15}~=Namelist{1}.missing_value & leadtime_vector==j)
           if not(isempty(good_idx{i}))
            if Namelist{10}.normalize_errors
                [WRF_d2_rmse_20(j) WRF_d2_bias_20(j) WRF_d2_crmse_20(j)] = RMSEdecomp_all(obs/Namelist{10}.rated_capasity_kw, turbine_time_series(1,i).data{2,2}(good_idx{i})/Namelist{10}.rated_capasity_kw);
                WRF_d2_NMAE_20(j)=mean(abs(obs-turbine_time_series(1,i).data{2,2}(good_idx{i}))/Namelist{10}.rated_capasity_kw)
                WRF_d2_pearson_20(j)=corr(obs,turbine_time_series(1,i).data{2,2}(good_idx{i}), 'Type', 'Pearson');
                WRF_d2_spearman_rank_correltion_20(j)=corr(obs,turbine_time_series(1,i).data{2,2}(good_idx{i}), 'Type', 'Spearman');
            else
                [WRF_d2_rmse_20(j) WRF_d2_bias_20(j) WRF_d2_crmse_20(j)] = RMSEdecomp_all(obs, turbine_time_series(1,i).data{2,2}(good_idx{i}));
                WRF_d2_NMAE_20(j)=mean(abs(obs-turbine_time_series(1,i).data{2,2}(good_idx{i})))
                WRF_d2_pearson_20(j)=corr(obs,turbine_time_series(1,i).data{2,2}(good_idx{i}), 'Type', 'Pearson');
                WRF_d2_spearman_rank_correltion_20(j)=corr(obs,turbine_time_series(1,i).data{2,2}(good_idx{i}), 'Type', 'Spearman');
            end
           end
        end % turbine id
    end % for lead times 

    exp_name_wrf='Turbine_by_turbine_winter_1_mslp_wspd_wdir_rho_shear_domaine_1'
    file_path=['C:\Users\jnini\MATLAB\work\AnEn\data\workspace\WRF\out\experiments\',exp_name_wrf]
    load([file_path,'\turbine_time_series_for_nr_analogs_20']);Namelist{4}.nwp_model_domain=1
    leadtime_vector=get_leadtime_vector(turbine_time_series,Namelist)'
    [ analogs_lead_times_d1 ] = get_analog_lead_times( Namelist );
    % gets the index where obervation are not missing for each turbine 
    [m n]=size(turbine_time_series)    

    for j=analogs_lead_times_d1
    % gets the index where obervation are not missing for each turbine 
    [m n]=size(turbine_time_series)    
        for i=1:n
          good_idx{i}=find(turbine_time_series(1,i).data{2,15}~=Namelist{1}.missing_value & leadtime_vector==j)
           if not(isempty(good_idx{i}))
            if Namelist{10}.normalize_errors
               [WRF_d1_rmse_20(j) WRF_d1_bias_20(j) WRF_d1_crmse_20(j)] = RMSEdecomp_all(obs/Namelist{10}.rated_capasity_kw, turbine_time_series(1,i).data{2,2}(good_idx{i})/Namelist{10}.rated_capasity_kw);
                WRF_d1_NMAE_20(j)=mean(abs(obs-turbine_time_series(1,i).data{2,2}(good_idx{i}))/Namelist{10}.rated_capasity_kw)
                WRF_d1_pearson_20(j)=corr(obs,turbine_time_series(1,i).data{2,2}(good_idx{i}), 'Type', 'Pearson');
                WRF_d1_spearman_rank_correltion_20(j)=corr(obs,turbine_time_series(1,i).data{2,2}(good_idx{i}), 'Type', 'Spearman');
            else
                [WRF_d1_rmse_20(j) WRF_d1_bias_20(j) WRF_d1_crmse_20(j)] = RMSEdecomp_all(obs, turbine_time_series(1,i).data{2,2}(good_idx{i}));
                WRF_d1_NMAE_20(j)=mean(abs(obs-turbine_time_series(1,i).data{2,2}(good_idx{i})))
                WRF_d1_pearson_20(j)=corr(obs,turbine_time_series(1,i).data{2,2}(good_idx{i}), 'Type', 'Pearson');
                WRF_d1_spearman_rank_correltion_20(j)=corr(obs,turbine_time_series(1,i).data{2,2}(good_idx{i}), 'Type', 'Spearman');
            end
           end
        end
        for dummy=1:length(analogs_lead_times_d1)
             lead_time_match_idx(dummy)=find(analogs_lead_times_d1(dummy)==analogs_lead_times_d3)        
        end
    end
             mtx_nmae(:,:,1)=ETA_NMAE_20(:,analogs_lead_times_d3(lead_time_match_idx));mtx_nmae(:,:,2)=WRF_d3_NMAE_20(:,analogs_lead_times_d3(lead_time_match_idx));mtx_nmae(:,:,3)=WRF_d2_NMAE_20(:,analogs_lead_times_d2);mtx_nmae(:,:,4)=WRF_d1_NMAE_20(:,analogs_lead_times_d1)
             mtx_bias(:,:,1)=ETA_bias_20(:,analogs_lead_times_d3(lead_time_match_idx));mtx_bias(:,:,2)=WRF_d3_bias_20(:,analogs_lead_times_d3(lead_time_match_idx));mtx_bias(:,:,3)=WRF_d2_bias_20(:,analogs_lead_times_d2);mtx_bias(:,:,4)=WRF_d1_bias_20(:,analogs_lead_times_d1)
             mtx_rmse(:,:,1)=ETA_rmse_20(:,analogs_lead_times_d3(lead_time_match_idx));mtx_rmse(:,:,2)=WRF_d3_rmse_20(:,analogs_lead_times_d3(lead_time_match_idx));mtx_rmse(:,:,3)=WRF_d2_rmse_20(:,analogs_lead_times_d2);mtx_rmse(:,:,4)=WRF_d1_rmse_20(:,analogs_lead_times_d1)
             mtx_crmse(:,:,1)=      ETA_crmse_20(:,analogs_lead_times_d3(lead_time_match_idx));mtx_crmse(:,:,2)=WRF_d3_crmse_20(:,analogs_lead_times_d3(lead_time_match_idx));mtx_crmse(:,:,3)=WRF_d2_crmse_20(:,analogs_lead_times_d2);mtx_crmse(:,:,4)=WRF_d1_crmse_20(:,analogs_lead_times_d1)
             mtx_pearson(:,:,1)=ETA_pearson_20(:,analogs_lead_times_d3(lead_time_match_idx));mtx_pearson(:,:,2)=WRF_d3_pearson_20(:,analogs_lead_times_d3(lead_time_match_idx));mtx_pearson(:,:,3)=WRF_d2_pearson_20(:,analogs_lead_times_d2);mtx_pearson(:,:,4)=WRF_d1_pearson_20(:,analogs_lead_times_d1)
             mtx_spearman_rank_correltion(:,:,1)=ETA_spearman_rank_correltion_20(:,analogs_lead_times_d3(lead_time_match_idx));mtx_spearman_rank_correltion(:,:,2)=WRF_d3_spearman_rank_correltion_20(:,analogs_lead_times_d3(lead_time_match_idx));mtx_spearman_rank_correltion(:,:,3)=WRF_d2_spearman_rank_correltion_20(:,analogs_lead_times_d2);mtx_spearman_rank_correltion(:,:,4)=WRF_d1_spearman_rank_correltion_20(:,analogs_lead_times_d1)

        i=turbine_counter % to be changed i is tubine id and set to be the first as test!!!!!!
            subplot (4,5,16)
            plotmtx(:,:)=mtx_nmae(i,:,:);
            bar(plotmtx,'grouped');colormap('gray'); 
            grid on;ylabel('NMAE','fontsize',Namelist{7}.fontsize_sub_plot);
            xlabel('Leadtime','fontsize',Namelist{7}.fontsize_sub_plot);set(gca,'fontsize',Namelist{7}.fontsize_sub_plot,'ylim',[0.12 0.25],'xticklabel',analogs_lead_times_d3(lead_time_match_idx));

        subplot (4,5,17)
            plotmtx(:,:)=mtx_crmse(i,:,:);
            bar(plotmtx,'grouped');colormap('gray'); 
            grid on;ylabel('CRMSE','fontsize',Namelist{7}.fontsize_sub_plot);
            set(gca,'fontsize',Namelist{7}.fontsize_sub_plot,'ylim',[0.14 0.25],'xticklabel',analogs_lead_times_d3(lead_time_match_idx));

        subplot (4,5,18)
            plotmtx(:,:)=mtx_bias(i,:,:);
            bar(plotmtx,'grouped');colormap('gray'); 
            grid on;ylabel('BIAS','fontsize',Namelist{7}.fontsize_sub_plot);
            set(gca,'fontsize',Namelist{7}.fontsize_sub_plot,'ylim',[-0.04 0.02],'xticklabel',analogs_lead_times_d3(lead_time_match_idx));
            legend({'ETA','WRF-d3','WRF-d2','WRF-d1'},'location','southoutside')
            title('15 analogs WRF-ETA')

        subplot (4,5,19)
            plotmtx(:,:)=mtx_pearson(i,:,:);
            bar(plotmtx,'grouped');colormap('gray'); 
            grid on;ylabel('Cor pearson','fontsize',Namelist{7}.fontsize_sub_plot);
            set(gca,'fontsize',Namelist{7}.fontsize_sub_plot,'ylim',[0.45,0.75],'xticklabel',analogs_lead_times_d3(lead_time_match_idx));

        subplot (4,5,20)
            plotmtx(:,:)=mtx_spearman_rank_correltion(i,:,:);
            bar(plotmtx,'grouped');colormap('gray'); 
            grid on;ylabel('Spearman','fontsize',Namelist{7}.fontsize_sub_plot);
            set(gca,'fontsize',Namelist{7}.fontsize_sub_plot,'ylim',[0.45,0.75],'xticklabel',analogs_lead_times_d3(lead_time_match_idx));





        maximize
        save_dir=[Namelist{1}.stat_plot_dir,'\accuracy_nwp_turbine_vice_on_leadtimes']
        plot_filename=['\pearson_spearman_nmae_crmse_bias_on_nr_analogs_nwp_all_domaines_wrf_shear_turbine_',num2str(turbine_counter)]
                if isdir(save_dir)
                   saveas(gcf,[save_dir plot_filename] ,'fig')
                   saveas(gcf,[save_dir plot_filename] ,'jpeg')

                else
                    mkdir(save_dir)
                    saveas(gcf,[save_dir plot_filename] ,'fig')
                    saveas(gcf,[save_dir plot_filename] ,'jpeg')

                end
end % turbine Counter



