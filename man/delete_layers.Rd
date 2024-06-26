% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/layer-manip.R
\name{delete_layers}
\alias{delete_layers}
\alias{append_layers}
\alias{move_layers}
\alias{shift_layers}
\alias{which_layers}
\alias{extract_layers}
\alias{top_layer}
\alias{bottom_layer}
\alias{num_layers}
\title{Layer manipulation.}
\usage{
delete_layers(x, match_type = NULL, idx = NULL)

append_layers(x, object, position = "top")

move_layers(x, match_type = NULL, position = "top", idx = NULL)

shift_layers(x, match_type = NULL, idx = NULL, shift = 1L)

which_layers(x, match_type = NULL, idx = NULL)

extract_layers(x, match_type = NULL, idx = NULL)

top_layer(x)

bottom_layer(x)

num_layers(x)
}
\arguments{
\item{x}{an object of class \code{gg} to be operated upon.}

\item{match_type}{The name of the ggproto object class for the geom(s),
position(s) or stat(s) matching that of the layers to be operated upon.}

\item{idx}{integer vector Index into the list of layers used to select the
layers to be operated upon.}

\item{object}{a ggplot layer created by a \code{geom_} or \code{stat_}
function or a list of such layers or an empty list.}

\item{position}{character or interger, the position of the layer immediately
above of which to move or append the moved or appended layers.}

\item{shift}{integer.}
}
\value{
An edited copy of \code{x} for \code{delete_layers},
  \code{append_layers} and \code{move_layers}. An integer vector of indexes
  giving the positions of the matching layers in the list of layers contained
  in \code{x} in the case of \code{which_layers}.
}
\description{
Delete, move or append one or more layers in a ggplot object.
}
\details{
These functions must be used with care as they select all layers
  matching the provided geom, position or stat ggproto object class. Layers
  added with a stat do use a geom, and vice versa.

  One and only one of \code{match_type} and \code{idx} must be passed a
  non-null argument.

  In plots with several layers, it is possible that more than one layer
  matches the class name passed to \code{match_type}. It is also possible to
  pass a numeric vector with multiple indexes through parameter \code{idx}.
  In both cases multiple layers will be operated upon, but their relative
  positions will remain unchanged.

  If a numeric vector with multiple position indexes is supplied as argument
  for \code{position}, the topmost position will be used. As indexing in R
  starts at 1, passing 0 or \code{"bottom"} as argument for \code{position}
  puts the moved or appended layer(s) behind all other layers (prepends the
  layer).
}
\note{
The functions described here are not expected to be useful in everyday
  plotting as one can more easily change the order in which layers are added
  to a ggplot. However, if one uses high level methods or functions that
  automatically produce a full plot using 'ggplot2' internally, one may need
  to add, move or delete layers so as to profit from such canned methods and
  retain enough flexibility.
}
\examples{
df <- data.frame(
  gp = factor(rep(letters[1:3], each = 10)),
  y = rnorm(30)
)
p <- ggplot(df, aes(gp, y)) +
       geom_point() +
       stat_summary(fun.data = "mean_se", colour = "red")
p
delete_layers(p, "GeomPoint")
delete_layers(p, "StatSummary")
move_layers(p, "GeomPoint", position = "top")
move_layers(p, "GeomPointrange", position = "bottom")
move_layers(p, "StatSummary", position = "bottom")
move_layers(p, "GeomPointrange", position = 1L)
append_layers(p, geom_line(colour = "orange"), position = "bottom")
append_layers(p, geom_line(colour = "orange"), position = 1L)
extract_layers(p, "GeomPoint")
ggplot(df, aes(gp, y)) + extract_layers(p, "GeomPoint")
which_layers(p, "GeomPoint")
num_layers(p)
top_layer(p)
bottom_layer(p)
num_layers(ggplot())
top_layer(ggplot())
bottom_layer(ggplot())

if (requireNamespace("sf", quietly = TRUE)) {
  nc <- sf::st_read(system.file("shape/nc.shp", package = "sf"), quiet = TRUE)
  nc_3857 <- sf::st_transform(nc, 3857)

  p.sf1 <- ggplot() +
           geom_sf(data = nc)
  p.sf1
  num_layers(p.sf1)
  top_layer(p.sf1)

  append_layers(p.sf1,
                geom_sf(data = nc_3857, colour = "red", fill = NA),
                position = "top")

  p.sf2 <- ggplot() +
           geom_sf(data = nc) +
           geom_sf(data = nc_3857, colour = "red", fill = NA)
  p.sf2
  num_layers(p.sf2)
  top_layer(p.sf2)
  delete_layers(p.sf2, idx = 2L)

  extract_layers(p.sf2, "GeomSf")
  extract_layers(p.sf2, "StatSf")
  extract_layers(p.sf2, idx = 1L)
  p.sf1 + extract_layers(p.sf2, idx = 2L)

  # beware that Coords are not extracted!
  ggplot() + extract_layers(p.sf2, idx = 2L) + coord_sf()
}

}
\references{
\url{https://stackoverflow.com/questions/13407236/remove-a-layer-from-a-ggplot2-chart}
}
