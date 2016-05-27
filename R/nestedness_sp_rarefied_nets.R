#-----------------------------------------------------------------------------------------------------#

# Description:
#   Calculates nestedness of species-rarefied interaction matrices regarding general core, plant-pollinator 
#   subnetwork core, plant-ant subnetwork core, and plants-seed-disperser subnetwork core.
# Returns:
#   Saves tables containing the nestedness values for each of the 4 scenarios described above.

library(bipartite)

# complete matrix
mat = as.matrix(read.table("data/complete_network.txt"))
NODF_complete = nested(mat, method = "NODF2") 

# general core
mat_no_gen_core = as.matrix(read.table("output/data/core_species_removal/mats_gen_core/net_no_general_core.txt"))
NODF_no_gen_core = nested(mat_no_gen_core, method = "NODF2") 
NODF_gen_core_random = rep(NA, 100)
for (i in 1:100) {
  mat_gen_core_random = as.matrix(read.table(paste("output/data/core_species_removal/mats_gen_core/",
                                                   "net_random_general_core_", i, ".txt", sep = "")))
  NODF_gen_core_random[i] = nested(mat_gen_core_random, method = "NODF2") 
}
# saving
NODF_gen_core = as.numeric(c(NODF_complete, NODF_no_gen_core, NODF_gen_core_random))
write.csv(NODF_gen_core, "output/data/core_species_removal/nestedness/NODF_general_core_removal.csv",
          row.names = FALSE)
  
# plant-pollinator subnetwork core
mat_no_pol_core = as.matrix(read.table("output/data/core_species_removal/mats_pol_core/net_no_pollination_core.txt"))
NODF_no_pol_core = nested(mat_no_pol_core, method = "NODF2")
NODF_pol_core_random = rep(NA, 100)
for (i in 1:100) {
  mat_pol_core_random = as.matrix(read.table(paste("output/data/core_species_removal/mats_pol_core/",
                                                   "net_random_pollination_core_", i, ".txt", sep = "")))
  NODF_pol_core_random[i] = nested(mat_pol_core_random, method = "NODF2")
}
# saving  
NODF_pol_core = as.numeric(c(NODF_complete, NODF_no_pol_core, NODF_pol_core_random))
write.csv(NODF_pol_core, "output/data/core_species_removal/nestedness/NODF_pollination_core_removal.csv",
          row.names = FALSE)

# plant-ant subnetwork core
mat_no_ant_core = as.matrix(read.table("output/data/core_species_removal/mats_ant_core/net_no_ant_core.txt"))
NODF_no_ant_core = nested(mat_no_ant_core, method = "NODF2")
NODF_ant_core_random = rep(NA, 100)
for (i in 1:100) {
  mat_ant_core_random = as.matrix(read.table(paste("output/data/core_species_removal/mats_ant_core/",
                                                   "net_random_ant_core_", i, ".txt", sep = "")))
  NODF_ant_core_random[i] = nested(mat_ant_core_random, method = "NODF2")
}
# saving
NODF_ant_core = as.numeric(c(NODF_complete, NODF_no_ant_core, NODF_ant_core_random))
write.csv(NODF_ant_core, "output/data/core_species_removal/nestedness/NODF_ant_core_removal.csv",
          row.names = FALSE)
  
# plants-seed-disperser subnetwork core
mat_no_disp_core = as.matrix(read.table("output/data/core_species_removal/mats_disp_core/net_no_disp_core.txt"))
NODF_no_disp_core = nested(mat_no_disp_core, method = "NODF2")
NODF_disp_core_random = rep(NA, 100)
for (i in 1:100) {
  mat_disp_core_random = as.matrix(read.table(paste("output/data/core_species_removal/mats_disp_core/",
                                                    "net_random_disp_core_", i, ".txt", sep = "")))
  NODF_disp_core_random[i] = nested(mat_disp_core_random, method = "NODF2")
}
# saving
NODF_disp_core = as.numeric(c(NODF_complete, NODF_no_disp_core, NODF_disp_core_random))
write.csv(NODF_disp_core, "output/data/core_species_removal/nestedness/NODF_disp_core_removal.csv",
          row.names = FALSE)

#-----------------------------------------------------------------------------------------------------#