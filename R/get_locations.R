#' Get Locations
#'
#' Receive a list of Locations.
#' Docs: https://tiendanube.github.io/api-documentation/resources/location .
#'
#' @param store_id The ID of the store.
#' @param page Page to retrieve.
#' @param created_at_min Show Locations created after date (ISO 8601 format).
#' @param created_at_max Show Locations created before date (ISO 8601 format).
#' @param updated_at_min Show Locations last updated after date (ISO 8601 format).
#' @param updated_at_max Show Locations last updated before date (ISO 8601 format).
#' @param per_page Amount of results.
#' @param fields Comma-separated list of fields to include in the response.
#' @param access_token The store's access token for your app.
#'
#' @importFrom httr add_headers content GET
#'
#' @export
#'
get_locations <- function(store_id, page, created_at_min = NULL, created_at_max = NULL,
                          updated_at_min = NULL, updated_at_max = NULL, per_page = 200,
                          fields = NULL, access_token = Sys.getenv("TIENDANUBE_ACCESS_TOKEN")) {
  GET(
    paste0(api_url, store_id, "/locations"),
    query = list(
      created_at_min = created_at_min, created_at_max = created_at_max,
      updated_at_min = updated_at_min, updated_at_max = updated_at_max,
      page = page, per_page = per_page, fields = fields
    ),
    add_headers(Authentication = paste("bearer", access_token))
  ) |> content(as = "parsed", simplifyVector = TRUE)
}

#' Get All Locations
#'
#' Receive a list of all Locations.
#'
#' @param store_id The ID of the store.
#' @param created_at_min Show Locations created after date (ISO 8601 format).
#' @param created_at_max Show Locations created before date (ISO 8601 format).
#' @param updated_at_min Show Locations last updated after date (ISO 8601 format).
#' @param updated_at_max Show Locations last updated before date (ISO 8601 format).
#' @param fields Comma-separated list of fields to include in the response.
#' @param max_pages Max pages to query.
#' @param access_token The store's access token for your app.
#'
#' @importFrom dplyr bind_rows
#'
#' @export
#'
get_all_locations <- function(store_id, created_at_min = NULL, created_at_max = NULL,
                              updated_at_min = NULL, updated_at_max = NULL, fields = NULL,
                              max_pages = Inf,
                              access_token = Sys.getenv("TIENDANUBE_ACCESS_TOKEN")) {
  page <- 1
  locations <- data.frame()
  while (page <= max_pages) {
    new_locations <- get_locations(
      store_id, page, created_at_min, created_at_max, updated_at_min, updated_at_max,
      fields = fields, access_token = access_token
    )
    if (isTRUE(new_locations$code == 404) || length(new_locations) == 0) {
      break
    } else if (isTRUE(new_locations$code == 401)) {
      # Invalid access token.
      return(new_locations)
    }
    locations <- bind_rows(new_locations, locations)
    page <- page + 1
  }
  return(locations)
}
