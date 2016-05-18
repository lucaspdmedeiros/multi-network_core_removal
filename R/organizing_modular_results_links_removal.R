#-----------------------------------------------------------------------------------------------------#

# Description:
#   Organizing results from MODULAR for links removal simulations into csv files. 
#   Calculating p value for modularity.
# Returns:
#   Returns 5 csv files. The first 4 files contain modularity values for different subnetwork species 
#   removal simulations. The 5th file contains the modularity values for core sp removal and the p values.

# general core
output_gen = read.table("output/data/core_links_removal/modularity/OUT_MOD_gen_core_links.txt", 
                        header = TRUE)
mod_ref_gen = output_gen$Modularity[1]
output_gen_random = output_gen[-1, ] # removing the core removal modularity value
mod_gen_random = output_gen_random$Modularity
length(mod_gen_random)
# calculating p value
p_gen = sum(mod_gen_random > mod_ref_gen)/length(mod_gen_random)
# saving
write.csv(mod_gen_random, 
          file = "output/data/core_links_removal/modularity/modularity_gen_core_links_random.csv",
          row.names = FALSE)

# pollination core
output_pol = read.table("output/data/core_links_removal/modularity/OUT_MOD_pol_core_links.txt", 
                        header = TRUE)
mod_ref_pol = output_pol$Modularity[1]
output_pol_random = output_pol[-1, ] # removing the core removal modularity value
mod_pol_random = output_pol_random$Modularity
length(mod_pol_random)
# calculating p value
p_pol = sum(mod_pol_random > mod_ref_pol)/length(mod_pol_random)
# saving
write.csv(mod_pol_random, 
          file = "output/data/core_links_removal/modularity/modularity_pol_core_links_random.csv",
          row.names = FALSE)

# ant core
output_ant = read.table("output/data/core_links_removal/modularity/OUT_MOD_ant_core_links.txt", 
                        header = TRUE)
mod_ref_ant = output_ant$Modularity[1]
output_ant_random = output_ant[-1, ] # removing the core removal modularity value
mod_ant_random = output_ant_random$Modularity
length(mod_ant_random)
# calculating p value
p_ant = sum(mod_ant_random > mod_ref_ant)/length(mod_ant_random)
# saving
write.csv(mod_ant_random, 
          file = "output/data/core_links_removal/modularity/modularity_ant_core_links_random.csv",
          row.names = FALSE)

# dispersal core
output_disp = read.table("output/data/core_links_removal/modularity/OUT_MOD_disp_core_links.txt", 
                         header = TRUE)
mod_ref_disp = output_disp$Modularity[1]
output_disp_random = output_disp[-1, ] # removing the core removal modularity value
mod_disp_random = output_disp_random$Modularity
length(mod_disp_random)
# calculating p value
p_disp = sum(mod_disp_random > mod_ref_disp)/length(mod_disp_random)
# saving
write.csv(mod_disp_random, 
          file = "output/data/core_links_removal/modularity/modularity_disp_core_links_random.csv",
          row.names = FALSE)

# saving values of modularity for core species removal
p_values_mod = data.frame(subnetwork = c("general", "pollination", "ant", "dispersal"),
                          modularity = c(mod_ref_gen, mod_ref_pol, mod_ref_ant, mod_ref_disp),
                          p_value  = c(p_gen, p_pol, p_ant, p_disp))
# saving
write.csv(p_values_mod, 
          file = "output/data/core_links_removal/modularity/modularity_core_links_removal_p_values.csv",
          row.names = FALSE)

#-----------------------------------------------------------------------------------------------------#