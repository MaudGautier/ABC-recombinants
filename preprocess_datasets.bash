cd /Users/maudgautier/Documents/These/R_projects/07_Github_R_projects/ABC-recombinants

# SEQ 2
cp /Users/maudgautier/Documents/These/02_pandata_sshfs/5_HFM1/Sequencing_2/06_Analyses_of_Recombinants/02_Recombinants_and_False_Positives_Dataset/Recombinants_MUT_dataset.txt ./data/MUT_seq2.txt
cp /Users/maudgautier/Documents/These/02_pandata_sshfs/5_HFM1/Sequencing_2/06_Analyses_of_Recombinants/02_Recombinants_and_False_Positives_Dataset/Recombinants_WT_dataset.txt ./data/WT_seq2.txt

# SEQ 1
cp /Users/maudgautier/Documents/These/02_pandata_sshfs/5_HFM1/Sequencing_1/05_Analyses_of_Recombinants/02_Recombinants_and_False_Positives_Dataset/Recombinants_MUT_dataset.txt ./data/MUT_seq1.txt
cp /Users/maudgautier/Documents/These/02_pandata_sshfs/5_HFM1/Sequencing_1/05_Analyses_of_Recombinants/02_Recombinants_and_False_Positives_Dataset/Recombinants_WT_dataset.txt ./data/WT_seq1.txt

# Extract each sample individually
(head -n1 ./data/WT_seq1.txt && grep S28355 ./data/WT_seq1.txt) > ./data/WT_S28355.txt
(head -n1 ./data/WT_seq1.txt && grep S28371 ./data/WT_seq1.txt) > ./data/WT_S28371.txt

(head -n1 ./data/MUT_seq1.txt && grep S28353 ./data/MUT_seq1.txt) > ./data/MUT_S28353.txt
(head -n1 ./data/MUT_seq1.txt && grep S28367 ./data/MUT_seq1.txt) > ./data/MUT_S28367.txt

(head -n1 ./data/WT_seq2.txt && grep S28359 ./data/WT_seq2.txt) > ./data/WT_S28359.txt
(head -n1 ./data/WT_seq2.txt && grep S28377 ./data/WT_seq2.txt) > ./data/WT_S28377.txt

(head -n1 ./data/MUT_seq2.txt && grep S28347 ./data/MUT_seq2.txt) > ./data/MUT_S28347.txt
(head -n1 ./data/MUT_seq2.txt && grep S28364 ./data/MUT_seq2.txt) > ./data/MUT_S28364.txt

# Combine all MUT and all WT
(cat ./data/MUT_seq1.txt && tail -n +1 ./data/MUT_seq2.txt) > ./data/MUT_ALL.txt
(cat ./data/WT_seq1.txt && tail -n +1 ./data/WT_seq2.txt) > ./data/WT_ALL.txt



