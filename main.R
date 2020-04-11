
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
dir_exp <- "5_HFM1/Sequencing_1/05_Analyses_of_Recombinants/02_Recombinants_and_False_Positives_Dataset"
file_recombinants <- "Recombinants_WT_dataset.txt"    


# Read simulations summary statistics -------------------------------------

sum_stats_simul <- read.table(paste(path_sshfs, dir_simul, file_sum_stats, 
                              sep = "/"),
                        header = T)



# Summarise results from biological experiment ----------------------------

# Load dataset
recombinants <- read.table(paste(path_sshfs, dir_exp, file_recombinants, 
                                 sep = "/"),
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


# Perform ABC -------------------------------------------------------------


source("functions.R")
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

