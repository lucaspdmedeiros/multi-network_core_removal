#-----------------------------------------------------------------------------------------------------#

# reading data
mat = as.matrix(read.table("data/complete_network.txt")) # reading interaction matrix
core_plants = read.csv("output/data/core_plants_sub.csv") # reading data on plant sp
core_animals = read.csv("output/data/core_animals_sub.csv") # reading data on animal sp

# general core
id_plants_gen_core = which(core_plants$general_core == 1)
id_animals_gen_core = which(core_animals$general_core == 1)
mat_no_gen_core = mat[-id_plants_gen_core, -id_animals_gen_core] # removing general core
# save matrix without general core
write.table(mat_no_gen_core, "output/data/mats_gen_core/net_no_general_core.txt")
# rarefaction simulation
s = 100
n_plants = length(id_plants_gen_core) # number of plant sp in the general core
n_animals = length(id_animals_gen_core) # number of animal sp in the general core
sub_id_plants = rep(1, nrow(mat)) # defining the subnetwork, namely the complete network
sub_id_animals = rep(1, ncol(mat)) # defining the subnetwork, namely the complete network
mat_list = RemoveSpSubnetwork(s = 100, n_plants, n_animals, mat, sub_id_plants, sub_id_animals)
# save ensemble of rarefied matrices
for (i in 1:s)
  write.table(mat_list[[i]], paste("output/data/mats_gen_core/", "net_random_general_core_", i,
                                   ".txt", sep = ""))

# plant-pollinator subnetwork core
id_plants_pol_core = which(core_plants$pollination_core == 1)
id_animals_pol_core = which(core_animals$pollination_core == 1)
mat_no_pol_core = mat[-id_plants_pol_core, -id_animals_pol_core] # removing pollination core
# save matrix without plant-pollinator subnetwork core
write.table(mat_no_pol_core, "output/data/mats_pol_core/net_no_pollination_core.txt")
# rarefaction simulation
s = 100
n_plants = length(id_plants_pol_core) # number of plant sp in the pollination core
n_animals = length(id_animals_pol_core) # number of animal sp in the pollination core
sub_id_plants = core_plants$pol_subnetwork # defining the subnetwork
sub_id_animals = core_animals$pol_subnetwork # defining the subnetwork
mat_list = RemoveSpSubnetwork(s, n_plants, n_animals, mat, sub_id_plants, sub_id_animals)
# save ensemble of rarefied matrices
for (i in 1:s)
  write.table(mat_list[[i]], paste("output/data/mats_pol_core/", "net_random_pollination_core_", i,
                                   ".txt", sep = ""))

# plant-ant subnetwork core

# save matrix without plant-ant subnetwork core

# rarefaction simulation

# save ensemble of rarefied matrices


# plants-seed-disperser subnetwork core

# save matrix without plant-seed-disperser subnetwork core

# rarefaction simulation

# save ensemble of rarefied matrices
