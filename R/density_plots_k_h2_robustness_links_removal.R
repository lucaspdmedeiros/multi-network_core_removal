#-----------------------------------------------------------------------------------------------------#

# Description:
#   
# Returns:
#   

library(ggplot2)

# core species removal density plots mean k, h2 and robustness
# general core removal
gen_links_random = read.csv("output/data/core_links_removal/h2_k_robustness/gen_random_links_removal.csv")
# plant-pollinator subnetwork core removal
pol_links_random = read.csv("output/data/core_links_removal/h2_k_robustness/pol_random_links_removal.csv")
# plant-ant subnetwork core removal
ant_links_random = read.csv("output/data/core_links_removal/h2_k_robustness/ant_random_links_removal.csv")
# seed-dispersal subnetwork core removal
disp_links_random = read.csv("output/data/core_links_removal/h2_k_robustness/disp_random_links_removal.csv")
# data frame with reference (core removal) data
gen_links = read.csv("output/data/core_links_removal/h2_k_robustness/gen_core_links_removal.csv")
pol_links = read.csv("output/data/core_links_removal/h2_k_robustness/pol_core_links_removal.csv")
ant_links = read.csv("output/data/core_links_removal/h2_k_robustness/ant_core_links_removal.csv")
disp_links = read.csv("output/data/core_links_removal/h2_k_robustness/disp_core_links_removal.csv")

# specialization
# data frame with all random data
h2_all = data.frame(h2 = c(gen_links_random$h2, pol_links_random$h2, ant_links_random$h2, disp_links_random$h2), 
                    subnetwork = rep(c("General core", "Pollination core", "Ant core", "Dispersal core"), each = 100))
h2_ref = data.frame(h2 = c(gen_links[1, "core_links_removed"], pol_links[1, "core_links_removed"], 
                           ant_links[1, "core_links_removed"], disp_links[1, "core_links_removed"]),
                    subnetwork = c("General core", "Pollination core", "Ant core", "Dispersal core"))

# plotting
palette = c("#F8766D", "#7CAE00", "#B79F00", "#C77CFF")
jpeg("output/figs/h2_core_and_random_links_removal.jpeg", width = 1000, height = 1200, quality = 100)
ggplot(h2_all, aes(x = h2, fill = subnetwork)) +
  scale_fill_manual(values = palette) +
  facet_wrap( ~ subnetwork, ncol = 2, scales = "free") +
  geom_density(alpha = 0.4, size = 1.25) + # density plot
  geom_vline(data = h2_ref, aes(xintercept = h2), size = 2, 
             linetype = "dashed") + # plotting vertical lines
  xlab("Network specialization after link removal") +
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
r_p_random_all = data.frame(r_p_random = c(gen_links_random$r_p_random, pol_links_random$r_p_random, ant_links_random$r_p_random, disp_links_random$r_p_random), 
                            subnetwork = rep(c("General core", "Pollination core", "Ant core", "Dispersal core"), each = 100))
r_p_random_ref = data.frame(r_p_random = c(gen_links[2, "core_links_removed"], pol_links[2, "core_links_removed"], 
                                           ant_links[2, "core_links_removed"], disp_links[2, "core_links_removed"]),
                            subnetwork = c("General core", "Pollination core", "Ant core", "Dispersal core"))

# plotting
palette = c("#F8766D", "#7CAE00", "#B79F00", "#C77CFF")
jpeg("output/figs/r_p_random_core_and_random_links_removal.jpeg", width = 1000, height = 1200, quality = 100)
ggplot(r_p_random_all, aes(x = r_p_random, fill = subnetwork)) +
  scale_fill_manual(values = palette) +
  facet_wrap( ~ subnetwork, ncol = 2, scales = "free") +
  geom_density(alpha = 0.4, size = 1.25) + # density plot
  geom_vline(data = r_p_random_ref, aes(xintercept = r_p_random), size = 2, 
             linetype = "dashed") + # plotting vertical lines
  xlab("Robustness (random plant extinction) after link removal") +
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
r_p_lm_all = data.frame(r_p_lm = c(gen_links_random$r_p_lm, pol_links_random$r_p_lm, ant_links_random$r_p_lm, disp_links_random$r_p_lm), 
                        subnetwork = rep(c("General core", "Pollination core", "Ant core", "Dispersal core"), each = 100))
r_p_lm_ref = data.frame(r_p_lm = c(gen_links[3, "core_links_removed"], pol_links[3, "core_links_removed"], 
                                   ant_links[3, "core_links_removed"], disp_links[3, "core_links_removed"]),
                        subnetwork = c("General core", "Pollination core", "Ant core", "Dispersal core"))

# plotting
palette = c("#F8766D", "#7CAE00", "#B79F00", "#C77CFF")
jpeg("output/figs/r_p_lm_core_and_random_links_removal.jpeg", width = 1000, height = 1200, quality = 100)
ggplot(r_p_lm_all, aes(x = r_p_lm, fill = subnetwork)) +
  scale_fill_manual(values = palette) +
  facet_wrap( ~ subnetwork, ncol = 2, scales = "free") +
  geom_density(alpha = 0.4, size = 1.25) + # density plot
  geom_vline(data = r_p_lm_ref, aes(xintercept = r_p_lm), size = 2, 
             linetype = "dashed") + # plotting vertical lines
  xlab("Robustness (least-to-most plant extinction) after link removal") +
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
r_p_ml_all = data.frame(r_p_ml = c(gen_links_random$r_p_ml, pol_links_random$r_p_ml, ant_links_random$r_p_ml, disp_links_random$r_p_ml), 
                        subnetwork = rep(c("General core", "Pollination core", "Ant core", "Dispersal core"), each = 100))
