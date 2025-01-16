#' Create a New Customer
#'
#' Needs "Edit Customers" permissions.
#' Docs: https://tiendanube.github.io/api-documentation/resources/customer .
#'
#' @param store_id The ID of the store.
#' @param name Name of the Customer.
#' @param email E-mail of the Customer.
#' @param phone Phone number of the customer (not necessarily the same as the address's phone).
#' @param identification Customer's identification (in Brazil for example, it would be the
#'   CPF/CNPJ).
#' @param note Store owner's notes about the customer.
#' @param default_address Default shipping address of the Customer.
#' @param addresses List of shipping addresses for the Customer.
#' @param billing_address Billing address of the Customer.
#' @param billing_number Billing number of the Customer.
#' @param billing_floor Billing floor of the Customer.
#' @param billing_locality Billing locality of the Customer.
#' @param billing_zipcode Billing zipcode of the Customer.
#' @param billing_city Billing city of the Customer.
#' @param billing_province Billing province of the Customer.
#' @param billing_country Billing country code of the Customer.
#' @param extra A JSON object containing custom information. Can be set via the API or through
#'   custom form fields of name "extra[key]" on the Customer's register form in the storefront.
#' @param total_spent The total amount of money that the Customer has spent at the store.
#' @param total_spent_currency The total spent's currency in ISO 4217 format.
#' @param last_order_id The id of the Customer's last Order.
#' @param active `TRUE` if the Customer activated his account. `FALSE` if he/she hasn't.
#' @param accepts_marketing Boolean field. Indicates if the buyer accepted to receive offers and
#'   news via email. Read-only field in the API.
#' @param send_email_invite Send an email to notify the customer of their registration.
#' @param password User's password description.
#' @param access_token The store's access token for your app.
#'
#' @importFrom httr add_headers content POST
#'
#' @export
#'
create_customer <- function(store_id, name, email = NULL, phone = NULL, identification = NULL,
                            note = NULL, default_address = NULL, addresses = NULL,
                            billing_address = NULL, billing_number = NULL, billing_floor = NULL,
                            billing_locality = NULL, billing_zipcode = NULL, billing_city = NULL,
                            billing_province = NULL, billing_country = NULL, extra = NULL,
                            total_spent = NULL, total_spent_currency = NULL, last_order_id = NULL,
                            active = TRUE, accepts_marketing = TRUE, send_email_invite = FALSE,
                            password = NULL, access_token = Sys.getenv("TIENDANUBE_ACCESS_TOKEN")) {
  POST(
    paste0(api_url, store_id, "/customers"),
    body = list(
      name = name, email = email, phone = phone, identification = identification, note = note,
      default_address = default_address, addresses = addresses,
      billing_address = billing_address, billing_number = billing_number,
      billing_floor = billing_floor, billing_locality = billing_locality,
      billing_zipcode = billing_zipcode, billing_city = billing_city,
      billing_province = billing_province, billing_country = billing_country, extra = extra,
      total_spent = total_spent, total_spent_currency = total_spent_currency,
      last_order_id = last_order_id, active = active, accepts_marketing = accepts_marketing,
      send_email_invite = send_email_invite, password = password
    ),
    encode = "json",
    add_headers(Authentication = paste("bearer", access_token))
  ) |> content(as = "parsed", simplifyVector = TRUE)
}
