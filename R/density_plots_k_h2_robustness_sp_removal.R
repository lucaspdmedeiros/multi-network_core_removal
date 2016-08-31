#-----------------------------------------------------------------------------------------------------#

# Description:
#   Plots the distribution of robustness, mean degree and specialization values of randomly 
#   species-rarefied networks and a reference value: the value of the network without the 
#   core species of each subnetwork.
# Returns:
#   Saves plots as jpeg files.

library(ggplot2)

# core species removal density plots mean k, h2 and robustness
# general core removal
gen_core_random = read.csv("output/data/core_species_removal/h2_k_robustness/gen_random_sp_removal.csv")
# plant-pollinator subnetwork core removal
pol_core_random = read.csv("output/data/core_species_removal/h2_k_robustness/pol_random_sp_removal.csv")
# plant-ant subnetwork core removal
ant_core_random = read.csv("output/data/core_species_removal/h2_k_robustness/ant_random_sp_removal.csv")
# seed-dispersal subnetwork core removal
disp_core_random = read.csv("output/data/core_species_removal/h2_k_robustness/disp_random_sp_removal.csv")
# data frame with reference (core removal) data
gen_core = read.csv("output/data/core_species_removal/h2_k_robustness/gen_core_sp_removal.csv")
pol_core = read.csv("output/data/core_species_removal/h2_k_robustness/pol_core_sp_removal.csv")
ant_core = read.csv("output/data/core_species_removal/h2_k_robustness/ant_core_sp_removal.csv")
disp_core = read.csv("output/data/core_species_removal/h2_k_robustness/disp_core_sp_removal.csv")

# mean degree
# data frame with all random data
k_all = data.frame(k = c(gen_core_random$k, pol_core_random$k, ant_core_random$k, disp_core_random$k), 
                   subnetwork = rep(c("General core", "Pollination core", "Ant core", "Dispersal core"), each = 100))
k_ref = data.frame(k = c(gen_core[2, "core_sp_removed"], pol_core[2, "core_sp_removed"], 
                         ant_core[2, "core_sp_removed"], disp_core[2, "core_sp_removed"]),
                   subnetwork = c("General core", "Pollination core", "Ant core", "Dispersal core"))

# plotting
palette = c("#F8766D", "#7CAE00", "#B79F00", "#C77CFF")
jpeg("output/figs/mean_k_core_and_random_sp_removal.jpeg", width = 1000, height = 1200, quality = 100)
ggplot(k_all, aes(x = k, fill = subnetwork)) +
  scale_fill_manual(values = palette) +
  facet_wrap( ~ subnetwork, ncol = 2, scales = "free") +
  geom_density(alpha = 0.4, size = 1.25) + # density plot
  geom_vline(data = k_ref, aes(xintercept = k), size = 2, 
             linetype = "dashed") + # plotting vertical lines
  xlab("Mean number of links after species removal") +
  ylab("Density") +
  theme_bw() +
  theme(axis.text = element_text(size = 22), 
        axis.title = element_text(size = 35, face = "bold"),
        axis.title.y=element_text(margin=margin(0,15,0,0)), 
        strip.text.x = element_text(size = 27),
        legend.position = "none")
dev.off()

# specialization
# data frame with all random data
h2_all = data.frame(h2 = c(gen_core_random$h2, pol_core_random$h2, ant_core_random$h2, disp_core_random$h2), 
                   subnetwork = rep(c("General core", "Pollination core", "Ant core", "Dispersal core"), each = 100))
h2_ref = data.frame(h2 = c(gen_core[1, "core_sp_removed"], pol_core[1, "core_sp_removed"], 
                           ant_core[1, "core_sp_removed"], disp_core[1, "core_sp_removed"]),
                    subnetwork = c("General core", "Pollination core", "Ant core", "Dispersal core"))

# plotting
palette = c("#F8766D", "#7CAE00", "#B79F00", "#C77CFF")
jpeg("output/figs/h2_core_and_random_sp_removal.jpeg", width = 1000, height = 1200, quality = 100)
ggplot(h2_all, aes(x = h2, fill = subnetwork)) +
  scale_fill_manual(values = palette) +
  facet_wrap( ~ subnetwork, ncol = 2, scales = "free") +
  geom_density(alpha = 0.4, size = 1.25) + # density plot
  geom_vline(data = h2_ref, aes(xintercept = h2), size = 2, 
             linetype = "dashed") + # plotting vertical lines
  xlab("Network specialization after species removal") +
  ylab("Density") +
  theme_bw() +
  theme(axis.text = element_text(size = 22), 
        axis.title = element_text(size = 35, face = "bold"),
        axis.title.y=element_text(margin=margin(0,15,0,0)), 
        strip.text.x = element_text(size = 27),
        legend.position = "none")
dev.off()

# robustness: random extinction of plants
# data frame with all random data
r_p_random_all = data.frame(r_p_random = c(gen_core_random$r_p_random, pol_core_random$r_p_random, ant_core_random$r_p_random, disp_core_random$r_p_random), 
                            subnetwork = rep(c("General core", "Pollination core", "Ant core", "Dispersal core"), each = 100))
