#-----------------------------------------------------------------------------------------------------#

# Description:
#   Calculates z-scores for nestedness and modularity for both core species and core links rarefaction
#   simulations.
#   Returns:
#   A csv file containing all z-scores calculated.

# NODF - species removal
# general core removal
NODF_gen_core = read.csv("output/data/core_species_removal/nestedness/NODF_general_core_removal.csv")
# plant-pollinator subnetwork core removal
NODF_pol_core = read.csv("output/data/core_species_removal/nestedness/NODF_pollination_core_removal.csv")
# plant-ant subnetwork core removal
NODF_ant_core = read.csv("output/data/core_species_removal/nestedness/NODF_ant_core_removal.csv")
# seed-dispersal subnetwork core removal
NODF_disp_core = read.csv("output/data/core_species_removal/nestedness/NODF_disp_core_removal.csv")
# data frame with all NODF data
NODF_sp_all = data.frame(NODF = c(NODF_gen_core[3:nrow(NODF_gen_core), 1], NODF_pol_core[3:nrow(NODF_pol_core), 1],
                                  NODF_ant_core[3:nrow(NODF_ant_core), 1], NODF_disp_core[3:nrow(NODF_disp_core), 1]), 
                         subnetwork = rep(c("gen", "pol", "ant", "disp"), each = 100))
# mean of random removal
mean_random_sp_NODF = tapply(NODF_sp_all$NODF, NODF_sp_all$subnetwork, mean)
mean_random_sp_NODF = mean_random_sp_NODF[c("gen", "pol", "ant", "disp")]
# standard deviation of random removal
sd_random_sp_NODF = tapply(NODF_sp_all$NODF, NODF_sp_all$subnetwork, sd)
sd_random_sp_NODF = sd_random_sp_NODF[c("gen", "pol", "ant", "disp")]
# core species removal
core_sp_removal_NODF = c(NODF_gen_core[2, 1], NODF_pol_core[2, 1], NODF_ant_core[2, 1], NODF_disp_core[2, 1])
# z-score
z_score_sp_NODF = (core_sp_removal_NODF - mean_random_sp_NODF)/sd_random_sp_NODF

# NODF - link removal
# general core links removed
NODF_gen_links = read.csv("output/data/core_links_removal/nestedness/NODF_general_links_random.csv")
# plant-pollinator subnetwork core links removed
NODF_pol_links = read.csv("output/data/core_links_removal/nestedness/NODF_pollination_links_random.csv")
# plant-ant subnetwork core links removed
NODF_ant_links = read.csv("output/data/core_links_removal/nestedness/NODF_ant_links_random.csv")
# seed-dispersal subnetwork core links removed
NODF_disp_links = read.csv("output/data/core_links_removal/nestedness/NODF_dispersal_links_random.csv")
# data frame with all NODF data
NODF_links_all = data.frame(NODF = rbind(NODF_gen_links, NODF_pol_links, NODF_ant_links, NODF_disp_links), 
                            subnetwork = rep(c("gen", "pol", "ant", "disp"), each = 100))
# mean of random removal
mean_random_links_NODF = tapply(NODF_links_all$x, NODF_links_all$subnetwork, mean)
mean_random_links_NODF = mean_random_links_NODF[c("gen", "pol", "ant", "disp")]
# standard deviation of random removal
sd_random_links_NODF = tapply(NODF_links_all$x, NODF_links_all$subnetwork, sd)
sd_random_links_NODF = sd_random_links_NODF[c("gen", "pol", "ant", "disp")]
# core links removal
core_links_removal_NODF = read.csv("output/data/core_links_removal/nestedness/nestedness_links_removal_p_values.csv")$NODF_core_removed
# z-score
z_score_links_NODF = (core_links_removal_NODF - mean_random_links_NODF)/sd_random_links_NODF

# modularity - species removal
# general core removal
mod_gen_core = read.csv("output/data/core_species_removal/modularity/modularity_gen_core_sp_random.csv")
# plant-pollinator subnetwork core removal
mod_pol_core = read.csv("output/data/core_species_removal/modularity/modularity_pol_core_sp_random.csv")
# plant-ant subnetwork core removal
mod_ant_core = read.csv("output/data/core_species_removal/modularity/modularity_ant_core_sp_random.csv")
# seed-dispersal subnetwork core removal
mod_disp_core = read.csv("output/data/core_species_removal/modularity/modularity_disp_core_sp_random.csv")
# data frame with all modularity data
mod_sp_all = data.frame(mod = rbind(mod_gen_core, mod_pol_core, mod_ant_core, mod_disp_core), 
                        subnetwork = rep(c("gen", "pol", "ant", "disp"), each = 100))
# mean of random removal
mean_random_sp_mod = tapply(mod_sp_all$x, mod_sp_all$subnetwork, mean)
mean_random_sp_mod = mean_random_sp_mod[c("gen", "pol", "ant", "disp")]
# standard deviation of random removal
sd_random_sp_mod = tapply(mod_sp_all$x, mod_sp_all$subnetwork, sd)
sd_random_sp_mod = sd_random_sp_mod[c("gen", "pol", "ant", "disp")]
# core species removal
core_sp_removal_mod = read.csv("output/data/core_species_removal/modularity/modularity_core_sp_removal_p_values.csv")$modularity
# z-score
z_score_sp_mod = (core_sp_removal_mod - mean_random_sp_mod)/sd_random_sp_mod

# modularity - link removal
# general core links removal
mod_gen_core_links = read.csv("output/data/core_links_removal/modularity/modularity_gen_core_links_random.csv")
# plant-pollinator subnetwork core links removal
mod_pol_core_links = read.csv("output/data/core_links_removal/modularity/modularity_pol_core_links_random.csv")
# plant-ant subnetwork core links removal
mod_ant_core_links = read.csv("output/data/core_links_removal/modularity/modularity_ant_core_links_random.csv")
# seed-dispersal subnetwork core links removal
mod_disp_core_links = read.csv("output/data/core_links_removal/modularity/modularity_disp_core_links_random.csv")
# data frame with all modularity data
mod_links_all = data.frame(mod = rbind(mod_gen_core_links, mod_pol_core_links, mod_ant_core_links, mod_disp_core_links), 
                           subnetwork = rep(c("gen", "pol", "ant", "disp"), each = 100))
# mean of random removal
mean_random_links_mod = tapply(mod_links_all$x, mod_links_all$subnetwork, mean)
mean_random_links_mod = mean_random_links_mod[c("gen", "pol", "ant", "disp")]
# standard deviation of random removal
sd_random_links_mod = tapply(mod_links_all$x, mod_links_all$subnetwork, sd)
sd_random_links_mod = sd_random_links_mod[c("gen", "pol", "ant", "disp")]
# core links removal
core_links_removal_mod = read.csv("output/data/core_links_removal/modularity/modularity_core_links_removal_p_values.csv")$modularity
# z-score
z_score_links_mod = (core_links_removal_mod - mean_random_links_mod)/sd_random_links_mod

# saving z-scores results
df_results = data.frame(z_score_sp_NODF, z_score_links_NODF, z_score_sp_mod, z_score_links_mod, 
                        row.names = c("general core", "pollination core", "ant core", "dispersal core"))
write.csv(df_results, file = "output/data/z-scores_nestedness_modularity.csv")

#-----------------------------------------------------------------------------------------------------#