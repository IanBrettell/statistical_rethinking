# Big Entropy and the Generalized Linear Model


```r
library(here)
source(here::here("code/scripts/source.R"))
```


```r
slides_dir = here::here("docs/slides/L11")
```


<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L11/01.png" alt="We'll move conceptually at a slow rate, which will set up a bunch of different models for this week and next." width="80%" />
<p class="caption">We'll move conceptually at a slow rate, which will set up a bunch of different models for this week and next.</p>
</div>

There are vastly more ways for cords to end up in a knot than for them to remain untied. Events that can happen vastly more ways are more likely.

Statistical models force many choices upon us. Some of these choices are distributions that represent uncertainty. We must choose, for each parameter, a prior distribution. And we must choose a likelihood function, which serves as a distribution of data. There are conventional choices, such as wide Gaussian priors and the Gaussian likelihood of linear regression. These conventional choices work unreasonably well in many circumstances. But very often the conventional choices are not the best choices. Inference can be more powerful when we use all of the information, and doing so usually requires going beyond convention.

Bet on the distribution with the biggest entropy. Why? There are three sorts of justifications:

1. The distribution with the biggest entropy is the widest and least informative distribution. Choosing the distribution with the largest entropy means spreading probability as evenly as possible, while still remaining consistent with anything we think we know about a process.
1. Nature tends to produce empirical distributions that have high entropy.
1. Regardless of why it works, it tends to work.

A generalized linear model (GLM) is much like the linear regressions of previous chapters. It is a model that replaces a parameter of a likelihood function with a linear model. But GLMs need not use Gaussian likelihoods. Any likelihood function can be used, and linear models can be attached to any or all of the parameters that describe its shape. The principle of maximum entropy helps us choose likelihood functions, by providing a way to use stated assumptions about constraints on the outcome variable to choose the likelihood function that is the most conservative distribution compatible with the known constraints.

## Maximum entropy

Maximum entropy principle:

>The distribution that can happen the most ways is also the distribution with the biggest information entropy. The distribution with the biggest entropy is the most conservative distribution that obeys its constraints.

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L11/02.png" alt="Imagine you have buckets equidistant from you. At your feet you have 100 pebbles, each painted with a number. Unique pebbles. " width="80%" />
<p class="caption">Imagine you have buckets equidistant from you. At your feet you have 100 pebbles, each painted with a number. Unique pebbles. </p>
</div>

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L11/03.png" alt="What happens when we toss pebbles one at a time into the buckets at random. Eventually all 100 pebbles end up in the buckets, and you count them, and you get a distribution of pebbles. What types of distributions are really common, and what types are really rare?" width="80%" />
<p class="caption">What happens when we toss pebbles one at a time into the buckets at random. Eventually all 100 pebbles end up in the buckets, and you count them, and you get a distribution of pebbles. What types of distributions are really common, and what types are really rare?</p>
</div>

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L11/04.png" alt="Think about extreme distributions first. There's only 1 way to get all 100 pebbles in bucket 1. " width="80%" />
<p class="caption">Think about extreme distributions first. There's only 1 way to get all 100 pebbles in bucket 1. </p>
</div>

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L11/05.png" alt="Same with bucket 5. So there are 5 unique distributions with all pebbles in a single bucket." width="80%" />
<p class="caption">Same with bucket 5. So there are 5 unique distributions with all pebbles in a single bucket.</p>
</div>

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L11/06.png" alt="There are a bunch of distributions that will happen in a bunch of different ways. We could take a pebble from bucket 2 and swap it with one from bucket 3. How many ways could you get the same distribution. This very problem is the basis of Bayesian inference. Some distributions can arise in many more ways. It's a principle called Maximum Entropy, and it justifies Bayesian inference." width="80%" />
<p class="caption">There are a bunch of distributions that will happen in a bunch of different ways. We could take a pebble from bucket 2 and swap it with one from bucket 3. How many ways could you get the same distribution. This very problem is the basis of Bayesian inference. Some distributions can arise in many more ways. It's a principle called Maximum Entropy, and it justifies Bayesian inference.</p>
</div>

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L11/07.png" alt="We can replace the integers with $n$s. In some point, you learned that there's a formula for the number of arrangements of the pebbles." width="80%" />
<p class="caption">We can replace the integers with $n$s. In some point, you learned that there's a formula for the number of arrangements of the pebbles.</p>
</div>

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L11/08.png" alt="This is called the multiplicity. It's the foundation of statistical inference. It gets big really fast when the Ns get equal. " width="80%" />
<p class="caption">This is called the multiplicity. It's the foundation of statistical inference. It gets big really fast when the Ns get equal. </p>
</div>

Let’s put each distribution of pebbles in a list:


```r
d <-
  tibble(a = c(0, 0, 10, 0, 0),
         b = c(0, 1, 8, 1, 0),
         c = c(0, 2, 6, 2, 0),
         d = c(1, 2, 4, 2, 1),
         e = 2) 
```

And let’s normalize each such that it is a probability distribution. 


```r
# this is our analogue to McElreath's `lapply()` code
d %>% 
  mutate_all(~ . / sum(.)) %>% 
  # the next few lines constitute our analogue to his `sapply()` code
  pivot_longer(everything(), names_to = "plot") %>% 
  group_by(plot) %>% 
  summarise(h = -sum(ifelse(value == 0, 0, value * log(value))))
```

