---
title: "Notes for Statistical Rethinking 2nd ed. by Richard McElreath"
date: '2021-11-15'
output:
  bookdown::tufte_html_book:
    toc: yes
    css: toc.css
    pandoc_args: --lua-filter=color-text.lua
    highlight: pygments
    link-citations: yes
---

# Sampling from the Imaginary


```r
library(here)
source(here::here("code/scripts/source.R"))
```


```r
slides_dir = here::here("docs/slides/L02")
```

<div class="figure">
<p class="caption">(\#fig:unnamed-chunk-3)When I work with Bayesian models, we work with random numbers drawn from the posterior distribution. That's nice, because you can easily summarise the sample. And you can make inferences from the sample. Cognitively a prosthetic because it helps us transform hard calculus problems into easy data summary problems. </p><img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L02/45.png" alt="When I work with Bayesian models, we work with random numbers drawn from the posterior distribution. That's nice, because you can easily summarise the sample. And you can make inferences from the sample. Cognitively a prosthetic because it helps us transform hard calculus problems into easy data summary problems. " width="80%"  /></div>

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L02/46.png" width="80%"  />

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L02/47.png" width="80%"  />


<div class="figure">
<p class="caption">(\#fig:unnamed-chunk-6)One line in R is sufficient to do the sampling. `p` are the possibilities of our grid. We'll get a big bag of numbers, and they'll be in the same distribution as our posterior. When you use Markov chains, they only spit out samples.</p><img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L02/48.png" alt="One line in R is sufficient to do the sampling. `p` are the possibilities of our grid. We'll get a big bag of numbers, and they'll be in the same distribution as our posterior. When you use Markov chains, they only spit out samples." width="80%"  /></div>

## Sampling from a grid-approximate posterior

Generate the samples. First compute the posterior.


```r
# how many grid points would you like?
n <- 1000
n_success <- 6
n_trials  <- 9

(
  d <-
  tibble(p_grid = seq(from = 0, to = 1, length.out = n),
         # note we're still using a flat uniform prior
         prior  = 1) %>% 
  mutate(likelihood = dbinom(n_success, size = n_trials, prob = p_grid)) %>% 
  mutate(posterior = (likelihood * prior) / sum(likelihood * prior))
)
```

```
## # A tibble: 1,000 × 4
##     p_grid prior likelihood posterior
##      <dbl> <dbl>      <dbl>     <dbl>
##  1 0           1   0         0       
##  2 0.00100     1   8.43e-17  8.43e-19
##  3 0.00200     1   5.38e-15  5.38e-17
##  4 0.00300     1   6.11e-14  6.11e-16
##  5 0.00400     1   3.42e-13  3.42e-15
##  6 0.00501     1   1.30e-12  1.30e-14
##  7 0.00601     1   3.87e-12  3.88e-14
##  8 0.00701     1   9.73e-12  9.74e-14
##  9 0.00801     1   2.16e-11  2.16e-13
## 10 0.00901     1   4.37e-11  4.38e-13
## # … with 990 more rows
```

Now draw 10,000 samples from this posterior. Scoop out 10,000 values from the bucket containing parameter values that exist in proportion to the posterior probability.


```r
# how many samples would you like?
n_samples <- 1e4

# make it reproducible
set.seed(3)

samples <-
  d %>% 
  slice_sample(n = n_samples, weight_by = posterior, replace = T)

glimpse(samples)
```

```
## Rows: 10,000
## Columns: 4
## $ p_grid     <dbl> 0.5645646, 0.6516517, 0.5475475, 0.5905906, 0.5955956, 0.78…
## $ prior      <dbl> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,…
## $ likelihood <dbl> 0.22455994, 0.27190272, 0.20966655, 0.24460869, 0.24799092,…
## $ posterior  <dbl> 0.0022478473, 0.0027217490, 0.0020987643, 0.0024485355, 0.0…
```

<p><span class="marginnote shownote">
<!--
<div class="figure">-->
<img src="03_sampling_from_the_imaginary_files/figure-html/3.4-1.png" alt=" " width="672"  />
<!--
<p class="caption marginnote">--> <!--</p>-->
<!--</div>--></span></p>

```r
samples %>% 
  mutate(sample_number = 1:n()) %>% 
  
  ggplot(aes(x = sample_number, y = p_grid)) +
  geom_point(alpha = 1/10) +
  scale_y_continuous("proportion of water (p)", limits = c(0, 1)) +
  xlab("sample number")
```

<p><span class="marginnote shownote">
<!--
<div class="figure">-->
<img src="03_sampling_from_the_imaginary_files/figure-html/3.5-1.png" alt=" " width="672"  />
<!--
<p class="caption marginnote">--> <!--</p>-->
<!--</div>--></span></p>

```r
samples %>% 
  ggplot(aes(x = p_grid)) +
  geom_density(fill = "black") +
  scale_x_continuous("proportion of water (p)", limits = c(0, 1))
```

Here's what it looks like with `1e6`:


```r
set.seed(3)

d %>% 
  slice_sample(n = 1e6, weight_by = posterior, replace = T) %>% 
  ggplot(aes(x = p_grid)) +
  geom_density(fill = "black") +
  scale_x_continuous("proportion of water (p)", limits = c(0, 1))
```

<img src="03_sampling_from_the_imaginary_files/figure-html/unnamed-chunk-7-1.png" width="672"  />

>All you’ve done so far is crudely replicate the posterior density you had already computed. That isn’t of much value. But next it is time to use these samples to describe and understand the posterior. That is of great value.

## Sampling to summarize

<div class="figure">
<p class="caption">(\#fig:unnamed-chunk-8)What might you want to compute? Commonly people want to construct intervals.</p><img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L02/49.png" alt="What might you want to compute? Commonly people want to construct intervals." width="80%"  /></div>

***3.2.1 Intervals of defined boudaries***

What's the posterior probability that the proportion of water is less than 0.5?


```r
# add up posterior probability where p < 0.5
d %>% 
  filter(p_grid < .5) %>% 
  summarise(sum = sum(posterior))
```

```
## # A tibble: 1 × 1
##     sum
##   <dbl>
## 1 0.172
```

But since grid approximation isn't practical in general, it won't always be so easy. Once there is more than one parameter in the posterior distribution, even this simple sum is no longer very simple. 

So let's see how to perform it using samples from the posterior.


```r
# Add up all the samples under .5, divided by the total number of samples
samples %>%
  filter(p_grid < .5) %>% 
  summarise(sum = n() / n_samples)
```

```
## # A tibble: 1 × 1
##     sum
##   <dbl>
## 1 0.163
```
Do the same but using `count()`:


```r
samples %>% 
  count(p_grid < .5) %>% 
  mutate(probability = n / sum(n))
```

```
## # A tibble: 2 × 3
##   `p_grid < 0.5`     n probability
##   <lgl>          <int>       <dbl>
## 1 FALSE           8371       0.837
## 2 TRUE            1629       0.163
```


<div class="figure">
<p class="caption">(\#fig:unnamed-chunk-10)Two general kinds of intervals. One is an interval of defined boundaries. Upper left is the probability that less than half the world is covered by water. Compute by counting the number of samples that satisfy the criteria, then dividing by the total number of samples. Upper right is the probability between 50% and 70%. Lower right - there's an infinite number of 80% intervals.</p><img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L02/50.png" alt="Two general kinds of intervals. One is an interval of defined boundaries. Upper left is the probability that less than half the world is covered by water. Compute by counting the number of samples that satisfy the criteria, then dividing by the total number of samples. Upper right is the probability between 50% and 70%. Lower right - there's an infinite number of 80% intervals." width="80%"  /></div>

Using the same approach, how much posterior probability lies between 0.5 and 0.75?


```r
samples %>% 
  filter(p_grid > .5 & p_grid < .75) %>% 
  summarise(sum = n() / n_samples)
```

```
## # A tibble: 1 × 1
##     sum
##   <dbl>
## 1 0.606
```

This is shown in the upper right of Figure 3.2.


```r
# upper left panel
p1 <-
  d %>% 
  ggplot(aes(x = p_grid, y = posterior)) +
  geom_line() +
  geom_area(data = d %>% filter(p_grid < .5)) +
  labs(x = "proportion of water (p)",
       y = "density")

# upper right panel
p2 <-
  d %>% 
  ggplot(aes(x = p_grid, y = posterior)) +
  geom_line() +
  # note this next line is the only difference in code from the last plot
  geom_area(data = d %>% filter(p_grid < .75 & p_grid > .5)) +
  labs(x = "proportion of water (p)",
       y = "density")

library(patchwork)
p1 + p2
```

<img src="03_sampling_from_the_imaginary_files/figure-html/unnamed-chunk-11-1.png" width="672"  />


***3.2.2 Intervals of defined mass***

What a compatibility interval indicates is a range of parameter values compatible with the model and data. 

Where does the 80th percentile lie? i.e. the boundaries fo the lower 80% posterior probability. 


```r
(q_80 <- quantile(samples$p_grid, prob = .8))
```

```
##       80% 
## 0.7627628
```

This is shown in the bottom-left of Figure 3.2. Similarly, the middle 80% interval lies between the 10th percentile and the 90th percentile.


```r
samples %>% 
  summarise(`10th percentile` = quantile(p_grid, p = .1),
            `90th percentile` = quantile(p_grid, p = .9))
```

```
## # A tibble: 1 × 2
##   `10th percentile` `90th percentile`
##               <dbl>             <dbl>
## 1             0.451             0.815
```

For quick indexing:


```r
(q_10_and_90 <- quantile(samples$p_grid, prob = c(.1, .9)))
```

```
##       10%       90% 
## 0.4514515 0.8148148
```

This is shown in the bottom-right of Figure 3.2.


```r
# lower left panel
p1 <-
  d %>% 
  ggplot(aes(x = p_grid, y = posterior)) +
  geom_line() +
  geom_area(data = d %>% filter(p_grid < q_80)) +
  annotate(geom = "text",
           x = .25, y = .0025,
           label = "lower 80%") +
  labs(x = "proportion of water (p)",
       y = "density")

# lower right panel
p2 <-
  d %>% 
  ggplot(aes(x = p_grid, y = posterior)) +
  geom_line() +
  geom_area(data = d %>% filter(p_grid > q_10_and_90[1] & p_grid < q_10_and_90[2])) +
  annotate(geom = "text",
           x = .25, y = .0025,
           label = "middle 80%") +
  labs(x = "proportion of water (p)",
       y = "density")

p1 + p2
```

<img src="03_sampling_from_the_imaginary_files/figure-html/unnamed-chunk-13-1.png" width="672"  />


Intervals of this sort are very common in the scientific literature. We'll call them **Percentile Intervals** (PI). These do a good job of communicating the shape of a distribution, as long as it's not too asymmetrical. 

But in terms of supporting inferences about which parameters are consistent with the data, they are not perfect. 

Consider the posterior distribution consistent with observing three waters in three tosses, and a flat prior. 


```r
# here we update the `dbinom()` parameters
n_success <- 3
n_trials  <- 3

# update `d`
d <-
  d %>% 
  mutate(likelihood = dbinom(n_success, size = n_trials, prob = p_grid)) %>% 
  mutate(posterior  = (likelihood * prior) / sum(likelihood * prior))

# make the next part reproducible
set.seed(3)

# here's our new samples tibble
(
  samples <-
    d %>% 
    slice_sample(n = n_samples, weight_by = posterior, replace = T)
)
```

```
## # A tibble: 10,000 × 4
##    p_grid prior likelihood posterior
##     <dbl> <dbl>      <dbl>     <dbl>
##  1  0.717     1     0.368   0.00147 
##  2  0.652     1     0.277   0.00111 
##  3  0.548     1     0.164   0.000656
##  4  1         1     1       0.00400 
##  5  0.991     1     0.973   0.00389 
##  6  0.788     1     0.489   0.00195 
##  7  0.940     1     0.830   0.00332 
##  8  0.817     1     0.545   0.00218 
##  9  0.955     1     0.871   0.00348 
## 10  0.449     1     0.0908  0.000363
## # … with 9,990 more rows
```

The `rethinking::PI()` function works like a nice shorthand for `quantile()`.


```r
quantile(samples$p_grid, prob = c(.25, .75))
```

```
##       25%       75% 
## 0.7087087 0.9349349
```

```r
rethinking::PI(samples$p_grid, prob = .5)
```

```
##       25%       75% 
## 0.7087087 0.9349349
```


<div class="figure">
<p class="caption">(\#fig:unnamed-chunk-15)Two basic kinds of specified mass intervals. PI gives you the central area, where .25 is left over in each tail. They're not necessarily the right thing to use. What if you have an asymmetric distribution? Now the 50 percentile interval omits the highest value. Use the HPDI to keep the highest point. But remember these are just summaries.</p><img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L02/51.png" alt="Two basic kinds of specified mass intervals. PI gives you the central area, where .25 is left over in each tail. They're not necessarily the right thing to use. What if you have an asymmetric distribution? Now the 50 percentile interval omits the highest value. Use the HPDI to keep the highest point. But remember these are just summaries." width="80%"  /></div>

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L02/52.png" width="80%"  />


```r
rethinking::PI(samples$p_grid, prob = .5)
```

```
##       25%       75% 
## 0.7087087 0.9349349
```

In this example, it ends up excluding the most probable parameter values, near $p$ = 1.


```r
rethinking::HPDI(samples$p_grid, prob = 0.5)
```

```
##      |0.5      0.5| 
## 0.8418418 0.9989990
```

Here the HPDI has an advantage over the PI, but in most cases, the two are very similar. That's because the posterior is skewed. When the posterior is bell-shaped, it hardly matters what type of interval you use. 

> Often, all compatibility intervals do is communicate the shape of a distribution.

`tidybayes` makes it easy to request multiple types of intervals:


```r
tidybayes::median_qi(samples$p_grid, .width = c(.5, .8, .99))
```

```
##           y      ymin      ymax .width .point .interval
## 1 0.8428428 0.7087087 0.9349349   0.50 median        qi
## 2 0.8428428 0.5705706 0.9749750   0.80 median        qi
## 3 0.8428428 0.2562563 0.9989990   0.99 median        qi
```

It also supports HPDIs:


```r
tidybayes::mode_hdi(samples$p_grid, .width = .5)
```

```
##          y      ymin     ymax .width .point .interval
## 1 0.955384 0.8418418 0.998999    0.5   mode       hdi
```

```r
# lower left panel
p1 <-
  d %>% 
  ggplot(aes(x = p_grid, y = posterior)) +
  # check out our sweet `qi()` indexing
  geom_area(data = d %>% filter(p_grid > tidybayes::qi(samples$p_grid, .width = .5)[1] & 
                                  p_grid < tidybayes::qi(samples$p_grid, .width = .5)[2]),
            fill = "grey75") +
  geom_line() +
  labs(subtitle = "50% Percentile Interval",
       x = "proportion of water (p)",
       y = "density")

# lower right panel
p2 <-
  d %>% 
  ggplot(aes(x = p_grid, y = posterior)) +
  geom_area(data = . %>% filter(p_grid > tidybayes::hdi(samples$p_grid, .width = .5)[1] & 
                                  p_grid < tidybayes::hdi(samples$p_grid, .width = .5)[2]),
            fill = "grey75") +
  geom_line() +
  labs(subtitle = "50% HPDI",
       x = "proportion of water (p)",
       y = "density")
# combine!
p1 | p2
```

<img src="03_sampling_from_the_imaginary_files/figure-html/unnamed-chunk-19-1.png" width="672"  />


***3.2.3 Point estimates***

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L02/53.png" width="80%"  />


```r
d %>% 
  arrange(desc(posterior)) %>% 
  slice(1)
```

```
## # A tibble: 1 × 4
##   p_grid prior likelihood posterior
##    <dbl> <dbl>      <dbl>     <dbl>
## 1      1     1          1   0.00400
```


```r
samples %>% 
  summarise(mean   = mean(p_grid),
            median = median(p_grid))
```

```
## # A tibble: 1 × 2
##    mean median
##   <dbl>  <dbl>
## 1 0.803  0.843
```


```r
(
  point_estimates <-
  dplyr::bind_rows(samples %>% tidybayes::mean_qi(p_grid),
                   samples %>% tidybayes::median_qi(p_grid),
                   samples %>% tidybayes::mode_qi(p_grid)) %>% 
  dplyr::select(p_grid, .point) %>% 
  # these last two columns will help us annotate  
  dplyr::mutate(x = p_grid + c(-.03, .03, -.03),
                y = c(.0005, .0012, .002))
)
```

```
## # A tibble: 3 × 4
##   p_grid .point     x      y
##    <dbl> <chr>  <dbl>  <dbl>
## 1  0.803 mean   0.773 0.0005
## 2  0.843 median 0.873 0.0012
## 3  0.955 mode   0.925 0.002
```


```r
d %>% 
  ggplot(aes(x = p_grid)) +
  geom_area(aes(y = posterior),
            fill = "grey75") +
  geom_vline(xintercept = point_estimates$p_grid) +
  geom_text(data = point_estimates,
            aes(x = x, y = y, label = .point),
            angle = 90) +
  labs(x = "proportion of water (p)",
       y = "density") +
  theme(panel.grid = element_blank())
```

<img src="03_sampling_from_the_imaginary_files/figure-html/unnamed-chunk-23-1.png" width="672"  />

We care about uncertainty, and we want to summarise that. To use a point estimate, you need to provide a cost-benefit analysis. e.g. conservation or forecasting. 

One principles way to go beyond using the entire posterior as the estimate is to choose a **Loss Function**: a rule that tells you the cost assoicated with using any particular point estimate. 

>Tell me which value of $p$, the proportion of water on the Earth, you think is correct, and if you get it exactly right, I will pay you $100. But I will subtract money from your gain, proportional to the distance of your decision from the correct value. Now that you have the posterior distribution in hand, how should you use it to maximise your expected winnings?


```r
# The expected loss will be:
d %>% 
  summarise(`expected loss` = sum(posterior * abs(0.5 - p_grid)))
```

```
## # A tibble: 1 × 1
##   `expected loss`
##             <dbl>
## 1           0.313
```

We can repeat this for every possible decision:


```r
make_loss <- function(our_d) {
  d %>% 
    mutate(loss = posterior * abs(our_d - p_grid)) %>% 
    summarise(weighted_average_loss = sum(loss))
}

(
  l <-
  d %>% 
  dplyr::select(p_grid) %>% 
  dplyr::rename(decision = p_grid) %>% 
  dplyr::mutate(weighted_average_loss = purrr::map(decision, make_loss)) %>% 
  tidyr::unnest(weighted_average_loss) 
)
```

```
## # A tibble: 1,000 × 2
##    decision weighted_average_loss
##       <dbl>                 <dbl>
##  1  0                       0.800
##  2  0.00100                 0.799
##  3  0.00200                 0.798
##  4  0.00300                 0.797
##  5  0.00400                 0.796
##  6  0.00501                 0.795
##  7  0.00601                 0.794
##  8  0.00701                 0.793
##  9  0.00801                 0.792
## 10  0.00901                 0.791
## # … with 990 more rows
```

Now it's easy to find the parameter value that minimises that loss:


```r
# this will help us find the x and y coordinates for the minimum value
min_loss <-
  l %>% 
  filter(weighted_average_loss == min(weighted_average_loss)) %>% 
  as.numeric()
# the plot
l %>%   
  ggplot(aes(x = decision, y = weighted_average_loss)) +
  geom_area(fill = "grey75") +
  geom_vline(xintercept = min_loss[1], color = "white", linetype = 3) +
  geom_hline(yintercept = min_loss[2], color = "white", linetype = 3) +
  ylab("expected proportional loss") +
  theme(panel.grid = element_blank())
```

<img src="03_sampling_from_the_imaginary_files/figure-html/unnamed-chunk-25-1.png" width="672"  />

And this is actually the posterior median.


```r
samples %>% 
  summarise(posterior_median = median(p_grid))
```

```
## # A tibble: 1 × 1
##   posterior_median
##              <dbl>
## 1            0.843
```

Usually it's better to communicate as much as you can about the posterior distribution, as well as the data and the model itself. 

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L02/54.png" width="80%"  />

You can't have confidence in an interval. It's doublespeak. *Compatibility* emphasises the uncertainty. Credibility is the next conversation. 

## Sampling to simulate prediction

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L02/55.png" width="80%"  />

We've got the model and now we want to know what it expects. So we get it to simulate predictions. 

***3.3.1 Dummy data***

Suppose $N$ = 2, two tosses, then there are only three possible observations: 0, 1 and 2 water. You can compute the probability of each for any given value of $p$. Let's use $p$ = 0.7, about the true proportion of water on the Earth.


```r
tibble(n      = 2,
       `p(w)` = .7,
       w      = 0:2) %>% 
  mutate(density = dbinom(w, size = n, prob = `p(w)`))
```

```
## # A tibble: 3 × 4
##       n `p(w)`     w density
##   <dbl>  <dbl> <int>   <dbl>
## 1     2    0.7     0    0.09
## 2     2    0.7     1    0.42
## 3     2    0.7     2    0.49
```

Now we'll simulate observations using these probabilities.


```r
rbinom(1, size = 2, prob = 0.7)
```

```
## [1] 2
```

That 1 means "1 water in 2 tosses." You can simulate a set of 10:


```r
set.seed(3)
rbinom(10, size = 2, prob = 0.7)
```

```
##  [1] 2 1 2 2 1 1 2 2 1 1
```

Let's generate 10,000 just to verify 0, 1 and 2 appear in proportion to their likelihoods:


```r
# how many would you like?
n_draws <- 1e5

set.seed(3)

d <- tibble(draws = rbinom(n_draws, size = 2, prob = .7))

d %>% 
  count(draws) %>% 
  mutate(proportion = n / nrow(d))
```

```
## # A tibble: 3 × 3
##   draws     n proportion
##   <int> <int>      <dbl>
## 1     0  9000      0.09 
## 2     1 42051      0.421
## 3     2 48949      0.489
```

Let's now simulate the sample size as before, with 9 tosses

<p><span class="marginnote shownote">
<!--
<div class="figure">-->
<img src="03_sampling_from_the_imaginary_files/figure-html/3.24-1.png" alt=" " width="672"  />
<!--
<p class="caption marginnote">--> <!--</p>-->
<!--</div>--></span></p>

```r
set.seed(3)
d <- tibble(draws = rbinom(n_draws, size = 9, prob = .7))

# the histogram
d %>% 
  ggplot(aes(x = draws)) +
  geom_histogram(binwidth = 1, center = 0,
                 color = "grey92", size = 1/10) +
  scale_x_continuous("dummy water count",
                     breaks = seq(from = 0, to = 9, by = 2)) +
  ylab("frequency") +
  coord_cartesian(xlim = c(0, 9)) +
  theme(panel.grid = element_blank())
```

Play around with different values of `size` and `prob`:


```r
n_draws <- 1e5

simulate_binom <- function(n, probability) {
  set.seed(3)
  rbinom(n_draws, size = n, prob = probability) 
}

d <-
  crossing(n           = c(3, 6, 9),
           probability = c(.3, .6, .9)) %>% 
  mutate(draws = map2(n, probability, simulate_binom)) %>% 
  ungroup() %>% 
  mutate(n           = str_c("n = ", n),
         probability = str_c("p = ", probability)) %>% 
  unnest(draws)

head(d)
```

```
## # A tibble: 6 × 3
##   n     probability draws
##   <chr> <chr>       <int>
## 1 n = 3 p = 0.3         0
## 2 n = 3 p = 0.3         2
## 3 n = 3 p = 0.3         1
## 4 n = 3 p = 0.3         0
## 5 n = 3 p = 0.3         1
## 6 n = 3 p = 0.3         1
```

```r
d %>% 
  ggplot(aes(x = draws)) +
  geom_histogram(binwidth = 1, center = 0,
                 color = "grey92", size = 1/10) +
  scale_x_continuous("dummy water count",
                     breaks = seq(from = 0, to = 9, by = 2)) +
  ylab("frequency") +
  coord_cartesian(xlim = c(0, 9)) +
  theme(panel.grid = element_blank()) +
  facet_grid(n ~ probability)
```

<img src="03_sampling_from_the_imaginary_files/figure-html/unnamed-chunk-29-1.png" width="672"  />

***3.3.2 Model checking***

Means:
1. Ensuring the model fitting worked correctly; and
2. Evaluating the adequacy of a model for some purpose. 

<div class="figure">
<p class="caption">(\#fig:unnamed-chunk-30)Let's consider three values from it. If we took the true value A and simulated a bunch of globe tosses, what would the sampling distribution look like? </p><img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L02/56.png" alt="Let's consider three values from it. If we took the true value A and simulated a bunch of globe tosses, what would the sampling distribution look like? " width="80%"  /></div>

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L02/57.png" width="80%"  />

<div class="figure">
<p class="caption">(\#fig:unnamed-chunk-32)If it were B instead, it would centre around 6.</p><img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L02/58.png" alt="If it were B instead, it would centre around 6." width="80%"  /></div>

<div class="figure">
<p class="caption">(\#fig:unnamed-chunk-33)We want a posterior predictive distribution which mixes all these together in proportion to the posterior probability of each value of $p$. We want the actual predictions of the model are not any one of these sampling distributions, they're all of them mixed together in the proper weights to the improbable weights of $p$ are given little weight and vice versa. </p><img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L02/59.png" alt="We want a posterior predictive distribution which mixes all these together in proportion to the posterior probability of each value of $p$. We want the actual predictions of the model are not any one of these sampling distributions, they're all of them mixed together in the proper weights to the improbable weights of $p$ are given little weight and vice versa. " width="80%"  /></div>

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L02/60.png" width="80%"  />

<div class="figure">
<p class="caption">(\#fig:unnamed-chunk-35)The probabilities come from the samples from the posterior distribution.</p><img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L02/61.png" alt="The probabilities come from the samples from the posterior distribution." width="80%"  /></div>

<p><span class="marginnote shownote">
<!--
<div class="figure">-->
<img src="03_sampling_from_the_imaginary_files/figure-html/3.25-1.png" alt=" " width="672"  />
<!--
<p class="caption marginnote">--> <!--</p>-->
<!--</div>--></span></p>

```r
w =  rbinom(1e4, size = 9, prob = .6)
rethinking::simplehist(w)
```

This generates 10,000 simulated predictions of 9 globe tosses `(size = 9)`, assuming $p$ = 0.6. The predictions are stored as counts of water. 

To propagate parameter uncertainty into these predictions, replace the value of `0.6` with samples from the posterior.

<p><span class="marginnote shownote">
<!--
<div class="figure">-->
<img src="03_sampling_from_the_imaginary_files/figure-html/3.26-1.png" alt=" " width="672"  />
<!--
<p class="caption marginnote">--> <!--</p>-->
<!--</div>--></span></p>

```r
p_grid = seq(from = 0, to = 1, length.out = 1000)
prob_p = rep(1, 1000)
prob_data = dbinom(6, size = 9, prob = p_grid)
posterior = prob_data * prob_p
posterior = posterior / sum(posterior)
samples = sample(p_grid, prob = posterior, size = 1e4, replace = T)
w = rbinom(1e4, size = 9, prob = samples)
rethinking::simplehist(w)
```


<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L02/62.png" width="80%"  />
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L02/63.png" width="80%"  />

## Let's practice with brms


```r
b3.1 <-
  brm(data = list(w = 6), 
      family = binomial(link = "identity"),
      w | trials(9) ~ 0 + Intercept,
      # this is a flat prior
      prior(beta(1, 1), class = b, lb = 0, ub = 1),
      iter = 5000, warmup = 1000,
      seed = 3,
      file = "fits/b03.01")
```


```r
brms::posterior_summary(b3.1)["b_Intercept", ] %>% 
  round(digits = 2)
```

```
##  Estimate Est.Error      Q2.5     Q97.5 
##      0.64      0.14      0.35      0.88
```


<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L02/64.png" width="80%"  />

## Practice {-}


```r
p_grid <- seq( from=0 , to=1 , length.out=1000 )
prior <- rep( 1 , 1000 )
likelihood <- dbinom( 6 , size=9 , prob=p_grid )
posterior <- likelihood * prior
posterior <- posterior / sum(posterior)
set.seed(100)
samples <- sample( p_grid , prob=posterior , size=1e4 , replace=TRUE )
```

<p><span class="marginnote shownote">
<!--
<div class="figure">-->
<img src="03_sampling_from_the_imaginary_files/figure-html/unnamed-chunk-41-1.png" alt=" " width="672"  />
<!--
<p class="caption marginnote">--> <!--</p>-->
<!--</div>--></span></p>

```r
rethinking::dens(samples)
```


```r
# 3E1. How much posterior lies below = 0.2?
sum(samples < 0.2) / length(samples)
```

```
## [1] 4e-04
```

```r
# 3E2. How much posterior probability lies above p = 0.8?
sum(samples > 0.8) / length(samples)
```

```
## [1] 0.1116
```

```r
# How much posterior probability lies between p = 0.2 and p = 0.8?
sum(samples > 0.2 & samples < 0.8) / length(samples)
```

```
## [1] 0.888
```

```r
# 3E4. 20% of the posterior probability lies below which value of p?
quantile(samples, 0.2)
```

```
##       20% 
## 0.5185185
```

```r
# 3E5. 20% of the posterior probability lies above which value of p?
quantile(samples, 0.8)
```

```
##       80% 
## 0.7557558
```

## Homework: week 1 {-}

1. Suppose the globe tossing data (Chapter 2) had turned out ot be 4 water in 15 tosses. Construct the posterior distribution, using grid approximation. Use the same flat prior as in the book.


```r
grid_size = 1000
n_water = 4

p_grid = seq(from = 0, to = 1, length.out = grid_size)

# define prior
prior = rep(1, grid_size)

# compute likelihood at each value in grid
likelihood = dbinom(n_water, size = 9, prob = p_grid)

# compute product of likelihood and prior
unstd.posterior = likelihood * prior

# standardise the posterior, so it susms to 1
posterior = unstd.posterior / sum(unstd.posterior)

# plot
plot(p_grid, posterior, type = "b",
     xlab = "probability of water",
     ylab = "posterior probability")
mtext(grid_size)  
```

<img src="03_sampling_from_the_imaginary_files/figure-html/unnamed-chunk-43-1.png" width="672"  />

2. Start over in 1, but now use a prior that is zero below $p$ = 0.5 and a constant above $p$ = 0.5. This corresponds to prior inforamtion that a majority of the Earth's surface is water. What difference does the better prior make? 


```r
grid_size = 1000
n_water = 4

p_grid = seq(from = 0, to = 1, length.out = grid_size)

# define prior
prior = ifelse(p_grid < .5, 0, 1)

# compute likelihood at each value in grid
likelihood = dbinom(n_water, size = 9, prob = p_grid)

# compute product of likelihood and prior
unstd.posterior = likelihood * prior

# standardise the posterior, so it susms to 1
posterior = unstd.posterior / sum(unstd.posterior)

# plot
plot(p_grid, posterior, type = "b",
     xlab = "probability of water",
     ylab = "posterior probability")
mtext(grid_size)  
```

<img src="03_sampling_from_the_imaginary_files/figure-html/unnamed-chunk-44-1.png" width="672"  />

3. For the posterior distribution from **2**, compute 89% percentile and HPDI intervals. Compare the widths of these intervals. Which is wider? Why? If you had only the information in the interval, what might you misunderstand about the shape of the posterior distribution? 


```r
samples = sample(p_grid, prob = posterior, size = 1e4, replace = T)

rethinking::PI(samples)
```

```
##        5%       94% 
## 0.5085085 0.7497497
```

```r
rethinking::HPDI(samples)
```

```
##     |0.89     0.89| 
## 0.5005005 0.7097097
```

```r
# PI is wider, and neither tells you that the highest point is just after 50%.
```

