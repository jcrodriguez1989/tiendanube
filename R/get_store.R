#' Get Store
#'
#' The Store resource contains general settings and information about a Tiendanube's store.
#' Docs: https://tiendanube.github.io/api-documentation/resources/store .
#'
#' @param store_id The ID of the store.
#' @param fields Comma-separated list of fields to include in the response.
#' @param access_token The store's access token for your app.
#'
#' @importFrom httr add_headers content GET
#'
#' @export
#'
get_store <- function(store_id, fields = NULL,
                      access_token = Sys.getenv("TIENDANUBE_ACCESS_TOKEN")) {
  GET(
    paste0(api_url, store_id, "/store"),
    query = list(fields = fields),
    add_headers(Authentication = paste("bearer", access_token))
  ) |> content(as = "parsed", simplifyVector = TRUE)
}
