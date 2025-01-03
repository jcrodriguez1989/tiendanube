#' Get Orders
#'
#' Receive a list of Orders.
#' Docs: https://tiendanube.github.io/api-documentation/resources/order .
#'
#' @param store_id The ID of the store.
#' @param page Page to retrieve.
#' @param created_at_min Show Orders created after date (ISO 8601 format).
#' @param created_at_max Show Orders created before date (ISO 8601 format).
#' @param updated_at_min Show Orders last updated after date (ISO 8601 format).
#' @param updated_at_max Show Orders last updated before date (ISO 8601 format).
#' @param per_page Amount of results.
#' @param access_token The store's access token for your app.
#'
#' @importFrom httr add_headers content GET
#'
#' @export
#'
get_orders <- function(store_id, page, created_at_min = NULL, created_at_max = NULL,
                       updated_at_min = NULL, updated_at_max = NULL, per_page = 200,
                       access_token = Sys.getenv("TIENDANUBE_ACCESS_TOKEN")) {
  GET(
    paste0(api_url, store_id, "/orders"),
    query = list(
      created_at_min = created_at_min, created_at_max = created_at_max,
      updated_at_min = updated_at_min, updated_at_max = updated_at_max,
      page = page, per_page = per_page
    ),
    add_headers(Authentication = paste("bearer", access_token))
  ) |> content(as = "parsed", simplifyVector = TRUE)
}

#' Get All Orders
#'
#' Receive a list of all Orders.
#'
#' @param store_id The ID of the store.
#' @param created_at_min Show Orders created after date (ISO 8601 format).
#' @param created_at_max Show Orders created before date (ISO 8601 format).
#' @param updated_at_min Show Orders last updated after date (ISO 8601 format).
#' @param updated_at_max Show Orders last updated before date (ISO 8601 format).
#' @param access_token The store's access token for your app.
#'
#' @importFrom dplyr bind_rows
#'
#' @export
#'
get_all_orders <- function(store_id, created_at_min = NULL, created_at_max = NULL,
                           updated_at_min = NULL, updated_at_max = NULL,
                           access_token = Sys.getenv("TIENDANUBE_ACCESS_TOKEN")) {
  page <- 1
  orders <- data.frame()
  while (TRUE) {
    new_orders <- get_orders(
      store_id, page, created_at_min, created_at_max, updated_at_min, updated_at_max,
      access_token = access_token
    )
    if (isTRUE(new_orders$code == 404) || length(new_orders) == 0) {
      break
    }
    orders <- bind_rows(new_orders, orders)
    page <- page + 1
  }
  return(orders)
}
