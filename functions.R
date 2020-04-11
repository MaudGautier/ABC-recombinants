
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
    
    return(res)
    
    # # Get max density
    # #names(dataset_simul_sum_stats[,col_params])
    # d <- apply(res$adj.values[,names(dataset_simul_sum_stats[,col_params])], 2, density)
    # # d$Param_ratio_CO_NCO$x[which.max(d$Param_ratio_CO_NCO$y)]
    # return(#c(lapply(d, function(dens) 10**dens$x[which.max(dens$y)]),
    #          apply(10**res$adj.values[,names(dataset_simul_sum_stats[,col_params])], 2, quantile, c(0.025,0.5,0.975)))
    #        #)
    #        

}

get_max_density_ABC <- function(dataset_simul_sum_stats,
                            experimental_summary_statistics, 
                            col_params, col_sum_stats) {
    
    # Perform abc
    abc_result <- perform_ABC(dataset_simul_sum_stats = sum_stats_simul, 
                              experimental_summary_statistics = sum_stats_exp,
                              col_params = col_parameters_simul,
                              col_sum_stats = col_sum_stats_simul)
    
    # Get max of density function for each parameter
    d <- apply(abc_result$adj.values[,names(dataset_simul_sum_stats[,col_params])], 
               2, density)
    return(t(as.matrix(lapply(d, function(dens) 10**dens$x[which.max(dens$y)]))))
    
}

get_CI_ABC <- function(dataset_simul_sum_stats,
                            experimental_summary_statistics, 
                            col_params, col_sum_stats) {
    
    # Perform abc
    abc_result <- perform_ABC(dataset_simul_sum_stats = sum_stats_simul, 
                              experimental_summary_statistics = sum_stats_exp,
                              col_params = col_parameters_simul,
                              col_sum_stats = col_sum_stats_simul)
    
    # Get 95% confidence interval
    return(apply(10**abc_result$adj.values[,names(dataset_simul_sum_stats[,col_params])], 
          2, quantile, c(0.025, 0.975)))
    
}


get_max_dens_and_CI_ABC <- function(dataset_simul_sum_stats,
                                    experimental_summary_statistics, 
                                    col_params, col_sum_stats) {
    
    # Perform abc
    abc_result <- perform_ABC(dataset_simul_sum_stats = sum_stats_simul, 
                              experimental_summary_statistics = sum_stats_exp,
                              col_params = col_parameters_simul,
                              col_sum_stats = col_sum_stats_simul)
    
    # Get max of density function for each parameter
    d <- apply(abc_result$adj.values[,names(dataset_simul_sum_stats[,col_params])], 
               2, density)
    max_dens <- t(as.matrix(lapply(d, function(dens) 10**dens$x[which.max(dens$y)])))
    rownames(max_dens) <- c("max.density")
    
    # Get 95% confidence interval
    CI <- apply(10**abc_result$adj.values[,names(dataset_simul_sum_stats[,col_params])], 
                 2, quantile, c(0.025, 0.975))
    
    # Return
    return(rbind(max_dens, CI))
    
}


create_sum_stats_of_experiment <- function(path_recomb_file) {
    
    
    # Load dataset
    recombinants <- read.table(path_recomb_file,
                               header = T, comment = "")
    
    # Extract Rec-1S and Rec-2S events
    Rec1S <- recombinants[which(recombinants$PRODUCT == "Rec-1S"),]
    Rec2S <- recombinants[which(recombinants$PRODUCT == "Rec-2S"),]
    
    # Get summary statistics
    Rec1S_Rec2S_ratio <- nrow(Rec1S)/nrow(Rec2S)
    
    quart_Rec1S <- quantile(Rec1S$TRACT_LENGTH, c(0.25,0.50,0.75))
    quart_Rec2S <- quantile(Rec2S$TRACT_LENGTH, c(0.25,0.50,0.75))
    
    # Put in same order as in sum stats of col_sum_stats_simul
    sum_stats_exp <- c(Rec1S_Rec2S_ratio,
                       mean(Rec1S$TRACT_LENGTH),
                       quart_Rec1S,
                       mean(Rec2S$TRACT_LENGTH),
                       quart_Rec2S)
    names(sum_stats_exp) <- names(sum_stats_simul)[col_sum_stats_simul]
    
    return (sum_stats_exp)
}