# create posts using data

# import data
df_resources <- read.csv("data/df_resources.csv") %>% as_tibble() %>%
  mutate(combined_tags = paste0(type, ", ", tags))
#df_resources_json <- jsonlite::toJSON(df_resources, pretty = TRUE)
#writeLines(df_resources_json, "data/df_resources_json.json")

# make function
create_post <- function(folder_name, name, author, link, tags, type, source, image){
  file_name <- stringr::str_replace_all(tolower(name), " ", "_") # replace space with underscore
  file_path <- file.path(folder_name, paste0(file_name, ".qmd")) # create file path for post
  
  if (is.na(tags)) { # test
    tags <- ""
  }
  
  # prepare front matter
  yaml <- c(
    "---",
    paste("title:", shQuote(name)),
    paste("author:", shQuote(author)),
    paste("categories:", "[", tags, "]"),
    paste("image:", shQuote(paste0("images/", image))),
    "---"
  )
  
  # prepare content
  content <- c(
    paste("##", "Description"),
    "",
    #description,
    "",
    paste("##", "Link To Resource"),
    "",
    paste0('<a target="_blank" href="', link, '">', link, "'</a>")
  )
  
  # write to posts folder
  writeLines(c(yaml, "", content), file_path)
  
}


for (i in 1:nrow(df_resources)) {
  create_post(
    folder_name = "posts_resources",
    name = df_resources$name[i],
    author = df_resources$author[i],
    link = df_resources$link[i],
    tags = ifelse(is.null(df_resources$combined_tags[i]), "", df_resources$combined_tags[i]),
    image = ifelse(is.null(df_resources$image[i]), "", df_resources$image[i])
    #description = ""
  )
}



