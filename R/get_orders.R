#' Get Orders
#'
#' Receive a list of Orders.
#' Docs: https://tiendanube.github.io/api-documentation/resources/order .
#'
#' @param store_id The ID of the store.
#' @param page Page to retrieve.
#' @param since_id Restrict results to after the specified ID.
#' @param status Show Orders with a given state. Possible values are "any" (default), "open",
#'   "closed" or "cancelled".
#' @param channels Restrict results to the specified sales channel. Possible values are "form"
#'   (draft order created via admin or API), "store" (order created in the storefront), "api"
#'   (order created via API - doesn't include draft orders), "meli" (order imported from Mercado
#'   Libre) or "pos" (order created via point of sale app).
#' @param payment_status Show Orders with a given payment state. Possible values are "any"
#'   (default), "pending", "authorized", "paid", "abandoned", "refunded" or "voided".
#' @param shipping_status Show Orders with a given shipping state. Possible values are "any"
#'   (default), "unpacked", "unfulfilled" (means "unshipped") or "fulfilled" (means "shipped").
#' @param created_at_min Show Orders created after date (ISO 8601 format).
#' @param created_at_max Show Orders created before date (ISO 8601 format).
#' @param updated_at_min Show Orders last updated after date (ISO 8601 format).
#' @param updated_at_max Show Orders last updated before date (ISO 8601 format).
#' @param total_min Show Orders with total value bigger or equals than the specified value.
#' @param total_max Show Orders with total value lower or equals than the specified value.
#' @param customer_ids Restrict results to the specified customer IDs (comma-separated).
#' @param per_page Amount of results.
#' @param fields Comma-separated list of fields to include in the response.
#' @param q Search Orders by the given number; or containing the given text in the customer name
#'   or email.
#' @param app_id Show orders created by a given app.
#' @param payment_methods Show orders with a given payment method.
#' @param payment_provider Show orders with a given payment provider.
#' @param aggregates One possible value: fulfillment_orders. Enables an array called fulfillments
#'   that displays the information of the Fulfillment Order. Important: in the list of orders
#'   (endpoint GET /orders), it returns partial information of the Fulfillment Order. The full
#'   information is only displayed if a single order is queried (endpoint GET /orders/{id}).
#' @param access_token The store's access token for your app.
#'
#' @importFrom httr add_headers content GET
#'
#' @export
#'
get_orders <- function(store_id, page, since_id = NULL, status = NULL, channels = NULL,
                       payment_status = NULL, shipping_status = NULL, created_at_min = NULL,
                       created_at_max = NULL, updated_at_min = NULL, updated_at_max = NULL,
                       total_min = NULL, total_max = NULL, customer_ids = NULL, per_page = 200,
                       fields = NULL, q = NULL, app_id = NULL, payment_methods = NULL,
                       payment_provider = NULL, aggregates = NULL,
                       access_token = Sys.getenv("TIENDANUBE_ACCESS_TOKEN")) {
  GET(
    paste0(api_url, store_id, "/orders"),
    query = list(
      since_id = since_id, status = status, channels = channels, payment_status = payment_status,
      shipping_status = shipping_status, created_at_min = created_at_min,
      created_at_max = created_at_max, updated_at_min = updated_at_min,
      updated_at_max = updated_at_max, total_min = total_min, total_max = total_max,
      customer_ids = customer_ids, page = page, per_page = per_page, fields = fields, q = q,
      app_id = app_id, payment_methods = payment_methods, payment_provider = payment_provider,
      aggregates = aggregates
    ),
    add_headers(Authentication = paste("bearer", access_token))
  ) |> content(as = "parsed", simplifyVector = TRUE)
}

#' Get All Orders
#'
#' Receive a list of all Orders.
#'
#' @param store_id The ID of the store.
#' @param since_id Restrict results to after the specified ID.
#' @param status Show Orders with a given state. Possible values are "any" (default), "open",
#'   "closed" or "cancelled".
#' @param channels Restrict results to the specified sales channel. Possible values are "form"
#'   (draft order created via admin or API), "store" (order created in the storefront), "api"
#'   (order created via API - doesn't include draft orders), "meli" (order imported from Mercado
#'   Libre) or "pos" (order created via point of sale app).
#' @param payment_status Show Orders with a given payment state. Possible values are "any"
#'   (default), "pending", "authorized", "paid", "abandoned", "refunded" or "voided".
#' @param shipping_status Show Orders with a given shipping state. Possible values are "any"
#'   (default), "unpacked", "unfulfilled" (means "unshipped") or "fulfilled" (means "shipped").
#' @param created_at_min Show Orders created after date (ISO 8601 format).
#' @param created_at_max Show Orders created before date (ISO 8601 format).
#' @param updated_at_min Show Orders last updated after date (ISO 8601 format).
#' @param updated_at_max Show Orders last updated before date (ISO 8601 format).
#' @param total_min Show Orders with total value bigger or equals than the specified value.
#' @param total_max Show Orders with total value lower or equals than the specified value.
#' @param customer_ids Restrict results to the specified customer IDs (comma-separated).
#' @param fields Comma-separated list of fields to include in the response.
#' @param q Search Orders by the given number; or containing the given text in the customer name
#'   or email.
#' @param app_id Show orders created by a given app.
#' @param payment_methods Show orders with a given payment method.
#' @param payment_provider Show orders with a given payment provider.
#' @param aggregates One possible value: fulfillment_orders. Enables an array called fulfillments
#'   that displays the information of the Fulfillment Order. Important: in the list of orders
#'   (endpoint GET /orders), it returns partial information of the Fulfillment Order. The full
#'   information is only displayed if a single order is queried (endpoint GET /orders/{id}).
#' @param max_pages Max pages to query.
#' @param access_token The store's access token for your app.
#'
#' @importFrom dplyr bind_rows
#'
#' @export
#'
get_all_orders <- function(store_id, since_id = NULL, status = NULL, channels = NULL,
                           payment_status = NULL, shipping_status = NULL, created_at_min = NULL,
                           created_at_max = NULL, updated_at_min = NULL, updated_at_max = NULL,
                           total_min = NULL, total_max = NULL, customer_ids = NULL, fields = NULL,
                           q = NULL, app_id = NULL, payment_methods = NULL,
                           payment_provider = NULL, aggregates = NULL,
                           max_pages = Inf, access_token = Sys.getenv("TIENDANUBE_ACCESS_TOKEN")) {
  page <- 1
  orders <- data.frame()
  while (page <= max_pages) {
    new_orders <- get_orders(
      store_id, page, since_id, status, channels, payment_status, shipping_status, created_at_min,
      created_at_max, updated_at_min, updated_at_max, total_min, total_max, customer_ids,
      per_page = 200, fields, q, app_id, payment_methods, payment_provider, aggregates,
      access_token
    )
    if (isTRUE(new_orders$code %in% c(404, 422)) || length(new_orders) == 0) {
      break
    } else if (isTRUE(new_orders$code == 401)) {
      # Invalid access token.
      return(new_orders)
    }
    orders <- bind_rows(new_orders, orders)
    page <- page + 1
  }
  return(orders)
}
