library(ggplot2)
library(ggrepel)
library(RColorBrewer)
library(tidyverse)

setwd('/Users/ddemszky/Google_Drive/Research/Framing/NAACL/framing-twitter')

# plot overall polarization
#data <- read.csv("data/output/polarization_noRT.csv",header=TRUE)
data <- read.csv("data/output/mutual_information_noRT.csv",header=TRUE)

lm(polarization ~ year, data=data %>% filter(is_actual == 'actual value')) %>% 
  summary() %>% 
  print()

ggplot(data, aes(x=year, y=polarization, color=is_actual))+
  stat_smooth(aes(group=is_actual), method=lm, se=TRUE, fullrange=TRUE) +
  geom_line(aes(group=label), color='gray75', linetype='dashed') +
  geom_point(aes(fill=is_actual), pch=21, size=2, colour='gray20')+
  geom_point() +
  geom_point(shape=1, size=2, colour='gray20') +
  geom_text_repel(data=subset(data, is_actual == 'actual value'), aes(label=label),color='gray10', show.legend = FALSE) +
  xlab('Year') +
  ylab('Mutual information') +
  theme_bw(base_size=13) +
  theme(legend.position="top", legend.direction="horizontal", legend.title = element_blank(), legend.box.margin=margin(-1,-10,-10,-10), panel.grid.major.x = element_blank(), panel.grid.minor = element_blank(), legend.text = element_text(margin = margin(r =10, unit = "pt"), size=12)) +
  scale_color_manual(values=c("indianred2", "lightsteelblue3")) +
  scale_x_continuous(limits = c(2015.5,2019.05), expand = c(0, 0)) 

ggplot(data, aes(x=year, y=polarization, color=is_actual))+
  stat_smooth(aes(group=is_actual), method=lm, se=TRUE, fullrange=TRUE) +
  geom_point(aes(fill=is_actual), pch=21, size=2, colour='gray20')+
  geom_point() +
  geom_point(shape=1, size=2, colour='gray20') +
  geom_text_repel(data=subset(data, is_actual == 'actual value'), aes(label=label),color='gray10', show.legend = FALSE) +
  xlab('Year') +
  ylab('Leave-out estimate') +
  theme_bw(base_size=13) +
  theme(legend.position="top", legend.direction="horizontal", legend.title = element_blank(), legend.box.margin=margin(-1,-10,-10,-10), panel.grid.major.x = element_blank(), panel.grid.minor = element_blank(), legend.text = element_text(margin = margin(r =10, unit = "pt"), size=12)) +
  scale_color_manual(values=c("indianred2", "lightsteelblue3")) +
  scale_x_continuous(limits = c(2015.5,2019.05), expand = c(0, 0))

data <- read.csv("data/output/mutual_information_topic_polarization_relative.csv",header=TRUE)

ggplot(data, aes(x=year, y=polarization, color=kind))+
  stat_smooth(aes(group=kind), method=lm, se=TRUE, fullrange=TRUE) +
  geom_line(aes(group=label), color='gray75', linetype='dashed') +
  geom_point(aes(fill=kind), pch=21, size=2, colour='gray20')+
  geom_point() +
  geom_point(shape=1, size=2, colour='gray20') +
  geom_text_repel(data=subset(data, kind == 'within-topic'), aes(label=label),color='gray10', show.legend = FALSE) +
  xlab('Year') +
  ylab('Polarization') +
  theme_bw(base_size=13) +
  theme(legend.position="none", legend.direction="horizontal", legend.title = element_blank(), legend.box.margin=margin(0,0,-10,0), legend.text = element_text(margin = margin(r =50, unit = "pt"), size=12), panel.grid.major.x = element_blank(), panel.grid.minor = element_blank()) +
  scale_color_manual(values=c("khaki1", "deeppink4")) +
  scale_y_continuous(limits = c(.5,.551), expand = c(0,0))+
  scale_x_continuous(limits = c(2015.5,2019.05), expand = c(0, 0)) 

# change legend position to "none" to make it disappear
ggplot(data, aes(x=year, y=polarization, color=kind))+
  stat_smooth(aes(group=kind), method=lm, se=TRUE, fullrange=TRUE) +
  geom_line(aes(group=label), color='gray75', linetype='dashed') +
  geom_point(aes(fill=kind), pch=21, size=2, colour='gray20')+
  geom_point() +
  geom_point(shape=1, size=2, colour='gray20') +
  geom_text_repel(data=subset(data, kind == 'within-topic'), aes(label=label),color='gray10', show.legend = FALSE) +
  xlab('Year') +
  ylab('Polarization') +
  theme_bw(base_size=13) +
  theme(legend.position="top", legend.direction="horizontal", legend.title = element_blank(), legend.box.margin=margin(0,0,-10,0), legend.text = element_text(margin = margin(r =50, unit = "pt"), size=12), panel.grid.major.x = element_blank(), panel.grid.minor = element_blank()) +
  scale_color_manual(values=c("khaki1", "deeppink4")) +
  scale_y_continuous(limits = c(.5,.551), expand = c(0,0))+
  scale_x_continuous(limits = c(2015.5,2019.05), expand = c(0, 0)) 

ggplot(data %>% filter(kind=='between-topic'), aes(x=year, y=polarization))+
  stat_smooth(method=lm, se=TRUE, fullrange=TRUE, color='khaki1') +
  geom_point(pch=21, size=2, colour='gray20')+
  geom_point(colour='khaki1') +
  geom_point(shape=1, size=2, colour='gray20') +
  geom_text_repel(aes(label=label),color='gray10', show.legend = FALSE) +
  xlab('Year') +
  ylab('Polarization') +
  theme_bw(base_size=13) +
  theme(legend.position="none", legend.direction="horizontal", legend.title = element_blank(), legend.box.margin=margin(0,0,-10,0), legend.text = element_text(margin = margin(r =50, unit = "pt"), size=12), panel.grid.major.x = element_blank(), panel.grid.minor = element_blank()) +
  scale_x_continuous(limits = c(2015.5,2019.05), expand = c(0, 0))+
  scale_y_continuous(limits = c(.5,.551), expand = c(0,0))+
scale_color_manual(values=c("khaki1", "deeppink4"))