r_p_random_ref = data.frame(r_p_random = c(gen_core[3, "core_sp_removed"], pol_core[3, "core_sp_removed"], 
                           ant_core[3, "core_sp_removed"], disp_core[3, "core_sp_removed"]),
                           subnetwork = c("General core", "Pollination core", "Ant core", "Dispersal core"))

# plotting
palette = c("#F8766D", "#7CAE00", "#B79F00", "#C77CFF")
jpeg("output/figs/r_p_random_core_and_random_sp_removal.jpeg", width = 1000, height = 1200, quality = 100)
ggplot(r_p_random_all, aes(x = r_p_random, fill = subnetwork)) +
  scale_fill_manual(values = palette) +
  facet_wrap( ~ subnetwork, ncol = 2, scales = "free") +
  geom_density(alpha = 0.4, size = 1.25) + # density plot
  geom_vline(data = r_p_random_ref, aes(xintercept = r_p_random), size = 2, 
             linetype = "dashed") + # plotting vertical lines
  xlab("Robustness (random plant extinction) after species removal") +
  ylab("Density") +
  theme_bw() +
  theme(axis.text = element_text(size = 22), 
        axis.title = element_text(size = 27, face = "bold"),
        axis.title.y=element_text(margin=margin(0,15,0,0)), 
        strip.text.x = element_text(size = 27),
        legend.position = "none")
dev.off()

# robustness: least-to_most extinction of plants
# data frame with all random data
r_p_lm_all = data.frame(r_p_lm = c(gen_core_random$r_p_lm, pol_core_random$r_p_lm, ant_core_random$r_p_lm, disp_core_random$r_p_lm), 
                        subnetwork = rep(c("General core", "Pollination core", "Ant core", "Dispersal core"), each = 100))
r_p_lm_ref = data.frame(r_p_lm = c(gen_core[4, "core_sp_removed"], pol_core[4, "core_sp_removed"], 
                                           ant_core[4, "core_sp_removed"], disp_core[4, "core_sp_removed"]),
                        subnetwork = c("General core", "Pollination core", "Ant core", "Dispersal core"))

# plotting
palette = c("#F8766D", "#7CAE00", "#B79F00", "#C77CFF")
jpeg("output/figs/r_p_lm_core_and_random_sp_removal.jpeg", width = 1000, height = 1200, quality = 100)
ggplot(r_p_lm_all, aes(x = r_p_lm, fill = subnetwork)) +
  scale_fill_manual(values = palette) +
  facet_wrap( ~ subnetwork, ncol = 2, scales = "free") +
  geom_density(alpha = 0.4, size = 1.25) + # density plot
  geom_vline(data = r_p_lm_ref, aes(xintercept = r_p_lm), size = 2, 
             linetype = "dashed") + # plotting vertical lines
  xlab("Robustness (least-to-most plant extinction) after species removal") +
  ylab("Density") +
  theme_bw() +
  theme(axis.text = element_text(size = 22), 
        axis.title = element_text(size = 27, face = "bold"),
        axis.title.y=element_text(margin=margin(0,15,0,0)), 
        strip.text.x = element_text(size = 27),
        legend.position = "none")
dev.off()

# robustness: most-to-least extinction of plants
# data frame with all random data
r_p_ml_all = data.frame(r_p_ml = c(gen_core_random$r_p_ml, pol_core_random$r_p_ml, ant_core_random$r_p_ml, disp_core_random$r_p_ml), 
                        subnetwork = rep(c("General core", "Pollination core", "Ant core", "Dispersal core"), each = 100))
r_p_ml_ref = data.frame(r_p_ml = c(gen_core[5, "core_sp_removed"], pol_core[5, "core_sp_removed"], 
                                   ant_core[5, "core_sp_removed"], disp_core[5, "core_sp_removed"]),
                        subnetwork = c("General core", "Pollination core", "Ant core", "Dispersal core"))

# plotting
palette = c("#F8766D", "#7CAE00", "#B79F00", "#C77CFF")
jpeg("output/figs/r_p_ml_core_and_random_sp_removal.jpeg", width = 1000, height = 1200, quality = 100)
ggplot(r_p_ml_all, aes(x = r_p_ml, fill = subnetwork)) +
  scale_fill_manual(values = palette) +
  facet_wrap( ~ subnetwork, ncol = 2, scales = "free") +
  geom_density(alpha = 0.4, size = 1.25) + # density plot
  geom_vline(data = r_p_ml_ref, aes(xintercept = r_p_ml), size = 2, 
             linetype = "dashed") + # plotting vertical lines
  xlab("Robustness (most-to-least plant extinction) after species removal") +
  ylab("Density") +
  theme_bw() +
  theme(axis.text = element_text(size = 22), 
        axis.title = element_text(size = 27, face = "bold"),
        axis.title.y=element_text(margin=margin(0,15,0,0)), 
        strip.text.x = element_text(size = 27),
        legend.position = "none")
dev.off()

# robustness: random extinction of animals
# data frame with all random data
r_a_random_all = data.frame(r_a_random = c(gen_core_random$r_a_random, pol_core_random$r_a_random, ant_core_random$r_a_random, disp_core_random$r_a_random), 
                        subnetwork = rep(c("General core", "Pollination core", "Ant core", "Dispersal core"), each = 100))
