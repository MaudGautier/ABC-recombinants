
# Import functions and source libraries -----------------------------------

library(abc)
source("functions.R")
path_sshfs <- "/Users/maudgautier/Documents/These/02_pandata_sshfs"



# Summary statistics for simulations --------------------------------------

# Parameters
dir_simul <- "5_HFM1/Simulations_ABC_for_HFM1"
file_sum_stats <- "Results/Perform_ABC/Summary_statistics.txt"
col_sum_stats_simul <- c(11:12, 14:16, 18, 20:22)
col_parameters_simul <- 4:8

sum_stats_simul <- read.table(paste(path_sshfs, dir_simul, file_sum_stats, 
                              sep = "/"),
                        header = T)



# Run ABC on samples ------------------------------------------------------

#### Open output file
dest_file <- "Results_ABC_HFM1_per_pair.txt"
if(file.exists(dest_file)) file.remove(dest_file) # need empty file before append
fileConn<-file(dest_file, open='at')




#### Seq1-WT
write("Seq1-WT (S28355, S28371)", file = fileConn)

# Summary statistics for biological experiment
file_recombinants <- "5_HFM1/Sequencing_1/05_Analyses_of_Recombinants/02_Recombinants_and_False_Positives_Dataset/Recombinants_WT_dataset.txt"    
path_recomb <- paste(path_sshfs, file_recombinants, sep = "/")
sum_stats_exp <- create_sum_stats_of_experiment(path_recomb_file = path_recomb) 

# Perform ABC
                        experimental_summary_statistics = sum_stats_exp,
                        col_params = col_parameters_simul,
                        col_sum_stats = col_sum_stats_simul)

