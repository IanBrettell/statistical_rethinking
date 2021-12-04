# Ulysses' Compass


```r
library(here)
source(here::here("code/scripts/source.R"))
```


```r
slides_dir = here::here("docs/slides/L07")
```

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L07/14.png" alt="Polish astronomer and ecclesiastical lawyer. Famous for arguing about the heliocentric model. What's missing is that Copernicus's model was terrible. No better than the Ptolemaic model." width="80%" />
<p class="caption">Polish astronomer and ecclesiastical lawyer. Famous for arguing about the heliocentric model. What's missing is that Copernicus's model was terrible. No better than the Ptolemaic model.</p>
</div>



<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L07/15.png" alt="Keppler later figured out that orbits were ellipses. If you're committed to circles, you can't make it work unless you stack circles on circles. Was an equivalent model. Copernican needed fewer epicricles.. it's simpler, and therefore more beautiful. " width="80%" />
<p class="caption">Keppler later figured out that orbits were ellipses. If you're committed to circles, you can't make it work unless you stack circles on circles. Was an equivalent model. Copernican needed fewer epicricles.. it's simpler, and therefore more beautiful. </p>
</div>



<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L07/16.png" alt="Not a fully-developed research program. Need something more substantial if we wantto chose between models based on complexity." width="80%" />
<p class="caption">Not a fully-developed research program. Need something more substantial if we wantto chose between models based on complexity.</p>
</div>



<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L07/17.png" alt="Often we have to make trade-offs between complexity and accuracy. Usually what we're trading off. So Ockham's Razor is one-sided. Let's think of _The Odyssey_. He gets near Sicily, and there are two monsters, Scylla and Charybdis, who eat most of his crew." width="80%" />
<p class="caption">Often we have to make trade-offs between complexity and accuracy. Usually what we're trading off. So Ockham's Razor is one-sided. Let's think of _The Odyssey_. He gets near Sicily, and there are two monsters, Scylla and Charybdis, who eat most of his crew.</p>
</div>



<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L07/18.png" alt="Metaphor for how complexity and accuracy trade off. There are monsters on both sides, with different characteristics. " width="80%" />
<p class="caption">Metaphor for how complexity and accuracy trade off. There are monsters on both sides, with different characteristics. </p>
</div>



<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L07/19.png" alt="In the wilds of the sciences, the standard method is &quot;star-gazing&quot;, because you run a regression and you keep the asterisks. There's nothing about p-values, but whether you use them or not, they're not designed for this, so they do a bad job at it. Statistical significance is not a criterion about predictive accuracy, but rather Type 1 error rate." width="80%" />
<p class="caption">In the wilds of the sciences, the standard method is "star-gazing", because you run a regression and you keep the asterisks. There's nothing about p-values, but whether you use them or not, they're not designed for this, so they do a bad job at it. Statistical significance is not a criterion about predictive accuracy, but rather Type 1 error rate.</p>
</div>



<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L07/20.png" alt="Scylla and Charybdis. Regularization teaches statistical models to expect overfitting and guard against it. CV and information cirteria are tools to cope with it,  by not solving it, but measuiring it. Want to emphasise that finding a model that makes good predictions is different from causal inference. Netflix predicts your viewing habits. No one understands how those systems work. But in the basic sciences we intend to intervene. " width="80%" />
<p class="caption">Scylla and Charybdis. Regularization teaches statistical models to expect overfitting and guard against it. CV and information cirteria are tools to cope with it,  by not solving it, but measuiring it. Want to emphasise that finding a model that makes good predictions is different from causal inference. Netflix predicts your viewing habits. No one understands how those systems work. But in the basic sciences we intend to intervene. </p>
</div>



<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L07/21.png" alt="Think about a contest between different models. In a given race (sample), one horse will win (fit it the best). The distance between the horses gives us information about the relative performance on average across tracks. You want to make a bet on the _next_ race. The quantiative differences between the finishing times is what you want to use. The finishing times won't be exactly the same. What you shouldn't do is alwasy choose the horse that runs the fastest." width="80%" />
<p class="caption">Think about a contest between different models. In a given race (sample), one horse will win (fit it the best). The distance between the horses gives us information about the relative performance on average across tracks. You want to make a bet on the _next_ race. The quantiative differences between the finishing times is what you want to use. The finishing times won't be exactly the same. What you shouldn't do is alwasy choose the horse that runs the fastest.</p>
</div>

## The problem with parameters

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L07/22.png" alt="The basic problem is that models that are too simple don't know enough; and models that are too complex learn too much. On the extrmee, you can encrypt every data point as a parameter, but it will make terrible predictions. Want to learn the &quot;regular features&quot; of the sample. Multilevel models don't work like this because they're less liekly to overfit. I have a model with 27K parameters, and it overfits very little because of this hierarchical structure." width="80%" />
<p class="caption">The basic problem is that models that are too simple don't know enough; and models that are too complex learn too much. On the extrmee, you can encrypt every data point as a parameter, but it will make terrible predictions. Want to learn the "regular features" of the sample. Multilevel models don't work like this because they're less liekly to overfit. I have a model with 27K parameters, and it overfits very little because of this hierarchical structure.</p>
</div>

***7.1.1. More parameters (almost) always improve fit***

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L07/23.png" alt="Humans have big brains. If we look at body mass v brain volume, there is some association. What's the statistical relationship?" width="80%" />
<p class="caption">Humans have big brains. If we look at body mass v brain volume, there is some association. What's the statistical relationship?</p>
</div>


```r
(
  d <- 
  tibble(species = c("afarensis", "africanus", "habilis", "boisei", "rudolfensis", "ergaster", "sapiens"), 
         brain   = c(438, 452, 612, 521, 752, 871, 1350), 
         mass    = c(37.0, 35.5, 34.5, 41.5, 55.5, 61.0, 53.5))
  )
```

```
## # A tibble: 7 × 3
##   species     brain  mass
##   <chr>       <dbl> <dbl>
## 1 afarensis     438  37  
## 2 africanus     452  35.5
## 3 habilis       612  34.5
## 4 boisei        521  41.5
## 5 rudolfensis   752  55.5
## 6 ergaster      871  61  
## 7 sapiens      1350  53.5
```


<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L07/24.png" alt="$R^2$ is one of the most over-used measures. If there's no variance in the residuals, $R^2$ = 1. It's trivial to get there. A bit of a joke, but I've seen it in _Nature_." width="80%" />
<p class="caption">$R^2$ is one of the most over-used measures. If there's no variance in the residuals, $R^2$ = 1. It's trivial to get there. A bit of a joke, but I've seen it in _Nature_.</p>
</div>


```r
library(rcartocolor)
```


```r
library(ggrepel)

theme_set(
  theme_classic() +
    theme(text = element_text(family = "Courier"),
          panel.background = element_rect(fill = alpha(rcartocolor::carto_pal(7, "BurgYl")[3], 1/4)))
)

d %>%
  ggplot(aes(x =  mass, y = brain, label = species)) +
  geom_point(color = carto_pal(7, "BurgYl")[5]) +
  geom_text_repel(size = 3, color = rcartocolor::carto_pal(7, "BurgYl")[7], family = "Courier", seed = 438) +
  labs(subtitle = "Average brain volume by body\nmass for six hominin species",
       x = "body mass (kg)",
       y = "brain volume (cc)") +
  xlim(30, 65)
```

<img src="07_ulysses_compass_files/figure-html/unnamed-chunk-15-1.png" width="672" />

>we want to standardize body mass–give it mean zero and standard deviation one–and rescale the outcome, brain volume, so that the largest observed value is 1. Why not standardize brain volume as well? Because we want to preserve zero as a reference point: No brain at all. You can’t have negative brain. I don’t think. (p. 195)


```r
d <-
  d %>% 
  mutate(mass_std  = (mass - mean(mass)) / sd(mass),
         brain_std = brain / max(brain))
```

>This simply says that the average brain volume bi of species i is a linear function of its body mass mi. Now consider what the priors imply. The prior for α is just centered on the mean brain volume (rescaled) in the data. So it says that the average species with an average body mass has a brain volume with an 89% credible interval from about −1 to 2. That is ridiculously wide and includes impossible (negative) values. The prior for β is very flat and centered on zero. It allows for absurdly large positive and negative relationships. These priors allow for absurd inferences, especially as the model gets more complex. And that’s part of the lesson. (p. 196)


```r
b7.1 <- 
  brm(data = d, 
      family = gaussian,
      brain_std ~ 1 + mass_std,
      prior = c(prior(normal(0.5, 1), class = Intercept),
                prior(normal(0, 10), class = b),
                prior(lognormal(0, 1), class = sigma)),
      iter = 2000, warmup = 1000, chains = 4, cores = 4,
      seed = 7,
      file = "fits/b07.01")
```


I’ve used `exp(log_sigma)` in the likelihood, so that the result is always greater than zero.


```r
print(b7.1)
```

```
##  Family: gaussian 
##   Links: mu = identity; sigma = identity 
## Formula: brain_std ~ 1 + mass_std 
##    Data: d (Number of observations: 7) 
## Samples: 4 chains, each with iter = 2000; warmup = 1000; thin = 1;
##          total post-warmup samples = 4000
## 
## Population-Level Effects: 
##           Estimate Est.Error l-95% CI u-95% CI Rhat Bulk_ESS Tail_ESS
## Intercept     0.53      0.10     0.31     0.74 1.00     2487     1978
## mass_std      0.17      0.11    -0.06     0.41 1.00     2619     2123
## 
## Family Specific Parameters: 
##       Estimate Est.Error l-95% CI u-95% CI Rhat Bulk_ESS Tail_ESS
## sigma     0.26      0.11     0.13     0.55 1.00     1543     2174
## 
## Samples were drawn using sampling(NUTS). For each parameter, Bulk_ESS
## and Tail_ESS are effective sample size measures, and Rhat is the potential
## scale reduction factor on split chains (at convergence, Rhat = 1).
```

