
# Import functions --------------------------------------------------------

library(abc)
source("functions.R")



# Parameters --------------------------------------------------------------

path_sshfs <- "/Users/maudgautier/Documents/These/02_pandata_sshfs"
dir_simul <- "5_HFM1/Simulations_ABC_for_HFM1"
file_sum_stats <- "Results/Perform_ABC/Summary_statistics.txt"



# Read simulations summary statistics -------------------------------------

# Get dataset
sum_stats <- read.table(paste(path_sshfs, dir_simul, file_sum_stats, 
                              sep = "/"),
                        header = T)

head(sum_stats)
lapply(sum_stats, class)
