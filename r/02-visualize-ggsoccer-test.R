library(tidyverse)
library(ggsoccer)

shots <-read_csv("data/shots.csv") |>
  janitor::clean_names()

kb <- shots |>
  filter(shooter_id == 447)

kb <- kb |>
  mutate(x = position_x * 100, y = position_y * 100)

ggplot(kb) +
  annotate_pitch(colour = "white",
                 fill   = "springgreen4",
                 limits = FALSE) +
  geom_bin_2d(aes(x = x, y = y), alpha = .5) +
  theme_pitch() +
  theme(panel.background = element_rect(fill = "springgreen4")) +
  coord_flip(xlim = c(49, 101)) +
  scale_fill_continuous(type = "viridis") +
  scale_y_reverse()

