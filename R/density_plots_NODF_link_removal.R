#-----------------------------------------------------------------------------------------------------#

# Description:
#   Plots the distribution of nestedness values of randomly link-rarefied networks and a reference value:
#   the nestedness value of the network without the core links of a each subnetwork.
# Returns:
#   Saves one plot as jpeg file.

library(ggplot2)

# general core links removed
NODF_gen_links = read.csv("output/data/core_links_removal/nestedness/NODF_general_links_random.csv")
# plant-pollinator subnetwork core links removed
NODF_pol_links = read.csv("output/data/core_links_removal/nestedness/NODF_pollination_links_random.csv")
# plant-ant subnetwork core links removed
NODF_ant_links = read.csv("output/data/core_links_removal/nestedness/NODF_ant_links_random.csv")
# seed-dispersal subnetwork core links removed
NODF_disp_links = read.csv("output/data/core_links_removal/nestedness/NODF_dispersal_links_random.csv")
# data frame with nestedness values for core link removal
NODF_p_values = read.csv("output/data/core_links_removal/nestedness/nestedness_links_removal_p_values.csv")
NODF_ref = NODF_p_values$NODF_core_removed

# data frame with all NODF data
NODF_all = data.frame(NODF = rbind(NODF_gen_links, NODF_pol_links, NODF_ant_links, NODF_disp_links), 
                      subnetwork = rep(c("General core", "Pollination core", "Ant core", "Dispersal core"), each = 100))
# data frame with reference (core links removal) NODF data
NODF_ref = data.frame(NODF = NODF_ref, 
                      subnetwork = c("General core", "Pollination core", "Ant core", "Dispersal core"))

# plotting
palette = c("#F8766D", "#7CAE00", "#B79F00", "#C77CFF")
jpeg("output/figs/NODF_core_and_random_links_removal.jpeg", width = 1000, height = 1200, quality = 100)
ggplot(NODF_all, aes(x = x, fill = subnetwork)) +
  scale_fill_manual(values = palette) +
  facet_wrap( ~ subnetwork, ncol = 2, scales = "free") +
  geom_density(alpha = 0.4, size = 1.25) + # density plot
  geom_vline(data = NODF_ref, aes(xintercept = NODF), size = 2, 
             linetype = "dashed") + # plotting vertical lines
  xlab("Nestedness after link removal") +
  ylab("Density") +
  theme_bw() +
  theme(axis.text = element_text(size = 22), 
        axis.title = element_text(size = 35, face = "bold"),
        axis.title.y=element_text(margin=margin(0,15,0,0)), 
        strip.text.x = element_text(size = 27),
        legend.position = "none")
dev.off()

#-----------------------------------------------------------------------------------------------------#