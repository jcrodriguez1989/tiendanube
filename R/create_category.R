#' Create a New Category
#'
#' Needs "Edit Products" permissions.
#' Docs: https://tiendanube.github.io/api-documentation/resources/category .
#'
#' @param store_id The ID of the store.
#' @param name List of the names of the Category, in every language supported by the store.
#' @param description List of the descriptions of the Category, as HTML, in every language supported
#'   by the store.
#' @param handle List of the url-friendly strings generated from the Category's names, in every
#'   language supported by the store.
#' @param parent Id of the Category's parent.
#' @param subcategories The ids of the Category's first level subcategories.
#' @param google_shopping_category Attributes used to categorize an item. This category is selected
#'   from the Google’s taxonomy. The full list of product categories can be found here:
#'   https://www.google.com/basepages/producttype/taxonomy.es-ES.txt .
#' @param access_token The store's access token for your app.
#'
#' @importFrom httr add_headers content POST
#'
#' @export
#'
create_category <- function(store_id, name, description = NULL, handle = NULL, parent = NULL,
                            subcategories = NULL, google_shopping_category = NULL,
                            access_token = Sys.getenv("TIENDANUBE_ACCESS_TOKEN")) {
  POST(
    paste0(api_url, store_id, "/categories"),
    body = list(
      name = name, description = description, handle = handle, parent = parent,
      subcategories = subcategories, google_shopping_category = google_shopping_category
    ),
    encode = "json",
    add_headers(Authentication = paste("bearer", access_token))
  ) |> content(as = "parsed", simplifyVector = TRUE)
}
