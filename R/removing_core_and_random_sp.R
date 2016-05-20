#-----------------------------------------------------------------------------------------------------#

# Description:
#   Removes species from the general core and the core of each subnetwork (pollination, ant and 
#   seed-dispersal) and saves the rarefied interaction matrix. Then, removes the same number of core 
#   species from the complete network and from each of the subnetworks 100 times for each and saves
#   the rarefied interaction matrices.
# Returns:
#   Generate and saves 404 rarefied interaction matrices. 

source("R/RemoveSpSubnetwork.R")

# reading data
mat = as.matrix(read.table("data/complete_network.txt")) # reading interaction matrix
core_plants = read.csv("output/data/core_plants_sub.csv") # reading data on plant sp
core_animals = read.csv("output/data/core_animals_sub.csv") # reading data on animal sp

# general core
id_plants_gen_core = which(core_plants$general_core == 1)
id_animals_gen_core = which(core_animals$general_core == 1)
mat_no_gen_core = mat[-id_plants_gen_core, -id_animals_gen_core] # removing general core
# save matrix without general core
write.table(mat_no_gen_core, 
            "output/data/core_species_removal/mats_gen_core/net_no_general_core.txt")
# rarefaction simulation
s = 100
n_plants_gen = length(id_plants_gen_core) # number of plant sp in the general core
n_animals_gen = length(id_animals_gen_core) # number of animal sp in the general core
sub_id_plants_gen = rep(1, nrow(mat)) # defining the subnetwork, namely the complete network
sub_id_animals_gen = rep(1, ncol(mat)) # defining the subnetwork, namely the complete network
mat_list = RemoveSpSubnetwork(s = 100, n_plants = n_plants_gen, n_animals = n_animals_gen,
                              mat = mat, sub_id_plants = sub_id_plants_gen,
                              sub_id_animals = sub_id_animals_gen)
# save ensemble of rarefied matrices
for (i in 1:s)
  write.table(mat_list[[i]], paste("output/data/core_species_removal/mats_gen_core/",
                                   "net_random_general_core_", i, ".txt", sep = ""))

# plant-pollinator subnetwork core
id_plants_pol_core = which(core_plants$pollination_core == 1)
id_animals_pol_core = which(core_animals$pollination_core == 1)
mat_no_pol_core = mat[-id_plants_pol_core, -id_animals_pol_core] # removing pollination core
# save matrix without plant-pollinator subnetwork core
write.table(mat_no_pol_core, "output/data/core_species_removal/mats_pol_core/net_no_pollination_core.txt")
# rarefaction simulation
s = 100
n_plants_pol = length(id_plants_pol_core) # number of plant sp in the pollination core
n_animals_pol = length(id_animals_pol_core) # number of animal sp in the pollination core
sub_id_plants_pol = core_plants$pol_subnetwork # defining the subnetwork
sub_id_animals_pol = core_animals$pol_subnetwork # defining the subnetwork
mat_list = RemoveSpSubnetwork(s, n_plants = n_plants_pol, n_animals = n_animals_pol,
                              mat, sub_id_plants = sub_id_plants_pol, 
                              sub_id_animals = sub_id_animals_pol)
# save ensemble of rarefied matrices
for (i in 1:s)
  write.table(mat_list[[i]], paste("output/data/core_species_removal/mats_pol_core/",
                                   "net_random_pollination_core_", i, ".txt", sep = ""))

# plant-ant subnetwork core
id_plants_ant_core = which(core_plants$ant_core == 1)
id_animals_ant_core = which(core_animals$ant_core == 1)
mat_no_ant_core = mat[-id_plants_ant_core, -id_animals_ant_core] # removing ant core
# save matrix without plant-ant subnetwork core
write.table(mat_no_ant_core, "output/data/core_species_removal/mats_ant_core/net_no_ant_core.txt")
# rarefaction simulation
s = 100
n_plants_ant = length(id_plants_ant_core) # number of plant sp in the ant core
n_animals_ant = length(id_animals_ant_core) # number of animal sp in the ant core
sub_id_plants_ant = core_plants$ant_subnetwork # defining the subnetwork
sub_id_animals_ant = core_animals$ant_subnetwork # defining the subnetwork
mat_list = RemoveSpSubnetwork(s, n_plants = n_plants_ant, n_animals = n_animals_ant,
                              mat, sub_id_plants = sub_id_plants_ant,
                              sub_id_animals = sub_id_animals_ant)
# save ensemble of rarefied matrices
for (i in 1:s)
  write.table(mat_list[[i]], paste("output/data/core_species_removal/mats_ant_core/",
                                   "net_random_ant_core_", i, ".txt", sep = ""))

# plants-seed-disperser subnetwork core
id_plants_disp_core = which(core_plants$dispersal_core == 1)
id_animals_disp_core = which(core_animals$dispersal_core == 1)
mat_no_disp_core = mat[-id_plants_disp_core, -id_animals_disp_core] # removing dispersal core
# save matrix without plant-seed-disperser subnetwork core
write.table(mat_no_disp_core, "output/data/core_species_removal/mats_disp_core/net_no_disp_core.txt")
# rarefaction simulation
s = 100
n_plants_disp = length(id_plants_disp_core) # number of plant sp in the seed-dispersal core
n_animals_disp = length(id_animals_disp_core) # number of animal sp in the seed-dispersal core
sub_id_plants_disp = core_plants$disp_subnetwork # defining the subnetwork
sub_id_animals_disp = core_animals$disp_subnetwork # defining the subnetwork
mat_list = RemoveSpSubnetwork(s, n_plants = n_plants_disp, n_animals = n_animals_disp,
                              mat, sub_id_plants = sub_id_plants_disp,
                              sub_id_animals = sub_id_animals_disp)
# save ensemble of rarefied matrices
for (i in 1:s)
  write.table(mat_list[[i]], paste("output/data/core_species_removal/mats_disp_core/",
                                   "net_random_disp_core_", i, ".txt", sep = ""))

#-----------------------------------------------------------------------------------------------------#