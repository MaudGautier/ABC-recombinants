
# Import functions --------------------------------------------------------

library(abc)
source("functions.R")



# Parameters --------------------------------------------------------------

path_sshfs <- "/Users/maudgautier/Documents/These/02_pandata_sshfs"

# Simulations
dir_simul <- "5_HFM1/Simulations_ABC_for_HFM1"
file_sum_stats <- "Results/Perform_ABC/Summary_statistics.txt"
col_sum_stats_simul <- c(11:12, 14:16, 18, 20:22)
col_parameters_simul <- 4:8

# Biological experiment
file_recombinants <- "5_HFM1/Sequencing_1/05_Analyses_of_Recombinants/02_Recombinants_and_False_Positives_Dataset/Recombinants_WT_dataset.txt"    


# Read simulations summary statistics -------------------------------------

sum_stats_simul <- read.table(paste(path_sshfs, dir_simul, file_sum_stats, 
                              sep = "/"),
                        header = T)



# Summarise results from biological experiment ----------------------------

path_recomb <- paste(path_sshfs, file_recombinants, 
                          sep = "/")
sum_stats_exp <- create_sum_stats_of_experiment(path_recomb_file = path_recomb) 

# Perform ABC -------------------------------------------------------------

# get_max_density_ABC(dataset_simul_sum_stats = sum_stats_simul, 
#                     experimental_summary_statistics = sum_stats_exp,
#                     col_params = col_parameters_simul,
#                     col_sum_stats = col_sum_stats_simul)
# get_CI_ABC(dataset_simul_sum_stats = sum_stats_simul, 
#            experimental_summary_statistics = sum_stats_exp,
#            col_params = col_parameters_simul,
#            col_sum_stats = col_sum_stats_simul)

get_max_dens_and_CI_ABC(dataset_simul_sum_stats = sum_stats_simul, 
                        experimental_summary_statistics = sum_stats_exp,
                        col_params = col_parameters_simul,
                        col_sum_stats = col_sum_stats_simul)

