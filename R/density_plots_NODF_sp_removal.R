#-----------------------------------------------------------------------------------------------------#

# Description:
#   Plots the distribution of nestedness values of randomly rarefied networks and 2 reference values:
#   (1) the nestedness value of the complete network and (2) the nestedness value of the network without
#   the core species of a certain subnetwork.
# Returns:
#   Saves 4 plots as jpeg files.

library(ggplot2)

# general core removal
NODF_gen_core = read.csv("output/data/core_species_removal/nestedness/NODF_general_core_removal.csv")
# data frame with nestedness of complete network and nesteness without the general core
NODF_ref_gen = data.frame(type = c("complete", "gen_core_removed"), NODF = NODF_gen_core[c(1, 2), 1])
NODF_random_gen = data.frame(NODF = NODF_gen_core[-c(1, 2), 1]) # nestedness after random sp removal
# calculating p value
p_gen = sum(NODF_random_gen < NODF_ref_gen[2, 2])/nrow(NODF_random_gen)
# plotting
ggplot(NODF_random_gen, aes(x = NODF)) + 
  geom_density(alpha = 0.4, size = 0.8, fill = "#B79F00") + # density plot
  geom_vline(data = NODF_ref_gen, # plotting vertical lines
             aes(xintercept = NODF,  colour = type), 
             linetype = "dashed", size = 1) +
  scale_colour_manual(values = c("black", "red")) +
  scale_x_continuous(limits = c(0, 8)) +
  xlab("Nestedness") +
  ylab("Density") +
  theme_bw() +
  theme(axis.text = element_text(size = 15), 
        axis.title = element_text(size = 20),
        legend.position = "none")

# plant-pollinator subnetwork core removal
NODF_pol_core = read.csv("output/data/core_species_removal/nestedness/NODF_pollination_core_removal.csv")
# data frame with nestedness of complete network and nesteness without the pollination core
NODF_ref_pol = data.frame(type = c("complete", "pol_core_removed"), NODF = NODF_pol_core[c(1, 2), 1])
NODF_random_pol = data.frame(NODF = NODF_pol_core[-c(1, 2), 1]) # nestedness after random sp removal
# calculating p value
p_pol = sum(NODF_random_pol < NODF_ref_pol[2, 2])/nrow(NODF_random_pol)
# plotting
ggplot(NODF_random_pol, aes(x = NODF)) + 
  geom_density(alpha = 0.4, size = 0.8, fill = "#C77CFF") + # density plot
  geom_vline(data = NODF_ref_pol, # plotting vertical lines
             aes(xintercept = NODF,  colour = type), 
             linetype = "dashed", size = 1) +
  scale_colour_manual(values = c("black", "red")) +
  scale_x_continuous(limits = c(2.5, 7.5)) +
  xlab("Nestedness") +
  ylab("Density") +
  theme_bw() +
  theme(axis.text = element_text(size = 15), 
        axis.title = element_text(size = 20),
        legend.position = "none")

# plant-ant subnetwork core removal
NODF_ant_core = read.csv("output/data/core_species_removal/nestedness/NODF_ant_core_removal.csv")
# data frame with nestedness of complete network and nesteness without the ant core
NODF_ref_ant = data.frame(type = c("complete", "ant_core_removed"), NODF = NODF_ant_core[c(1, 2), 1])
NODF_random_ant = data.frame(NODF = NODF_ant_core[-c(1, 2), 1]) # nestedness after random sp removal
# calculating p value
p_ant = sum(NODF_random_ant < NODF_ref_ant[2, 2])/nrow(NODF_random_ant)
# plotting
ggplot(NODF_random_ant, aes(x = NODF)) + 
  geom_density(alpha = 0.4, size = 0.8, fill = "#F8766D") + # density plot
  geom_vline(data = NODF_ref_ant, # plotting vertical lines
             aes(xintercept = NODF,  colour = type), 
             linetype = "dashed", size = 1) +
  scale_colour_manual(values = c("red", "black")) +
  scale_x_continuous(limits = c(5, 7.25)) +
  xlab("Nestedness") +
  ylab("Density") +
  theme_bw() +
  theme(axis.text = element_text(size = 15), 
        axis.title = element_text(size = 20),
        legend.position = "none")

# seed-dispersal subnetwork core removal
NODF_disp_core = read.csv("output/data/core_species_removal/nestedness/NODF_disp_core_removal.csv")
NODF_ref_disp = data.frame(type = c("complete", "disp_core_removed"), NODF = NODF_disp_core[c(1, 2), 1])
NODF_random_disp = data.frame(NODF = NODF_disp_core[-c(1, 2), 1]) # nestedness after random sp removal
# calculating p value
p_disp = sum(NODF_random_disp < NODF_ref_disp[2, 2])/nrow(NODF_random_disp)
# plotting
ggplot(NODF_random_disp, aes(x = NODF)) + 
  geom_density(alpha = 0.4, size = 0.8, fill = "#7CAE00") + # density plot
  geom_vline(data = NODF_ref_disp, # plotting vertical lines
             aes(xintercept = NODF,  colour = type), 
             linetype = "dashed", size = 1) +
  scale_colour_manual(values = c("black", "red")) +
  scale_x_continuous(limits = c(6, 7.25)) +
  xlab("Nestedness") +
  ylab("Density") +
  theme_bw() +
  theme(axis.text = element_text(size = 15), 
        axis.title = element_text(size = 20),
        legend.position = "none")

#-----------------------------------------------------------------------------------------------------#