---

**Rethinking:**

You could use OLS to get posteriors for these brain size model, e.g. by using `lm`. But you won't get a posterior for `sigma`. 

>Bayesian inference means approximating the posterior distribution. It does not specify how that approximation is done.

---

We'll compute $R^2$ ourselves by computing the variance of the residuals, and the variance of the outcome variable. This means the actual empirical variance, not the variance that R returns with the `var` function, which is a frequentist estimator and therefore has the wrong denominator. So we’ll compute variance the old fashioned way: the average squared deviation from the mean. `rethinking::var2` does this.

Let's write a function to do this again:


```r
R2_is_bad <- function(brm_fit, seed = 7, ...) {
  
  set.seed(seed)
  p <- predict(brm_fit, summary = F, ...)
  r <- apply(p, 2, mean) - d$brain_std
  1 - rethinking::var2(r) / rethinking::var2(d$brain_std)
  
}

R2_is_bad(b7.1)
```

```
## [1] 0.4847697
```



Now we'll compare 5 models, each just a polynomial of higher degree.


```r
b7.2 <- 
  brm(data = d, 
      family = gaussian,
      brain_std ~ 1 + mass_std + I(mass_std^2),
      prior = c(prior(normal(0.5, 1), class = Intercept),
                prior(normal(0, 10), class = b),
                prior(lognormal(0, 1), class = sigma)),
      iter = 2000, warmup = 1000, chains = 4, cores = 4,
      seed = 7,
      file = "fits/b07.02")
```


```r
# cubic
b7.3 <- 
  brm(data = d, 
      family = gaussian,
      brain_std ~ 1 + mass_std + I(mass_std^2) + I(mass_std^3),
      prior = c(prior(normal(0.5, 1), class = Intercept),
                prior(normal(0, 10), class = b),
                prior(lognormal(0, 1), class = sigma)),
      iter = 2000, warmup = 1000, chains = 4, cores = 4,
      seed = 7,
      file = "fits/b07.03")

# fourth-order
b7.4 <- 
  brm(data = d, 
      family = gaussian,
      brain_std ~ 1 + mass_std + I(mass_std^2) + I(mass_std^3) + I(mass_std^4),
      prior = c(prior(normal(0.5, 1), class = Intercept),
                prior(normal(0, 10), class = b),
                prior(lognormal(0, 1), class = sigma)),
      iter = 2000, warmup = 1000, chains = 4, cores = 4,
      seed = 7,
      file = "fits/b07.04")
  
# fifth-order
b7.5 <- 
  brm(data = d, 
      family = gaussian,
      brain_std ~ 1 + mass_std + I(mass_std^2) + I(mass_std^3) + I(mass_std^4) + I(mass_std^5),
      prior = c(prior(normal(0.5, 1), class = Intercept),
                prior(normal(0, 10), class = b),
                prior(lognormal(0, 1), class = sigma)),
      iter = 2000, warmup = 1000, chains = 4, cores = 4,
      seed = 7,
      file = "fits/b07.05")
```

For the last one we replace the standard deviation with 0.001.

By "last model, m7.6," McElreath was referring to the sixth-order polynomial, fit on page 199. McElreath’s rethinking package is set up so the syntax is simple to replacing σ with a constant value. We can do this with brms, too, but it’ll take more effort. If we want to fix σ to a constant, we’ll need to define a custom likelihood. Bürkner explained how to do so in his (2021a) vignette, Define custom response distributions with brms. I’m not going to explain this in great detail, here. In brief, first we use the `custom_family()` function to define the name and parameters of a `custom_normal()` likelihood that will set σ to a constant value, 0.001. Second, we’ll define some functions for Stan which are not defined in Stan itself and save them as `stan_funs`. Third, we make a `stanvar()` statement which will allow us to pass our `stan_funs` to `brm()`.


```r
custom_normal <- custom_family(
  "custom_normal", dpars = "mu",
  links = "identity",
  type = "real"
)

stan_funs  <- "real custom_normal_lpdf(real y, real mu) {
  return normal_lpdf(y | mu, 0.001);
}
real custom_normal_rng(real mu) {
  return normal_rng(mu, 0.001);
}
" 

stanvars <- stanvar(scode = stan_funs, block = "functions")

b7.6 <- 
  brm(data = d, 
      family = custom_normal,
      brain_std ~ 1 + mass_std + I(mass_std^2) + I(mass_std^3) + I(mass_std^4) + I(mass_std^5) + I(mass_std^6),
      prior = c(prior(normal(0.5, 1), class = Intercept),
                prior(normal(0, 10), class = b)),
      iter = 2000, warmup = 1000, chains = 4, cores = 4,
      seed = 7,
      stanvars = stanvars,
      file = "fits/b07.06")
```


```r
expose_functions(b7.6, vectorize = TRUE)

posterior_epred_custom_normal <- function(prep) {
  mu <- prep$dpars$mu
  mu 
}

posterior_predict_custom_normal <- function(i, prep, ...) {
  mu <- prep$dpars$mu
  mu 
  custom_normal_rng(mu)
}

log_lik_custom_normal <- function(i, prep) {
  mu <- prep$dpars$mu
  y <- prep$data$Y[i]
  custom_normal_lpdf(y, mu)
}
```


```r
nd <- tibble(mass_std = seq(from = -2, to = 2, length.out = 100))

fitted(b7.1, 
       newdata = nd, 
       probs = c(.055, .945)) %>% 
  data.frame() %>% 
  bind_cols(nd) %>% 
  
  ggplot(aes(x = mass_std, y = Estimate)) +
  geom_lineribbon(aes(ymin = Q5.5, ymax = Q94.5),
                  color = carto_pal(7, "BurgYl")[7], size = 1/2, 
                  fill = alpha(carto_pal(7, "BurgYl")[6], 1/3)) +
  geom_point(data = d,
             aes(y = brain_std),
             color = carto_pal(7, "BurgYl")[7]) +
  labs(subtitle = bquote(italic(R)^2==.(round(R2_is_bad(b7.1), digits = 2))),
       x = "body mass (standardized)",
       y = "brain volume (standardized)") +
  coord_cartesian(xlim = range(d$mass_std))
```

<img src="07_ulysses_compass_files/figure-html/7.10-1.png" width="672" />




<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L07/25.png" alt="This isn't a bad model. $R^2$ is 0.5 - that's pretty good. But can you do better?" width="80%" />
<p class="caption">This isn't a bad model. $R^2$ is 0.5 - that's pretty good. But can you do better?</p>
</div>




<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L07/26.png" alt="Sure, make it a parabola. Does a little better. Why stop there?" width="80%" />
<p class="caption">Sure, make it a parabola. Does a little better. Why stop there?</p>
</div>



<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L07/27.png" alt="We can make it all the way to 6 parameters, then we run out of data points." width="80%" />
<p class="caption">We can make it all the way to 6 parameters, then we run out of data points.</p>
</div>



<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L07/28.png" width="80%" />



<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L07/29.png" alt="Maybe brain evolution is cubic." width="80%" />
<p class="caption">Maybe brain evolution is cubic.</p>
</div>



<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L07/30.png" width="80%" />



<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L07/31.png" width="80%" />



<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L07/32.png" alt="Finally, we've reached nirvana - the singularity. If all you do basing your model on $R^2$, this is the danger. In multiple regression, it's less obvious that it's happening." width="80%" />
<p class="caption">Finally, we've reached nirvana - the singularity. If all you do basing your model on $R^2$, this is the danger. In multiple regression, it's less obvious that it's happening.</p>
</div>


```r
make_figure7.3 <- function(brms_fit, ylim = range(d$brain_std)) {
  
  # compute the R2
  r2 <- R2_is_bad(brms_fit)
  
  # define the new data 
  nd <- tibble(mass_std = seq(from = -2, to = 2, length.out = 200))
  
  # simulate and wrangle
  fitted(brms_fit, newdata = nd, probs = c(.055, .945)) %>% 
    data.frame() %>% 
    bind_cols(nd) %>% 
    
    # plot!  
    ggplot(aes(x = mass_std)) +
    geom_lineribbon(aes(y = Estimate, ymin = Q5.5, ymax = Q94.5),
                    color = carto_pal(7, "BurgYl")[7], size = 1/2, 
                    fill = alpha(carto_pal(7, "BurgYl")[6], 1/3)) +
    geom_point(data = d,
               aes(y = brain_std),
               color = carto_pal(7, "BurgYl")[7]) +
    labs(subtitle = bquote(italic(R)^2==.(round(r2, digits = 2))),
         x = "body mass (std)",
         y = "brain volume (std)") +
    coord_cartesian(xlim = c(-1.2, 1.5),
                    ylim = ylim)
  
}

p1 <- make_figure7.3(b7.1)
p2 <- make_figure7.3(b7.2)
p3 <- make_figure7.3(b7.3)
p4 <- make_figure7.3(b7.4, ylim = c(.25, 1.1))
p5 <- make_figure7.3(b7.5, ylim = c(.1, 1.4))
p6 <- make_figure7.3(b7.6, ylim = c(-0.25, 1.5)) +
  geom_hline(yintercept = 0, color = carto_pal(7, "BurgYl")[2], linetype = 2) 

library(patchwork)

((p1 | p2) / (p3 | p4) / (p5 | p6)) +
  patchwork::plot_annotation(title = "Figure7.3. Polynomial linear models of increasing\ndegree for the hominin data.")
```

