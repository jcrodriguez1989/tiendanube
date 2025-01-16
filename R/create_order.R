#' Create a New Order
#'
#' Needs "Edit Orders" permissions.
#' Docs: https://tiendanube.github.io/api-documentation/resources/order .
#'
#' @param store_id The ID of the store.
#' @param products Order's products list (Product).
#' @param customer The customer object (Customer).
#' @param currency The order currency code (ISO 4217 format).
#' @param language The language code (ISO 639-1 format).
#' @param gateway	The order's payment gateway (Payment Gateway).
#' @param payment_status The order's payment status (Payment Status).
#' @param status The order's status (Order Status).
#' @param fulfillment The order's status (Order Status).
#' @param total The sum of all products prices, shipping costs and discounts. Must be positive. If
#'   not specified, it's calculated considering the provided costs and discounts.
#' @param inventory_behaviour The inventory behaviur that the order must perform (Inventory
#'   Behaviour).
#' @param note An additional customer note for the order.
#' @param billing_address The customer's billing address object (Address).
#' @param shipping_address The customer's shipping address object (Address).
#' @param shipping_pickup_type The shipping pickup type (Shipping Type).
#' @param shipping The shipping method (Shipping Method).
#' @param shipping_option The order's shipping option nice name.
#' @param shipping_tracking_number The order's shipping tracking number
#' @param shipping_cost_customer The customer's shipping cost double value. The value 0 means free
#'   shipping.
#' @param shipping_cost_owner The owner's shipping cost double value.
#' @param send_confirmation_email Send the order confirmation email to the customer.
#' @param send_fulfillment_email Send the order fulfillment email to the customer.
#' @param location_id Location id from where the stock will be decreased. Must be string.
#' @param access_token The store's access token for your app.
#'
#' @importFrom httr add_headers content POST
#'
#' @export
#'
create_order <- function(store_id, products, customer, currency = NULL, language = NULL,
                         gateway = NULL, payment_status = NULL, status = NULL, fulfillment = NULL,
                         total = NULL, inventory_behaviour = NULL, note = NULL,
                         billing_address = NULL, shipping_address, shipping_pickup_type = NULL,
                         shipping = NULL, shipping_option = NULL, shipping_tracking_number = NULL,
                         shipping_cost_customer = NULL, shipping_cost_owner = NULL,
                         send_confirmation_email = FALSE, send_fulfillment_email = FALSE,
                         location_id = NULL, access_token = Sys.getenv("TIENDANUBE_ACCESS_TOKEN")) {
  POST(
    paste0(api_url, store_id, "/orders"),
    body = list(
      products = products, customer = customer, currency = currency, language = language,
      gateway = gateway, payment_status = payment_status, status = status,
      fulfillment = fulfillment, total = total, inventory_behaviour = inventory_behaviour,
      note = note, billing_address = billing_address, shipping_address = shipping_address,
      shipping_pickup_type = shipping_pickup_type, shipping = shipping,
      shipping_option = shipping_option, shipping_tracking_number = shipping_tracking_number,
      shipping_cost_customer = shipping_cost_customer, shipping_cost_owner = shipping_cost_owner,
      send_confirmation_email = send_confirmation_email,
      send_fulfillment_email = send_fulfillment_email, location_id = location_id
    ),
    encode = "json",
    add_headers(Authentication = paste("bearer", access_token))
  ) |> content(as = "parsed", simplifyVector = TRUE)
}
