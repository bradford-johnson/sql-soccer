#---- load packages ----
pacman::p_load(tidyverse,
               ggsoccer)

#----load data ----
shots <-read_csv("data/sql/epl_shots.csv") |>
  janitor::clean_names()

#---- clean data ----
shots <- shots |>
  mutate(x = position_x * 100, y = position_y * 100)

#---- explore data ----
shots |>
  filter(shot_result == "Goal") |>
  group_by(name) |>
  count() |>
  arrange(desc(n)) |>
  print(n = 50)

#---- wrangle data ----
selected_players <-c("Sadio Mané", "Raheem Sterling", "Romelu Lukaku", "Kevin De Bruyne")

#---- visualize ----
shots |>
  filter(shot_result == "Goal" & name %in% selected_players) |>
ggplot() +
  annotate_pitch(colour = "white",
                 fill   = "springgreen4",
                 limits = FALSE) +
  geom_bin_2d(aes(x = x, y = y), alpha = .6, bins = 31) +
  stat_bin2d(geom = "text", aes(x = x, y = y, label = after_stat(count)), bins = 31, color = "gray1", size = 4) +
  geom_label(aes(x = 62, y = 50, label = name), alpha = .5, fill = "springgreen4", label.size = NA) +
  theme_pitch() +
  theme(panel.background = element_rect(fill = "springgreen4")) +
  coord_flip(xlim = c(49, 101)) +
  scale_fill_viridis_c(option = "plasma") +
  scale_y_reverse() +
  facet_wrap(~name) +
  theme(legend.position = "none",
        strip.background = element_blank(),
        strip.text = element_blank())



