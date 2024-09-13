### create posts using data ###

# import data
df_resources <- read.csv("data/df_resources.csv") %>% as_tibble() %>%
  mutate(combined_tags = paste0(type, ", ", tags)) #%>% mutate(description = "example description")

# make function with custom column names
create_post <- function(df, folder_name,
                        title = "name", author = "author", categories = "combined_tags",
                        image = "image", link = "link", description = NULL) {
  
  # helper function to create individual posts
  create_individual_post <- function(title, author, link, categories, image, description) {
    file_name <- stringr::str_replace_all(tolower(title), " ", "_") # replace space with underscore
    file_path <- file.path(folder_name, paste0(file_name, ".qmd")) # create file path for post
    
    categories <- ifelse(is.na(categories), "", categories)
    description <- ifelse(is.na(description), "", description)
    
    
    # prepare front matter
    yaml <- c(
      "---",
      paste("title:", shQuote(title)),
      paste("author:", shQuote(author)),
      paste("categories:", "[", categories, "]"),
      paste("image:", shQuote(paste0("images/", image))),
      "---"
    )
    
    # prepare content
    content <- c(
      paste("##", "Description"),
      "",
      description,
      "",
      paste("##", "Link To Resource"),
      "",
      paste0('<a target="_blank" href="', link, '">', link, '</a>')
    )
    
    # write to posts folder
    writeLines(c(yaml, "", content), file_path)
  }
  
  # iterate over rows of the dataframe
  for (i in 1:nrow(df)) {
    create_individual_post(
      title = df[[title]][i],
      author = df[[author]][i],
      link = df[[link]][i],
      categories = ifelse(is.null(df[[categories]][i]), "", df[[categories]][i]),
      image = ifelse(is.null(df[[image]][i]), "", df[[image]][i]),
      description = ifelse(description %in% colnames(df), df[[description]][i], "")
    )
  }
}

# Use function to create posts
create_post(df_resources, folder_name = "posts_resources",
            title = "name", author = "author", categories = "combined_tags", link = "link", image = "image")


