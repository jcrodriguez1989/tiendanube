#' Get Abandoned Checkouts
#'
#' Receive a list of Abandoned Checkouts.
#' Docs: https://tiendanube.github.io/api-documentation/resources/abandoned-checkout .
#'
#' @param store_id The ID of the store.
#' @param page Page to retrieve.
#' @param created_at_max Show Abandoned Checkouts created before date (ISO 8601 format).
#' @param updated_at_max Show Abandoned Checkouts last updated before date (ISO 8601 format).
#' @param per_page Amount of results.
#' @param fields Comma-separated list of fields to include in the response.
#' @param access_token The store's access token for your app.
#'
#' @importFrom httr add_headers content GET
#'
#' @export
#'
get_abandoned_checkouts <- function(store_id, page, created_at_max = NULL, updated_at_max = NULL,
                                    per_page = 200, fields = NULL,
                                    access_token = Sys.getenv("TIENDANUBE_ACCESS_TOKEN")) {
  GET(
    paste0(api_url, store_id, "/checkout"),
    query = list(
      created_at_max = created_at_max, updated_at_max = updated_at_max,
      page = page, per_page = per_page, fields = fields
    ),
    add_headers(Authentication = paste("bearer", access_token))
  ) |> content(as = "parsed", simplifyVector = TRUE)
}

#' Get All Abandoned Checkouts
#'
#' Receive a list of all Abandoned Checkouts.
#'
#' @param store_id The ID of the store.
#' @param created_at_max Show Abandoned Checkouts created before date (ISO 8601 format).
#' @param updated_at_max Show Abandoned Checkouts last updated before date (ISO 8601 format).
#' @param fields Comma-separated list of fields to include in the response.
#' @param max_pages Max pages to query.
#' @param access_token The store's access token for your app.
#'
#' @importFrom dplyr bind_rows
#'
#' @export
#'
get_all_abandoned_checkouts <- function(store_id, created_at_max = NULL, updated_at_max = NULL,
                                        fields = NULL, max_pages = Inf,
                                        access_token = Sys.getenv("TIENDANUBE_ACCESS_TOKEN")) {
  page <- 1
  abandoned_checkouts <- data.frame()
  while (page <= max_pages) {
    new_abandoned_checkouts <- get_abandoned_checkouts(
      store_id, page, created_at_max, updated_at_max,
      fields = fields, access_token = access_token
    )
    if (isTRUE(new_abandoned_checkouts$code == 404) || length(new_abandoned_checkouts) == 0) {
      break
    } else if (isTRUE(new_abandoned_checkouts$code == 401)) {
      # Invalid access token.
      return(new_abandoned_checkouts)
    }
    abandoned_checkouts <- bind_rows(new_abandoned_checkouts, abandoned_checkouts)
    page <- page + 1
  }
  return(abandoned_checkouts)
}
