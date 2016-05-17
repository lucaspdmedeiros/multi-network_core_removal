#-----------------------------------------------------------------------------------------------------#

# Description:
#   Calculates p values for each subnetwork and general core removal. 
# Returns:
#   Saves a table with the NODF values and the p values.

# general core removal
NODF_gen_core = read.csv("output/data/core_species_removal/nestedness/NODF_general_core_removal.csv")
# p value general core
p_gen = sum(NODF_gen_core[3:nrow(NODF_gen_core), 1] < NODF_gen_core[2, 1])/length(NODF_gen_core[3:nrow(NODF_gen_core), 1])
# plant-pollinator subnetwork core removal
NODF_pol_core = read.csv("output/data/core_species_removal/nestedness/NODF_pollination_core_removal.csv")
# p value pollination core
p_pol = sum(NODF_pol_core[3:nrow(NODF_pol_core), 1] < NODF_pol_core[2, 1])/length(NODF_pol_core[3:nrow(NODF_pol_core), 1])
# plant-ant subnetwork core removal
NODF_ant_core = read.csv("output/data/core_species_removal/nestedness/NODF_ant_core_removal.csv")
# p value ant core
p_ant = sum(NODF_ant_core[3:nrow(NODF_ant_core), 1] < NODF_ant_core[2, 1])/length(NODF_ant_core[3:nrow(NODF_ant_core), 1])
# seed-dispersal subnetwork core removal
NODF_disp_core = read.csv("output/data/core_species_removal/nestedness/NODF_disp_core_removal.csv")
# p value ant core
p_disp = sum(NODF_disp_core[3:nrow(NODF_disp_core), 1] < NODF_disp_core[2, 1])/length(NODF_disp_core[3:nrow(NODF_disp_core), 1])

# saving table with NODF values and p values
results_df = data.frame(NODF_complete_net = rep(NODF_gen_core[1, 1], 4), 
                        NODF_core_removed = c(NODF_gen_core[2, 1], NODF_pol_core[2, 1], 
                                              NODF_ant_core[2, 1], NODF_disp_core[2, 1]), 
                        p_value = c(p_gen, p_pol, p_ant, p_disp), 
                        subnetwork = c("general", "pollination", "ant", "dispersal"))
write.csv(results_df, file = "output/data/core_species_removal/nestedness/nestedness_p_values.csv", 
          row.names = FALSE)

#-----------------------------------------------------------------------------------------------------#