<div class="figure">
<img src="07_ulysses_compass_files/figure-html/unnamed-chunk-26-1.png" alt="Figure 7.3" width="672" />
<p class="caption">Figure 7.3</p>
</div>

***7.1.2. Too few parameters hurts, too***

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L07/33.png" alt="The model is overly sensitive. We can repeat the linear regression, removing one data point at a time. The lines don't move very much. Drops a lot when we drop _homo sapiens_." width="80%" />
<p class="caption">The model is overly sensitive. We can repeat the linear regression, removing one data point at a time. The lines don't move very much. Drops a lot when we drop _homo sapiens_.</p>
</div>



<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L07/34.png" alt="This fifth-order polynomial." width="80%" />
<p class="caption">This fifth-order polynomial.</p>
</div>


```r
#d_minus_i <- d[ -i , ]
```


```r
b7.1.1 <- 
  brm(data = filter(d, row_number() != 1), 
      family = gaussian,
      brain_std ~ 1 + mass_std,
      prior = c(prior(normal(0.5, 1), class = Intercept),
                prior(normal(0, 10), class = b),
                prior(lognormal(0, 1), class = sigma)),
      iter = 2000, warmup = 1000, chains = 4, cores = 4,
      seed = 7,
      file = "fits/b07.01.1")
```


```r
print(b7.1.1)
```

```
##  Family: gaussian 
##   Links: mu = identity; sigma = identity 
## Formula: brain_std ~ 1 + mass_std 
##    Data: filter(d, row_number() != 1) (Number of observations: 6) 
## Samples: 4 chains, each with iter = 2000; warmup = 1000; thin = 1;
##          total post-warmup samples = 4000
## 
## Population-Level Effects: 
##           Estimate Est.Error l-95% CI u-95% CI Rhat Bulk_ESS Tail_ESS
## Intercept     0.54      0.14     0.25     0.83 1.00     2007     1625
## mass_std      0.16      0.15    -0.15     0.49 1.00     2416     1595
## 
## Family Specific Parameters: 
##       Estimate Est.Error l-95% CI u-95% CI Rhat Bulk_ESS Tail_ESS
## sigma     0.31      0.16     0.14     0.74 1.00     1169     1657
## 
## Samples were drawn using sampling(NUTS). For each parameter, Bulk_ESS
## and Tail_ESS are effective sample size measures, and Rhat is the potential
## scale reduction factor on split chains (at convergence, Rhat = 1).
```


```r
fitted(b7.1.1, 
       newdata = nd) %>% 
  data.frame() %>% 
  bind_cols(nd) %>% 
  
  ggplot(aes(x = mass_std)) +
  geom_line(aes(y = Estimate),
            color = carto_pal(7, "BurgYl")[7], size = 1/2, alpha = 1/2) +
  geom_point(data = d,
             aes(y = brain_std),
             color = carto_pal(7, "BurgYl")[7]) +
  labs(subtitle = "b7.1.1",
       x = "body mass (std)",
       y = "brain volume (std)") +
  coord_cartesian(xlim = range(d$mass_std),
                  ylim = range(d$brain_std))
```

<img src="07_ulysses_compass_files/figure-html/unnamed-chunk-31-1.png" width="672" />


## Entropy and accuracy


<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L07/35.png" alt="Multiple strategies. In Bayesian statistics, we regularise. Can be even omre aggressive. In non-Bayesian, it's mathematically identical to using a prior. Why do machine leanring people regularise? Because it makes better predictions. " width="80%" />
<p class="caption">Multiple strategies. In Bayesian statistics, we regularise. Can be even omre aggressive. In non-Bayesian, it's mathematically identical to using a prior. Why do machine leanring people regularise? Because it makes better predictions. </p>
</div>



<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L07/36.png" alt="We want to get to CV and WAIC, which replaced AIC. The jounrey to these appraoches requires some setups. First thing to answer is how to measure accuracy. Many bad ways to measure it. There's an actual gold standard. And once we've got it, we want to measure distance from the target. How do we decide how close the models are getting to it? Then we learn how to develop these instruments." width="80%" />
<p class="caption">We want to get to CV and WAIC, which replaced AIC. The jounrey to these appraoches requires some setups. First thing to answer is how to measure accuracy. Many bad ways to measure it. There's an actual gold standard. And once we've got it, we want to measure distance from the target. How do we decide how close the models are getting to it? Then we learn how to develop these instruments.</p>
</div>

***7.2.1. Firing the weatherperson***

In defining a target, there are two major dimensions to worry about:

1.  *Cost-benefit analysis*. How much does it cost when we're wrong? How much do we win when we're right? Most scientists never ask these questions in any formal way, but applied scientists must routinely answer them.
2. *Accuracy in context*. Some prediction tasks are inherently easier than others. So even if we ignore costs and benefits, we still need a way to judge "accuracy" that accounts for how much a model could possibly improve prediction.

<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L07/37.png" width="80%" />

-----


```r
slides_dir = here::here("docs/slides/L08")
```

<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L08/01.png" width="60%" />

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L08/02.png" alt="We need to appeal to information theory because machine prediction works by following the laws of information theory. We'll drive the single gold-standard way to score a model's accuracy. Here's the basic problem information theory sets out to address. When we have some unknown event, there is uncertainty. When we know more, we become less uncertain. IC is a principle for saying when something is more uncertain than something else. There's uncertainty about the weather tomorrow. We may use cues from today to predict tomorrow." width="60%" />
<p class="caption">We need to appeal to information theory because machine prediction works by following the laws of information theory. We'll drive the single gold-standard way to score a model's accuracy. Here's the basic problem information theory sets out to address. When we have some unknown event, there is uncertainty. When we know more, we become less uncertain. IC is a principle for saying when something is more uncertain than something else. There's uncertainty about the weather tomorrow. We may use cues from today to predict tomorrow.</p>
</div>



<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L08/03.png" alt="Presume you know that LA has no weather. Always sunny. 15-20 degrees. Little uncertainty. If it does rain, you'll be shocked. Contrast this with Glasgow, where it rains a lot. More rain than not. NY has highly-variable weather. There's great uncertainty about what the weather would be like, unlike the other two. This uncertainty arises from the frequency distributions of these microclimates." width="60%" />
<p class="caption">Presume you know that LA has no weather. Always sunny. 15-20 degrees. Little uncertainty. If it does rain, you'll be shocked. Contrast this with Glasgow, where it rains a lot. More rain than not. NY has highly-variable weather. There's great uncertainty about what the weather would be like, unlike the other two. This uncertainty arises from the frequency distributions of these microclimates.</p>
</div>

***7.2.2. Information and uncertainty***

The basic insight is to ask: How much is our uncertainty reduced by learning an outcome? 

>Information: The reduction in uncertainty when we learn an outcome.

There are many possible ways to measure uncertainty. The most common way begins by naming some properties a measure of uncertainty should possess. These are the three intuitive desiderata:

1. The measure of uncertainty should be continuous. 

2. The measure of uncertainty should increase as the number of possible events increases.  

3. The measure of uncertainty should be additive.

There is only one function that satisfies these desiderata. This function is usually known as INFORMATION ENTROPY, and has a surprisingly simple definition.

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L08/04.png" alt="Uncertainty $H$ of $p$, which is a vector of probability, is just the average log-probability of the event. This is a unique criterion. If you want a reasonable measure of surprise, you have to adopt something that is this or something proportional to this. Your mobile phones (3G and above) work because of this." width="60%" />
<p class="caption">Uncertainty $H$ of $p$, which is a vector of probability, is just the average log-probability of the event. This is a unique criterion. If you want a reasonable measure of surprise, you have to adopt something that is this or something proportional to this. Your mobile phones (3G and above) work because of this.</p>
</div>

***7.2.3. From entropy to accuracy***

How can we use information entropy to say how far a model is from the target? 

> **Divergence**: The additional uncertainty induced by using probabilities from one distribution to describe another distribution.

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L08/05.png" alt="What's the **potential for surprise**?. We are interested in this. Want to calculate the entropy of our model, and then there's the entropy of the true distribution, of nature. And we want to minimise the difference between them. This is called the $D_{KL}$ divergence. Two probabilities $p$ and $q$. $p$ is nature, say the frequencies of weather events, and $q$ is our forecast. If we want to score $q$, we look at the divergence. K is for Kulbak. The distance from $p$ to $q$ is the sum (averaging) between $p$ and $q$. It's a distance, but it's not symmetric. " width="60%" />
<p class="caption">What's the **potential for surprise**?. We are interested in this. Want to calculate the entropy of our model, and then there's the entropy of the true distribution, of nature. And we want to minimise the difference between them. This is called the $D_{KL}$ divergence. Two probabilities $p$ and $q$. $p$ is nature, say the frequencies of weather events, and $q$ is our forecast. If we want to score $q$, we look at the divergence. K is for Kulbak. The distance from $p$ to $q$ is the sum (averaging) between $p$ and $q$. It's a distance, but it's not symmetric. </p>
</div>



<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L08/06.png" alt="Easy to code. Take the vector `p`. Sum `p` time the difference between `log(p)` and `log(q)`. It's only 0 where `q = p`. " width="60%" />
<p class="caption">Easy to code. Take the vector `p`. Sum `p` time the difference between `log(p)` and `log(q)`. It's only 0 where `q = p`. </p>
</div>


