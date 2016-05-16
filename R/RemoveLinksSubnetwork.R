#-----------------------------------------------------------------------------------------------------#

RemoveLinksSubnetwork = function(s, l, mat, sub_id_plants, sub_id_animals) {
  # Performs s simulations of random removal of l links from a subnetwork embedded in a 
  # complete network.
  # 
  # Args:
  #   s: number of simulations (number of different complete networks that will be generated)
  #   l: number of links that will be removed from the desired subnetwork
  #   mat: bipartite matrix with plants in rows and animals in columns
  #   sub_id_plants: vector identifying the plant species that belong to the subnetwork (1: belong; 
  #                  0: do not belong)
  #   sub_id_animals: vector identifying the animal species that belong to the subnetwork (1: belong; 
  #                   0: do not belong)
  #
  # Returns:
  #   s complete networks, each with l links removed from the desired subnetwork
  
  rarefied_mats = list()
  for (i in 1:s) {
    curr_mat = mat
    counter = 1
    while (counter <= l) {
      index_plant = sample(which(sub_id_plants == 1), 1)
      index_animal = sample(which(sub_id_animals == 1), 1)
      if (curr_mat[index_plant, index_animal] == 1) {
        curr_mat[index_plant, index_animal] = 0
        counter = counter + 1
        degree_plant = sum(curr_mat[index_plant, ])
        degree_animal = sum(curr_mat[ , index_animal])
        if ((degree_plant == 0) | (degree_animal == 0)) {
          curr_mat[index_plant, index_animal] = 1
          counter = counter - 1
        }
      }
    }
    rarefied_mats[[i]] = curr_mat
  }
  return (rarefied_mats)
}  

#-----------------------------------------------------------------------------------------------------#