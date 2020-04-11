
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
    #names(dataset_simul_sum_stats[,col_params])
    d <- apply(res$adj.values[,names(dataset_simul_sum_stats[,col_params])], 2, density)
    # d$Param_ratio_CO_NCO$x[which.max(d$Param_ratio_CO_NCO$y)]
    return(lapply(d, function(dens) 10**dens$x[which.max(dens$y)]))

}