```
## # A tibble: 5 × 2
##   plot      h
##   <chr> <dbl>
## 1 a     0    
## 2 b     0.639
## 3 c     0.950
## 4 d     1.47 
## 5 e     1.61
```

Since these are now probability distributions, we can compute the information entropy of each as above. 

So distribution E, which can realized by far the greatest number of ways, also has the biggest entropy.


```r
library(ghibli)
ghibli_palette("MarnieMedium1")[1:7]
```

```
## [1] "#28231DFF" "#5E2D30FF" "#008E90FF" "#1C77A3FF" "#C5A387FF" "#67B8D6FF"
## [7] "#E9D097FF"
```



<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L11/09.png" alt="Only one way to get all the pebbles in bucket 3. " width="80%" />
<p class="caption">Only one way to get all the pebbles in bucket 3. </p>
</div>

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L11/10.png" alt="How many ways to get the second distribution?" width="80%" />
<p class="caption">How many ways to get the second distribution?</p>
</div>

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L11/11.png" alt="It's massively bigger. This will accelerate. People have really bad intuitions regarding combinatorics." width="80%" />
<p class="caption">It's massively bigger. This will accelerate. People have really bad intuitions regarding combinatorics.</p>
</div>

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L11/12.png" alt="Now we've got two in bucket 2. Now we're getting an order of magnitude increase." width="80%" />
<p class="caption">Now we've got two in bucket 2. Now we're getting an order of magnitude increase.</p>
</div>

<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L11/13.png" width="80%" />

<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L11/14.png" width="80%" />

<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L11/15.png" width="80%" />

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L11/16.png" alt="General principle: Distributions that are flat can happen in many many more ways. And this is why we bet on them. They have high entropy. Flat distributions are closer, less surprised when the distribution turns out to be different. Then become really good foundations for statistical inference, because they distribute the possibilities as widely as possible." width="80%" />
<p class="caption">General principle: Distributions that are flat can happen in many many more ways. And this is why we bet on them. They have high entropy. Flat distributions are closer, less surprised when the distribution turns out to be different. Then become really good foundations for statistical inference, because they distribute the possibilities as widely as possible.</p>
</div>

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L11/17.png" alt="This is a unique way to derive the formula. It's nothing more than the multiplicity. W is the multiplicity (number of ways to get the N). Then we've normalised it across the number of the pebbles. And that turns out to be a good approximation. Information entropy is just the logarithm of the number of ways to realise a distribution. And it's maximised when the distribution is flat. And flatter distributions have higher entropy." width="80%" />
<p class="caption">This is a unique way to derive the formula. It's nothing more than the multiplicity. W is the multiplicity (number of ways to get the N). Then we've normalised it across the number of the pebbles. And that turns out to be a good approximation. Information entropy is just the logarithm of the number of ways to realise a distribution. And it's maximised when the distribution is flat. And flatter distributions have higher entropy.</p>
</div>

<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L11/18.png" width="80%" />

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L11/19.png" alt="Most centrally associated with Jaynes. If you choose any other distribution to characterise your state of knowledge, you will be implicitly adding other information into your distribution. So if you lay out all the constraints, then solve for the distribution that's as flat as possible under those constraints, you do the best you possibly can. You're honestly characterising your ignorance." width="80%" />
<p class="caption">Most centrally associated with Jaynes. If you choose any other distribution to characterise your state of knowledge, you will be implicitly adding other information into your distribution. So if you lay out all the constraints, then solve for the distribution that's as flat as possible under those constraints, you do the best you possibly can. You're honestly characterising your ignorance.</p>
</div>

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L11/20.png" alt="Lots of conceptual examples for. What is the information content of a prior distribution? It turns out that Bayesian updating is a special case of this principle. You can input the data as constraints, and you get the posterior distribution by solving the maximum entropy problem. High entropy is good because the distance from the truth is smaller. One way to thing about it is it's deflationary. No matter what happens, and even distrubtion is bound to arise. We put in a tiny sliver of scientific information in our model, and the rest we just bet on entropy." width="80%" />
<p class="caption">Lots of conceptual examples for. What is the information content of a prior distribution? It turns out that Bayesian updating is a special case of this principle. You can input the data as constraints, and you get the posterior distribution by solving the maximum entropy problem. High entropy is good because the distance from the truth is smaller. One way to thing about it is it's deflationary. No matter what happens, and even distrubtion is bound to arise. We put in a tiny sliver of scientific information in our model, and the rest we just bet on entropy.</p>
</div>

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L11/21.png" alt="Motivates forward to other distributions. If we're going to maximise this function, if all the $p$s are equal, they're highest. Sometimes there are constrants that prevent us from making the $p$s equal. What kind of constraints? Known mean or variance." width="80%" />
<p class="caption">Motivates forward to other distributions. If we're going to maximise this function, if all the $p$s are equal, they're highest. Sometimes there are constrants that prevent us from making the $p$s equal. What kind of constraints? Known mean or variance.</p>
</div>

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L11/22.png" alt="This is actually what we did in Week 1. Shows that it's just counting. " width="80%" />
<p class="caption">This is actually what we did in Week 1. Shows that it's just counting. </p>
</div>

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L11/23.png" alt="Under some set of constraints, the distributions we use are maximum entropy distributions. Exponential distributions used for scale. They have a very clear maxent constraint. If a parameter is non-negative real, and has some mean value, then the exponential contains only that information." width="80%" />
<p class="caption">Under some set of constraints, the distributions we use are maximum entropy distributions. Exponential distributions used for scale. They have a very clear maxent constraint. If a parameter is non-negative real, and has some mean value, then the exponential contains only that information.</p>
</div>

