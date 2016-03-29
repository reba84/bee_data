# source("C:/Users/Becky/Documents/r_data_merge.R") LOADS FILES
library(dplyr)
library(tidyr)
#rm(list= ls(insect, cover, inflorescence))
setwd("C:/Users/Becky/Documents")
insect <- read.csv("insect.txt", na.strings="")
cover <- read.csv("cover.txt", na.strings="")
inflorescence <- read.csv("inflorescence.txt", na.strings="")
#merging csv files maintians joint coloumns and adds na for data in columns not shared by all sample type
jha_lab_data <- bind_rows(list(insect,cover,inflorescence))
#removes all rows with only na's and no other data besides barcode numbers
jha_lab_data <- filter(jha_lab_data, !(is.na(site) & is.na(insect_box_number)))
 
 alan_1_2012 <- jha_lab_data %>%
 filter(quadrat_type == "inflorescence") %>% 
 filter(!is.na(quadrat_plant_species)) %>% 
 filter(!is.na(inflorescence_count)) %>% 
 filter(sample_round == "1_2012") %>% 
 group_by(site,transect_point,quadrat_plant_genus,quadrat_plant_species) %>% 
 summarize(inflor_sum = sum(inflorescence_count)) %>%
 tbl_df %>% 
 unite(plant, quadrat_plant_genus, quadrat_plant_species, sep = " ", remove = TRUE) %>%
 unite(site_transect, site, transect_point, sep = " ", remove = TRUE) %>%
 spread(plant,inflor_sum,fill = 0)
 
 alan_2_2012 <- jha_lab_data %>%
 filter(quadrat_type == "inflorescence") %>% 
 filter(!is.na(quadrat_plant_species)) %>% 
 filter(!is.na(inflorescence_count)) %>% 
 filter(sample_round == "2_2012") %>% 
 group_by(site,transect_point,quadrat_plant_genus,quadrat_plant_species) %>% 
 summarize(inflor_sum = sum(inflorescence_count)) %>%
 tbl_df %>% 
 unite(plant, quadrat_plant_genus, quadrat_plant_species, sep = " ", remove = TRUE) %>%
 unite(site_transect, site, transect_point, sep = " ", remove = TRUE) %>%
 spread(plant,inflor_sum,fill = 0)
 
  alan_3_2012 <- jha_lab_data %>%
 filter(quadrat_type == "inflorescence") %>% 
 filter(!is.na(quadrat_plant_species)) %>% 
 filter(!is.na(inflorescence_count)) %>% 
 filter(sample_round == "3_2012") %>% 
 group_by(site,transect_point,quadrat_plant_genus,quadrat_plant_species) %>% 
 summarize(inflor_sum = sum(inflorescence_count)) %>%
 tbl_df %>% 
 unite(plant, quadrat_plant_genus, quadrat_plant_species, sep = " ", remove = TRUE) %>%
 unite(site_transect, site, transect_point, sep = " ", remove = TRUE) %>%
 spread(plant,inflor_sum,fill = 0)