```r
t <- 
  tibble(p_1 = .3,
         p_2 = .7,
         q_1 = seq(from = .01, to = .99, by = .01)) %>% 
  mutate(q_2 = 1 - q_1) %>%
  mutate(d_kl = (p_1 * log(p_1 / q_1)) + (p_2 * log(p_2 / q_2)))

head(t)
```

```
## # A tibble: 6 × 5
##     p_1   p_2   q_1   q_2  d_kl
##   <dbl> <dbl> <dbl> <dbl> <dbl>
## 1   0.3   0.7  0.01  0.99 0.778
## 2   0.3   0.7  0.02  0.98 0.577
## 3   0.3   0.7  0.03  0.97 0.462
## 4   0.3   0.7  0.04  0.96 0.383
## 5   0.3   0.7  0.05  0.95 0.324
## 6   0.3   0.7  0.06  0.94 0.276
```

```r
t %>% 
  ggplot(aes(x = q_1, y = d_kl)) +
  geom_vline(xintercept = .3, color = carto_pal(7, "BurgYl")[5], linetype = 2) +
  geom_line(color = carto_pal(7, "BurgYl")[7], size = 1.5) +
  annotate(geom = "text", x = .4, y = 1.5, label = "q = p",
           color = carto_pal(7, "BurgYl")[5], family = "Courier", size = 3.5) +
  labs(x = "q[1]",
       y = "Divergence of q from p")
```

<div class="figure">
<img src="07_ulysses_compass_files/figure-html/unnamed-chunk-42-1.png" alt="Figure 7.6" width="672" />
<p class="caption">Figure 7.6</p>
</div>


Suppose instead we live in Abu Dhabi. Then the probabilities of rain and shine might be more like 
$p_1 = 0.01 $ and $p_2 = 0.99$. Now the entropy would be approximately 0.06. Why has the uncertainty decreased? Because in Abu Dhabi it hardly ever rains. Therefore there’s much less uncertainty about any given day, compared to a place in which it rains 30% of the time. It’s in this way that information entropy measures the uncertainty inherent in a distribution of events. Similarly, if we add another kind of event to the distribution—forecasting into winter, so also predicting snow—entropy tends to increase, due to the added dimensionality of the prediction problem. 

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L08/07.png" alt="Here's a cartoon version. You're heading to Mars, or a Mars-like planet, but you don't know much about it. You can't control your rocket and you want to predict whether you'll land on water or land. You'll use Earth as your only model. Earth is a high-entropy planet because it has a lot of water and land. So you won't be surprised whether you get land or water. " width="60%" />
<p class="caption">Here's a cartoon version. You're heading to Mars, or a Mars-like planet, but you don't know much about it. You can't control your rocket and you want to predict whether you'll land on water or land. You'll use Earth as your only model. Earth is a high-entropy planet because it has a lot of water and land. So you won't be surprised whether you get land or water. </p>
</div>



<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L08/08.png" alt="But say you're going in the other direction. Your potential for surprise is now very high. When you get to Earth and discover all this blue liquid, you'll be surprised. Mars is the LA of planets. And as a consequence, the information distance from Earth to Mars is smaller than the information distance from Mars to Earth. Because if your model is the Earth, it expects all sorts of events, which means that it's less surprised, which means that its prediction error is lower, on average, across a huge number of potential planets across the universe, than if you came from Mars, where you'll be surprised by water all the time. **This is why simpler models work better - because they have higher entropy.** The distance between a simpler model and other things are on average lower, because it expects many things. Gneeralized linear models have higher entropy. All machine learning works this way." width="60%" />
<p class="caption">But say you're going in the other direction. Your potential for surprise is now very high. When you get to Earth and discover all this blue liquid, you'll be surprised. Mars is the LA of planets. And as a consequence, the information distance from Earth to Mars is smaller than the information distance from Mars to Earth. Because if your model is the Earth, it expects all sorts of events, which means that it's less surprised, which means that its prediction error is lower, on average, across a huge number of potential planets across the universe, than if you came from Mars, where you'll be surprised by water all the time. **This is why simpler models work better - because they have higher entropy.** The distance between a simpler model and other things are on average lower, because it expects many things. Gneeralized linear models have higher entropy. All machine learning works this way.</p>
</div>

***7.2.4. Estimating divergence***

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L08/09.png" alt="How to estimate this in practice: we want the gold standard way to score, but the problem is we can't score the truth. Turns out we don't need the truth part because it's just an additive term, so you can get the relative scores of the models without knowning the truth. THe log score is the gold standard, whether you're Bayesian or not. In practice, there's not a single log score, but a distribution of log scores. So we want the average log score, which unfortunately is called the *log-pointwise-predictive-density*. For each point `i`, we're taking the average probability of that observation conditional on the samples, and we average over the samples, and find the average probabiltiy that the model expects, then we take the log and sum across all observations in the model." width="60%" />
<p class="caption">How to estimate this in practice: we want the gold standard way to score, but the problem is we can't score the truth. Turns out we don't need the truth part because it's just an additive term, so you can get the relative scores of the models without knowning the truth. THe log score is the gold standard, whether you're Bayesian or not. In practice, there's not a single log score, but a distribution of log scores. So we want the average log score, which unfortunately is called the *log-pointwise-predictive-density*. For each point `i`, we're taking the average probability of that observation conditional on the samples, and we average over the samples, and find the average probabiltiy that the model expects, then we take the log and sum across all observations in the model.</p>
</div>

>This kind of score is a log-probability score, and it is the gold standard way to compare the predictive accuracy of different models. It is an estimate of $E\ log(q_i)$, just without the final step of dividing by the number of observations.

Compute lppd for the first model we fit in this chapter:


```r
log_lik(b7.1) %>% 
  data.frame() %>% 
  purrr::set_names(pull(d, species)) %>% 
  pivot_longer(everything(),
               names_to = "species",
               values_to = "logprob") %>% 
  mutate(prob = exp(logprob)) %>% 
  group_by(species) %>% 
  summarise(log_probability_score = mean(prob) %>% log())
```

```
## # A tibble: 7 × 2
##   species     log_probability_score
##   <chr>                       <dbl>
## 1 afarensis                   0.384
## 2 africanus                   0.411
## 3 boisei                      0.400
## 4 ergaster                    0.231
## 5 habilis                     0.336
## 6 rudolfensis                 0.274
## 7 sapiens                    -0.607
```

>If you sum these values, you’ll have the total log-probability score for the model and data” (p. 210).

Here we sum those $log(q_i)$ values up to compute $S(q)$.


```r
log_lik(b7.1) %>% 
  data.frame() %>% 
  set_names(pull(d, species)) %>% 
  pivot_longer(everything(),
               names_to = "species",
               values_to = "logprob") %>% 
  mutate(prob = exp(logprob)) %>% 
  group_by(species) %>% 
  summarise(log_probability_score = mean(prob) %>% log()) %>% 
  summarise(total_log_probability_score = sum(log_probability_score))
```

```
## # A tibble: 1 × 1
##   total_log_probability_score
##                         <dbl>
## 1                        1.43
```


Larger values are better, because that indicates larger average accuracy.


```r
log_prob <- brms::log_lik(b7.1) 

log_prob %>%
  glimpse()
```

```
##  num [1:4000, 1:7] 0.769 0.396 0.894 0.558 -0.235 ...
##  - attr(*, "dimnames")=List of 2
##   ..$ : NULL
##   ..$ : NULL
```

```r
prob <-
  log_prob %>% 
  # make it a data frame
  data.frame() %>% 
  # add case names, for convenience
  set_names(pull(d, species)) %>% 
  # add an s iteration index, for convenience
  mutate(s = 1:n()) %>% 
  # make it long
  pivot_longer(-s,
               names_to = "species",
               values_to = "logprob") %>% 
  # compute the probability scores
  mutate(prob = exp(logprob))

prob
```

```
## # A tibble: 28,000 × 4
##        s species     logprob  prob
##    <int> <chr>         <dbl> <dbl>
##  1     1 afarensis    0.769  2.16 
##  2     1 africanus    0.837  2.31 
##  3     1 habilis      0.647  1.91 
##  4     1 boisei       0.690  1.99 
##  5     1 rudolfensis  0.140  1.15 
##  6     1 ergaster    -0.0126 0.987
##  7     1 sapiens     -0.497  0.608
##  8     2 afarensis    0.396  1.49 
##  9     2 africanus    0.479  1.61 
## 10     2 habilis      0.768  2.16 
## # … with 27,990 more rows
```

```r
# Now for each case, take the aerage of each of the probability scores, then take the log of that
prob <-
  prob %>% 
  group_by(species) %>% 
  summarise(log_probability_score = mean(prob) %>% log())

prob
```

```
## # A tibble: 7 × 2
##   species     log_probability_score
##   <chr>                       <dbl>
## 1 afarensis                   0.384
## 2 africanus                   0.411
## 3 boisei                      0.400
## 4 ergaster                    0.231
## 5 habilis                     0.336
## 6 rudolfensis                 0.274
## 7 sapiens                    -0.607
```

```r
# Then sum up the values
prob %>% 
  summarise(total_log_probability_score = sum(log_probability_score))
```

```
## # A tibble: 1 × 1
##   total_log_probability_score
##                         <dbl>
## 1                        1.43
```