***10.1.1. Gaussian***

To appreciate why the Gaussian shape has the biggest entropy for any continuous distribution with this variance, consider that entropy increases as we make a distribution flatter. So we could easily make up a probability distribution with larger entropy than the blue distribution in Figure 10.2: Just take probability from the center and put it in the tails. The more uniform the distribution looks, the higher its entropy will be. But there are limits on how much of this we can do and maintain the same variance, $\sigma^2 = 1$.

*Then the Gaussian distribution gets its shape by being as spread out as possible for a distribution with fixed variance.*

***10.1.2. Binomial***


```r
# data
d <-
  tibble(distribution = letters[1:4],
         ww = c(1/4, 2/6, 1/6, 1/8),
         bw = c(1/4, 1/6, 2/6, 4/8),
         wb = c(1/4, 1/6, 2/6, 2/8),
         bb = c(1/4, 2/6, 1/6, 1/8))

# table
d %>% 
  mutate_if(is.numeric, ~MASS::fractions(.) %>% as.character()) %>% 
  flextable::flextable()
```

```{=html}
<template id="9b0bf497-d963-4772-bea4-3f000e078a75"><style>
.tabwid table{
  border-collapse:collapse;
  line-height:1;
  margin-left:auto;
  margin-right:auto;
  border-width: 0;
  display: table;
  margin-top: 1.275em;
  margin-bottom: 1.275em;
  border-spacing: 0;
  border-color: transparent;
}
.tabwid_left table{
  margin-left:0;
}
.tabwid_right table{
  margin-right:0;
}
.tabwid td {
    padding: 0;
}
.tabwid a {
  text-decoration: none;
}
.tabwid thead {
    background-color: transparent;
}
.tabwid tfoot {
    background-color: transparent;
}
.tabwid table tr {
background-color: transparent;
}
</style><div class="tabwid"><style>.cl-4eda109e{border-collapse:collapse;}.cl-4ed2a746{font-family:'DejaVu Sans';font-size:11pt;font-weight:normal;font-style:normal;text-decoration:none;color:rgba(0, 0, 0, 1.00);background-color:transparent;}.cl-4ed2ce60{margin:0;text-align:left;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-4ed3146a{width:54pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-4ed31492{width:54pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-4ed3149c{width:54pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 2pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}</style><table class='cl-4eda109e'><thead><tr style="overflow-wrap:break-word;"><td class="cl-4ed3149c"><p class="cl-4ed2ce60"><span class="cl-4ed2a746">distribution</span></p></td><td class="cl-4ed3149c"><p class="cl-4ed2ce60"><span class="cl-4ed2a746">ww</span></p></td><td class="cl-4ed3149c"><p class="cl-4ed2ce60"><span class="cl-4ed2a746">bw</span></p></td><td class="cl-4ed3149c"><p class="cl-4ed2ce60"><span class="cl-4ed2a746">wb</span></p></td><td class="cl-4ed3149c"><p class="cl-4ed2ce60"><span class="cl-4ed2a746">bb</span></p></td></tr></thead><tbody><tr style="overflow-wrap:break-word;"><td class="cl-4ed3146a"><p class="cl-4ed2ce60"><span class="cl-4ed2a746">a</span></p></td><td class="cl-4ed3146a"><p class="cl-4ed2ce60"><span class="cl-4ed2a746">1/4</span></p></td><td class="cl-4ed3146a"><p class="cl-4ed2ce60"><span class="cl-4ed2a746">1/4</span></p></td><td class="cl-4ed3146a"><p class="cl-4ed2ce60"><span class="cl-4ed2a746">1/4</span></p></td><td class="cl-4ed3146a"><p class="cl-4ed2ce60"><span class="cl-4ed2a746">1/4</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-4ed3146a"><p class="cl-4ed2ce60"><span class="cl-4ed2a746">b</span></p></td><td class="cl-4ed3146a"><p class="cl-4ed2ce60"><span class="cl-4ed2a746">1/3</span></p></td><td class="cl-4ed3146a"><p class="cl-4ed2ce60"><span class="cl-4ed2a746">1/6</span></p></td><td class="cl-4ed3146a"><p class="cl-4ed2ce60"><span class="cl-4ed2a746">1/6</span></p></td><td class="cl-4ed3146a"><p class="cl-4ed2ce60"><span class="cl-4ed2a746">1/3</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-4ed3146a"><p class="cl-4ed2ce60"><span class="cl-4ed2a746">c</span></p></td><td class="cl-4ed3146a"><p class="cl-4ed2ce60"><span class="cl-4ed2a746">1/6</span></p></td><td class="cl-4ed3146a"><p class="cl-4ed2ce60"><span class="cl-4ed2a746">1/3</span></p></td><td class="cl-4ed3146a"><p class="cl-4ed2ce60"><span class="cl-4ed2a746">1/3</span></p></td><td class="cl-4ed3146a"><p class="cl-4ed2ce60"><span class="cl-4ed2a746">1/6</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-4ed31492"><p class="cl-4ed2ce60"><span class="cl-4ed2a746">d</span></p></td><td class="cl-4ed31492"><p class="cl-4ed2ce60"><span class="cl-4ed2a746">1/8</span></p></td><td class="cl-4ed31492"><p class="cl-4ed2ce60"><span class="cl-4ed2a746">1/2</span></p></td><td class="cl-4ed31492"><p class="cl-4ed2ce60"><span class="cl-4ed2a746">1/4</span></p></td><td class="cl-4ed31492"><p class="cl-4ed2ce60"><span class="cl-4ed2a746">1/8</span></p></td></tr></tbody></table></div></template>
<div class="flextable-shadow-host" id="0f38f866-276e-44e5-b588-e5142c6d363b"></div>
<script>
var dest = document.getElementById("0f38f866-276e-44e5-b588-e5142c6d363b");
var template = document.getElementById("9b0bf497-d963-4772-bea4-3f000e078a75");
var caption = template.content.querySelector("caption");
if(caption) {
  caption.style.cssText = "display:block;text-align:center;";
  var newcapt = document.createElement("p");
  newcapt.appendChild(caption)
  dest.parentNode.insertBefore(newcapt, dest.previousSibling);
}
var fantome = dest.attachShadow({mode: 'open'});
var templateContent = template.content;
fantome.appendChild(templateContent);
</script>

```

