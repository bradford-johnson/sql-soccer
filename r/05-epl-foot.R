#---- load packages ----
pacman::p_load(tidyverse,
               ggsoccer,
               showtext,
               htmltools)

showtext_auto()

#----load data ----
shots <-read_csv("data/sql/epl_shots.csv") |>
  janitor::clean_names()

#---- clean data ----
shots <- shots |>
  mutate(x = position_x * 100, y = position_y * 100)

#---- explore data ----
shots |>
  filter(shot_result == "Goal" & situation != "Penalty") |>
  group_by(shot_type) |>
  count()

#---- wrangle data ----
shot_types <- c("LeftFoot", "RightFoot")

shots <- shots |>
  filter(shot_result == "Goal" & shot_type %in% shot_types & situation != "Penalty") |>
  mutate(shot_type = case_when(shot_type == "LeftFoot" ~ "Left foot shots",
                               shot_type == "RightFoot" ~ "Right foot shots"))

#---- create labs ----
title = "Premier League Goals 2014-2020"
subtitle = "Excluding PKs, 36.8% percent of goals scored were shot with the left foot."

caption = paste0(
  "<span style='font-family:fb;color:#ffffff;'>&#xf09b;</span>", "<span style='font-family:sans;color:#008b45;'>.</span>",
  "<span style='font-family:Dosis;color:#ffffff;'>bradfordjohnson</span>"
)


#---- load fonts ----
font_add(
  family = "fb", regular = "C:/Users/Bradf/AppData/Local/Microsoft/Windows/Fonts/Font Awesome 6 Brands-Regular-400.otf"
)

font_add_google("Tauri", "Tauri")
font_1 <- "Tauri"

font_add_google("Urbanist", "Urbanist")
font_2 <- "Urbanist"

font_add_google(name = "Dosis", family = "Dosis")

#---- load colors ----
bg_1 <- "springgreen4"

#---- visualize ----
shots |>
  ggplot() +
  annotate_pitch(colour = "white",
                 fill   = "springgreen4",
                 limits = FALSE) +
  geom_bin_2d(aes(x = x, y = y), alpha = .5, bins = 31) +
  stat_bin2d(geom = "text", aes(x = x, y = y, label = after_stat(count)), bins = 31, color = "white", family = font_1, size = 2.5, alpha = .7) +
  # geom_label(data = lab_shot, aes(x = 52, y = 80, label = shot_type), alpha = .5, fill = "springgreen4", label.size = NA, family = font_1, size = 7, color = "white") +
  theme_pitch() +
  theme(panel.background = element_rect(fill = "springgreen4")) +
  coord_flip(xlim = c(52.25, 101)) +
  scale_fill_viridis_c(option = "plasma") +
  scale_y_reverse() +
  facet_wrap(~shot_type) +
  labs(title = title,
       subtitle = subtitle,
       caption = caption) +
  theme(legend.position = "none",
        strip.background = element_blank(),
        strip.text = element_text(family = font_1, color = "white", size = 20),
        plot.caption = ggtext::element_textbox_simple(size = 17, margin = margin(4, 0, 1, 0, "mm"), halign = 1),
        plot.title = element_text(family = font_1, size = 30, margin = margin(2, 0, 0, 0, "mm"), color = "white"),
        plot.subtitle = element_text(family = font_2, size = 20, margin = margin(1, 0, 2, 0, "mm"), color = "white"),
        plot.margin = unit(c(2,2,0,2), "mm"),
        axis.title = element_blank(),
        axis.text = element_blank(),
        plot.background = element_rect(color = bg_1, fill = bg_1),
        panel.background = element_rect(color = bg_1, fill = bg_1))

ggsave("visuals/foot.png", width = 6, height = 3, dpi = 320)
