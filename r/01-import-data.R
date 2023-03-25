# load packages
library(tidyverse)
library(DBI)
library(RPostgres)

# load data
appearances <-read_csv("data/appearances.csv") |>
  janitor::clean_names()

games <-read_csv("data/games.csv") |>
  janitor::clean_names()

leagues <-read_csv("data/leagues.csv") |>
  janitor::clean_names()

#readr::guess_encoding()
players <-read.csv("data/players.csv", fileEncoding = "ISO-8859-1") |>
  janitor::clean_names()

shots <-read_csv("data/shots.csv") |>
  janitor::clean_names()

teams <-read_csv("data/teams.csv") |>
  janitor::clean_names()

teamstats <-read_csv("data/teamstats.csv") |>
  janitor::clean_names()

# connect to database
con <- dbConnect(RPostgres::Postgres(),dbname = 'postgres',
                 host = 'localhost',
                 port = 5432,
                 user = 'postgres',
                 password = 'vannah')

# create tables in database
dbWriteTable(con, "appearances", appearances, append = TRUE)

dbWriteTable(con, "games", games, append = TRUE)

dbWriteTable(con, "leagues", leagues, append = TRUE)

dbWriteTable(con, "players", players, append = TRUE)

dbWriteTable(con, "shots", shots, append = TRUE)

dbWriteTable(con, "teams", teams, append = TRUE)

dbWriteTable(con, "teamstats", teamstats, append = TRUE)
# disconnect from database
dbDisconnect(con)
