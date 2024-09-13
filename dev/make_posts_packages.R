### create posts using data ###

# make function with custom column names
create_post_packages <- function(df, folder_name,
                        title = "name", categories = "type", image = "image",
                        description = "description", github = "github", website = "website") {
  
  # helper function to create individual posts
  create_individual_post <- function(df, i, title_col, author_col, categories_col, image_col, description_col, github_col, website_col) {
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
    #post_author <- get_col_value(author_col)
    post_categories <- get_col_value(categories_col)
    post_image <- get_col_value(image_col)
    post_description <- get_col_value(description_col)
    post_github <- get_col_value(github_col)
    post_website <- get_col_value(website_col)
    
    file_name <- stringr::str_replace_all(tolower(post_title), " ", "_") # replace space with underscore
    file_path <- file.path(folder_name, paste0(file_name, ".qmd")) # create file path for post
    
    # Handle missing values inside the function
    post_categories <- ifelse(is.na(post_categories), "", post_categories)
    #post_author <- ifelse(is.na(post_author), "", post_author)
    post_image <- ifelse(is.na(post_image), "", post_image)
    post_description <- ifelse(is.na(post_description), "No description.", post_description)
    post_github <- ifelse(is.na(post_github), "", post_github)
    post_website <- ifelse(is.na(post_website), "", post_website)
    
    # prepare front matter
    yaml <- c(
      "---",
      paste("title:", shQuote(post_title)),
      #paste("author:", shQuote(post_author)),
      paste("categories:", "[", post_categories, "]"),
      paste("image:", shQuote(paste0("images/", post_image))),
      "---"
    )
    
    # prepare content
    content <- c(
      paste("##", "Description"),
      "",
      post_description,
      "",
      paste("##", "Link To GitHub Repository"),
      "",
      paste0('<a target="_blank" href="', post_github, '">', post_github, '</a>'),
      "",
      paste("##", "Link To Package Website"),
      "",
      paste0('<a target="_blank" href="', post_website, '">', post_website, '</a>')
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
      #author_col = author,
      categories_col = categories,
      image_col = image,
      description_col = description,
      github_col = github,
      website_col = website
    )
  }
}


# packages posts
df_packages <- read.csv("data/df_packages.csv") %>% as_tibble()

create_post_packages(df_packages, folder_name = "posts_packages")

