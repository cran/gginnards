## ----include=FALSE, echo=FALSE------------------------------------------------
library(knitr)
opts_chunk$set(fig.align = 'center', 
               fig.show = 'hold', fig.width = 7, fig.height = 4)
options(warnPartialMatchArgs = FALSE)

## -----------------------------------------------------------------------------
library(gginnards)
library(tibble)

## -----------------------------------------------------------------------------
set.seed(4321)
# generate artificial data
x <- 1:100
y <- (x + x^2 + x^3) + rnorm(length(x), mean = 0, sd = mean(x^3) / 4)
my.data <- data.frame(x, 
                      y, 
                      group = c("A", "B"), 
                      y2 = y * c(0.5, 2),
                      block = c("a", "a", "b", "b"))

## -----------------------------------------------------------------------------
old_theme <- theme_set(theme_bw())

## -----------------------------------------------------------------------------
class(ggplot())

## -----------------------------------------------------------------------------
p0 <- ggplot()
p0

## -----------------------------------------------------------------------------
str(p0)

## -----------------------------------------------------------------------------
p1 <- ggplot(data = my.data, aes(x, y, colour = group))
str(p1)

## -----------------------------------------------------------------------------
str(p1, max.level = 2, components = "data")

## -----------------------------------------------------------------------------
p2 <- p1 + geom_point()
str(p2)

## -----------------------------------------------------------------------------
summary(p2)

## -----------------------------------------------------------------------------
str(p2, max.level = 2, components = "mapping")

## -----------------------------------------------------------------------------
p3 <- p2 + theme_classic()
str(p3)

## -----------------------------------------------------------------------------
str(p3, max.level = 2, components = "theme")

## -----------------------------------------------------------------------------
ggplot(mpg, aes(cyl, hwy, colour = factor(cyl))) + 
  geom_point() +
  geom_debug_panel()

## -----------------------------------------------------------------------------
ggplot(my.data, aes(x, y, colour = group)) + 
  geom_point() + 
  geom_debug_panel(dbgfun.data = head, dbgfun.data.args = list(n = 3))

## -----------------------------------------------------------------------------
ggplot(mpg, aes(cyl, hwy)) +
  stat_summary(fun.data = "mean_se") +
  stat_summary(fun.data = "mean_se", geom = "debug_panel") 

## -----------------------------------------------------------------------------
ggplot(my.data, aes(x, y, colour = group)) + 
  geom_point() + 
  stat_smooth(method = "lm", formula = y ~ poly(x, 2)) +
  stat_smooth(method = "lm", formula = y ~ poly(x, 2), 
              geom = "debug_panel", dbgfun.data = head)

## -----------------------------------------------------------------------------
ggplot(my.data, aes(x, y)) + 
  geom_null()

## -----------------------------------------------------------------------------
ggplot(my.data, aes(x, y)) + 
  stat_debug_group()

## -----------------------------------------------------------------------------
ggplot(my.data, aes(x, y)) + 
  geom_point() + 
  stat_debug_group(geom = "debug_panel")

## -----------------------------------------------------------------------------
ggplot(my.data, aes(x, y)) + 
  geom_point() + 
  stat_debug_panel()

## -----------------------------------------------------------------------------
ggplot(my.data, aes(x, y, colour = group)) + 
  geom_point() + 
  stat_debug_group()

## -----------------------------------------------------------------------------
ggplot(my.data, aes(x, y, colour = group)) + 
  geom_point() + 
  stat_debug_panel()

## -----------------------------------------------------------------------------
ggplot(my.data, aes(x, y, shape = group)) + 
  geom_point() + 
  stat_debug_group()

## -----------------------------------------------------------------------------
ggplot(my.data, aes(x, y, colour = group)) + 
  geom_point() + 
  stat_debug_panel(dbgfun.data = "nrow") +
  facet_wrap(~block)

## -----------------------------------------------------------------------------
ggplot(my.data, aes(x, y, colour = group)) + 
  geom_point() + 
  stat_debug_group(dbgfun.data = "nrow") +
  facet_wrap(~block)

## -----------------------------------------------------------------------------
ggplot(my.data, aes(x, y, shape = group)) + 
  geom_point() + 
  stat_debug_group(geom = "debug_panel")

## -----------------------------------------------------------------------------
ggplot(my.data, aes(x, y, shape = group)) + 
  geom_point() + 
  stat_debug_panel(geom = "debug_panel")

## -----------------------------------------------------------------------------
ggplot(my.data, aes(x, y, colour = group)) + 
  geom_point() + 
  stat_debug_group(geom = "text",
                   mapping = aes(label = sprintf("group = %i", 
                                                 after_stat(group))),
                   dbgfun.data = function(x) {NULL})

