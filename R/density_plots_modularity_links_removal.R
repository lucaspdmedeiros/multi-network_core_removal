#-----------------------------------------------------------------------------------------------------#

# Description:
#   Plots the distribution of modularity values of randomly link-rarefied networks and a reference value:
#   the modularity value of the network without the core links of a each subnetwork.
# Returns:
#   Saves one plot as jpeg file.

library(ggplot2)

# general core removal
mod_gen_core_links = read.csv("output/data/core_links_removal/modularity/modularity_gen_core_links_random.csv")
# plant-pollinator subnetwork core removal
mod_pol_core_links = read.csv("output/data/core_links_removal/modularity/modularity_pol_core_links_random.csv")
# plant-ant subnetwork core removal
mod_ant_core_links = read.csv("output/data/core_links_removal/modularity/modularity_ant_core_links_random.csv")
# seed-dispersal subnetwork core removal
mod_disp_core_links = read.csv("output/data/core_links_removal/modularity/modularity_disp_core_links_random.csv")

# data frame with all modularity data
mod_all = data.frame(mod = rbind(mod_gen_core_links, mod_pol_core_links, mod_ant_core_links, mod_disp_core_links), 
                     subnetwork = rep(c("General core", "Pollination core", "Ant core", "Dispersal core"), each = 100))
# data frame with reference (core removal) mod data
mod_p_values = read.csv("output/data/core_links_removal/modularity/modularity_core_links_removal_p_values.csv")

mod_ref = data.frame(mod = mod_p_values$modularity, 
                     subnetwork = c("General core", "Pollination core", "Ant core", "Dispersal core"))

# plotting
palette = c("#F8766D", "#7CAE00", "#B79F00", "#C77CFF")
jpeg("output/figs/modularity_core_and_random_links_removal.jpeg", width = 1000, height = 1200, quality = 100)
ggplot(mod_all, aes(x = x, fill = subnetwork)) +
  scale_fill_manual(values = palette) +
  facet_wrap( ~ subnetwork, ncol = 2, scales = "free") +
  geom_density(alpha = 0.4, size = 1.25) + # density plot
  geom_vline(data = mod_ref, aes(xintercept = mod), size = 2, 
             linetype = "dashed") + # plotting vertical lines
  xlab("Modularity after link removal") +
  ylab("Density") +
  theme_bw() +
  theme(axis.text = element_text(size = 22), 
        axis.title = element_text(size = 35, face = "bold"),
        axis.title.y=element_text(margin=margin(0,15,0,0)), 
        strip.text.x = element_text(size = 27),
        legend.position = "none")
dev.off()

#-----------------------------------------------------------------------------------------------------#