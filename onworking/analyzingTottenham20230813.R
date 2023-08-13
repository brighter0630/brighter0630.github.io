library(ggplot2)
library(dplyr)
library(ggrepel)
library(ggforce)
library(tidyr)

data <- read.csv('allplayers.csv')

Tottenham <- data %>% filter(Squad == 'Tottenham')
Tottenham$color = ifelse(Tottenham$Player == 'Son Heung-min', 1, 0)

ggplot(data = Tottenham, aes(x = MP_Playing, y = Cmp_Total)) +
  geom_point(aes(size = KP/MP_Playing), alpha =.2) +
  geom_text_repel(aes(label = Player), nudge_y = 20) +
  scale_y_continuous(labels = scales::comma) +
  theme_bw() +
  labs(title = "Key Stats of Tottenham Players in 2022/2023 Season",
       subtitle = "",
       x = "Number of Matches Played", y = "Total Completed Passes",
       size = "Key Pass/Match") +
  theme(
    panel.background = element_rect(fill = 'grey100')
  ) +
  geom_mark_circle(aes(x = 36.5, y = 625, label = "Son & Kane"),
                   radius = unit(15, "mm"), colour = 'blue', size = 1,
                   label.fill = NA, con.colour = NA, label.colour = 'blue',
                   label.buffer = unit(5, 'mm'))
Tottenham %>% 
  filter(Player %in% c("Son Heung-min", "Harry Kane")) %>%
  ggplot(data = ., aes(x = Player, y = KP/MP_Playing, fill=Player)) +
  geom_col(alpha = .8) +
  scale_y_continuous(limits = c(0, 2)) +
  labs(
    title = "Comparison between Kane And Son",
    x = element_blank(),
    y = "Key Passes per Match"
  ) +
  theme_bw()

Tottenham %>% 
  filter(Player %in% c("Son Heung-min", "Harry Kane")) %>%
  select( Final_Third, Player) %>%
  ggplot(data = ., aes ( x = Player, y = Final_Third, fill = Player)) +
  geom_col(alpha = .8) +
  labs(
    title = "Comparison between Kane And Son",
    x = element_blank()
  )

Tottenham %>% 
  filter(Player %in% c("Son Heung-min", "Harry Kane")) %>%
  select( Final_Third_Carries, Player) %>%
  ggplot(data = ., aes ( x = Player, y = Final_Third_Carries, fill = Player)) +
  geom_col(alpha = .8) +
  labs(
    title = "Comparison between Kane And Son",
    x = element_blank()
  )

Tottenham %>% 
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

