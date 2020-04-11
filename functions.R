
perform_ABC <- function(dataset_simul_sum_stats,
                        experimental_summary_statistics, 
                        col_params, col_sum_stats) 
{
    # Get log10 of biological targets
    targets <- log10(experimental_summary_statistics)
    
    # Get log10 of simulation parameters and statistics
    summary_stats <- log10(dataset_simul_sum_stats[, col_sum_stats])
    parameters <- log10(dataset_simul_sum_stats[, col_params])
    
    # Run ABC
    res<-abc(target=targets,
             param=parameters,
             sumstat=summary_stats,
             tol=.05,
             method="loclinear")
    
    # Get max density

specify_decimal <- function(x, k) trimws(format(round(x, k), nsmall=k))

    #names(dataset_simul_sum_stats[,col_params])
    d <- apply(res$adj.values[,names(dataset_simul_sum_stats[,col_params])], 2, density)
    # d$Param_ratio_CO_NCO$x[which.max(d$Param_ratio_CO_NCO$y)]
    return(lapply(d, function(dens) 10**dens$x[which.max(dens$y)]))

log10_no_queues_WT <- function(DATASET)
{
    #210.0278 101.616 38  126 311 56.0  83.0  124.5
    
    # Put params in dataframes
    targets <-c(log10(2.0020263424518743), 
                log10(210.0278), 
                log10(101.616), 
                log10(38),
                log10(126),
                log10(311),
                log10(56),
                log10(83),
                log10(124.5)
    )
    summary_stats <- data.frame(ratio_CO_NCO = log10(DATASET$Ratio_CO_NCO),
                                Mean_CO = log10(DATASET$Obs_mean_l_CO),
                                Mean_NCO = log10(DATASET$Obs_mean_l_NCO),
                                CO_25 = log10(DATASET$CO_25),
                                CO_50 = log10(DATASET$CO_50),
                                CO_75 = log10(DATASET$CO_75),
                                NCO_25 = log10(DATASET$NCO_25),
                                NCO_50 = log10(DATASET$NCO_50),
                                NCO_75 = log10(DATASET$NCO_75)
    )
    parameters <- data.frame(par_ratio_CO_NCO = log10(sum_stats$Param_ratio_CO_NCO),
                             par_mean_l_CO = log10(sum_stats$Param_mean_l_CO),
                             par_mean_sd_CO = log10(sum_stats$Param_sd_l_CO),
                             par_mean_l_NCO = log10(sum_stats$Param_mean_l_NCO),
                             par_mean_sd_NCO = log10(sum_stats$Param_sd_l_NCO))


    # Run ABC
    res<-abc(target=targets,
             param=parameters,
             sumstat=summary_stats,
             tol=.05,
             method="loclinear")
    
    
    
    # Get max values
    dens1 <- density(res$adj.values[,1])
    dens2 <- density(res$adj.values[,2])
    dens3 <- density(res$adj.values[,3])
    dens4 <- density(res$adj.values[,4])
    dens5 <- density(res$adj.values[,5])
    
    return(c(10**dens1$x[which.max(dens1$y)],
             10**dens2$x[which.max(dens2$y)],
             10**dens3$x[which.max(dens3$y)],
             10**dens4$x[which.max(dens4$y)],
             10**dens5$x[which.max(dens5$y)]
    ))
}

