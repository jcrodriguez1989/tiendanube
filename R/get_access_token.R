#' Get Access Token
#'
#' When a customer installs our app, it redirects to the "URL to redirect after installation" and
#' it adds a `code` value to the URL. E.g., if our redirect URL is https://myapp.com , after
#' app installation, the customer will be redirected to https://myapp.com?code=SOME_CODE .
#'
#' @param client_id The Client or App Tienda Nube ID.
#' @param client_secret The Client Tienda Nube Secret.
#' @param code The customer activation code.
#'
#' @importFrom httr content POST
#' @importFrom jsonlite fromJSON
#'
#' @export
#'
get_access_token <- function(client_id, client_secret, code) {
  POST(
    "https://www.tiendanube.com/apps/authorize/token",
    body = list(
      client_id = client_id,
      client_secret = client_secret,
      grant_type = "authorization_code",
      code = code
    )
  ) |>
    content(as = "text", encoding = "UTF-8") |>
    fromJSON()
}