<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L08/10.png" alt="Why does this all matter in a practical sense? We can measure overfitting. Look at the difference between in- and out-of-sample. Smaller is better. The more negative it is, the better it is. Two samples from the same generative process. Training and testing set. Fit our model to the training sample, and get the deviance of train. Then we force it to predict the out-of-sample. The difference between them are our measure of overfitting." width="60%" />
<p class="caption">Why does this all matter in a practical sense? We can measure overfitting. Look at the difference between in- and out-of-sample. Smaller is better. The more negative it is, the better it is. Two samples from the same generative process. Training and testing set. Fit our model to the training sample, and get the deviance of train. Then we force it to predict the out-of-sample. The difference between them are our measure of overfitting.</p>
</div>



<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L08/11.png" alt="We'll generate some samples based on a known &quot;truth&quot;. The first is our intercept model. " width="60%" />
<p class="caption">We'll generate some samples based on a known "truth". The first is our intercept model. </p>
</div>

***7.2.5. Scoring the right data***

Create custome function:


```r
my_lppd <- function(brms_fit) {
  
  log_lik(brms_fit) %>% 
    data.frame() %>% 
    pivot_longer(everything(),
                 values_to = "logprob") %>% 
    mutate(prob = exp(logprob)) %>% 
    group_by(name) %>% 
    summarise(log_probability_score = mean(prob) %>% log()) %>% 
    summarise(total_log_probability_score = sum(log_probability_score))
  
}
```

Let’s compute the log-score for each of the models from earlier in this chapter:


```r
tibble(name = stringr::str_c("b7.", 1:6)) %>% 
  mutate(brms_fit = purrr::map(name, get)) %>% 
  mutate(lppd = purrr::map(brms_fit, ~my_lppd(.))) %>% 
  unnest(lppd)
```

```
## # A tibble: 6 × 3
##   name  brms_fit  total_log_probability_score
##   <chr> <list>                          <dbl>
## 1 b7.1  <brmsfit>                       1.43 
## 2 b7.2  <brmsfit>                       0.686
## 3 b7.3  <brmsfit>                       0.168
## 4 b7.4  <brmsfit>                       0.912
## 5 b7.5  <brmsfit>                       0.102
## 6 b7.6  <brmsfit>                      25.9
```

The more complex models have larger scores, but it is really the score on new data that interests us.



<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L08/12.png" alt="This is what happens in-sample. Lower deviance is better. The point is the average across all simulations, with one standard deviation on either side. Note the more complicated models do better. They're always going to fit in-sample better. Note there's a big jump at 3, then very little after 3. " width="60%" />
<p class="caption">This is what happens in-sample. Lower deviance is better. The point is the average across all simulations, with one standard deviation on either side. Note the more complicated models do better. They're always going to fit in-sample better. Note there's a big jump at 3, then very little after 3. </p>
</div>



<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L08/13.png" alt="Here's out-of-sample. Unsurprisingly, everything does worse out-of-sample. There's a pattern to the amount of overfitting. You can see that model 3 is best on average. Models 4 and 5 get progressively worse, because they're fitting noise. " width="60%" />
<p class="caption">Here's out-of-sample. Unsurprisingly, everything does worse out-of-sample. There's a pattern to the amount of overfitting. You can see that model 3 is best on average. Models 4 and 5 get progressively worse, because they're fitting noise. </p>
</div>



<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L08/14.png" alt="In anthropology we're happy with 20. But with N = 100, you can more precisely estimate when a data point doesn't matter. So 4 and 5 are only slightly worse. Because you can get a really good posterior distribution. But they pattern is the same. There's a very special pattern in the distances between these points. On the left, you can see the distances are growing, and approximately twice the number of parameters in each case. Hold that in your mind." width="60%" />
<p class="caption">In anthropology we're happy with 20. But with N = 100, you can more precisely estimate when a data point doesn't matter. So 4 and 5 are only slightly worse. Because you can get a really good posterior distribution. But they pattern is the same. There's a very special pattern in the distances between these points. On the left, you can see the distances are growing, and approximately twice the number of parameters in each case. Hold that in your mind.</p>
</div>


```r
# I've reduced this number by one order of magnitude to reduce computation time
n_sim   <- 1e3
n_cores <- 8
kseq    <- 1:5

# define the simulation function
my_sim <- function(k) {
  
  print(k);
  r <- mcreplicate(n_sim, sim_train_test(N = n, k = k), mc.cores = n_cores);
  c(mean(r[1, ]), mean(r[2, ]), sd(r[1, ]), sd(r[2, ]))
  
}

# here's our dev object based on `N <- 20`
n      <- 20
dev_20 <-
  sapply(kseq, my_sim)

# here's our dev object based on N <- 100
n       <- 100
dev_100 <- 
  sapply(kseq, my_sim)

# bind together in a tibble to plot
dev_tibble <-
  rbind(dev_20, dev_100) %>% 
  data.frame() %>% 
  mutate(statistic = rep(c("mean", "sd"), each = 2) %>% rep(., times = 2),
         sample    = rep(c("in", "out"), times = 2) %>% rep(., times = 2),
         n         = rep(c("n = 20", "n = 100"), each = 4)) %>% 
  pivot_longer(-(statistic:n)) %>% 
  pivot_wider(names_from = statistic, values_from = value) %>%
  mutate(n     = factor(n, levels = c("n = 20", "n = 100")),
         n_par = str_extract(name, "\\d+") %>% as.double()) %>% 
  mutate(n_par = ifelse(sample == "in", n_par - .075, n_par + .075))
```






```r
head(dev_tibble)
```

```
## # A tibble: 6 × 6
##   sample n      name   mean    sd n_par
##   <chr>  <fct>  <chr> <dbl> <dbl> <dbl>
## 1 in     n = 20 X1     55.9  6.02 0.925
## 2 in     n = 20 X2     54.9  5.46 1.92 
## 3 in     n = 20 X3     51.8  4.30 2.92 
## 4 in     n = 20 X4     51.6  3.96 3.92 
## 5 in     n = 20 X5     51.3  3.75 4.92 
## 6 out    n = 20 X1     57.7  6.59 1.08
```



```r
# for the annotation
text <-
  dev_tibble %>% 
  filter(n_par > 1.5, 
         n_par < 2.5) %>% 
  mutate(n_par = ifelse(sample == "in", n_par - 0.2, n_par + 0.29))
  
# plot!
dev_tibble %>% 
  ggplot(aes(x = n_par, y = mean,
             ymin = mean - sd, ymax = mean + sd,
             group = sample, color = sample, fill  = sample)) +
  geom_pointrange(shape = 21) +
  geom_text(data = text,
            aes(label = sample)) +
  scale_fill_manual(values  = carto_pal(7, "BurgYl")[c(5, 7)]) +
  scale_color_manual(values = carto_pal(7, "BurgYl")[c(7, 5)]) +
  labs(title = "Figure 7.6. Deviance in and out of sample.",
       x = "number of parameters",
       y = "deviance") +
  theme(legend.position = "none",
        strip.background = element_rect(fill = alpha(carto_pal(7, "BurgYl")[1], 1/4), color = "transparent")) +
  facet_wrap(~ n, scale = "free_y")
```

<div class="figure">
<img src="07_ulysses_compass_files/figure-html/7.18-1.png" alt="Figure 7.6" width="672" />
<p class="caption">Figure 7.6</p>
</div>

## Golem taming: regularization

>The root of overfitting is a model’s tendency to get overexcited by the training sample. When the priors are flat or nearly flat, the machine interprets this to mean that every parameter value is equally plausible. 
One way to prevent a model from getting too excited by the training sample is to use a skeptical prior. By "skeptical," I mean a prior that slows the rate of learning from the sample.

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L08/15.png" alt="The first thing to do is regularize. We don't want to use flat priors. We have to be skeptical. We have to build scepticism into the models. Choose priors that only give us possible outcomes. That helps to regularise - to reduce overfitting. " width="60%" />
<p class="caption">The first thing to do is regularize. We don't want to use flat priors. We have to be skeptical. We have to build scepticism into the models. Choose priors that only give us possible outcomes. That helps to regularise - to reduce overfitting. </p>
</div>



<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L08/16.png" alt="The model on the left is the linear regression model. We're going to use different standard deviations to deduce different amounts of skeptisism to large effects. SD of 0.2 is the very peaked one. Which of these will be best?" width="60%" />
<p class="caption">The model on the left is the linear regression model. We're going to use different standard deviations to deduce different amounts of skeptisism to large effects. SD of 0.2 is the very peaked one. Which of these will be best?</p>
</div>



<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L08/17.png" alt="On average, how did they do in-sample? The more sceptical prior does worse." width="60%" />
<p class="caption">On average, how did they do in-sample? The more sceptical prior does worse.</p>
</div>

<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L08/18.png" width="60%" />

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L08/19.png" alt="But out of sample, it's the opposite. Why? Because it learns less from the sample. It's skeptical. Out of sample, it predicts best because it ignored irregular distractions. Now in any particular problem the pattern might be different. Too skeptical and you can overshoot. But some scepticism helps you make good predictions. That's why you should never use flat priors. Even slightly curved and you'll do better. The order is the same, but the differences are tiny. Because if you have enough data, the regularisation isnt' doing any heavy work for you. But for a small sample, regularization does a lot. With multi-level models, we have to revisit, because even in really big smaple sizes there are some parameters with not big datasets." width="60%" />
<p class="caption">But out of sample, it's the opposite. Why? Because it learns less from the sample. It's skeptical. Out of sample, it predicts best because it ignored irregular distractions. Now in any particular problem the pattern might be different. Too skeptical and you can overshoot. But some scepticism helps you make good predictions. That's why you should never use flat priors. Even slightly curved and you'll do better. The order is the same, but the differences are tiny. Because if you have enough data, the regularisation isnt' doing any heavy work for you. But for a small sample, regularization does a lot. With multi-level models, we have to revisit, because even in really big smaple sizes there are some parameters with not big datasets.</p>
</div>