Compute the entropy of each distribution:



```r
d <- 
  d %>% 
  pivot_longer(-distribution,
               names_to = "sequence", 
               values_to = "probability") %>% 
  mutate(sequence = factor(sequence, levels = c("ww", "bw", "wb", "bb")))

d  %>% 
  ggplot(aes(x = sequence, y = probability, group = 1)) +
  geom_point(size = 2, color = ghibli_palette("PonyoMedium")[4]) +
  geom_line(color = ghibli_palette("PonyoMedium")[5]) +
  labs(x = NULL, y = NULL) +
  coord_cartesian(ylim = 0:1) +
  theme(axis.ticks.x = element_blank(),
        panel.background = element_rect(fill = ghibli_palette("PonyoMedium")[2]),
        panel.grid = element_blank(),
        strip.background = element_rect(fill = ghibli_palette("PonyoMedium")[6])) +
  facet_wrap(~ distribution)
```

<div class="figure">
<img src="10_big_entropy_and_the_generalized_linear_model_files/figure-html/unnamed-chunk-27-1.png" alt="Figure 10.3" width="672" />
<p class="caption">Figure 10.3</p>
</div>


```r
d %>% 
  # `str_count()` will count the number of times "b" occurs within a given row of `sequence`
  mutate(n_b = str_count(sequence, "b")) %>% 
  mutate(product = probability * n_b) %>% 
  group_by(distribution) %>% 
  summarise(expected_value = sum(product))
```

```
## # A tibble: 4 × 2
##   distribution expected_value
##   <chr>                 <dbl>
## 1 a                         1
## 2 b                         1
## 3 c                         1
## 4 d                         1
```


```r
d %>% 
  group_by(distribution) %>% 
  summarise(entropy = -sum(probability * log(probability)))
```

```
## # A tibble: 4 × 2
##   distribution entropy
##   <chr>          <dbl>
## 1 a               1.39
## 2 b               1.33
## 3 c               1.33
## 4 d               1.21
```


The binomial with this expected value is:


```r
p <- 0.7

(
  a <- 
  c((1 - p)^2, 
    p * (1 - p), 
    (1 - p) * p, 
    p^2)
)
```

```
## [1] 0.09 0.21 0.21 0.49
```

This distribution is definitely not flat. So to appreciate how this distribution has maximum entropy—is the flattest distribution with expected value 1.4—we’ll simulate a bunch of distributions with the same expected value and then compare entropies. The entropy of the distribution above is just:


```r
-sum(a * log(a))
```

```
## [1] 1.221729
```

So if we randomly generate thousands of distributions with expected value 1.4, we expect that none will have a larger entropy than this.

We can use a short R function to simulate random probability distributions that have any specified expected value. The code below will do the job. Don’t worry about how it works (unless you want to).


```r
sim_p <- function(seed, g = 1.4) {
  
  set.seed(seed)
  
  x_123 <- runif(3)
  x_4   <- ((g) * sum(x_123) - x_123[2] - x_123[3]) / (2 - g)
  z     <- sum(c(x_123, x_4))
  p     <- c(x_123, x_4) / z
  
  tibble(h   = -sum(p * log(p)), 
         p   = p,
         key = factor(c("ww", "bw", "wb", "bb"), levels = c("ww", "bw", "wb", "bb")))
  
}
```


```r
sim_p(seed = 9.9, g = 1.4)
```

```
## # A tibble: 4 × 3
##       h      p key  
##   <dbl>  <dbl> <fct>
## 1  1.02 0.197  ww   
## 2  1.02 0.0216 bw   
## 3  1.02 0.184  wb   
## 4  1.02 0.597  bb
```


