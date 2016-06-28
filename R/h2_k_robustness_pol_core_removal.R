#-----------------------------------------------------------------------------------------------------#

# Description:
#   Calculates specialization (H2), mean degree (k) and robustness of species and link-rarefied interaction 
#   matrices regarding pollination core. Calculates z-scores and p-values by comparing networks with core species  
#   removed and networks with randomly removed species.
# Returns:
#   Saves tables containing the values of the metrics for randomly rarefied networks and tables containing
#   the values of the metric with core species or links removed and their respective z-scores and p-values

library(bipartite)
source("R/RemoveNodesNoLinks.R")

# pollination core species removed

files = dir("output/data/core_species_removal/mats_pol_core")
n_files = length(files)

h2 = rep(NA, 101)
k = rep(NA, 101)
r_p_random = rep(NA, 101)
r_p_lm = rep(NA, 101)
r_p_ml = rep(NA, 101)
r_a_random = rep(NA, 101)
r_a_lm = rep(NA, 101)
r_a_ml = rep(NA, 101)

for (i in 1:n_files) {
  mat = as.matrix(read.table(paste("output/data/core_species_removal/mats_pol_core/", files[i],
                                   sep = "")))
  mat = RemoveNodesNoLinks(mat)
  h2[i] = H2fun(mat, H2_integer=FALSE)[1] # specialization
  k[i] = networklevel(mat, index="links per species") # mean degree
  # robustness
  # plants, random removal
  ex_p_random <- second.extinct(mat, participant="lower", method="random", nrep=100, details=FALSE)
  r_p_random[i] = robustness(ex_p_random)
  # plants, least-to-most
  ex_p_lm <- second.extinct(mat, participant="lower", method="abund", nrep=100, details=FALSE)
  r_p_lm[i] = robustness(ex_p_lm)
  # plants, most-to-least
  ex_p_ml <- second.extinct(mat, participant="lower", method="degree", nrep=100, details=FALSE)
  r_p_ml[i] = robustness(ex_p_ml)
  # animals, random removal
  ex_a_random <- second.extinct(mat, participant="higher", method="random", nrep=100, details=FALSE)
  r_a_random[i] = robustness(ex_a_random)
  # animals, least-to-most
  ex_a_lm <- second.extinct(mat, participant="higher", method="abund", nrep=100, details=FALSE)
  r_a_lm[i] = robustness(ex_a_lm)
  # animals, most-to-least
  ex_a_ml <- second.extinct(mat, participant="higher", method="degree", nrep=100, details=FALSE)
  r_a_ml[i] = robustness(ex_a_ml)
}

metrics_pol_core_sp = data.frame(h2, k, r_p_random, r_p_lm, r_p_ml, r_a_random, r_a_lm, r_a_ml)

# z-scores
z_scores_pol_core_sp = rep(NA, ncol(metrics_pol_core_sp))
for (i in 1:ncol(metrics_pol_core_sp)) {
  z_scores_pol_core_sp[i] = (metrics_pol_core_sp[1, i] - mean(metrics_pol_core_sp[-1, i])) / sd(metrics_pol_core_sp[-1, i])
}
# p values
p_values_pol_core_sp = rep(NA, ncol(metrics_pol_core_sp))
p_values_pol_core_sp[1] = sum(metrics_pol_core_sp[-1, 1] > metrics_pol_core_sp[1, 1]) / length(metrics_pol_core_sp[-1, 1]) # p value for specialization
for (i in 2:ncol(metrics_pol_core_sp)) {
  p_values_pol_core_sp[i] = sum(metrics_pol_core_sp[-1, i] < metrics_pol_core_sp[1, i]) / length(metrics_pol_core_sp[-1, i])
}
# saving
metrics_pol_core_sp_random = data.frame(h2 = metrics_pol_core_sp[-1, "h2"], k = metrics_pol_core_sp[-1, "k"],
                                        r_p_random = metrics_pol_core_sp[-1, "r_p_random"], r_p_lm = metrics_pol_core_sp[-1, "r_p_lm"],
                                        r_p_ml = metrics_pol_core_sp[-1, "r_p_ml"], r_a_random = metrics_pol_core_sp[-1, "r_a_random"],
                                        r_a_lm = metrics_pol_core_sp[-1, "r_a_lm"], r_a_ml = metrics_pol_core_sp[-1, "r_a_ml"])
metrics_no_pol_core_sp = data.frame(core_sp_removed = c(metrics_pol_core_sp[1, "h2"], metrics_pol_core_sp[1, "k"], metrics_pol_core_sp[1, "r_p_random"],
                                                        metrics_pol_core_sp[1, "r_p_lm"], metrics_pol_core_sp[1, "r_p_ml"], 
                                                        metrics_pol_core_sp[1, "r_a_random"], metrics_pol_core_sp[1, "r_a_lm"], metrics_pol_core_sp[1, "r_a_ml"]),
                                    z_score = z_scores_pol_core_sp, p_value = p_values_pol_core_sp)
