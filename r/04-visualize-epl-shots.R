library(tidyverse)
library(ggsoccer)

shots <-read_csv("data/sql/epl_shots.csv") |>
  janitor::clean_names()

shots <- shots |>
  mutate(x = position_x * 100, y = position_y * 100)

ggplot(shots) +
  annotate_pitch(colour = "white",
                 fill   = "springgreen4",
                 limits = FALSE) +
  geom_bin_2d(aes(x = x, y = y), alpha = .6) +
  theme_pitch() +
  theme(panel.background = element_rect(fill = "springgreen4")) +
  coord_flip(xlim = c(49, 101)) +
  scale_fill_viridis_c(option = "plasma") +
  scale_y_reverse() +
  facet_wrap(~shot_result)


shots |>
  filter(shot_result == "Goal") |>
ggplot() +
  annotate_pitch(colour = "white",
                 fill   = "springgreen4",
                 limits = FALSE) +
  geom_bin_2d(aes(x = x, y = y), alpha = .6) +
  theme_pitch() +
  theme(panel.background = element_rect(fill = "springgreen4")) +
  coord_flip(xlim = c(49, 101)) +
  scale_fill_viridis_c(option = "plasma") +
  scale_y_reverse() +
  facet_wrap(~shot_type)