<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L08/20.png" alt="In industry, there's a lot of regularisation, because they're scored on it. But they do care about predictive accuracy. Why do scientists care less? Maybe because we're not taught to. Functionally, it makes getting significant results harder. Maybe the biggest thing is that we're not judged on the accuracy of future predictions. We don't have a strong philosophy on how it's connected to inference." width="60%" />
<p class="caption">In industry, there's a lot of regularisation, because they're scored on it. But they do care about predictive accuracy. Why do scientists care less? Maybe because we're not taught to. Functionally, it makes getting significant results harder. Maybe the biggest thing is that we're not judged on the accuracy of future predictions. We don't have a strong philosophy on how it's connected to inference.</p>
</div>

## Predicting predictive accuracy

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L08/21.png" alt="If we regularize correctly, we'll do better out-of-sample. We can actually predict the amount of overfitting, even when you don't have the out-of-sample. This is all small-world stuff, so be sceptical, but it gives us a principled way of talking about a model in terms of its overfitting risk. " width="60%" />
<p class="caption">If we regularize correctly, we'll do better out-of-sample. We can actually predict the amount of overfitting, even when you don't have the out-of-sample. This is all small-world stuff, so be sceptical, but it gives us a principled way of talking about a model in terms of its overfitting risk. </p>
</div>

***7.4.1. Cross-validation***

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L08/22.png" alt="If you do this across lots of left-out bits from your sample, that turns out to be a really good approximation of your model. These prediction contests in industry. Motivated this on Monday talking about under- vs over-fitted model. There's a LOOCV function for `quap`. Huge literature about how many to leave out. But the general idea is to use this. " width="60%" />
<p class="caption">If you do this across lots of left-out bits from your sample, that turns out to be a really good approximation of your model. These prediction contests in industry. Motivated this on Monday talking about under- vs over-fitted model. There's a LOOCV function for `quap`. Huge literature about how many to leave out. But the general idea is to use this. </p>
</div>

The key trouble with leave-one-out cross-validation is that, if we have 1000 observations, that means computing 1000 posterior distributions. That can be time consuming. Luckily, there are clever ways to approximate the cross-validation score without actually running the model over and over again. One approach is to use the “importance” of each observation to the posterior distribution. What “importance” means here is that some observations have a larger impact on the posterior distribution—if we remove an important observation, the posterior changes more. Other observations have less impact. It is a benign aspect of the universe that this importance can be estimated without refitting the model. *The key intuition is that an observation that is relatively unlikely is more important than one that is relatively expected.*

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L08/23.png" alt="These days you have too many data points. Really good analytical approximations, like Pareto-smoothed. Incredibly accurate. Pareto-smoothed is useful because you get a lot of diagnostic information." width="60%" />
<p class="caption">These days you have too many data points. Really good analytical approximations, like Pareto-smoothed. Incredibly accurate. Pareto-smoothed is useful because you get a lot of diagnostic information.</p>
</div>

***7.4.2. Information criteria***

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L08/24.png" alt="Other approach, stemming from Akaike. To get an analytical approximation, a lot of assumptions are made, including that you need a Gaussian distribution. If that's true, you can get a really nice approxiatmion of the performance of the log score out-of-sample. Just the training deviance time twice th enumber of parameters. Incredible acheivement." width="60%" />
<p class="caption">Other approach, stemming from Akaike. To get an analytical approximation, a lot of assumptions are made, including that you need a Gaussian distribution. If that's true, you can get a really nice approxiatmion of the performance of the log score out-of-sample. Just the training deviance time twice th enumber of parameters. Incredible acheivement.</p>
</div>



<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L08/25.png" alt="It has since been eclipsed. Another theoretical statistician has developed this new, more capable version. This thing looks complicated, but lppd is the Bayesian distance, and the penalty term on the right is the point-wise variance of the log probability of each observation. That's the generalised parameter count you want. This works for anything. Turns out in general the parameter count isn't what matters, rather the variance in the posterior distribution. And for models with flat priors and Gaussian distributions, it gives you the same value as AIC. But in general we won't use flat priors, and it often has interesting information." width="60%" />
<p class="caption">It has since been eclipsed. Another theoretical statistician has developed this new, more capable version. This thing looks complicated, but lppd is the Bayesian distance, and the penalty term on the right is the point-wise variance of the log probability of each observation. That's the generalised parameter count you want. This works for anything. Turns out in general the parameter count isn't what matters, rather the variance in the posterior distribution. And for models with flat priors and Gaussian distributions, it gives you the same value as AIC. But in general we won't use flat priors, and it often has interesting information.</p>
</div>

To see how WAIC works:

Consider a simple regression fit with `quap`: 


```r
data(cars)

b7.m <- 
  brm(data = cars, 
      family = gaussian,
      dist ~ 1 + speed,
      prior = c(prior(normal(0, 100), class = Intercept),
                prior(normal(0, 10), class = b),
                prior(exponential(1), class = sigma)),
      iter = 2000, warmup = 1000, chains = 4, cores = 4,
      seed = 7,
      file = "fits/b07.0m")
```


```r
print(b7.m)
```

```
##  Family: gaussian 
##   Links: mu = identity; sigma = identity 
## Formula: dist ~ 1 + speed 
##    Data: cars (Number of observations: 50) 
## Samples: 4 chains, each with iter = 2000; warmup = 1000; thin = 1;
##          total post-warmup samples = 4000
## 
## Population-Level Effects: 
##           Estimate Est.Error l-95% CI u-95% CI Rhat Bulk_ESS Tail_ESS
## Intercept   -17.54      6.14   -29.45    -5.13 1.00     3878     2503
## speed         3.93      0.38     3.16     4.67 1.00     3872     2895
## 
## Family Specific Parameters: 
##       Estimate Est.Error l-95% CI u-95% CI Rhat Bulk_ESS Tail_ESS
## sigma    13.82      1.22    11.66    16.40 1.00     3662     2650
## 
## Samples were drawn using sampling(NUTS). For each parameter, Bulk_ESS
## and Tail_ESS are effective sample size measures, and Rhat is the potential
## scale reduction factor on split chains (at convergence, Rhat = 1).
```


Get the log-likelihood of each observation $i$ at each sample $s$ from the posterior:


```r
n_cases <- nrow(cars)

ll <-
  brms::log_lik(b7.m) %>%
  data.frame() %>%
  set_names(c(str_c(0, 1:9), 10:n_cases))

dim(ll)
```

```
## [1] 4000   50
```

You end up with a 50-by-4000 matrix of log-likelihoods, with observations in rows and samples in columns. Now to compute lppd, the Bayesian deviance, we average the samples in each row, take the log, and add all of the logs together. However, to do this with precision, we need to do all of the averaging on the log scale. This is made easy with a function `log_sum_exp`, which computes the log of a sum of exponentiated terms. Then we can just subtract the log of the number of samples. This computes the log of the average.


```r
log_mu_l <-
  ll %>% 
  pivot_longer(everything(),
               names_to = "i",
               values_to = "loglikelihood") %>% 
  mutate(likelihood = exp(loglikelihood)) %>% 
  group_by(i) %>% 
  summarise(log_mean_likelihood = mean(likelihood) %>% log())

(
  lppd <-
  log_mu_l %>% 
  summarise(lppd = sum(log_mean_likelihood)) %>% 
  pull(lppd) 
)
```

```
## [1] -206.6265
```


```r
v_i <-
  ll %>% 
  pivot_longer(everything(),
               names_to = "i",
               values_to = "loglikelihood") %>% 
  group_by(i) %>% 
  summarise(var_loglikelihood = var(loglikelihood))

pwaic <-
  v_i %>%
  summarise(pwaic = sum(var_loglikelihood)) %>% 
  pull()

pwaic
```

```
## [1] 4.111924
```

To compute WAIC:


```r
-2 * (lppd - pwaic)
```

```
## [1] 421.4769
```


```r
brms::waic(b7.m)
```

```
## Warning: 
## 2 (4.0%) p_waic estimates greater than 0.4. We recommend trying loo instead.
```

```
## 
## Computed from 4000 by 50 log-likelihood matrix
## 
##           Estimate   SE
## elpd_waic   -210.7  8.2
## p_waic         4.1  1.6
## waic         421.5 16.4
## 
## 2 (4.0%) p_waic estimates greater than 0.4. We recommend trying loo instead.
```

Compute the WAIC standard error:


```r
tibble(lppd   = pull(log_mu_l, log_mean_likelihood),
       p_waic = pull(v_i, var_loglikelihood)) %>% 
  mutate(waic_vec = -2 * (lppd - p_waic)) %>% 
  summarise(waic_se = sqrt(n_cases * var(waic_vec)))
```

```
## # A tibble: 1 × 1
##   waic_se
##     <dbl>
## 1    16.4
```

If you want the pointwise values:


```r
brms::waic(b7.m)$pointwise %>% 
  head()
```

```
## Warning: 
## 2 (4.0%) p_waic estimates greater than 0.4. We recommend trying loo instead.
```

```
##      elpd_waic     p_waic     waic
## [1,] -3.649870 0.02182091 7.299741
## [2,] -4.023347 0.09214764 8.046694
## [3,] -3.684137 0.02150916 7.368275
## [4,] -3.995993 0.05840990 7.991986
## [5,] -3.588907 0.01056900 7.177814
## [6,] -3.741526 0.02125830 7.483051
```