r_a_random_ref = data.frame(r_a_random = c(gen_core[6, "core_sp_removed"], pol_core[6, "core_sp_removed"], 
                                   ant_core[6, "core_sp_removed"], disp_core[6, "core_sp_removed"]),
                        subnetwork = c("General core", "Pollination core", "Ant core", "Dispersal core"))

# plotting
palette = c("#F8766D", "#7CAE00", "#B79F00", "#C77CFF")
jpeg("output/figs/r_a_random_core_and_random_sp_removal.jpeg", width = 1000, height = 1200, quality = 100)
ggplot(r_a_random_all, aes(x = r_a_random, fill = subnetwork)) +
  scale_fill_manual(values = palette) +
  facet_wrap( ~ subnetwork, ncol = 2, scales = "free") +
  geom_density(alpha = 0.4, size = 1.25) + # density plot
  geom_vline(data = r_a_random_ref, aes(xintercept = r_a_random), size = 2, 
             linetype = "dashed") + # plotting vertical lines
  xlab("Robustness (random animal extinction) after species removal") +
  ylab("Density") +
  theme_bw() +
  theme(axis.text = element_text(size = 22), 
        axis.title = element_text(size = 27, face = "bold"),
        axis.title.y=element_text(margin=margin(0,15,0,0)), 
        strip.text.x = element_text(size = 27),
        legend.position = "none")
dev.off()

# robustness: least-to-most extinction of animals
# data frame with all random data
r_a_lm_all = data.frame(r_a_lm = c(gen_core_random$r_a_lm, pol_core_random$r_a_lm, ant_core_random$r_a_lm, disp_core_random$r_a_lm), 
                            subnetwork = rep(c("General core", "Pollination core", "Ant core", "Dispersal core"), each = 100))
r_a_lm_ref = data.frame(r_a_lm = c(gen_core[7, "core_sp_removed"], pol_core[7, "core_sp_removed"], 
                                           ant_core[7, "core_sp_removed"], disp_core[7, "core_sp_removed"]),
                            subnetwork = c("General core", "Pollination core", "Ant core", "Dispersal core"))

# plotting
palette = c("#F8766D", "#7CAE00", "#B79F00", "#C77CFF")
jpeg("output/figs/r_a_lm_core_and_random_sp_removal.jpeg", width = 1000, height = 1200, quality = 100)
ggplot(r_a_lm_all, aes(x = r_a_lm, fill = subnetwork)) +
  scale_fill_manual(values = palette) +
  facet_wrap( ~ subnetwork, ncol = 2, scales = "free") +
  geom_density(alpha = 0.4, size = 1.25) + # density plot
  geom_vline(data = r_a_lm_ref, aes(xintercept = r_a_lm), size = 2, 
             linetype = "dashed") + # plotting vertical lines
  xlab("Robustness (least-to-most animal extinction) after species removal") +
  ylab("Density") +
  theme_bw() +
  theme(axis.text = element_text(size = 22), 
        axis.title = element_text(size = 27, face = "bold"),
        axis.title.y=element_text(margin=margin(0,15,0,0)), 
        strip.text.x = element_text(size = 27),
        legend.position = "none")
dev.off()

# robustness: most-to-least extinction of animals
# data frame with all random data
r_a_ml_all = data.frame(r_a_ml = c(gen_core_random$r_a_ml, pol_core_random$r_a_ml, ant_core_random$r_a_ml, disp_core_random$r_a_ml), 
                        subnetwork = rep(c("General core", "Pollination core", "Ant core", "Dispersal core"), each = 100))
r_a_ml_ref = data.frame(r_a_ml = c(gen_core[8, "core_sp_removed"], pol_core[8, "core_sp_removed"], 
                                   ant_core[8, "core_sp_removed"], disp_core[8, "core_sp_removed"]),
                        subnetwork = c("General core", "Pollination core", "Ant core", "Dispersal core"))

# plotting
palette = c("#F8766D", "#7CAE00", "#B79F00", "#C77CFF")
jpeg("output/figs/r_a_ml_core_and_random_sp_removal.jpeg", width = 1000, height = 1200, quality = 100)
ggplot(r_a_ml_all, aes(x = r_a_ml, fill = subnetwork)) +
  scale_fill_manual(values = palette) +
  facet_wrap( ~ subnetwork, ncol = 2, scales = "free") +
  geom_density(alpha = 0.4, size = 1.25) + # density plot
  geom_vline(data = r_a_ml_ref, aes(xintercept = r_a_ml), size = 2, 
             linetype = "dashed") + # plotting vertical lines
  xlab("Robustness (most-to-least animal extinction) after species removal") +
  ylab("Density") +
  theme_bw() +
  theme(axis.text = element_text(size = 22), 
        axis.title = element_text(size = 27, face = "bold"),
        axis.title.y=element_text(margin=margin(0,15,0,0)), 
        strip.text.x = element_text(size = 27),
        legend.position = "none")
dev.off()

#-----------------------------------------------------------------------------------------------------#