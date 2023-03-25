library(tidyverse)
library(ggsoccer)

shots <-read_csv("data/shots.csv") |>
  janitor::clean_names()

shots <- shots |>
  filter(shooter_id == 447 & situation == "DirectFreekick")

shots <- shots |>
  mutate(x = position_x * 100, y = position_y * 100)

ggplot(shots) +
  annotate_pitch(colour = "white",
                 fill   = "springgreen4",
                 limits = FALSE) +
  geom_point(aes(x = x, y = y),
             colour = "yellow",
             size = 4) +
  theme_pitch() +
  theme(panel.background = element_rect(fill = "springgreen4")) +
  coord_flip(xlim = c(49, 101)) +
  scale_y_reverse()