```r
# how many replications would you like?
n_rep <- 1e5

d <-
  tibble(seed = 1:n_rep) %>% 
  mutate(sim = map2(seed, 1.4, sim_p)) %>% 
  unnest(sim)

head(d)
```

```
## # A tibble: 6 × 4
##    seed     h      p key  
##   <int> <dbl>  <dbl> <fct>
## 1     1  1.21 0.108  ww   
## 2     1  1.21 0.151  bw   
## 3     1  1.21 0.233  wb   
## 4     1  1.21 0.508  bb   
## 5     2  1.21 0.0674 ww   
## 6     2  1.21 0.256  bw
```


Let’s split out the entropies and distributions, so that it’s easier to work with them.

Now we can ask what the largest observed entropy was:


```r
ranked_d <-
  d %>% 
  group_by(seed) %>% 
  arrange(desc(h)) %>% 
  ungroup() %>%
  # here's the rank order step
  mutate(rank = rep(1:n_rep, each = 4))

head(ranked_d)
```

```
## # A tibble: 6 × 5
##    seed     h      p key    rank
##   <int> <dbl>  <dbl> <fct> <int>
## 1 55665  1.22 0.0903 ww        1
## 2 55665  1.22 0.209  bw        1
## 3 55665  1.22 0.210  wb        1
## 4 55665  1.22 0.490  bb        1
## 5 71132  1.22 0.0902 ww        2
## 6 71132  1.22 0.210  bw        2
```


```r
subset_d <-
  ranked_d %>%
  # I arrived at these `rank` values by trial and error
  filter(rank %in% c(1, 87373, n_rep - 1500, n_rep - 10)) %>% 
  # I arrived at the `height` values by trial and error, too
  mutate(height       = rep(c(8, 2.25, .75, .5), each = 4),
         distribution = rep(letters[1:4], each = 4))
head(subset_d)
```

```
## # A tibble: 6 × 7
##    seed     h      p key    rank height distribution
##   <int> <dbl>  <dbl> <fct> <int>  <dbl> <chr>       
## 1 55665  1.22 0.0903 ww        1   8    a           
## 2 55665  1.22 0.209  bw        1   8    a           
## 3 55665  1.22 0.210  wb        1   8    a           
## 4 55665  1.22 0.490  bb        1   8    a           
## 5 50981  1.00 0.0459 ww    87373   2.25 b           
## 6 50981  1.00 0.0459 bw    87373   2.25 b
```


```r
p1 <-
  d %>% 
  ggplot(aes(x = h)) +
  geom_density(size = 0, fill = ghibli_palette("LaputaMedium")[3],
               adjust = 1/4) +
  # note the data statements for the next two geoms
  geom_linerange(data = subset_d %>% group_by(seed) %>% slice(1),
                 aes(ymin = 0, ymax = height),
                 color = ghibli_palette("LaputaMedium")[5]) +
  geom_text(data = subset_d %>% group_by(seed) %>% slice(1),
            aes(y = height + .5, label = distribution)) +
  scale_x_continuous("Entropy", breaks = seq(from = .7, to = 1.2, by = .1)) +
  theme(panel.background = element_rect(fill = ghibli_palette("LaputaMedium")[7]),
        panel.grid = element_blank())
```


```r
p2 <-
  ranked_d %>%
  filter(rank %in% c(1, 87373, n_rep - 1500, n_rep - 10)) %>% 
  mutate(distribution = rep(letters[1:4], each = 4)) %>% 
  
  ggplot(aes(x = key, y = p, group = 1)) +
  geom_line(color = ghibli_palette("LaputaMedium")[5]) +
  geom_point(size = 2, color = ghibli_palette("LaputaMedium")[4]) +
  scale_y_continuous(NULL, breaks = NULL, limits = c(0, .75)) +
  xlab(NULL) +
  theme(axis.ticks.x = element_blank(),
        panel.background = element_rect(fill = ghibli_palette("LaputaMedium")[7]),
        panel.grid = element_blank(),
        strip.background = element_rect(fill = ghibli_palette("LaputaMedium")[6])) +
  facet_wrap(~ distribution)

# combine and plot
library(patchwork)
p1 | p2
```

<div class="figure">
<img src="10_big_entropy_and_the_generalized_linear_model_files/figure-html/unnamed-chunk-31-1.png" alt="Figure 10.4" width="672" />
<p class="caption">Figure 10.4</p>
</div>


```r
ranked_d %>% 
  group_by(key) %>% 
  arrange(desc(h)) %>% 
  slice(1)
```

```
## # A tibble: 4 × 5
## # Groups:   key [4]
##    seed     h      p key    rank
##   <int> <dbl>  <dbl> <fct> <int>
## 1 55665  1.22 0.0903 ww        1
## 2 55665  1.22 0.209  bw        1
## 3 55665  1.22 0.210  wb        1
## 4 55665  1.22 0.490  bb        1
```


And that’s almost exactly ${0.09, 0.21, 0.21, 0.49}$, the distribution we calculated earlier.
The other distributions in Figure 10.4—B, C, and D—are all less even than A.

There is no guarantee that the maximum entropy distribution is the best probability distribution for the real problem you are analyzing. But there is a guarantee that no other distribution more conservatively reflects your assumptions.

