% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_locations.R
\name{get_all_locations}
\alias{get_all_locations}
\title{Get All Locations}
\usage{
get_all_locations(
  store_id,
  created_at_min = NULL,
  created_at_max = NULL,
  updated_at_min = NULL,
  updated_at_max = NULL,
  fields = NULL,
  max_pages = Inf,
  access_token = Sys.getenv("TIENDANUBE_ACCESS_TOKEN")
)
}
\arguments{
\item{store_id}{The ID of the store.}

\item{created_at_min}{Show Locations created after date (ISO 8601 format).}

\item{created_at_max}{Show Locations created before date (ISO 8601 format).}

\item{updated_at_min}{Show Locations last updated after date (ISO 8601 format).}

\item{updated_at_max}{Show Locations last updated before date (ISO 8601 format).}

\item{fields}{Comma-separated list of fields to include in the response.}

\item{max_pages}{Max pages to query.}

\item{access_token}{The store's access token for your app.}
}
\description{
Receive a list of all Locations.
}
