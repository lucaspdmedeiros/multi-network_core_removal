#-----------------------------------------------------------------------------------------------------#

RemoveSpSubnetwork = function(s, n_plants, n_animals, mat, sub_id_plants, sub_id_animals) {
  # Performs s simulations of random removal of n_plants + n_animals species from a subnetwork 
  # embedded in a complete network.
  # 
  # Args:
  #   s: number of simulations (number of different complete networks that will be generated)
  #   n_plants: number of species in the rows (plant species) that will be removed
  #   n_animals: number of species in the columns (animal species) that will be removed
  #   mat: bipartite matrix with plants in rows and animals in columns
  #   sub_id_plants: vector identifying the plant species that belong to the subnetwork (1: belong; 
  #                  0: do not belong)
  #   sub_id_animals: vector identifying the animal species that belong to the subnetwork (1: belong; 
  #                   0: do not belong)
  #
  # Returns:
  #   s complete networks, each with n_row + n_col species removed from the desired subnetwork

  rarefied_mats = list()
  for (i in 1:s) {
    indexes_plants = sample(which(sub_id_plants == 1), n_plants)
    indexes_animals = sample(which(sub_id_animals == 1), n_animals)
    rarefied_mats[[i]] = mat[-indexes_plants, -indexes_animals]
  }
  return (rarefied_mats)
}

#-----------------------------------------------------------------------------------------------------#