#-----------------------------------------------------------------------------------------------------#

# Description:
#
# Returns:
#

library(ggplot2)

# seed-dispersal subnetwork core removal
NODF_disp_core = read.csv("output/data/core_species_removal/nestedness/NODF_disp_core_removal.csv")
NODF_obs_disp = NODF_disp_core[1, 1] # observed nestedness
NODF_no_disp_core = NODF_disp_core[2, 1] # nestedness without the core
NODF_ref = data.frame(type = c("obs", "core_removal"), 
                      NODF = c(NODF_obs_disp, NODF_no_disp_core))
NODF_random_disp = data.frame(NODF = NODF_disp_core[-c(1, 2), 1]) # nestedness after random sp removal
# plotting
ggplot(NODF_random_disp, aes(x = NODF)) + 
  geom_density(alpha = 0.4, size = 0.8, fill = "#7CAE00") + # density plot
  geom_vline(data = NODF_ref, # plotting vertical lines
             aes(xintercept = NODF,  colour = type), 
             linetype = "dashed", size = 1) +
  scale_colour_manual(values = c("red", "black")) +
  scale_x_continuous(limits = c(6, 7.25)) +
  theme_bw() +
  theme(axis.text = element_text(size = 15), 
        axis.title = element_text(size = 20),
        legend.position = "none")

#-----------------------------------------------------------------------------------------------------#