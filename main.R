
# Import functions --------------------------------------------------------

library(abc)
source("functions.R")



# Parameters --------------------------------------------------------------

path_sshfs <- "/Users/maudgautier/Documents/These/02_pandata_sshfs"
dir_simul <- "5_HFM1/Simulations_ABC_for_HFM1"
file_sum_stats <- "Results/Perform_ABC/Summary_statistics.txt"

# Biological experiment
dir_exp <- "5_HFM1/Sequencing_1/05_Analyses_of_Recombinants/02_Recombinants_and_False_Positives_Dataset"
file_recombinants <- "Recombinants_WT_dataset.txt"    


# Read simulations summary statistics -------------------------------------

# Get dataset
sum_stats <- read.table(paste(path_sshfs, dir_simul, file_sum_stats, 
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

