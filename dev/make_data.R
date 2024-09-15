# import library
library(tidyverse)

# make data
df_resources <- tibble(name = paste0(rep("resource", 15), seq(1:15)),
                       author = paste0(rep("author", 15), rep(c("A", "B", "C", "D", "E"), times = c(3, 2, 6, 1, 3))),
                       link = rep("https://quarto.org/docs/websites/", 15),
                       tags = c(
                         c("tagA, tagB, tagC"),
                         c("tagA"),
                         c("tagB"),
                         c("tagA, tagC, tagD, tagD"),
                         c("tagA, tagD"),
                         c("tagB"),
                         c("tagA, tagE"),
                         c("tagA, tagB, tagD"),
                         c("tagA, tagC"),
                         c("tagA, tagB, tagD"),
                         c("tagB"),
                         c("tagB"),
                         c("tagA, tagD"),
                         c("tagC"),
                         c("tagD")
                       ),
                       type = rep(c("written", "book", "summary", "course", "interactive"), each = 3),
                       source = rep(c("internal", "external"), c(13, 2)),
                       image = rep("icon_folder.PNG", 15))

df_multimedia <- tibble(name = paste0(rep("multimedia", 10), seq(1:10)),
                        author = paste0(rep("author", 10), rep(c("A", "B", "C"), times = c(3, 5, 2))),
                        link = rep("https://quarto.org/docs/websites/", 10),
                        tags = c(
                          c("tagA, tagB"),
                          c("tagA"),
                          c("tagB"),
                          c("tagA, tagC"),
                          c("tagC"),
                          c("tagB"),
                          c("tagB, tagC"),
                          c("tagA"),
                          c("tagA, tagC"),
                          c("tagB")
                        ),
                        type = rep(c("video", "podcast"), each = 5),
                        image = rep("icon_multimedia.PNG", 10),
                        description = rep("Lorem ipsum dolor sit amet.", 10))

df_packages <- tibble(name = paste0(rep("package", 15), seq(1:15)),
                      github = rep("https://github.com/tidyverse/dplyr", 15),
                      website = rep("https://dplyr.tidyverse.org/", 15),
                      image = rep("icon_box.PNG", 15),
                      description = rep("Lorem ipsum dolor sit amet.", 15),
                      type = rep(c("internal", "external", "collaboration"), c(8, 5, 2)))


# view data
df_resources
df_packages
df_multimedia


write.csv(df_resources, "data/df_resources.csv", row.names = FALSE)
write.csv(df_packages, "data/df_packages.csv", row.names = FALSE)
write.csv(df_multimedia, "data/df_multimedia.csv", row.names = FALSE)

