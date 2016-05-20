#-----------------------------------------------------------------------------------------------------#

# Description:
#   Removes links between species from the general core and the core of each subnetwork (pollination, 
#   ant and seed-dispersal) and saves the rarefied interaction matrix. Then, removes the same number 
#   of core links from the complete network and from each of the subnetworks 100 times for each and 
#   saves the rarefied interaction matrices.
# Returns:
#   Generate and saves 404 rarefied interaction matrices. 

source("R/RemoveLinksSubnetwork.R")

# reading data
mat = as.matrix(read.table("data/complete_network.txt")) # reading interaction matrix
links_total = sum(mat)
core_plants = read.csv("output/data/core_plants_sub.csv") # reading data on plant sp
core_animals = read.csv("output/data/core_animals_sub.csv") # reading data on animal sp

# general core
id_plants_gen_core = which(core_plants$general_core == 1)
id_animals_gen_core = which(core_animals$general_core == 1)
links_gen_core = sum(mat[id_plants_gen_core, id_animals_gen_core])
mat_no_gen_core = mat
mat_no_gen_core[id_plants_gen_core, id_animals_gen_core] = 0
sum(mat_no_gen_core)
# save matrix without general core links
write.table(mat_no_gen_core, 
            "output/data/core_links_removal/mats_gen_core/net_no_general_core_links.txt",
            row.names = FALSE, col.names = FALSE)
# rarefaction simulation
s = 100
sub_id_plants_gen = rep(1, nrow(mat)) # defining the subnetwork, namely the complete network
sub_id_animals_gen = rep(1, ncol(mat)) # defining the subnetwork, namely the complete network
mat_list = RemoveLinksSubnetwork(s, l = links_gen_core, mat, sub_id_plants_gen, sub_id_animals_gen)
# save ensemble of rarefied matrices
for (i in 1:s)
  write.table(mat_list[[i]], paste("output/data/core_links_removal/mats_gen_core/",
                                   "net_random_links_general_core_", i, ".txt", sep = ""),
              row.names = FALSE, col.names = FALSE)

# plant-pollinator subnetwork core
id_plants_pol_core = which(core_plants$pollination_core == 1)
id_animals_pol_core = which(core_animals$pollination_core == 1)
links_pol_core = sum(mat[id_plants_pol_core, id_animals_pol_core])
mat_no_pol_core = mat
mat_no_pol_core[id_plants_pol_core, id_animals_pol_core] = 0
sum(mat_no_pol_core)
# save matrix without general core links
write.table(mat_no_pol_core, 
            "output/data/core_links_removal/mats_pol_core/net_no_pollination_core_links.txt",
            row.names = FALSE, col.names = FALSE)
# rarefaction simulation
s = 100
sub_id_plants_pol = core_plants$pol_subnetwork # defining the subnetwork
sub_id_animals_pol = core_animals$pol_subnetwork # defining the subnetwork
mat_list = RemoveLinksSubnetwork(s, l = links_pol_core, mat, sub_id_plants_pol, sub_id_animals_pol)
# save ensemble of rarefied matrices
for (i in 1:s) 
  write.table(mat_list[[i]], paste("output/data/core_links_removal/mats_pol_core/",
                                   "net_random_links_pollination_core_", i, ".txt", sep = ""),
              row.names = FALSE, col.names = FALSE)

# plant-ant subnetwork core
id_plants_ant_core = which(core_plants$ant_core == 1)
id_animals_ant_core = which(core_animals$ant_core == 1)
links_ant_core = sum(mat[id_plants_ant_core, id_animals_ant_core])
mat_no_ant_core = mat
mat_no_ant_core[id_plants_ant_core, id_animals_ant_core] = 0
sum(mat_no_ant_core)
# save matrix without plant-ant subnetwork core
write.table(mat_no_ant_core, 
            "output/data/core_links_removal/mats_ant_core/net_no_ant_core_links.txt",
            row.names = FALSE, col.names = FALSE)
# rarefaction simulation
s = 100
sub_id_plants_ant = core_plants$ant_subnetwork # defining the subnetwork
sub_id_animals_ant = core_animals$ant_subnetwork # defining the subnetwork
mat_list = RemoveLinksSubnetwork(s, l = links_ant_core, mat, sub_id_plants_ant, sub_id_animals_ant)
# save ensemble of rarefied matrices
for (i in 1:s) 
  write.table(mat_list[[i]], paste("output/data/core_links_removal/mats_ant_core/",
                                   "net_random_links_ant_core_", i, ".txt", sep = ""),
              row.names = FALSE, col.names = FALSE)

# plants-seed-disperser subnetwork core
id_plants_disp_core = which(core_plants$dispersal_core == 1)
id_animals_disp_core = which(core_animals$dispersal_core == 1)
links_disp_core = sum(mat[id_plants_disp_core, id_animals_disp_core])
mat_no_disp_core = mat
mat_no_disp_core[id_plants_disp_core, id_animals_disp_core] = 0
sum(mat_no_disp_core)
# save matrix without plant-seed-disperser subnetwork core
write.table(mat_no_disp_core, 
            "output/data/core_links_removal/mats_disp_core/net_no_dispersal_core_links.txt",
            row.names = FALSE, col.names = FALSE)
# rarefaction simulation
s = 100
sub_id_plants_disp = core_plants$disp_subnetwork # defining the subnetwork
sub_id_animals_disp = core_animals$disp_subnetwork # defining the subnetwork
mat_list = RemoveLinksSubnetwork(s, l = links_disp_core, mat, sub_id_plants_disp, sub_id_animals_disp)
# save ensemble of rarefied matrices
for (i in 1:s) 
  write.table(mat_list[[i]], paste("output/data/core_links_removal/mats_disp_core/",
                                   "net_random_links_dispersal_core_", i, ".txt", sep = ""),
              row.names = FALSE, col.names = FALSE)

#-----------------------------------------------------------------------------------------------------#