### create posts using data ###

# make function with custom column names
create_post <- function(df, folder_name,
                        title = "name", author = "author", categories = "combined_tags",
                        image = "image", link = "link") {
  
  # helper function to create individual posts
  create_individual_post <- function(df, i, title_col, author_col, link_col, categories_col, image_col) {
    # Safely extract column values or provide default empty values
    get_col_value <- function(col_name) {
      if (col_name %in% colnames(df)) {
        return(df[[col_name]][i])
      } else {
        return(NA)  # Default if column is missing
      }
    }
    
    # Extract values using helper function
    post_title <- get_col_value(title_col)
    post_author <- get_col_value(author_col)
    post_link <- get_col_value(link_col)
    post_categories <- get_col_value(categories_col)
    post_image <- get_col_value(image_col)
    
    file_name <- stringr::str_replace_all(tolower(post_title), " ", "_") # replace space with underscore
    file_path <- file.path(folder_name, paste0(file_name, ".qmd")) # create file path for post
    
    # Handle missing values inside the function
    post_categories <- ifelse(is.na(post_categories), "", post_categories)
    post_author <- ifelse(is.na(post_author), "", post_author)
    post_image <- ifelse(is.na(post_image), "", post_image)
    
    # prepare front matter
    yaml <- c(
      "---",
      paste("title:", shQuote(post_title)),
      paste("author:", shQuote(post_author)),
      paste("categories:", "[", post_categories, "]"),
      paste("image:", shQuote(paste0("images/", post_image))),
      "---"
    )
    
    # prepare content
    content <- c(
      paste("##", "Link To Resource"),
      "",
      paste0('<a target="_blank" href="', post_link, '">', post_link, '</a>')
    )
    
    # write to posts folder
    writeLines(c(yaml, "", content), file_path)
  }
  
  # iterate over rows of the dataframe
  for (i in 1:nrow(df)) {
    create_individual_post(
      df = df,
      i = i,
      title_col = title,
      author_col = author,
      link_col = link,
      categories_col = categories,
      image_col = image
    )
  }
}


# resources posts
df_resources <- read.csv("data/df_resources.csv") %>% as_tibble() %>%
  mutate(combined_tags = paste0(type, ", ", tags)) #%>% mutate(description = "example description")

create_post(df_resources, folder_name = "posts_resources",
            title = "name", author = "author", categories = "combined_tags", link = "link", image = "image")

