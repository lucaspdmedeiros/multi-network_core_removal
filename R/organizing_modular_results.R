#-----------------------------------------------------------------------------------------------------#

# Description:
#   Organizing results from MODULAR into csv files.
# Returns:
#   Returns 4 csv files containing modularity values for different subnetwork species removal simulations.

# general core
output_gen = read.table("output/data/core_species_removal/modularity/OUT_MOD_gen_core.txt", 
                          header = TRUE)
mod_ref_gen = output_gen$Modularity[1]
output_gen_random = output_gen[-1, ] # removing the core removal modularity value
mod_gen_random = output_gen_random$Modularity
length(mod_gen_random)
# saving
write.csv(mod_gen_random, 
          file = "output/data/core_species_removal/modularity/modularity_gen_core_random.csv",
          row.names = FALSE)

# pollination core
output_pol = read.table("output/data/core_species_removal/modularity/OUT_MOD_pol_core.txt", 
                        header = TRUE)
mod_ref_pol = output_pol$Modularity[1]
output_pol_random = output_pol[-1, ] # removing the core removal modularity value
mod_pol_random = output_pol_random$Modularity
length(mod_pol_random)
# saving
write.csv(mod_pol_random, 
          file = "output/data/core_species_removal/modularity/modularity_pol_core_random.csv",
          row.names = FALSE)

# ant core
output_ant = read.table("output/data/core_species_removal/modularity/OUT_MOD_ant_core.txt", 
                        header = TRUE)
mod_ref_ant = output_ant$Modularity[1]
output_ant_random = output_ant[-1, ] # removing the core removal modularity value
mod_ant_random = output_ant_random$Modularity
length(mod_ant_random)
# saving
write.csv(mod_ant_random, 
          file = "output/data/core_species_removal/modularity/modularity_ant_core_random.csv",
          row.names = FALSE)

# dispersal core
output_disp = read.table("output/data/core_species_removal/modularity/OUT_MOD_disp_core.txt", 
                        header = TRUE)
mod_ref_disp = output_disp$Modularity[1]
output_disp_random = output_disp[-1, ] # removing the core removal modularity value
mod_disp_random = output_disp_random$Modularity
length(mod_disp_random)
# saving
write.csv(mod_disp_random, 
          file = "output/data/core_species_removal/modularity/modularity_disp_core_random.csv",
          row.names = FALSE)

#-----------------------------------------------------------------------------------------------------#