That’s not everything, but nor is it nothing. Any other distribution implies hidden constraints that are unknown to us, reflecting phantom assumptions. A full and honest accounting of assumptions is helpful, because it aids in understanding how a model misbehaves. And since all models misbehave sometimes, it’s good to be able to anticipate those times before they happen, as well as to learn from those times when they inevitably do.

**Rethinking: Conditional independence**

What is usually meant by “independence” in a probability distribution is just that each observation is uncorrelated with the others, once we know the corresponding predictor values.

## Generalized linear models

>For an outcome variable that is continuous and far from any theoretical maximum or minimum, this sort of Gaussian model has maximum entropy. But when the outcome variable is either discrete or bounded, a Gaussian likelihood is not the most powerful choice.

Luckily, it’s easy to do better. By using all of our prior knowledge about the outcome variable, usually in the form of constraints on the possible values it can take, we can appeal to maximum entropy for the choice of distribution. Then all we have to do is generalize the linear regression strategy—replace a parameter describing the shape of the likelihood with a linear model—to probability distributions other than the Gaussian.

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L11/24.png" alt="Larger family of geocentric linear models. We want to connect a linear model to a mean to the distribution. Unreasonably effective given how geocentric it is. We pick an outcome distribution, then model the parameters using weird things called links, whcih link the distribution to some model. Can do all kinds of fancy things with the same basic strategy. Often if you don't want to play this game, when you write it down, it'll turn out to be a linear model anyway. In most cases, you probably want a GLM." width="80%" />
<p class="caption">Larger family of geocentric linear models. We want to connect a linear model to a mean to the distribution. Unreasonably effective given how geocentric it is. We pick an outcome distribution, then model the parameters using weird things called links, whcih link the distribution to some model. Can do all kinds of fancy things with the same basic strategy. Often if you don't want to play this game, when you write it down, it'll turn out to be a linear model anyway. In most cases, you probably want a GLM.</p>
</div>

Instead of building linear models that look like this:

$$
y_i \sim Normal(\mu_i, \sigma) \\
\mu_i = \alpha + \beta x_i
$$

Replacing a parameter describing the shape of the likelihood with a linear model looks like this:

$$
y_i \sim Binomial(n, p_i) \\
f(p_i) = \alpha + \beta(x_i - \bar{x})
$$
The $f$ is a **link function**, to be determined separately from the distribution. 

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L11/25.png" alt="Distributions arise from natural processes. And resist histomancy. This doesn't make sense under any framework. You want to use knowledge of your constraints to figure it out. There's no statistical framework where the aggregate outcomes is going to have any particular distribution." width="80%" />
<p class="caption">Distributions arise from natural processes. And resist histomancy. This doesn't make sense under any framework. You want to use knowledge of your constraints to figure it out. There's no statistical framework where the aggregate outcomes is going to have any particular distribution.</p>
</div>

Histomancy is a false god, because even perfectly good Gaussian variables may not look Gaussian when displayed as a histogram. Why? **Because at most what a Gaussian likelihood assumes is not that the aggregated data look Gaussian, but rather that the residuals, after fitting the model, look Gaussian.** So for example the combined histogram of male and female body weights is certainly not Gaussian. But it is (approximately) a mixture of Gaussian distributions. So after conditioning on sex, the residuals may be quite normal.

***10.2.1. Meet the family***

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L11/26.png" alt="Going to build GLMs with these different outcome distributions. Just an extension of what you've already been doing. Exponential is everyone's favourite because it only has 1 parameter. Lambda is a rate, and the mean is 1/lambda. Generatively it can arise from a machine with a number of parts. If one part breaks, the whole thing stops working. A fruit fly is the same. Bunch of parts inside the washing machine, and each part has a chance of breaking at a particular time, the waiting time until the washing machine stops is exponentially distributed. " width="80%" />
<p class="caption">Going to build GLMs with these different outcome distributions. Just an extension of what you've already been doing. Exponential is everyone's favourite because it only has 1 parameter. Lambda is a rate, and the mean is 1/lambda. Generatively it can arise from a machine with a number of parts. If one part breaks, the whole thing stops working. A fruit fly is the same. Bunch of parts inside the washing machine, and each part has a chance of breaking at a particular time, the waiting time until the washing machine stops is exponentially distributed. </p>
</div>

*Exponential*: constrained to be 0 or positive. It is a fundamental distribution of distance and duration, kinds of measurements that represent displacement from some point of reference, either in time or space. If the probability of an event is constant in time or across space, then the distribution of events tends towards exponential.

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L11/27.png" alt="If you count events arising from exponential distributions. Mortality rates of fruit flies is bionimal. Like coin flips. Each fly could or could not ascend. And the binomial is maxent. " width="80%" />
<p class="caption">If you count events arising from exponential distributions. Mortality rates of fruit flies is bionimal. Like coin flips. Each fly could or could not ascend. And the binomial is maxent. </p>
</div>

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L11/28.png" alt="Poisson. Two ways of thinking about it. If you have a binomially distributed variable, but the probabiity of success is low and there are lots of flies oserved over a long time. " width="80%" />
<p class="caption">Poisson. Two ways of thinking about it. If you have a binomially distributed variable, but the probabiity of success is low and there are lots of flies oserved over a long time. </p>
</div>

**Poisson**

