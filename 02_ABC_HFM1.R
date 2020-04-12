
# Import functions and source libraries -----------------------------------

library(abc)
source("functions.R")



# Summary statistics for simulations --------------------------------------

# Parameters
file_sum_stats <- "./simulations/Summary_statistics.txt"
col_sum_stats_simul <- c(11:12, 14:16, 18, 20:22)
col_parameters_simul <- 4:8

sum_stats_simul <- read.table(file_sum_stats, header = T)



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



# Run ABC on MUTs and WTs (seq1 VS seq2) ----------------------------------


#### Open output file
dest_file <- "./output/Results_ABC_HFM1_Seq1_vs_Seq2.txt"
if(file.exists(dest_file)) file.remove(dest_file) # need empty file before append
fileConn<-file(dest_file, open='at')



#### Write samples
for (sample in c("MUT_seq1",
                 "MUT_seq2",
                 "WT_seq1",
                 "WT_seq2")) {
    
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



