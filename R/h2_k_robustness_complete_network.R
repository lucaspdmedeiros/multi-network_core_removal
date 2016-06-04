#-----------------------------------------------------------------------------------------------------#

# Description:
#   Calculates specialization (H2), mean degree (k) and robustness of the complete network
# Returns:
#   A table with the values for the 3 metrics

library(bipartite)

mat = as.matrix(read.table("data/complete_network.txt"))

h2 = H2fun(mat, H2_integer=FALSE)[1] # specialization
k = networklevel(mat, index="links per species") # mean degree
# robustness
# plants, random removal
ex_p_random <- second.extinct(mat, participant="lower", method="random", nrep=100, details=FALSE)
r_p_random = robustness(ex_p_random)
# plants, least-to-most
ex_p_lm <- second.extinct(mat, participant="lower", method="abund", nrep=100, details=FALSE)
r_p_lm = robustness(ex_p_lm)
# plants, most-to-least
ex_p_ml <- second.extinct(mat, participant="lower", method="degree", nrep=100, details=FALSE)
r_p_ml = robustness(ex_p_ml)
# animals, random removal
ex_a_random <- second.extinct(mat, participant="higher", method="random", nrep=100, details=FALSE)
r_a_random = robustness(ex_a_random)
# animals, least-to-most
ex_a_lm <- second.extinct(mat, participant="higher", method="abund", nrep=100, details=FALSE)
r_a_lm = robustness(ex_a_lm)
# animals, most-to-least
ex_a_ml <- second.extinct(mat, participant="higher", method="degree", nrep=100, details=FALSE)
r_a_ml = robustness(ex_a_ml)

metrics = data.frame(h2, k, r_p_random, r_p_lm, r_p_ml, r_a_random, r_a_lm, r_a_ml)
row.names(metrics) = NULL

write.csv(metrics, file = "output/data/k_h2_robustness_complete_network.csv")

#-----------------------------------------------------------------------------------------------------#