Practically, the Poisson distribution is used for counts that never get close to any theoretical maximum.

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L11/29.png" alt="If you think about the time to the event of the exponential - how long did you wait until the washing machine broke, if you start adding up that time, those waiting times are distributed like Gamma. Also maxent. e.g. age of onset of cancer, perhaps because there are a lot of cellular defence mechanisms, and all of them need to fail. " width="80%" />
<p class="caption">If you think about the time to the event of the exponential - how long did you wait until the washing machine broke, if you start adding up that time, those waiting times are distributed like Gamma. Also maxent. e.g. age of onset of cancer, perhaps because there are a lot of cellular defence mechanisms, and all of them need to fail. </p>
</div>

**Gamma**: also constrained to be zero or positive. It too is a fundamental distribution of distance and duration. But unlike the exponential distribution, the gamma distribution can have a peak above zero. **If an event can only happen after two or more exponentially distributed events happen, the resulting waiting times will be gamma distributed.** Common in survival and event history analysis, as well as some contexts in which a continuous measurement is constrained to be positive.

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L11/30.png" alt="If you get a Gamma with a really large mean, it converges to a Normal. But not the only way - all roads lead to normal. And it's hard to leave. So these are generative processes, based on the constraints. Doesn't mean that they're correct, but it's the betting part." width="80%" />
<p class="caption">If you get a Gamma with a really large mean, it converges to a Normal. But not the only way - all roads lead to normal. And it's hard to leave. So these are generative processes, based on the constraints. Doesn't mean that they're correct, but it's the betting part.</p>
</div>

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L11/31.png" alt="Tide prediction engine. When we get to GLMs, the metaphor is very potent. It's a mechinical computer, and a part of it is the prediction of times, and then there's messy stuff at the bottom that's calculating the output. You're absolutely wedded to the prediction perspective. Hard to have intuition about the parameters. You want to understand the prediction space, and you understand the parameters by observing their effects on prediction." width="80%" />
<p class="caption">Tide prediction engine. When we get to GLMs, the metaphor is very potent. It's a mechinical computer, and a part of it is the prediction of times, and then there's messy stuff at the bottom that's calculating the output. You're absolutely wedded to the prediction perspective. Hard to have intuition about the parameters. You want to understand the prediction space, and you understand the parameters by observing their effects on prediction.</p>
</div>

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L11/32.png" alt="Just need to think about before the data have arrived, you know things about the outcome variable. e.g. count variables are integers starting at 0, so there are no negative counts. So from the beginning you know things about them. That constrains the distributions before they arrive. Next week we'll move onto monsters because we glue together different models using links. Likhert scales are ordinal scales, but they're not numeric. What it takes to get from 1 to 2 might be different from what it takes to go from 2 to 3. Fight monsters by making monsters. Mixture models are super useful. Bear a lot of resemblance to multi-level models." width="80%" />
<p class="caption">Just need to think about before the data have arrived, you know things about the outcome variable. e.g. count variables are integers starting at 0, so there are no negative counts. So from the beginning you know things about them. That constrains the distributions before they arrive. Next week we'll move onto monsters because we glue together different models using links. Likhert scales are ordinal scales, but they're not numeric. What it takes to get from 1 to 2 might be different from what it takes to go from 2 to 3. Fight monsters by making monsters. Mixture models are super useful. Bear a lot of resemblance to multi-level models.</p>
</div>

***10.2.2. Linking linear models to distributions***