r_p_ml_ref = data.frame(r_p_ml = c(gen_links[4, "core_links_removed"], pol_links[4, "core_links_removed"], 
                                   ant_links[4, "core_links_removed"], disp_links[4, "core_links_removed"]),
                        subnetwork = c("General core", "Pollination core", "Ant core", "Dispersal core"))

# plotting
palette = c("#F8766D", "#7CAE00", "#B79F00", "#C77CFF")
jpeg("output/figs/r_p_ml_core_and_random_links_removal.jpeg", width = 1000, height = 1200, quality = 100)
ggplot(r_p_ml_all, aes(x = r_p_ml, fill = subnetwork)) +
  scale_fill_manual(values = palette) +
  facet_wrap( ~ subnetwork, ncol = 2, scales = "free") +
  geom_density(alpha = 0.4, size = 1.25) + # density plot
  geom_vline(data = r_p_ml_ref, aes(xintercept = r_p_ml), size = 2, 
             linetype = "dashed") + # plotting vertical lines
  xlab("Robustness (most-to-least plant extinction) after link removal") +
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
r_a_random_all = data.frame(r_a_random = c(gen_links_random$r_a_random, pol_links_random$r_a_random, ant_links_random$r_a_random, disp_links_random$r_a_random), 
                            subnetwork = rep(c("General core", "Pollination core", "Ant core", "Dispersal core"), each = 100))
r_a_random_ref = data.frame(r_a_random = c(gen_links[5, "core_links_removed"], pol_links[5, "core_links_removed"], 
                                           ant_links[5, "core_links_removed"], disp_links[5, "core_links_removed"]),
                            subnetwork = c("General core", "Pollination core", "Ant core", "Dispersal core"))

# plotting
palette = c("#F8766D", "#7CAE00", "#B79F00", "#C77CFF")
jpeg("output/figs/r_a_random_core_and_random_links_removal.jpeg", width = 1000, height = 1200, quality = 100)
ggplot(r_a_random_all, aes(x = r_a_random, fill = subnetwork)) +
  scale_fill_manual(values = palette) +
  facet_wrap( ~ subnetwork, ncol = 2, scales = "free") +
  geom_density(alpha = 0.4, size = 1.25) + # density plot
  geom_vline(data = r_a_random_ref, aes(xintercept = r_a_random), size = 2, 
             linetype = "dashed") + # plotting vertical lines
  xlab("Robustness (random animal extinction) after link removal") +
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
r_a_lm_all = data.frame(r_a_lm = c(gen_links_random$r_a_lm, pol_links_random$r_a_lm, ant_links_random$r_a_lm, disp_links_random$r_a_lm), 
                        subnetwork = rep(c("General core", "Pollination core", "Ant core", "Dispersal core"), each = 100))
r_a_lm_ref = data.frame(r_a_lm = c(gen_links[6, "core_links_removed"], pol_links[6, "core_links_removed"], 
                                   ant_links[6, "core_links_removed"], disp_links[6, "core_links_removed"]),
                        subnetwork = c("General core", "Pollination core", "Ant core", "Dispersal core"))

# plotting
palette = c("#F8766D", "#7CAE00", "#B79F00", "#C77CFF")
jpeg("output/figs/r_a_lm_core_and_random_links_removal.jpeg", width = 1000, height = 1200, quality = 100)
ggplot(r_a_lm_all, aes(x = r_a_lm, fill = subnetwork)) +
  scale_fill_manual(values = palette) +
  facet_wrap( ~ subnetwork, ncol = 2, scales = "free") +
  geom_density(alpha = 0.4, size = 1.25) + # density plot
  geom_vline(data = r_a_lm_ref, aes(xintercept = r_a_lm), size = 2, 
             linetype = "dashed") + # plotting vertical lines
  xlab("Robustness (least-to-most animal extinction) after link removal") +
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
r_a_ml_all = data.frame(r_a_ml = c(gen_links_random$r_a_ml, pol_links_random$r_a_ml, ant_links_random$r_a_ml, disp_links_random$r_a_ml), 
                        subnetwork = rep(c("General core", "Pollination core", "Ant core", "Dispersal core"), each = 100))
r_a_ml_ref = data.frame(r_a_ml = c(gen_links[7, "core_links_removed"], pol_links[7, "core_links_removed"], 
                                   ant_links[7, "core_links_removed"], disp_links[7, "core_links_removed"]),
                        subnetwork = c("General core", "Pollination core", "Ant core", "Dispersal core"))

# plotting
palette = c("#F8766D", "#7CAE00", "#B79F00", "#C77CFF")
jpeg("output/figs/r_a_ml_core_and_random_links_removal.jpeg", width = 1000, height = 1200, quality = 100)
ggplot(r_a_ml_all, aes(x = r_a_ml, fill = subnetwork)) +
  scale_fill_manual(values = palette) +
  facet_wrap( ~ subnetwork, ncol = 2, scales = "free") +
  geom_density(alpha = 0.4, size = 1.25) + # density plot
  geom_vline(data = r_a_ml_ref, aes(xintercept = r_a_ml), size = 2, 
             linetype = "dashed") + # plotting vertical lines
  xlab("Robustness (most-to-least animal extinction) after link removal") +
  ylab("Density") +
  theme_bw() +
  theme(axis.text = element_text(size = 22), 
        axis.title = element_text(size = 27, face = "bold"),
        axis.title.y=element_text(margin=margin(0,15,0,0)), 
        strip.text.x = element_text(size = 27),
        legend.position = "none")
dev.off()

#-----------------------------------------------------------------------------------------------------#