row.names(metrics_no_pol_core_sp) = colnames(metrics_pol_core_sp)

write.csv(metrics_pol_core_sp_random, file = "output/data/core_species_removal/h2_k_robustness/pol_random_sp_removal.csv")
write.csv(metrics_no_pol_core_sp, file = "output/data/core_species_removal/h2_k_robustness/pol_core_sp_removal.csv")

# pollination core links removed

files = dir("output/data/core_links_removal/mats_pol_core")
n_files = length(files)

h2 = rep(NA, 101)
r_p_random = rep(NA, 101)
r_p_lm = rep(NA, 101)
r_p_ml = rep(NA, 101)
r_a_random = rep(NA, 101)
r_a_lm = rep(NA, 101)
r_a_ml = rep(NA, 101)

for (i in 1:n_files) {
  mat = as.matrix(read.table(paste("output/data/core_links_removal/mats_pol_core/", files[i],
                                   sep = "")))
  h2[i] = H2fun(mat, H2_integer=FALSE)[1] # specialization
  # robustness
  # plants, random removal
  ex_p_random <- second.extinct(mat, participant="lower", method="random", nrep=100, details=FALSE)
  r_p_random[i] = robustness(ex_p_random)
  # plants, least-to-most
  ex_p_lm <- second.extinct(mat, participant="lower", method="abund", nrep=100, details=FALSE)
  r_p_lm[i] = robustness(ex_p_lm)
  # plants, most-to-least
  ex_p_ml <- second.extinct(mat, participant="lower", method="degree", nrep=100, details=FALSE)
  r_p_ml[i] = robustness(ex_p_ml)
  # animals, random removal
  ex_a_random <- second.extinct(mat, participant="higher", method="random", nrep=100, details=FALSE)
  r_a_random[i] = robustness(ex_a_random)
  # animals, least-to-most
  ex_a_lm <- second.extinct(mat, participant="higher", method="abund", nrep=100, details=FALSE)
  r_a_lm[i] = robustness(ex_a_lm)
  # animals, most-to-least
  ex_a_ml <- second.extinct(mat, participant="higher", method="degree", nrep=100, details=FALSE)
  r_a_ml[i] = robustness(ex_a_ml)
}

metrics_pol_core_links = data.frame(h2, r_p_random, r_p_lm, r_p_ml, r_a_random, r_a_lm, r_a_ml)

# z-scores
z_scores_pol_core_links = rep(NA, ncol(metrics_pol_core_links))
for (i in 1:ncol(metrics_pol_core_links)) {
  z_scores_pol_core_links[i] = (metrics_pol_core_links[1, i] - mean(metrics_pol_core_links[-1, i])) / sd(metrics_pol_core_links[-1, i])
}
# p values
p_values_pol_core_links = rep(NA, ncol(metrics_pol_core_links))
p_values_pol_core_links[1] = sum(metrics_pol_core_links[-1, 1] > metrics_pol_core_links[1, 1]) / length(metrics_pol_core_links[-1, 1]) # p value for specialization
for (i in 2:ncol(metrics_pol_core_links)) {
  p_values_pol_core_links[i] = sum(metrics_pol_core_links[-1, i] < metrics_pol_core_links[1, i]) / length(metrics_pol_core_links[-1, i])
}
# saving
metrics_pol_core_links_random = data.frame(h2 = metrics_pol_core_links[-1, "h2"], r_p_random = metrics_pol_core_links[-1, "r_p_random"],
                                           r_p_lm = metrics_pol_core_links[-1, "r_p_lm"], r_p_ml = metrics_pol_core_links[-1, "r_p_ml"],
                                           r_a_random = metrics_pol_core_links[-1, "r_a_random"], r_a_lm = metrics_pol_core_links[-1, "r_a_lm"],
                                           r_a_ml = metrics_pol_core_links[-1, "r_a_ml"])
metrics_no_pol_core_links = data.frame(core_links_removed = c(metrics_pol_core_links[1, "h2"], metrics_pol_core_links[1, "r_p_random"],
                                                              metrics_pol_core_links[1, "r_p_lm"], metrics_pol_core_links[1, "r_p_ml"], 
                                                              metrics_pol_core_links[1, "r_a_random"], metrics_pol_core_links[1, "r_a_lm"], metrics_pol_core_links[1, "r_a_ml"]),
                                       z_score = z_scores_pol_core_links, p_value = p_values_pol_core_links)
row.names(metrics_no_pol_core_links) = colnames(metrics_pol_core_links)

write.csv(metrics_pol_core_links_random, file = "output/data/core_links_removal/h2_k_robustness/pol_random_links_removal.csv")
write.csv(metrics_no_pol_core_links, file = "output/data/core_links_removal/h2_k_robustness/pol_core_links_removal.csv")

#-----------------------------------------------------------------------------------------------------#