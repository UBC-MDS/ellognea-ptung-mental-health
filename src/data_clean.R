library(tidyverse)

# read raw data
data <- read.csv("../data/raw/data_raw.csv")

# filter data
clean_data <- data %>%
  select("Age","Gender","Country","family_history","work_interfere","treatment","remote_work","benefits","seek_help","obs_consequence") %>%
  filter(Age>17 & Age<80)

# sex
clean_data <- clean_data %>% mutate(Gender = ifelse(Gender %in% c("Female", "female", "F", "f", "FEMALE"), "Female",
                                     ifelse(Gender %in% c("Male", "male","M","m","MALE","Mail", "maile", "Mal"), "Male", "Other")))
# work interfere
clean_data <- clean_data %>% mutate(work_interfere = ifelse(is.na(work_interfere), "None", work_interfere))

# age group
clean_data$age_group <- cut(clean_data$Age, breaks=c(18, 30, 40, 50, 60, 70, 80), right = FALSE, labels = FALSE)

# export csv
write.csv(clean_data, file = "../data/clean/data_clean.csv")


# # family history
# clean_data <- clean_data %>% mutate(family_history = ifelse(family_history == "Yes", 1.0, 0.0))
# 
# # remote work 
# clean_data <- clean_data %>% mutate(remote_work = ifelse(remote_work == "Yes", 1.0, 0.0))
# 
# # treatment 
# clean_data <- clean_data %>% mutate(treatment = ifelse(treatment == "Yes", 1.0, 0.0))
# 
# # benefits 
# clean_data <- clean_data %>% mutate(benefits = ifelse(benefits == "Yes", 1.0, ifelse(benefits == "No", 0.0, 2.0)))
