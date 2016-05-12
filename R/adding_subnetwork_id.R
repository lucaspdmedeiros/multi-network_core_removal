#-----------------------------------------------------------------------------------------------------#

# Description: 
#   Adds columns to the data frames core_animals and core_plants that containg a subnetwork identifiers.
#
# Returns:
#   Saves 2 csv tables, core_animals_sub and core_plants_sub.

# reading data
mat = as.matrix(read.table("data/complete_network.txt")) # reading interaction matrix
core_plants = read.csv("data/core_plants.csv") # reading data on plant sp
names(core_plants) = c("sp", "general_core", "pollination_core", "ant_core", "dispersal_core")
rownames(mat) == core_plants$sp # checking if sp are in the same order
head(core_plants)
core_animals = read.csv("data/core_animals.csv") # reading data on animal sp
names(core_animals) = c("sp", "general_core", "pollination_core", "ant_core", "dispersal_core")
colnames(mat) == core_animals$sp # checking if sp are in the same order
head(core_animals)

# subnetwork animal sp richness: pollination = 173, ants = 30, dispersal = 46
n_pol = 173
n_ants = 30
n_disp = 46
# adding columns with animal sp subnetwork id
core_animals$pol_subnetwork = c(rep(1, n_pol), rep(0, nrow(core_animals) - n_pol))
core_animals$ant_subnetwork = c(rep(0, n_pol), rep(1, n_ants), rep(0, nrow(core_animals) - (n_pol + n_ants)))
core_animals$disp_subnetwork = c(rep(0, n_pol + n_ants), rep(1, n_disp))

# adding columns with plant sp subnetwork id
# pollination
sub_mat_pol = mat[ , 1:173]
plant_not_sub_pol = as.numeric(which(apply(sub_mat_pol, 1, sum) == 0))
core_plants$pol_subnetwork = rep(1, 141)
core_plants[plant_not_sub_pol, "pol_subnetwork"] = 0
# ants
sub_mat_ant = mat[ , 174:203]
plant_not_sub_ant = as.numeric(which(apply(sub_mat_ant, 1, sum) == 0))
core_plants$ant_subnetwork = rep(1, 141)
core_plants[plant_not_sub_ant, "ant_subnetwork"] = 0
# dispersal
sub_mat_disp = mat[ , 204:ncol(mat)]
plant_not_sub_disp = as.numeric(which(apply(sub_mat_disp, 1, sum) == 0))
core_plants$disp_subnetwork = rep(1, 141)
core_plants[plant_not_sub_disp, "disp_subnetwork"] = 0

# saving the new tables
write.csv(core_animals, "output/data/core_animals_sub.csv")
write.csv(core_plants, "output/data/core_plants_sub.csv")

#-----------------------------------------------------------------------------------------------------#