>To build a regression model from any of the exponential family distributions is just a matter of attaching one or more linear models to one or more of the parameters that describe the distribution’s shape. But as hinted at earlier, usually we require a **link function** to prevent mathematical accidents like negative distances or probability masses that exceed 1. (p. 316, emphasis in the original)

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L11/33.png" alt="Consider the Gaussian linear regression. It's super benign, and that's because it has a special property: the scientific measurement units and the parameter for the mean are the same. " width="80%" />
<p class="caption">Consider the Gaussian linear regression. It's super benign, and that's because it has a special property: the scientific measurement units and the parameter for the mean are the same. </p>
</div>

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L11/34.png" alt="The much more typical case is the binomial model. If you want to connect a linear model to $p$, it's a probability. Probability is unitless. They're divided out. But the outcome has counts. So now the units aren't the same, and we need something that connects the parameter to the outcome scale. We need some function to put in where the question mark is so that it obeys physics." width="80%" />
<p class="caption">The much more typical case is the binomial model. If you want to connect a linear model to $p$, it's a probability. Probability is unitless. They're divided out. But the outcome has counts. So now the units aren't the same, and we need something that connects the parameter to the outcome scale. We need some function to put in where the question mark is so that it obeys physics.</p>
</div>

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L11/35.png" alt="We're going to wrap $p$ in some function which constraitns it. say there's some function we can apply to the probability so that it's linear in the outcome scale." width="80%" />
<p class="caption">We're going to wrap $p$ in some function which constraitns it. say there's some function we can apply to the probability so that it's linear in the outcome scale.</p>
</div>

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L11/36.png" alt="Searching is hearder. OLS can be used, but can be fragile. We're just going to use MCMC because we don't want to worry about it." width="80%" />
<p class="caption">Searching is hearder. OLS can be used, but can be fragile. We're just going to use MCMC because we don't want to worry about it.</p>
</div>

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L11/37.png" alt="One of the fun things is that suddenly all the varibles automatically interact with each others. Imagine you're trying to understand the habitat preferences of a reptile. If it gets really cold, probability of surivival is low, but hot they're fine. On the porobability scale, evenutally things get cold enough that you're dead no matter what. If any one varible will kill the lizxard, it doesn't matter what the other variables are doing. That's an interaction. No matter how much food you give it, it's going to die if it's really cold. You want your model to do this." width="80%" />
<p class="caption">One of the fun things is that suddenly all the varibles automatically interact with each others. Imagine you're trying to understand the habitat preferences of a reptile. If it gets really cold, probability of surivival is low, but hot they're fine. On the porobability scale, evenutally things get cold enough that you're dead no matter what. If any one varible will kill the lizxard, it doesn't matter what the other variables are doing. That's an interaction. No matter how much food you give it, it's going to die if it's really cold. You want your model to do this.</p>
</div>

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L11/38.png" alt="If you like to think about the rate of change in a linear regression, you take a partial slope. Do this with any GLM, and the chain rule kicks in. And you get a much less nice expression. In a logistic regression, that's the equation. If you take the partial derivative, you get this thing on the right. That's the rate of change. " width="80%" />
<p class="caption">If you like to think about the rate of change in a linear regression, you take a partial slope. Do this with any GLM, and the chain rule kicks in. And you get a much less nice expression. In a logistic regression, that's the equation. If you take the partial derivative, you get this thing on the right. That's the rate of change. </p>
</div>

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L11/39.png" alt="Let's move into doing some good work. We'll model some counts of events. What the Bionimal distriibution for? Counts of success out of trials. There's some constant expected value condtioinal on a set of predictor variables. Under those conditions the maxent distribution is binomial. " width="80%" />
<p class="caption">Let's move into doing some good work. We'll model some counts of events. What the Bionimal distriibution for? Counts of success out of trials. There's some constant expected value condtioinal on a set of predictor variables. Under those conditions the maxent distribution is binomial. </p>
</div>

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L11/40.png" alt="The expected value is $np$. Note the variance is related to the expected value. In general, the Guassian is the only distrubiton where the mean and the variance are independent. With all others, if the mean gets big, so does the variance. " width="80%" />
<p class="caption">The expected value is $np$. Note the variance is related to the expected value. In general, the Guassian is the only distrubiton where the mean and the variance are independent. With all others, if the mean gets big, so does the variance. </p>
</div>

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L11/41.png" alt="So we're going to plug a linear model and attach it to $p$." width="80%" />
<p class="caption">So we're going to plug a linear model and attach it to $p$.</p>
</div>

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L11/42.png" alt="On the horizontal I have some predictor $x$. What are the log odds? The log of $p$. " width="80%" />
<p class="caption">On the horizontal I have some predictor $x$. What are the log odds? The log of $p$. </p>
</div>

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L11/43.png" alt="If you do this, there's a really nice mapping onto the probability scale, where x is linear on the log odds scale, and constrained to the (0,1) internval on the probability scale. This arises from the maxent derivation of the binomial distribution. In machine learning they call it the maxent classifier." width="80%" />
<p class="caption">If you do this, there's a really nice mapping onto the probability scale, where x is linear on the log odds scale, and constrained to the (0,1) internval on the probability scale. This arises from the maxent derivation of the binomial distribution. In machine learning they call it the maxent classifier.</p>
</div>

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L11/44.png" alt="Logit means 'log odds'. $p$ is the probaility scale.  " width="80%" />
<p class="caption">Logit means 'log odds'. $p$ is the probaility scale.  </p>
</div>

<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L11/45.png" width="80%" />

<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L11/46.png" width="80%" />

<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L11/47.png" width="80%" />

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L11/48.png" alt="It really is just log odds. If you measure stuff in odds, you can measure things really well. Log odds are just the log of the odds. That's linear. How do you get back to the linear scale? Solve for $p$. " width="80%" />
<p class="caption">It really is just log odds. If you measure stuff in odds, you can measure things really well. Log odds are just the log of the odds. That's linear. How do you get back to the linear scale? Solve for $p$. </p>
</div>

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L11/49.png" alt="This is the conventional way to link, because it has lots of good mathematical properties." width="80%" />
<p class="caption">This is the conventional way to link, because it has lots of good mathematical properties.</p>
</div>

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L11/50.png" alt="For intuition, you want to relate the two scales. Horizontal is probability. Vertical is log-odds. Log odds 0 is equal chance. There's this compression effect, so you need some scale. Log odds of -1 is 1/4. This is really important for defining priors. " width="80%" />
<p class="caption">For intuition, you want to relate the two scales. Horizontal is probability. Vertical is log-odds. Log odds 0 is equal chance. There's this compression effect, so you need some scale. Log odds of -1 is 1/4. This is really important for defining priors. </p>
</div>

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L11/51.png" alt="We use this thing because its the natural link within the probability formula. It arises naturally in the derivation of the distribution. Big and legitimate links. If you have a scientific model, you can derive the link automatically. " width="80%" />
<p class="caption">We use this thing because its the natural link within the probability formula. It arises naturally in the derivation of the distribution. Big and legitimate links. If you have a scientific model, you can derive the link automatically. </p>
</div>