***7.4.3. Comparing CV, PSIS, and WAIC***

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L08/26.png" alt="Now we'll score them on their error. All are trying to estimate the prediction error. So how close do they get? Top are flat priors. Open circles and the actual generalisation errors. Each trend line is a different metric for calculating it. WAIC is getting closer, but the differences are really small. LOOIC is a really good approximation. At the bottom we have regularising priors. Everything does better, but the differences are about the same. Unit difference on the vertical is tiny." width="60%" />
<p class="caption">Now we'll score them on their error. All are trying to estimate the prediction error. So how close do they get? Top are flat priors. Open circles and the actual generalisation errors. Each trend line is a different metric for calculating it. WAIC is getting closer, but the differences are really small. LOOIC is a really good approximation. At the bottom we have regularising priors. Everything does better, but the differences are about the same. Unit difference on the vertical is tiny.</p>
</div>



<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L08/27.png" alt="Target we're trying to get is the out-of-sample error. These differences are tiny. All of these things work amazingly well." width="60%" />
<p class="caption">Target we're trying to get is the out-of-sample error. These differences are tiny. All of these things work amazingly well.</p>
</div>



<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L08/28.png" alt="When samples are large, they all work identically." width="60%" />
<p class="caption">When samples are large, they all work identically.</p>
</div>


## Model comparison

Road so far:

* When there are several plausible (and hopefully un-confounded) models for the same set of observations, how should we compare the accuracy of these models?
* We need to somehow evaluate models out-of-sample. How can we do that? A meta-model of forecasting tells us two important things. First, flat priors produce bad predictions. Regularizing priors—priors which are skeptical of extreme parameter values—reduce fit to sample but tend to improve predictive accuracy. 
* Second, we can get a useful guess of predictive accuracy with the criteria CV, PSIS, and WAIC. Regularizing priors and CV/PSIS/WAIC are complementary. Regularization reduces overfitting, and predictive criteria measure it.

You should never just keep the model that scores the best, and discard the rest. This kind of selection procedure discards the information about relative model accuracy contained in the differences among the CV/PSIS/WAIC values. Why are the differences useful? Because sometimes the differences are large and sometimes they are small. Just as relative posterior probability provides advice about how confident we might be about parameters (conditional on the model), relative model accuracy provides advice about how confident we might be about models (conditional on the set of models compared).

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L08/29.png" alt="Avoid model selection. We want to score the expected overfitting models to understand their properties. In the sciences we usually have an inferential objective, rather than a predictive one. But if you intend to intervene in the world, then we don't want to use these criteria to select a model, but rather to compare them." width="60%" />
<p class="caption">Avoid model selection. We want to score the expected overfitting models to understand their properties. In the sciences we usually have an inferential objective, rather than a predictive one. But if you intend to intervene in the world, then we don't want to use these criteria to select a model, but rather to compare them.</p>
</div>

***7.5.1. Model mis-selection***

Remember: Inferring cause and making predictions are different tasks. Cross-validation and WAIC aim to find models that make good predictions.

Run models from previous chapter again:


```r
b6.6 <- readRDS("fits/b06.06.rds")
b6.7 <- readRDS("fits/b06.07.rds")
b6.8 <- readRDS("fits/b06.08.rds")
```



```r
brms::waic(b6.7)
```

```
## 
## Computed from 4000 by 100 log-likelihood matrix
## 
##           Estimate   SE
## elpd_waic   -180.7  6.7
## p_waic         3.5  0.5
## waic         361.5 13.4
```

As recommended, add the `waic` estimates to the `brm()` fit object itself.


```r
b6.7 <- brms::add_criterion(b6.7, criterion = "waic")
```


```r
b6.7$criteria$waic
```

```
## 
## Computed from 4000 by 100 log-likelihood matrix
## 
##           Estimate   SE
## elpd_waic   -180.7  6.7
## p_waic         3.5  0.5
## waic         361.5 13.4
```



<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L08/30.png" alt="Smaller numbers are better, so the top model is 6.7 that includes the fungus. Can probably see the difference here. The fungus is what's causal. Inference about cause and finding a predictive model aren't the same thing. So you need to do both, but keep in mind that they're different. Because you haven't necessarily inferred a cause if you have good prediction error, because you might have blocked a pipe. Even spurious correlations are useful. The confounding really matters when you want to intervene. The highest preditive model won't necessary predict what will happen when you intervene. " width="60%" />
<p class="caption">Smaller numbers are better, so the top model is 6.7 that includes the fungus. Can probably see the difference here. The fungus is what's causal. Inference about cause and finding a predictive model aren't the same thing. So you need to do both, but keep in mind that they're different. Because you haven't necessarily inferred a cause if you have good prediction error, because you might have blocked a pipe. Even spurious correlations are useful. The confounding really matters when you want to intervene. The highest preditive model won't necessary predict what will happen when you intervene. </p>
</div>


```r
# compute and save the WAIC information for the next three models
b6.6 <- brms::add_criterion(b6.6, criterion = "waic")
b6.8 <- brms::add_criterion(b6.8, criterion = "waic")

# compare the WAIC estimates
w <- brms::loo_compare(b6.6, b6.7, b6.8, criterion = "waic")

print(w)
```

```
##      elpd_diff se_diff
## b6.7   0.0       0.0  
## b6.8 -20.5       4.9  
## b6.6 -22.1       5.8
```

```r
print(w, simplify = F)
```

```
##      elpd_diff se_diff elpd_waic se_elpd_waic p_waic se_p_waic waic   se_waic
## b6.7    0.0       0.0  -180.7       6.7          3.5    0.5     361.5   13.4 
## b6.8  -20.5       4.9  -201.2       5.4          2.5    0.3     402.5   10.8 
## b6.6  -22.1       5.8  -202.9       5.7          1.5    0.2     405.7   11.3
```

<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L08/31.png" width="60%" />


```r
cbind(waic_diff = w[, 1] * -2,
      se        = w[, 2] * 2)
```

```
##      waic_diff        se
## b6.7   0.00000  0.000000
## b6.8  41.03941  9.832777
## b6.6  44.28358 11.564703
```

<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L08/32.png" width="60%" />


```r
w[, 7:8] %>% 
  data.frame() %>% 
  rownames_to_column("model_name") %>% 
  mutate(model_name = fct_reorder(model_name, waic, .desc = T)) %>% 
  
  ggplot(aes(x = waic, y = model_name, 
             xmin = waic - se_waic, 
             xmax = waic + se_waic)) +
  geom_pointrange(color = carto_pal(7, "BurgYl")[7], 
                  fill = carto_pal(7, "BurgYl")[5], shape = 21) +
  labs(title = "My custom WAIC plot",
       x = NULL, y = NULL) +
  theme(axis.ticks.y = element_blank())
```

<img src="07_ulysses_compass_files/figure-html/7.29-1.png" width="672" />


```r
n <- length(b6.7$criteria$waic$pointwise[, "waic"])

tibble(waic_b6.7 = b6.7$criteria$waic$pointwise[, "waic"],
       waic_b6.8 = b6.8$criteria$waic$pointwise[, "waic"]) %>% 
  mutate(diff = waic_b6.7 - waic_b6.8) %>% 
  summarise(diff_se = sqrt(n * var(diff)))
```

```
## # A tibble: 1 × 1
##   diff_se
##     <dbl>
## 1    9.83
```


```r
brms::loo_compare(b6.6, b6.7, b6.8, criterion = "waic") %>% 
  str()
```

```
##  'compare.loo' num [1:3, 1:8] 0 -20.52 -22.14 0 4.92 ...
##  - attr(*, "dimnames")=List of 2
##   ..$ : chr [1:3] "b6.7" "b6.8" "b6.6"
##   ..$ : chr [1:8] "elpd_diff" "se_diff" "elpd_waic" "se_elpd_waic" ...
```

```r
brms::loo_compare(b6.6, b6.8, criterion = "waic")
```

```
##      elpd_diff se_diff
## b6.8  0.0       0.0   
## b6.6 -1.6       2.4
```

```r
loo_compare(b6.6, b6.8, criterion = "waic")[2, 2] * 2
```

```
## [1] 4.743149
```

***7.5.2. Outliers and other illusions***

In the divorce example from Chapter 5, we saw in the posterior predictions that a few States were very hard for the model to retrodict. The State of Idaho in particular was something of an outlier. Individual points like Idaho tend to be very influential in ordinary regression models. Let’s see how PSIS and WAIC represent that importance.


```r
data(WaffleDivorce, package = "rethinking")

d <-
  WaffleDivorce %>% 
  mutate(d = rethinking::standardize(Divorce),
         m = rethinking::standardize(Marriage),
         a = rethinking::standardize(MedianAgeMarriage))

rm(WaffleDivorce)

# Refit the divorce models
b5.1 <- 
  brm(data = d, 
      family = gaussian,
      d ~ 1 + a,
      prior = c(prior(normal(0, 0.2), class = Intercept),
                prior(normal(0, 0.5), class = b),
                prior(exponential(1), class = sigma)),
      iter = 2000, warmup = 1000, chains = 4, cores = 4,
      seed = 5,
      sample_prior = T,
      file = "fits/b05.01")

b5.2 <- 
  brm(data = d, 
      family = gaussian,
      d ~ 1 + m,
      prior = c(prior(normal(0, 0.2), class = Intercept),
                prior(normal(0, 0.5), class = b),
                prior(exponential(1), class = sigma)),
      iter = 2000, warmup = 1000, chains = 4, cores = 4,
      seed = 5,
      file = "fits/b05.02")

b5.3 <- 
  brm(data = d, 
      family = gaussian,
      d ~ 1 + m + a,
      prior = c(prior(normal(0, 0.2), class = Intercept),
                prior(normal(0, 0.5), class = b),
                prior(exponential(1), class = sigma)),
      iter = 2000, warmup = 1000, chains = 4, cores = 4,
      seed = 5,
      file = "fits/b05.03")
```

