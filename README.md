
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Tienda Nube API Interface

An R package to interact with [Tiendanube/Nuvemshop API
resources](https://tiendanube.github.io/api-documentation), enabling
easy access to data such as abandoned checkouts, categories, customers,
locations, orders, and products.

## Installation

You can install the development version of tiendanube from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("jcrodriguez1989/tiendanube")
```

## Authentication

The package uses an API token to authenticate with the Tiendanube API.
Set your token as an environment variable:

``` r
Sys.setenv(TIENDANUBE_ACCESS_TOKEN = "your_access_token")
```

## Usage

### Abandoned Checkouts

Retrieve abandoned checkouts from your store:

``` r
library("tiendanube")

# Get all abandoned checkouts.
all_abandoned_checkouts <- get_all_abandoned_checkouts(
  store_id = "123456",
  created_at_max = "2025-01-01T23:59:59"
)
```

### Categories

Retrieve product categories:

``` r
# Get all categories
all_categories <- get_all_categories(
  store_id = "123456"
)
```

### Customers

Retrieve customer data:

``` r
# Get all customers
all_customers <- get_all_customers(
  store_id = "123456"
)
```

### Locations

Retrieve store locations:

``` r
# Get all locations
all_locations <- get_all_locations(
  store_id = "123456"
)
```

### Orders

Retrieve order data:

``` r
# Get all orders
all_orders <- get_all_orders(
  store_id = "123456"
)
```

### Products

Retrieve product data:

``` r
# Get all products
all_products <- get_all_products(
  store_id = "123456"
)
```

## Documentation

For detailed API documentation, refer to the [Tiendanube API
Docs](https://tiendanube.github.io/api-documentation/).

## Contributing

Contributions are welcome! Please fork the repository and submit a pull
request.
