
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
write(capture.output(
    get_max_dens_and_CI_ABC(dataset_simul_sum_stats = sum_stats_simul, 
                        experimental_summary_statistics = sum_stats_exp,
                        col_params = col_parameters_simul,
                        col_sum_stats = col_sum_stats_simul)
    ), file = fileConn, append=TRUE )


#### Seq1-MUT
write("\n\nSeq1-MUT (S28353, S28367)", file = fileConn)

# Summary statistics for biological experiment
file_recombinants <- "5_HFM1/Sequencing_1/05_Analyses_of_Recombinants/02_Recombinants_and_False_Positives_Dataset/Recombinants_MUT_dataset.txt"    
path_recomb <- paste(path_sshfs, file_recombinants, sep = "/")
sum_stats_exp <- create_sum_stats_of_experiment(path_recomb_file = path_recomb) 

# Perform ABC
write(capture.output(
    get_max_dens_and_CI_ABC(dataset_simul_sum_stats = sum_stats_simul, 
                            experimental_summary_statistics = sum_stats_exp,
                            col_params = col_parameters_simul,
                            col_sum_stats = col_sum_stats_simul)
), file = fileConn, append=TRUE )



#### Seq2-WT
write("\n\nSeq2-WT (S28359, S28377)", file = fileConn)

# Summary statistics for biological experiment
file_recombinants <- "5_HFM1/Sequencing_2/06_Analyses_of_Recombinants/02_Recombinants_and_False_Positives_Dataset/Recombinants_WT_dataset.txt"    
path_recomb <- paste(path_sshfs, file_recombinants, sep = "/")
sum_stats_exp <- create_sum_stats_of_experiment(path_recomb_file = path_recomb) 

# Perform ABC
write(capture.output(
    get_max_dens_and_CI_ABC(dataset_simul_sum_stats = sum_stats_simul, 
                            experimental_summary_statistics = sum_stats_exp,
                            col_params = col_parameters_simul,
                            col_sum_stats = col_sum_stats_simul)
), file = fileConn, append=TRUE )



#### Seq2-MUT
write("\n\nSeq2-MUT (S28347, S28364)", file = fileConn)

# Summary statistics for biological experiment
file_recombinants <- "5_HFM1/Sequencing_2/06_Analyses_of_Recombinants/02_Recombinants_and_False_Positives_Dataset/Recombinants_MUT_dataset.txt"    
path_recomb <- paste(path_sshfs, file_recombinants, sep = "/")
sum_stats_exp <- create_sum_stats_of_experiment(path_recomb_file = path_recomb) 

# Perform ABC
write(capture.output(
    get_max_dens_and_CI_ABC(dataset_simul_sum_stats = sum_stats_simul, 
                            experimental_summary_statistics = sum_stats_exp,
                            col_params = col_parameters_simul,
                            col_sum_stats = col_sum_stats_simul)
), file = fileConn, append=TRUE )



#### Close output file
close(fileConn)

file.show(dest_file)



# Run ABC on all individual samples ---------------------------------------


#### Open output file
dest_file <- "./output/Results_ABC_HFM1_per_sample.txt"
if(file.exists(dest_file)) file.remove(dest_file) # need empty file before append
fileConn<-file(dest_file, open='at')



#### Write samples
for (sample in c("MUT_S28347",
                 "MUT_S28353",
                 "MUT_S28364",
                 "MUT_S28367",
                 "WT_S28355",
                 "WT_S28359",
                 "WT_S28371",
                 "WT_S28377")) {

# Summary statistics for biological experiment
path_recomb <- paste("./data/", sample, ".txt", sep="") 
nb_recomb <- nrow(read.table(path_recomb, header = T, comment = ""))
sum_stats_exp <- create_sum_stats_of_experiment(path_recomb_file = path_recomb) 

# Write output
write(paste("\n\n", sample, "( N = ", nb_recomb, ")"), file = fileConn)

# Perform ABC
write(capture.output(
    get_max_dens_and_CI_ABC(dataset_simul_sum_stats = sum_stats_simul, 
                            experimental_summary_statistics = sum_stats_exp,
                            col_params = col_parameters_simul,
                            col_sum_stats = col_sum_stats_simul)
), file = fileConn, append=TRUE )

}

#### Close output file
close(fileConn)

file.show(dest_file)



# Run ABC on all MUTs and all WTs -----------------------------------------


#### Open output file
dest_file <- "./output/Results_ABC_HFM1_MUTs_vs_WT.txt"
if(file.exists(dest_file)) file.remove(dest_file) # need empty file before append
fileConn<-file(dest_file, open='at')



#### Write samples
for (sample in c("MUT_ALL",
                 "WT_ALL")) {
    
    # Summary statistics for biological experiment
    path_recomb <- paste("./data/", sample, ".txt", sep="") 
    nb_recomb <- nrow(read.table(path_recomb, header = T, comment = ""))
    sum_stats_exp <- create_sum_stats_of_experiment(path_recomb_file = path_recomb) 
    
    # Write output
    write(paste("\n\n", sample, "( N = ", nb_recomb, ")"), file = fileConn)
    
    # Perform ABC
    write(capture.output(
        get_max_dens_and_CI_ABC(dataset_simul_sum_stats = sum_stats_simul, 
                                experimental_summary_statistics = sum_stats_exp,
                                col_params = col_parameters_simul,
                                col_sum_stats = col_sum_stats_simul)
    ), file = fileConn, append=TRUE )
    
}

#### Close output file
close(fileConn)

file.show(dest_file)