Let's compare these models with PSIS


```r
b5.1 <- add_criterion(b5.1, criterion = "loo")
b5.2 <- add_criterion(b5.2, criterion = "loo")
b5.3 <- add_criterion(b5.3, criterion = "loo")

loo_compare(b5.1, b5.2, b5.3, criterion = "loo") %>% 
  print(simplify = F)
```

```
##      elpd_diff se_diff elpd_loo se_elpd_loo p_loo se_p_loo looic se_looic
## b5.1   0.0       0.0   -62.9      6.4         3.6   1.8    125.7  12.8   
## b5.3  -1.0       0.4   -63.8      6.4         4.8   1.9    127.7  12.9   
## b5.2  -6.8       4.6   -69.7      4.9         3.0   0.9    139.3   9.9
```

First note that the model that omits marriage rate, m5.1, lands on top. This is because marriage rate has very little association with the outcome. So the model that omits it has slightly better expected out-of-sample performance, even though it actually fits the sample slightly worse than m5.3, the model with both predictors. 

`Some Pareto k values are very high (>1).` means that the smoothing approximation that PSIS uses is unreliable for some points.

Let’s look at the individual States, to see which are causing the problem. We can do this by adding `pointwise=TRUE` to PSIS. When you do this, you get a matrix with each observation on a row and the PSIS information, including individual Pareto k values, in columns. 


```r
loo::loo(b5.3) %>% 
  loo::pareto_k_ids(threshold = 0.5)
```

```
## [1] 13
```


```r
d %>% 
  slice(13) %>% 
  dplyr::select(Location:Loc)
```

```
##   Location Loc
## 1    Idaho  ID
```

```r
b5.3 <- add_criterion(b5.3, "waic", file = "fits/b05.03")

tibble(pareto_k = b5.3$criteria$loo$diagnostics$pareto_k,
       p_waic   = b5.3$criteria$waic$pointwise[, "p_waic"],
       Loc      = pull(d, Loc)) %>% 
  
  ggplot(aes(x = pareto_k, y = p_waic, color = Loc == "ID")) +
  geom_vline(xintercept = .5, linetype = 2, color = "black", alpha = 1/2) +
  geom_point(aes(shape = Loc == "ID")) +
  geom_text(data = . %>% filter(p_waic > 0.5),
            aes(x = pareto_k - 0.03, label = Loc),
            hjust = 1) +
  scale_color_manual(values = carto_pal(7, "BurgYl")[c(5, 7)]) +
  scale_shape_manual(values = c(1, 19)) +
  labs(subtitle = "Gaussian model (b5.3)") +
  theme(legend.position = "none")
```

<img src="07_ulysses_compass_files/figure-html/unnamed-chunk-82-1.png" width="672" />


One way to both use these extreme observations and reduce their influence is to employ some kind of ROBUST REGRESSION. A “robust regression” can mean many different things, but usually it indicates a linear model in which the influence of extreme observations is reduced. A common and useful kind of robust regression is to replace the Gaussian model with a thicker-tailed distribution like STUDENT’S T (or “Student-t”) distribution.

Let’s re-estimate the divorce model using a Student-t distribution with $v = 2$.


```r
b5.3t <- 
  brm(data = d, 
      family = student,
      bf(d ~ 1 + m + a, nu = 2),
      prior = c(prior(normal(0, 0.2), class = Intercept),
                prior(normal(0, 0.5), class = b),
                prior(exponential(1), class = sigma)),
      iter = 2000, warmup = 1000, chains = 4, cores = 4,
      seed = 5,
      file = "fits/b05.03t")
```


```r
print(b5.3t)
```

```
##  Family: student 
##   Links: mu = identity; sigma = identity; nu = identity 
## Formula: d ~ 1 + m + a 
##          nu = 2
##    Data: d (Number of observations: 50) 
## Samples: 4 chains, each with iter = 2000; warmup = 1000; thin = 1;
##          total post-warmup samples = 4000
## 
## Population-Level Effects: 
##           Estimate Est.Error l-95% CI u-95% CI Rhat Bulk_ESS Tail_ESS
## Intercept     0.03      0.10    -0.17     0.23 1.00     4082     2803
## m             0.05      0.20    -0.34     0.47 1.00     3549     3105
## a            -0.70      0.14    -0.99    -0.42 1.00     3546     2945
## 
## Family Specific Parameters: 
##       Estimate Est.Error l-95% CI u-95% CI Rhat Bulk_ESS Tail_ESS
## sigma     0.58      0.08     0.43     0.76 1.00     3945     2833
## nu        2.00      0.00     2.00     2.00 1.00     4000     4000
## 
## Samples were drawn using sampling(NUTS). For each parameter, Bulk_ESS
## and Tail_ESS are effective sample size measures, and Rhat is the potential
## scale reduction factor on split chains (at convergence, Rhat = 1).
```


```r
b5.3t <- add_criterion(b5.3t, criterion = c("loo", "waic"))
```


<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L08/33.png" alt="Incredibly clever and diabolical. Interested in life history evolution. Something to understand by looking at the whole field. Here's a dataset to consider. Why does lifespan vary so much? A typcial kind of conceptual model is this idea that body mass = fewer things kill you = living longer. And brain size = smart = avoiding danger. Should also season your DAG with some unobserved confounds." width="60%" />
<p class="caption">Incredibly clever and diabolical. Interested in life history evolution. Something to understand by looking at the whole field. Here's a dataset to consider. Why does lifespan vary so much? A typcial kind of conceptual model is this idea that body mass = fewer things kill you = living longer. And brain size = smart = avoiding danger. Should also season your DAG with some unobserved confounds.</p>
</div>



<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L08/34.png" alt="After you remove all the missing values, you get three models. The first is the industry standard m7.8 everyone expects to be the right prediction model. WIf we wnat ot figure out the infleucne of brainsize on lifespan, we need to block the backdoor path on body mass. Black dots are the in-sample, and open are the WAIC scores. Bars are standard errors. 7.8 and 7.9 are basically equivalent in their out-of-sample predictions. When you see something like this, you should see this as an invitiation to poke inside them. You can use IC to do that poiking." width="60%" />
<p class="caption">After you remove all the missing values, you get three models. The first is the industry standard m7.8 everyone expects to be the right prediction model. WIf we wnat ot figure out the infleucne of brainsize on lifespan, we need to block the backdoor path on body mass. Black dots are the in-sample, and open are the WAIC scores. Bars are standard errors. 7.8 and 7.9 are basically equivalent in their out-of-sample predictions. When you see something like this, you should see this as an invitiation to poke inside them. You can use IC to do that poiking.</p>
</div>



<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L08/35.png" alt="bM is the slope for body mass, and bB is the slope for brain size. 7.9 only has bM, and says there's a positive correlation. The model with both has this catastrophic flipping. Now bM is negative? What's going on here? " width="60%" />
<p class="caption">bM is the slope for body mass, and bB is the slope for brain size. 7.9 only has bM, and says there's a positive correlation. The model with both has this catastrophic flipping. Now bM is negative? What's going on here? </p>
</div>



<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L08/36.png" alt="The thing to do here is to do WAIC point-wise. For each species in the sample, say the Capuchin monkey which has those life history characteristics, which model expects to do the best out-of-sample on organisms with those same covariates? Or you could think about it as entropy scores, or divergence scores, to say how surprised is this model by a Capuchin monkey? The relative surprise between these models is plotted. " width="60%" />
<p class="caption">The thing to do here is to do WAIC point-wise. For each species in the sample, say the Capuchin monkey which has those life history characteristics, which model expects to do the best out-of-sample on organisms with those same covariates? Or you could think about it as entropy scores, or divergence scores, to say how surprised is this model by a Capuchin monkey? The relative surprise between these models is plotted. </p>
</div>



<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L08/37.png" alt="The model with brain + mass does better with Capuchins because they have small brains, but they're really big for their body size. So if you don't control for body size, you can't explain their longevity. So the model without body size is really surprised by Cebus. Lepilemur on the other extreme with small brains and extremely short lifespans, where you'd be surprised if you ignore body size." width="60%" />
<p class="caption">The model with brain + mass does better with Capuchins because they have small brains, but they're really big for their body size. So if you don't control for body size, you can't explain their longevity. So the model without body size is really surprised by Cebus. Lepilemur on the other extreme with small brains and extremely short lifespans, where you'd be surprised if you ignore body size.</p>
</div>



<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L08/38.png" alt="On the other hand, for these you can make fine predictions by knowing body size. So you can understand how they perform if you look point-wise. This is a principled way to inspect and understand your golem. Also a way to find your high-leverage points." width="60%" />
<p class="caption">On the other hand, for these you can make fine predictions by knowing body size. So you can understand how they perform if you look point-wise. This is a principled way to inspect and understand your golem. Also a way to find your high-leverage points.</p>
</div>

<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L08/39.png" width="80%" />

<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L08/40.png" width="80%" />

<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L08/41.png" width="80%" />

<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L08/42.png" width="80%" />

## Practice


