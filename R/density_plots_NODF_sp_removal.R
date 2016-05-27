#-----------------------------------------------------------------------------------------------------#

# Description:
#   Plots the distribution of nestedness values of randomly species-rarefied networks and a reference 
#   value: the nestedness value of the network without the core species of each subnetwork.
# Returns:
#   Saves one plot as jpeg file.

library(ggplot2)

# general core removal
NODF_gen_core = read.csv("output/data/core_species_removal/nestedness/NODF_general_core_removal.csv")
# plant-pollinator subnetwork core removal
NODF_pol_core = read.csv("output/data/core_species_removal/nestedness/NODF_pollination_core_removal.csv")
# plant-ant subnetwork core removal
NODF_ant_core = read.csv("output/data/core_species_removal/nestedness/NODF_ant_core_removal.csv")
# seed-dispersal subnetwork core removal
NODF_disp_core = read.csv("output/data/core_species_removal/nestedness/NODF_disp_core_removal.csv")

# data frame with all NODF data
NODF_all = data.frame(NODF = c(NODF_gen_core[3:nrow(NODF_gen_core), 1], NODF_pol_core[3:nrow(NODF_pol_core), 1],
                               NODF_ant_core[3:nrow(NODF_ant_core), 1], NODF_disp_core[3:nrow(NODF_disp_core), 1]), 
                      subnetwork = rep(c("General core", "Pollination core", "Ant core", "Dispersal core"), each = 100))
# data frame with reference (core removal) NODF data
NODF_ref = data.frame(NODF = c(NODF_gen_core[2, 1], NODF_pol_core[2, 1], NODF_ant_core[2, 1], NODF_disp_core[2, 1]), 
                      subnetwork = c("General core", "Pollination core", "Ant core", "Dispersal core"))

# plotting
palette = c("#F8766D", "#7CAE00", "#B79F00", "#C77CFF")
jpeg("output/figs/NODF_core_and_random_sp_removal.jpeg", width = 1000, height = 1200, quality = 100)
ggplot(NODF_all, aes(x = NODF, fill = subnetwork)) +
  scale_fill_manual(values = palette) +
  facet_wrap( ~ subnetwork, ncol = 2, scales = "free") +
  geom_density(alpha = 0.4, size = 1.25) + # density plot
  geom_vline(data = NODF_ref, aes(xintercept = NODF), size = 2, 
             linetype = "dashed") + # plotting vertical lines
  xlab("Nestedness after species removal") +
  ylab("Density") +
  theme_bw() +
  theme(axis.text = element_text(size = 22), 
        axis.title = element_text(size = 35, face = "bold"),
        axis.title.y=element_text(margin=margin(0,15,0,0)), 
        strip.text.x = element_text(size = 27),
        legend.position = "none")
dev.off()

#-----------------------------------------------------------------------------------------------------#