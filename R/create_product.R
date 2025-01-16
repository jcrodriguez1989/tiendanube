#' Create a new Product
#'
#' Needs "Edit Products" permissions.
#' Docs: https://tiendanube.github.io/api-documentation/resources/product .
#'
#' @param store_id The ID of the store.
#' @param name List of the names of the Product, in every language supported by the store.
#' @param description List of the descriptions of the Product, as HTML, in every language supported
#'   by the store.
#' @param handle List of the url-friendly strings generated from the Product's names, in every
#'   language supported by the store.
#' @param variants List of Product Variant objects representing the different version of the
#'   Product.
#' @param images List of Product Image objects representing the Product's images.
#' @param categories List of Category Ids representing the Product's categories.
#' @param brand	The Product's brand.
#' @param published	`TRUE` if the Product is published in the store. `FALSE` otherwise.
#' @param free_shipping `TRUE` if the Product is eligible for free shipping. `FALSE` otherwise.
#' @param video_url String with a valid URL format. Only admits https links.
#' @param seo_title The SEO friendly title for the Product. Up to 70 characters.
#' @param seo_description The SEO friendly description for the Product. Up to 320 characters.
#' @param attributes List of the names of the attributes whose values define the variants.
#'   E.g.: Color, Size, etc. It is important that the number of attributes is equal to the number
#'   of values within the variants. Each product can have a maximum of 3 attributes.
#' @param tags String with all the Product's tags, separated by commas.
#' @param requires_shipping `TRUE` if the Product is physical. `FALSE` if it is digital description.
#' @param access_token The store's access token for your app.
#'
#' @importFrom httr add_headers content POST
#'
#' @export
#'
create_product <- function(store_id, name, description = NULL, handle = NULL, variants,
                           images = NULL, categories = NULL, brand = NULL, published = TRUE,
                           free_shipping = FALSE, video_url = NULL, seo_title = NULL,
                           seo_description = NULL, attributes = NULL, tags = NULL,
                           requires_shipping = TRUE,
                           access_token = Sys.getenv("TIENDANUBE_ACCESS_TOKEN")) {
  POST(
    paste0(api_url, store_id, "/products"),
    body = list(
      name = name, description = description, handle = handle, variants = variants,
      images = images, categories = categories, brand = brand, published = published,
      free_shipping = free_shipping, video_url = video_url, seo_title = seo_title,
      seo_description = seo_description, attributes = attributes, tags = tags,
      requires_shipping = requires_shipping
    ),
    encode = "json",
    add_headers(Authentication = paste("bearer", access_token))
  ) |> content(as = "parsed", simplifyVector = TRUE)
}
