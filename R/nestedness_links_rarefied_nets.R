#-----------------------------------------------------------------------------------------------------#

# Description:
#   Calculates nestedness of link-rarefied interaction matrices regarding general core, plant-pollinator 
#   subnetwork core, plant-ant subnetwork core, and plants-seed-disperser subnetwork core.
#   Calculates the p values by comparing networks with core links removed and networks with randomly
#   removed links.
# Returns:
#   Saves tables containing the nestedness values for each of the 4 scenarios described above and a
#   table containing observed nestedness values and p values.

library(bipartite)

# complete matrix
mat = as.matrix(read.table("data/complete_network.txt"))
NODF_complete = nested(mat, method = "NODF2") 

# general core links removed
mat_no_gen_core_links = as.matrix(read.table("output/data/core_links_removal/mats_gen_core/net_no_general_core_links.txt"))
NODF_no_gen_core_links = nested(mat_no_gen_core_links, method = "NODF2") 
NODF_gen_core_links_random = rep(NA, 100)
for (i in 1:100) {
  mat_gen_core_links_random = as.matrix(read.table(paste("output/data/core_links_removal/mats_gen_core/",
                                                   "net_random_links_general_core_", i, ".txt", sep = "")))
  NODF_gen_core_links_random[i] = nested(mat_gen_core_links_random, method = "NODF2") 
}
# p value
p_gen = sum(NODF_gen_core_links_random < NODF_no_gen_core_links)/length(NODF_gen_core_links_random)
# saving
write.csv(NODF_gen_core_links_random, "output/data/core_links_removal/nestedness/NODF_general_links_random.csv",
          row.names = FALSE)

# pollination core links removed
mat_no_pol_core_links = as.matrix(read.table("output/data/core_links_removal/mats_pol_core/net_no_pollination_core_links.txt"))
NODF_no_pol_core_links = nested(mat_no_pol_core_links, method = "NODF2") 
NODF_pol_core_links_random = rep(NA, 100)
for (i in 1:100) {
  mat_pol_core_links_random = as.matrix(read.table(paste("output/data/core_links_removal/mats_pol_core/",
                                                         "net_random_links_pollination_core_", i, ".txt", sep = "")))
  NODF_pol_core_links_random[i] = nested(mat_pol_core_links_random, method = "NODF2") 
}
# p value
p_pol = sum(NODF_pol_core_links_random < NODF_no_pol_core_links)/length(NODF_pol_core_links_random)
# saving
write.csv(NODF_pol_core_links_random, "output/data/core_links_removal/nestedness/NODF_pollination_links_random.csv",
          row.names = FALSE)

# ant core links removed
mat_no_ant_core_links = as.matrix(read.table("output/data/core_links_removal/mats_ant_core/net_no_ant_core_links.txt"))
NODF_no_ant_core_links = nested(mat_no_ant_core_links, method = "NODF2") 
NODF_ant_core_links_random = rep(NA, 100)
for (i in 1:100) {
  mat_ant_core_links_random = as.matrix(read.table(paste("output/data/core_links_removal/mats_ant_core/",
                                                         "net_random_links_ant_core_", i, ".txt", sep = "")))
  NODF_ant_core_links_random[i] = nested(mat_ant_core_links_random, method = "NODF2") 
}
# p value
p_ant = sum(NODF_ant_core_links_random < NODF_no_ant_core_links)/length(NODF_ant_core_links_random)
# saving
write.csv(NODF_ant_core_links_random, "output/data/core_links_removal/nestedness/NODF_ant_links_random.csv",
          row.names = FALSE)

# dispersal core links removed
mat_no_disp_core_links = as.matrix(read.table("output/data/core_links_removal/mats_disp_core/net_no_dispersal_core_links.txt"))
NODF_no_disp_core_links = nested(mat_no_disp_core_links, method = "NODF2") 
NODF_disp_core_links_random = rep(NA, 100)
for (i in 1:100) {
  mat_disp_core_links_random = as.matrix(read.table(paste("output/data/core_links_removal/mats_disp_core/",
                                                         "net_random_links_dispersal_core_", i, ".txt", sep = "")))
  NODF_disp_core_links_random[i] = nested(mat_disp_core_links_random, method = "NODF2") 
}
# p value
p_disp = sum(NODF_disp_core_links_random < NODF_no_disp_core_links)/length(NODF_disp_core_links_random)
# saving
write.csv(NODF_disp_core_links_random, "output/data/core_links_removal/nestedness/NODF_dispersal_links_random.csv",
          row.names = FALSE)

# saving table with observed nestedness values and p values
results_df = data.frame(NODF_complete_net = rep(NODF_complete, 4), 
                        NODF_core_removed = c(NODF_no_gen_core_links, NODF_no_pol_core_links,
                                              NODF_no_ant_core_links, NODF_no_disp_core_links), 
                        p_value = c(p_gen, p_pol, p_ant, p_disp), 
                        subnetwork = c("general", "pollination", "ant", "dispersal"))
write.csv(results_df, file = "output/data/core_links_removal/nestedness/nestedness_links_removal_p_values.csv", 
          row.names = FALSE)

#-----------------------------------------------------------------------------------------------------#