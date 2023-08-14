library(worldfootballR)
library(ggplot2)
library(dplyr)
library(ggrepel)
library(ggforce)
library(stringr)
library(ggsoccer)

fb_teams_urls(
  league_url = "https://fbref.com/en/comps/13/Ligue-1-Stats"
)

match_urls <- fb_match_urls(
  country = 'FRA',
  gender = 'M',
  season_end_year = '2024',
  tier = '1st'
)

match_stat_team <- fb_advanced_match_stats(
  match_url = match_urls[3],
  stat_type = "summary",
  team_or_player = 'team')

match_stat_player <- fb_advanced_match_stats(
  match_url = match_urls[3],
  stat_type = "summary",
  team_or_player = 'player')

match_stat_player$color <- ifelse(match_stat_player$Player == "Lee Kangin", 1, 0)
match_stat_player$npxG.xAG_Expected <- match_stat_player$npxG_Expected + match_stat_player$xAG_Expected

data <- read.csv('./allplayers.csv')
PSG <- data %>% filter(str_detect(Squad, 'Paris'))
PSG$color = ifelse(PSG$Player == 'Lionel Messi', 1, 0)

ggplot(data = PSG, aes(x = MP_Playing, y = Cmp_Total)) +
  geom_point(aes(size = KP/MP_Playing), alpha =.2) +
  geom_text_repel(aes(label = Player), nudge_y = 20) +
  scale_y_continuous(labels = scales::comma) +
  theme_bw() +
  labs(title = "Key Stats of PSG Players in 2022/2023 Season",
       subtitle = "",
       x = "Number of Matches Played", y = "Total Completed Passes",
       size = "Key Pass/Match") +
  theme(
    panel.background = element_rect(fill = 'grey100')
  ) +
  geom_mark_circle(aes(x = 32.5, y = 1650, label = ""),
                   radius = unit(15, "mm"), colour = 'blue', size = 1,
                   label.fill = NA, con.colour = NA, label.colour = 'blue',
                   label.buffer = unit(5, 'mm'))

PSG %>% 
  select( npxG.xAG_Expected, Player, color) %>% arrange(desc(npxG.xAG_Expected)) %>% head(10) %>%
  ggplot(data = ., aes (x = reorder(Player, -npxG.xAG_Expected), y = npxG.xAG_Expected, fill = color)) +
  geom_col() +
  labs(
    title = "Expected Goals and Assists Excluding Penalty Kicks",
    x = element_blank(),
    y = "Expected Goals and Assists"
  ) +
  scale_x_discrete(guide = guide_axis(n.dodge = 2)) +
  theme(
    legend.position = "none"
  )

match_stat_player %>% 
  select(npxG.xAG_Expected, Player, color) %>% arrange(desc(npxG.xAG_Expected)) %>% head(7) %>%
  ggplot(data = ., aes (x = reorder(Player, -npxG.xAG_Expected), y = npxG.xAG_Expected, fill = color)) +
  geom_col() +
  labs(
    title = "Expected Goals and Assists Excluding Penalty Kicks",
    x = element_blank(),
    y = "Expected Goals and Assists"
  ) +
  scale_x_discrete(guide = guide_axis(n.dodge = 2)) +
  theme(
    legend.position = "none"
  )

ligue1_result <- understat_league_match_results(
  league = 'Ligue 1',
  season_start_year = "2023"
)
PSG_match_shots <- understat_match_shots(match_url = "https://understat.com/match/23379")

# Pitch 만들기
ggplot(data = PSG_match_shots) +
  annotate_pitch(colour = 'white', fill = 'springgreen4', limits = TRUE) +
  geom_point(aes(x = X*100, y=Y*100, size=xG, colour = result)) +
  scale_color_manual(breaks = c("BlockedShot", "MissedShots", "SavedShot", "ShotOnPost"),
                     values = c('red', 'blue', 'yellow', 'grey')) +
  coord_flip(xlim = c(49, 101)) +
  scale_y_reverse() + 
  theme_pitch() +
  theme(panel.background = element_rect(fill = "springgreen4"),
        legend.text = element_text(size = 15),
        legend.title = element_text(size = 15)) +
  guides(color = guide_legend(title = ""))

match_stat_player %>% 
  select( PrgP_Passes, Player, color) %>% arrange(desc(PrgP_Passes)) %>% head(10) %>%
  ggplot(data = ., aes (x = reorder(Player, -PrgP_Passes), y = PrgP_Passes, fill = color)) +
  geom_col() +
  labs(
    title = "Progressive Passes Completed",
    x = element_blank(),
    y = "Progressive Passes"
  ) +
  scale_x_discrete(guide = guide_axis(n.dodge = 2)) +
  theme(
    legend.position = "none"
  )

match_stat_player %>% 
  select( PrgC_Carries, Player, color) %>% arrange(desc(PrgC_Carries)) %>% head(10) %>%
  ggplot(data = ., aes (x = reorder(Player, -PrgC_Carries), y = PrgC_Carries, fill = color)) +
  geom_col() +
  labs(
    title = "Progressive Carries Completed",
    x = element_blank(),
    y = "Progressive Carries"
  ) +
  scale_x_discrete(guide = guide_axis(n.dodge = 2)) +
  theme(
    legend.position = "none"
  )
# Carries_Carries, PrgP_Passes, PrgC_Carries, 

