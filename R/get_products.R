#' Get Products
#'
#' Receive a list of Products.
#' Docs: https://tiendanube.github.io/api-documentation/resources/product .
#'
#' @param store_id The ID of the store.
#' @param page Page to retrieve.
#' @param created_at_min Show Products created after date (ISO 8601 format).
#' @param created_at_max Show Products created before date (ISO 8601 format).
#' @param updated_at_min Show Products last updated after date (ISO 8601 format).
#' @param updated_at_max Show Products last updated before date (ISO 8601 format).
#' @param per_page Amount of results.
#' @param fields Comma-separated list of fields to include in the response.
#' @param access_token The store's access token for your app.
#'
#' @importFrom httr add_headers content GET
#'
#' @export
#'
get_products <- function(store_id, page, created_at_min = NULL, created_at_max = NULL,
                         updated_at_min = NULL, updated_at_max = NULL, per_page = 200,
                         fields = NULL, access_token = Sys.getenv("TIENDANUBE_ACCESS_TOKEN")) {
  GET(
    paste0(api_url, store_id, "/products"),
    query = list(
      created_at_min = created_at_min, created_at_max = created_at_max,
      updated_at_min = updated_at_min, updated_at_max = updated_at_max,
      page = page, per_page = per_page, fields = fields
    ),
    add_headers(Authentication = paste("bearer", access_token))
  ) |> content(as = "parsed", simplifyVector = TRUE)
}

#' Get All Products
#'
#' Receive a list of all Products.
#'
#' @param store_id The ID of the store.
#' @param created_at_min Show Products created after date (ISO 8601 format).
#' @param created_at_max Show Products created before date (ISO 8601 format).
#' @param updated_at_min Show Products last updated after date (ISO 8601 format).
#' @param updated_at_max Show Products last updated before date (ISO 8601 format).
#' @param fields Comma-separated list of fields to include in the response.
#' @param max_pages Max pages to query.
#' @param access_token The store's access token for your app.
#'
#' @importFrom dplyr bind_rows
#'
#' @export
#'
get_all_products <- function(store_id, created_at_min = NULL, created_at_max = NULL,
                             updated_at_min = NULL, updated_at_max = NULL, fields = NULL,
                             max_pages = Inf,
                             access_token = Sys.getenv("TIENDANUBE_ACCESS_TOKEN")) {
  page <- 1
  products <- data.frame()
  while (page <= max_pages) {
    new_products <- get_products(
      store_id, page, created_at_min, created_at_max, updated_at_min, updated_at_max,
      fields = fields, access_token = access_token
    )
    if (isTRUE(new_products$code == 404) || length(new_products) == 0) {
      break
    }
    products <- bind_rows(new_products, products)
    page <- page + 1
  }
  return(products)
}
