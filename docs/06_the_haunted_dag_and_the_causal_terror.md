---
title: "Notes for Statistical Rethinking 2nd ed. by Richard McElreath"
date: '2021-07-02'
output:
  html_document:
    toc: true
    toc_float: true
    dev: 'svg'
    number_sections: false
    pandoc_args: --lua-filter=color-text.lua
    highlight: pygments
#output: html_notebook
#editor_options: 
#  chunk_output_type: inline
#output:
#  bookdown::tufte_html_book:
#    toc: yes
#    css: toc.css
#    pandoc_args: --lua-filter=color-text.lua
#    highlight: pygments
#    link-citations: yes
---

# The Haunted DAG & The Causal Terror


```r
library(here)
source(here::here("code/scripts/source.R"))
```


```r
slides_dir = here::here("docs/slides/L06")
```

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L06/01.png" width="80%" />

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L06/05.png" alt="Interesting feature of scientific literature is that there's a negative correlation between surprising things and true things. The most trustworthy science is incredibly boring. Paper from PNAS. Hurricanes get names. They had this convention of alternating names. You can regress them, and if you do a terrible regression, female hurricanes are deadlier, but it's not robust. And there's no robust mechanism." width="80%" />
<p class="caption">Interesting feature of scientific literature is that there's a negative correlation between surprising things and true things. The most trustworthy science is incredibly boring. Paper from PNAS. Hurricanes get names. They had this convention of alternating names. You can regress them, and if you do a terrible regression, female hurricanes are deadlier, but it's not robust. And there's no robust mechanism.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L06/06.png" alt="This is Mono Lake, with high levels of arsenic. Why's that bad? Arsenate mimics phosphate, and things break. How do the organisms in this lake adapt to it? Dr Wolfe-Simon published a study showing evidence that bacteria in the lake were using arsenic in their DNA. Since then it turns out it probably wasn't true, even though it was a rigorous study." width="80%" />
<p class="caption">This is Mono Lake, with high levels of arsenic. Why's that bad? Arsenate mimics phosphate, and things break. How do the organisms in this lake adapt to it? Dr Wolfe-Simon published a study showing evidence that bacteria in the lake were using arsenic in their DNA. Since then it turns out it probably wasn't true, even though it was a rigorous study.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L06/07.png" alt="We don't need any elaborate theory that we all have. All you need to get a negative correlation between newsworthy things and trustworthy things are peer-review. Here's a simulated example. Imagine that either journals or grant-review panels, you care about both. But you also care about rigour. A study can get published or funding *if* it's sufficiently trustworthy *or* it's sufficiently newsworthy. So even it there's no correlation in the production of science, post-selection there'll be a negative correlation. Here you can see there's no correlation. There's a threshold of the sum of newsworthiness and trustowrthiness. The blue are the ones that get funded, and the correlations are -0.8. You can't know from the correlation what's happening generatively. This is a spurious correlation. Conditioning on a variable in a regression is a selection process. Don't just add things to regressions. It's called a Simpson's paradox." width="80%" />
<p class="caption">We don't need any elaborate theory that we all have. All you need to get a negative correlation between newsworthy things and trustworthy things are peer-review. Here's a simulated example. Imagine that either journals or grant-review panels, you care about both. But you also care about rigour. A study can get published or funding *if* it's sufficiently trustworthy *or* it's sufficiently newsworthy. So even it there's no correlation in the production of science, post-selection there'll be a negative correlation. Here you can see there's no correlation. There's a threshold of the sum of newsworthiness and trustowrthiness. The blue are the ones that get funded, and the correlations are -0.8. You can't know from the correlation what's happening generatively. This is a spurious correlation. Conditioning on a variable in a regression is a selection process. Don't just add things to regressions. It's called a Simpson's paradox.</p>
</div>


```r
set.seed(1914)
N <- 200 # num grant proposals
p <- 0.1 # proportion to select
# uncorrelated newsworthiness and trustworthiness
nw <- rnorm(N)
tw <- rnorm(N)
# select top 10% of combined scores
s <- nw + tw # total score
q <- quantile( s , 1-p ) # top 10% threshold
selected <- ifelse( s >= q , TRUE , FALSE )
cor( tw[selected] , nw[selected] )
```

```
## [1] -0.7680083
```


<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L06/08.png" alt="Regression is an incredible tool. But it's an oracle. It automatically finds the most informative cases. It's amazing that the universe is designed such that this works out. But it's a historical oracle. Like the Oracle of Delphi. Poweful, but not benign. Or like a genie. Will take your wish (question) very literally." width="80%" />
<p class="caption">Regression is an incredible tool. But it's an oracle. It automatically finds the most informative cases. It's amazing that the universe is designed such that this works out. But it's a historical oracle. Like the Oracle of Delphi. Poweful, but not benign. Or like a genie. Will take your wish (question) very literally.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L06/09.png" alt="&quot;Table 2&quot;: uninterpretable causal salad. Adding variable can create confounds." width="80%" />
<p class="caption">"Table 2": uninterpretable causal salad. Adding variable can create confounds.</p>
</div>


<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L06/10.png" alt="Going to use a lot of simulated examples. Actually there's this benign fact that there are only four confounds. Ignoring those things, these are the only kinds we get. Going to explain each of them to see what they do. Going to learn how to de-confound each of them. If you know the causal graph, you can deconfound or conclude that it's hopeless and can't confound. So we'll come back to this." width="80%" />
<p class="caption">Going to use a lot of simulated examples. Actually there's this benign fact that there are only four confounds. Ignoring those things, these are the only kinds we get. Going to explain each of them to see what they do. Going to learn how to de-confound each of them. If you know the causal graph, you can deconfound or conclude that it's hopeless and can't confound. So we'll come back to this.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L06/11.png" alt="The most famous confound. Variable that is a common cause of two others. Median age of marriage creates a fork. Creates a spurious correlation between M and D. Interested in the causal effect of X on Y. In the fork, you deconfound by conditioning on Z and shut the fork. There's this notation at the bottom of the slide. X is independent on Y conditional on Z." width="80%" />
<p class="caption">The most famous confound. Variable that is a common cause of two others. Median age of marriage creates a fork. Creates a spurious correlation between M and D. Interested in the causal effect of X on Y. In the fork, you deconfound by conditioning on Z and shut the fork. There's this notation at the bottom of the slide. X is independent on Y conditional on Z.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L06/12.png" alt="The pipe is a lot like the fork. Here there's a mediation. In reality X is mediated by Z. If we condition on Z, we don't notice the true effect. If you condition on Z, then you remove the dependency between X and Y. From the data alone, you can't see the difference between a pipe and a fork. " width="80%" />
<p class="caption">The pipe is a lot like the fork. Here there's a mediation. In reality X is mediated by Z. If we condition on Z, we don't notice the true effect. If you condition on Z, then you remove the dependency between X and Y. From the data alone, you can't see the difference between a pipe and a fork. </p>
</div>

## Multicollinearity

Means a very strong association between two or more predictors. 

Consequence: the posterior distribution will seem to suggest that none of the variables is reliably associated with the outcome, even if all of the variables are in reality strongly associated with the outcome.

That said, the model will work fine for prediction; you will jsut be frustrated trying to understand it.

***6.1.1 Multicollinear legs***

Imagine trying to predict an individual's height using the length of their legs as a predictor. But once you put both legs (right and left) into the model, something vexing will happen. 


```r
N <- 100 # number of individuals
set.seed(909)
height <- rnorm(N,10,2) # sim total height of each
leg_prop <- runif(N,0.4,0.5) # leg as proportion of height
leg_left <- leg_prop*height + # sim left leg as proportion + error
  rnorm( N , 0 , 0.02 )
leg_right <- leg_prop*height + # sim right leg as proportion + error
  rnorm( N , 0 , 0.02 )
# combine into data frame
d <- data.frame(height,leg_left,leg_right)
```

We expect the beta coefficient that measures the association of a leg with height to end up around the average height (10) divided by 45% of the average height (4.5). 


```r
m6.1 <- quap(
  alist(
    height ~ dnorm( mu , sigma ) ,
    mu <- a + bl*leg_left + br*leg_right ,
    a ~ dnorm( 10 , 100 ) ,
    bl ~ dnorm( 2 , 10 ) ,
    br ~ dnorm( 2 , 10 ) ,
    sigma ~ dexp( 1 )
  ) , data=d )
precis(m6.1)
```

```
##            mean         sd       5.5%     94.5%
## a     0.9812791 0.28395540  0.5274635 1.4350947
## bl    0.2118585 2.52703706 -3.8268348 4.2505518
## br    1.7836774 2.53125061 -2.2617500 5.8291047
## sigma 0.6171026 0.04343427  0.5476862 0.6865189
```


```r
plot(precis(m6.1))
```

<img src="06_the_haunted_dag_and_the_causal_terror_files/figure-html/unnamed-chunk-12-1.svg" width="672" />


```r
post <- extract.samples(m6.1)
plot( bl ~ br , post , col=col.alpha(rangi2,0.1) , pch=16 )
```

<img src="06_the_haunted_dag_and_the_causal_terror_files/figure-html/6.5-1.svg" width="672" />

The posterior distribution for these two parameters is very hgihly correlated, with all of the plausible values of `bl` and `br` lying around a narrow ridge. When `bl` is large, then `br` must be small. Since both leg variables contain almost exactly the same information, if you insist on including both in a model, then there will be a practically infinite number of combinations of `bl` and `br` that produce the same predictions.

Compute the posterior distribution and plot it.


```r
sum_blbr <- post$bl + post$br
dens( sum_blbr , col=rangi2 , lwd=2 , xlab="sum of bl and br" )
```

<img src="06_the_haunted_dag_and_the_causal_terror_files/figure-html/6.6-1.svg" width="672" />


```r
m6.2 <- quap(
  alist(
    height ~ dnorm( mu , sigma ) ,
    mu <- a + bl*leg_left,
    a ~ dnorm( 10 , 100 ) ,
    bl ~ dnorm( 2 , 10 ) ,
    sigma ~ dexp( 1 )
  ) , data=d )
precis(m6.2)
```

```
##            mean         sd      5.5%    94.5%
## a     0.9979326 0.28364620 0.5446112 1.451254
## bl    1.9920676 0.06115704 1.8943269 2.089808
## sigma 0.6186038 0.04353998 0.5490185 0.688189
```

The basic lesson is this:
>When two predictor varilables are very strongly correlated (conditional on other variables int he model), including both in a model may lead to confusion.

***6.1.2. Multicollinear milk***


```r
library(rethinking)
data(milk)
d <- milk
d$K <- rethinking::standardize( d$kcal.per.g )
d$F <- rethinking::standardize( d$perc.fat )
d$L <- rethinking::standardize( d$perc.lactose )
```


```r
# kcal.per.g regressed on perc.fat
m6.3 <- quap(
  alist(
    K ~ dnorm( mu , sigma ) ,
    mu <- a + bF*F ,
    a ~ dnorm( 0 , 0.2 ) ,
    bF ~ dnorm( 0 , 0.5 ) ,
    sigma ~ dexp( 1 )
  ) , data=d )
# kcal.per.g regressed on perc.lactose
m6.4 <- quap(
  alist(
    K ~ dnorm( mu , sigma ) ,
    mu <- a + bL*L ,
    a ~ dnorm( 0 , 0.2 ) ,
    bL ~ dnorm( 0 , 0.5 ) ,
    sigma ~ dexp( 1 )
  ) , data=d )
precis( m6.3 )
```

```
##               mean         sd       5.5%     94.5%
## a     1.535526e-07 0.07725195 -0.1234634 0.1234637
## bF    8.618970e-01 0.08426088  0.7272318 0.9965621
## sigma 4.510179e-01 0.05870756  0.3571919 0.5448440
```

```r
precis( m6.4 )
```

```
##                mean         sd       5.5%      94.5%
## a      7.438895e-07 0.06661633 -0.1064650  0.1064665
## bL    -9.024550e-01 0.07132848 -1.0164517 -0.7884583
## sigma  3.804653e-01 0.04958259  0.3012227  0.4597078
```

Given the strong association of each predictor with the outcome, we might conclude that both variables are reliable predictors of total energy in milk, across species. But watch what happens when we place both predictor variables in the same regression model:


```r
m6.5 <- quap(
  alist(
    K ~ dnorm( mu , sigma ) ,
    mu <- a + bF*F + bL*L ,
    a ~ dnorm( 0 , 0.2 ) ,
    bF ~ dnorm( 0 , 0.5 ) ,
    bL ~ dnorm( 0 , 0.5 ) ,
    sigma ~ dexp( 1 )
  ) ,
  data=d )
precis( m6.5 )
```

```
##                mean         sd        5.5%      94.5%
## a     -3.172136e-07 0.06603577 -0.10553823  0.1055376
## bF     2.434983e-01 0.18357865 -0.04989579  0.5368925
## bL    -6.780825e-01 0.18377670 -0.97179320 -0.3843719
## sigma  3.767418e-01 0.04918394  0.29813637  0.4553472
```

Now the posterior means of both bF and bL are closer to zero. And the standard deviations for both parameters are twice as large as in the bivariate models (m6.3 and m6.4).


```r
pairs( ~ kcal.per.g + perc.fat + perc.lactose , data=d , col=rangi2 )
```

<img src="06_the_haunted_dag_and_the_causal_terror_files/figure-html/6.11-1.svg" width="672" />

Either helps in predicting kcal.per.g, but neither helps as much *once you already know the other*.

Some fields actually teach students to inspect pairwise correlations before fitting a model, to identify and drop highly correlated predictors. This is a mistake. Pairwise correlations are not the problem. It is the conditional associations—not correlations—that matter. 

Now let's see how the imprecision of the posterior increases with association between two predictors.


```r
library(rethinking)
data(milk)
d <- milk
sim.coll <- function( r=0.9 ) {
  d$x <- rnorm( nrow(d) , mean=r*d$perc.fat ,
    sd=sqrt( (1-r^2)*var(d$perc.fat) ) )
  m <- lm( kcal.per.g ~ perc.fat + x , data=d )
  sqrt( diag( vcov(m) ) )[2] # stddev of parameter
}
rep.sim.coll <- function( r=0.9 , n=100 ) {
  stddev <- replicate( n , sim.coll(r) )
  mean(stddev)
}
r.seq <- seq(from=0,to=0.99,by=0.01)
stddev <- sapply( r.seq , function(z) rep.sim.coll(r=z,n=100) )
plot( stddev ~ r.seq , type="l" , col=rangi2, lwd=2 , xlab="correlation" )
```

<img src="06_the_haunted_dag_and_the_causal_terror_files/figure-html/6.12-1.svg" width="672" />


## Post-treatment bias

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L06/13.png" alt="The confound that gets created is the &quot;post-treatment bias&quot;, Z. Post-treatment variables arise as a consequence of treatment. This happens a lot. The bias occurs when you're not aware of Z, and end up inferring something wrong. " width="80%" />
<p class="caption">The confound that gets created is the "post-treatment bias", Z. Post-treatment variables arise as a consequence of treatment. This happens a lot. The bias occurs when you're not aware of Z, and end up inferring something wrong. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L06/14.png" alt="Let's imagine an experiment where there's fungal growth in a greenhouse, and you have an anti-fungal treatment, and you randomly assign plants to either the treatment or control. The initial height of the plant is H0. The anti-fungal treatment is upstream from the fungus, but doesn't influence it directly. What happens here in a regression is if you measure fungus - which is how you test for mediation - but what you're interested in is the full path from T to H1. If you condition on F, it'll look like the treatment doesn't work. If you condition on F, you block the pipe, and information doesn't flow from T to H1. In observational studies, the terror is real. " width="80%" />
<p class="caption">Let's imagine an experiment where there's fungal growth in a greenhouse, and you have an anti-fungal treatment, and you randomly assign plants to either the treatment or control. The initial height of the plant is H0. The anti-fungal treatment is upstream from the fungus, but doesn't influence it directly. What happens here in a regression is if you measure fungus - which is how you test for mediation - but what you're interested in is the full path from T to H1. If you condition on F, it'll look like the treatment doesn't work. If you condition on F, you block the pipe, and information doesn't flow from T to H1. In observational studies, the terror is real. </p>
</div>


```r
set.seed(71)
# number of plants
N <- 100

# simulate initial heights
h0 <- rnorm(N,10,2)

# assign treatments and simulate fungus and growth
treatment <- rep( 0:1 , each=N/2 )
fungus <- rbinom( N , size=1 , prob=0.5 - treatment*0.4 )
h1 <- h0 + rnorm(N, 5 - 3*fungus)

# compose a clean data frame
d <- data.frame( h0=h0 , h1=h1 , treatment=treatment , fungus=fungus )
precis(d)
```

```
##               mean        sd      5.5%    94.5%    histogram
## h0         9.95978 2.1011623  6.570328 13.07874 ▁▂▂▂▇▃▂▃▁▁▁▁
## h1        14.39920 2.6880870 10.618002 17.93369     ▁▁▃▇▇▇▁▁
## treatment  0.50000 0.5025189  0.000000  1.00000   ▇▁▁▁▁▁▁▁▁▇
## fungus     0.23000 0.4229526  0.000000  1.00000   ▇▁▁▁▁▁▁▁▁▂
```

***6.2.1. A prior is born***

We should allow $p$ to be less than 1, in case the experiment goes horribly wrong and we kill all the plants. We also have to ensure that $p > 0$, because it is a proportion. 

$$
h_{1,i}\sim Normal(\mu_i, \sigma) \\
\mu_i = h_{0,i} \times p
$$


```r
sim_p <- rlnorm( 1e4 , 0 , 0.25 )
precis( data.frame(sim_p) )
```

```
##          mean        sd     5.5%    94.5%    histogram
## sim_p 1.03699 0.2629894 0.670683 1.496397 ▁▁▃▇▇▃▁▁▁▁▁▁
```

So this prior expects anything from 40% shrinkage up to 50% growth.


```r
m6.6 <- quap(
  alist(
    h1 ~ dnorm( mu , sigma ),
    mu <- h0*p,
    p ~ dlnorm( 0 , 0.25 ),
    sigma ~ dexp( 1 )
  ), data=d )
precis(m6.6)
```

```
##           mean         sd     5.5%    94.5%
## p     1.426626 0.01760992 1.398482 1.454770
## sigma 1.793286 0.12517262 1.593236 1.993336
```

```r
m6.7 <- quap(
  alist(
    h1 ~ dnorm( mu , sigma ),
    mu <- h0 * p,
    p <- a + bt*treatment + bf*fungus,
    a ~ dlnorm( 0 , 0.2 ) ,
    bt ~ dnorm( 0 , 0.5 ),
    bf ~ dnorm( 0 , 0.5 ),
    sigma ~ dexp( 1 )
  ), data=d )
precis(m6.7)
```

```
##               mean         sd        5.5%       94.5%
## a      1.481391468 0.02451069  1.44221865  1.52056429
## bt     0.002412222 0.02986965 -0.04532525  0.05014969
## bf    -0.266718915 0.03654772 -0.32512923 -0.20830860
## sigma  1.408797442 0.09862070  1.25118251  1.56641237
```

***6.2.2. Blocked by consequence***

>So when we control for fungus, the model is implicitly answering the question: Once we already know whether or not a plant developed fungus, does soil treatment matter? The answer is “no,” because soil treatment has its effects on growth through reducing fungus.

To measure treatment properly, we should omit the post-treatment variable `fungus`.



```r
m6.8 <- quap(
  alist(
    h1 ~ dnorm( mu , sigma ),
    mu <- h0 * p,
    p <- a + bt*treatment,
    a ~ dlnorm( 0 , 0.2 ),
    bt ~ dnorm( 0 , 0.5 ),
    sigma ~ dexp( 1 )
  ), data=d )
precis(m6.8)
```

```
##             mean         sd       5.5%     94.5%
## a     1.38035767 0.02517554 1.34012229 1.4205931
## bt    0.08499924 0.03429718 0.03018573 0.1398128
## sigma 1.74631655 0.12191552 1.55147200 1.9411611
```

Now the impact of treatment is clearly positive, as it should be.

***6.2.3. Fungus and d-separation***


```r
library(dagitty)
plant_dag <- dagitty( "dag {
  H_0 -> H_1
  F -> H_1
  T -> F
}")
coordinates( plant_dag ) <- list( x=c(H_0=0,T=2,F=1.5,H_1=1) ,
    y=c(H_0=0,T=0,F=0,H_1=0) )
drawdag( plant_dag )
```

<img src="06_the_haunted_dag_and_the_causal_terror_files/figure-html/6.18-1.svg" width="672" />


```r
dagitty::impliedConditionalIndependencies(plant_dag)
```

```
## F _||_ H_0
## H_0 _||_ T
## H_1 _||_ T | F
```

The first two say that original plant height should not be associated with the treatment of fungus, provided we do not condition on anything.

But consider this DAG:


```r
knitr::include_graphics(here::here("docs/misc_figs/06/fungus_dag.png"))
```

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/misc_figs/06/fungus_dag.png" width="218" />

A regression of $H_1$ on $T$ will show no association between the treatment and plant growth. But if we include $F$ in the model, suddenly there will be an association. Let’s try it.


```r
set.seed(71)
N <- 1000
h0 <- rnorm(N,10,2)
treatment <- rep( 0:1 , each=N/2 )
M <- rbern(N)
fungus <- rbinom( N , size=1 , prob=0.5 - treatment*0.4 + 0.4*M )
h1 <- h0 + rnorm( N , 5 + 3*M )
d2 <- data.frame( h0=h0 , h1=h1 , treatment=treatment , fungus=fungus )

# Rerun models with d2
m6.7 <- quap(
  alist(
    h1 ~ dnorm( mu , sigma ),
    mu <- h0 * p,
    p <- a + bt*treatment + bf*fungus,
    a ~ dlnorm( 0 , 0.2 ) ,
    bt ~ dnorm( 0 , 0.5 ),
    bf ~ dnorm( 0 , 0.5 ),
    sigma ~ dexp( 1 )
  ), data=d2 )
precis(m6.7)
```

```
##             mean         sd       5.5%      94.5%
## a     1.52211420 0.01360385 1.50037263 1.54385578
## bt    0.04859313 0.01415624 0.02596872 0.07121754
## bf    0.14276270 0.01415774 0.12013590 0.16538949
## sigma 2.10262855 0.04694249 2.02760537 2.17765172
```

```r
m6.8 <- quap(
  alist(
    h1 ~ dnorm( mu , sigma ),
    mu <- h0 * p,
    p <- a + bt*treatment,
    a ~ dlnorm( 0 , 0.2 ),
    bt ~ dnorm( 0 , 0.5 ),
    sigma ~ dexp( 1 )
  ), data=d2 )
precis(m6.8)
```

```
##              mean          sd        5.5%      94.5%
## a      1.62401319 0.009546625  1.60875584 1.63927054
## bt    -0.01051596 0.013511945 -0.03211066 0.01107874
## sigma  2.20520300 0.049231869  2.12652096 2.28388504
```

Now fungus seems like it helped the plants, even though it had no effect.

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L06/15.png" alt="Frustrating thing for statisticians is that if you condition on career choice, there's basically no wage gap. But that doesn't mean gender and race isn't causal, because there are streams where something downstream knocks it out. If you look at funding rates for the sciences, women get way less grant money. But not if you condition on field. " width="80%" />
<p class="caption">Frustrating thing for statisticians is that if you condition on career choice, there's basically no wage gap. But that doesn't mean gender and race isn't causal, because there are streams where something downstream knocks it out. If you look at funding rates for the sciences, women get way less grant money. But not if you condition on field. </p>
</div>

## Collider bias

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L06/16.png" alt="This is where the selection effect comes from. Like the fork but in reverse. Here `Z` is a common result of `X` and `Y`. X and Y are really independent, but if you condition on Z, it creates a spurious causal connection between X and Y. There's this &quot;finding out&quot; effect. " width="80%" />
<p class="caption">This is where the selection effect comes from. Like the fork but in reverse. Here `Z` is a common result of `X` and `Y`. X and Y are really independent, but if you condition on Z, it creates a spurious causal connection between X and Y. There's this "finding out" effect. </p>
</div>

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L06/17.png" width="80%" />

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L06/18.png" alt="This is the finding out effect. Works for continuous variables as well. " width="80%" />
<p class="caption">This is the finding out effect. Works for continuous variables as well. </p>
</div>

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L06/19.png" width="80%" />

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L06/20.png" alt="Both influence publication." width="80%" />
<p class="caption">Both influence publication.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L06/21.png" alt="So if it's been published in Nature and isn't trustworthy, can you tell me how newsworthy it is?" width="80%" />
<p class="caption">So if it's been published in Nature and isn't trustworthy, can you tell me how newsworthy it is?</p>
</div>



<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L06/22.png" alt="There are lots of effects like this that happen all the time. Being tall is definitely causatively-speaking an advantage. The taller you are, the easier to score field goals. But conditional on being a professional player, there's no correlation between height and shooting percentage. Because the shorter players are compensating by being amazing in other ways. They've been distorted by the selection effects." width="80%" />
<p class="caption">There are lots of effects like this that happen all the time. Being tall is definitely causatively-speaking an advantage. The taller you are, the easier to score field goals. But conditional on being a professional player, there's no correlation between height and shooting percentage. Because the shorter players are compensating by being amazing in other ways. They've been distorted by the selection effects.</p>
</div>

***6.3.1. Collider of false sorrow***

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L06/23.png" alt="Let's do an example. Image this causal graph at the bottom. Imagine it's true that getting married is positively, causally associated with happiness, and age. Now our question is, is there any causal impact of age on happiness? Here's a simulation where it's totally spurious. " width="80%" />
<p class="caption">Let's do an example. Image this causal graph at the bottom. Imagine it's true that getting married is positively, causally associated with happiness, and age. Now our question is, is there any causal impact of age on happiness? Here's a simulation where it's totally spurious. </p>
</div>



<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L06/24.png" alt="Here the simulation is slightly different to the usual `rnorm`. Here's the algorithm. Uniform happiness at birth. Distributed from 0 to 1. Reality is more complicated, even harder to figure out. At 18 years old, you're eligible to marry. Then you have your coin-flip chance to get married. The chance is proportional to your happiness, which is constant. Age itself doesn't cause marriage, but each year you're alive you have another chance to get married. Married people remain married unto death. Then everyone moves to Spain. 1300 people, 3 variables, over 1000 years." width="80%" />
<p class="caption">Here the simulation is slightly different to the usual `rnorm`. Here's the algorithm. Uniform happiness at birth. Distributed from 0 to 1. Reality is more complicated, even harder to figure out. At 18 years old, you're eligible to marry. Then you have your coin-flip chance to get married. The chance is proportional to your happiness, which is constant. Age itself doesn't cause marriage, but each year you're alive you have another chance to get married. Married people remain married unto death. Then everyone moves to Spain. 1300 people, 3 variables, over 1000 years.</p>
</div>

```r
library(rethinking)
d <- sim_happiness( seed=1977 , N_years=1000 )
precis(d)
```

```
##                    mean        sd      5.5%     94.5%     histogram
## age        3.300000e+01 18.768883  4.000000 62.000000 ▇▇▇▇▇▇▇▇▇▇▇▇▇
## married    3.007692e-01  0.458769  0.000000  1.000000    ▇▁▁▁▁▁▁▁▁▃
## happiness -1.000070e-16  1.214421 -1.789474  1.789474      ▇▅▇▅▅▇▅▇
```

Rescale age so that the range from 18 to 65 is one unit, i.e. `A` ranges from 0 to 1, where 0 is age 18 and 1 is age 65:


```r
d2 <- d[ d$age>17 , ] # only adults
d2$A <- ( d2$age - 18 ) / ( 65 - 18 )
```

Approximate the posterior 

```r
d2$mid <- d2$married + 1
m6.9 <- quap(
  alist(
    happiness ~ dnorm( mu , sigma ),
    mu <- a[mid] + bA*A,
    a[mid] ~ dnorm( 0 , 1 ) ,
    bA ~ dnorm( 0 , 2 ) ,
    sigma ~ dexp(1)
  ) , data=d2 )
precis(m6.9,depth=2)
```

```
##             mean         sd       5.5%      94.5%
## a[1]  -0.2350877 0.06348986 -0.3365568 -0.1336186
## a[2]   1.2585517 0.08495989  1.1227694  1.3943340
## bA    -0.7490274 0.11320112 -0.9299447 -0.5681102
## sigma  0.9897080 0.02255800  0.9536559  1.0257600
```

The model is quite sure that age is negatively associated with happiness. We’d like to compare the inferences from this model to a model that omits marriage status:


```r
m6.10 <- quap(
  alist(
    happiness ~ dnorm( mu , sigma ),
    mu <- a + bA*A,
    a ~ dnorm( 0 , 1 ),
    bA ~ dnorm( 0 , 2 ),
    sigma ~ dexp(1)
  ) , data=d2 )
precis(m6.10)
```

```
##                mean         sd       5.5%     94.5%
## a      1.649248e-07 0.07675015 -0.1226614 0.1226617
## bA    -2.728620e-07 0.13225976 -0.2113769 0.2113764
## sigma  1.213188e+00 0.02766080  1.1689803 1.2573949
```



<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L06/25.png" alt="Here's the system. Run a regression where we take happiness. Happiness is the outcome, then the linear model `mu`, the slope `a` which is age. That's the exposure we're interested in. And we know the marriage status, so perhaps we control for that. (No, that's the wrong thing to do, as we'll see.) Created an index variable. Then put that in as a control. We see that single people are less happy. Regression models don't have arrows. It's not in the Bayesian network; that's what the DAG does. `a[2]` is married individuals. Positive `mu`. The slope is solidly negative. But this is a spurious correlation by conditioning on a collider. " width="80%" />
<p class="caption">Here's the system. Run a regression where we take happiness. Happiness is the outcome, then the linear model `mu`, the slope `a` which is age. That's the exposure we're interested in. And we know the marriage status, so perhaps we control for that. (No, that's the wrong thing to do, as we'll see.) Created an index variable. Then put that in as a control. We see that single people are less happy. Regression models don't have arrows. It's not in the Bayesian network; that's what the DAG does. `a[2]` is married individuals. Positive `mu`. The slope is solidly negative. But this is a spurious correlation by conditioning on a collider. </p>
</div>



<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L06/26.png" alt="We know that happiness doesn't change and doesn't decline with age, because that's how we coded it. But if we stratify by marriage status, it does. Each point is a person. Each year 20 individuals are born. Happiness is uniformly distributed and constant. Blue filled are married. Starting early on the blue points are only at the top. But over time, indiviuals who are less happy will also get married. By 65, most of the population in the simulation is married." width="80%" />
<p class="caption">We know that happiness doesn't change and doesn't decline with age, because that's how we coded it. But if we stratify by marriage status, it does. Each point is a person. Each year 20 individuals are born. Happiness is uniformly distributed and constant. Blue filled are married. Starting early on the blue points are only at the top. But over time, indiviuals who are less happy will also get married. By 65, most of the population in the simulation is married.</p>
</div>

 

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L06/27.png" alt="Now if we draw regression lines, we can see there's a negative correlation. But the distribution of happiness has not changed for anybody." width="80%" />
<p class="caption">Now if we draw regression lines, we can see there's a negative correlation. But the distribution of happiness has not changed for anybody.</p>
</div>


<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L06/28.png" alt="If we condition on it, we allow information to flow from age to happiness. In reality we don't know, so we need to use information external to the data. " width="80%" />
<p class="caption">If we condition on it, we allow information to flow from age to happiness. In reality we don't know, so we need to use information external to the data. </p>
</div>

***6.3.2. The haunted DAG***

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L06/29.png" alt="Another example. Colliders are so powerful they can even occur when you haven't measured the confounder. In my subfield, we're interested in allopaternal effects. What is the material benefit of having grandparents? There are resource and information flows, so we want to figure out how important they are. How do you figure this out empirically? Say you have triads, and you're looking at educational outcomes. Indirect path through P, say through books. But also a potential direct effects during say babysitting. But regressions can show that grandparents have a negative effect?" width="80%" />
<p class="caption">Another example. Colliders are so powerful they can even occur when you haven't measured the confounder. In my subfield, we're interested in allopaternal effects. What is the material benefit of having grandparents? There are resource and information flows, so we want to figure out how important they are. How do you figure this out empirically? Say you have triads, and you're looking at educational outcomes. Indirect path through P, say through books. But also a potential direct effects during say babysitting. But regressions can show that grandparents have a negative effect?</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L06/30.png" alt="It's plausible that parents and children share unobserved confounds. Whenever you do observational studies, there are `U`s all over the place. e.g. the neighbourhood you live in. School and neighbourhood effects are really powerful. Makes parents into a collider. So if we condition on parents, it becomes a collider. " width="80%" />
<p class="caption">It's plausible that parents and children share unobserved confounds. Whenever you do observational studies, there are `U`s all over the place. e.g. the neighbourhood you live in. School and neighbourhood effects are really powerful. Makes parents into a collider. So if we condition on parents, it becomes a collider. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L06/31.png" alt="So we simulate this. Assuming that the direct path is 0." width="80%" />
<p class="caption">So we simulate this. Assuming that the direct path is 0.</p>
</div>


```r
N <- 200 # number of grandparent-parent-child triads
b_GP <- 1 # direct effect of G on P
b_GC <- 0 # direct effect of G on C
b_PC <- 1 # direct effect of P on C
b_U <- 2 # direct effect of U on P and C
```


```r
set.seed(1)
U <- 2*rbern( N , 0.5 ) - 1
G <- rnorm( N )
P <- rnorm( N , b_GP*G + b_U*U )
C <- rnorm( N , b_PC*P + b_GC*G + b_U*U )
d <- data.frame( C=C , P=P , G=G , U=U )
```


<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L06/32.png" alt="We end up concluding that grandparents hurt their kids. How does this work? Conditioning on a collider opens a path. It's closed by default. This oepns a path from G through U to see, which creates a spurious correlation." width="80%" />
<p class="caption">We end up concluding that grandparents hurt their kids. How does this work? Conditioning on a collider opens a path. It's closed by default. This oepns a path from G through U to see, which creates a spurious correlation.</p>
</div>


```r
m6.11 <- quap(
  alist(
    C ~ dnorm( mu , sigma ),
    mu <- a + b_PC*P + b_GC*G,
    a ~ dnorm( 0 , 1 ),
    c(b_PC,b_GC) ~ dnorm( 0 , 1 ),
    sigma ~ dexp( 1 )
  ), data=d )
precis(m6.11)
```

```
##             mean         sd       5.5%       94.5%
## a     -0.1174752 0.09919574 -0.2760091  0.04105877
## b_PC   1.7868915 0.04455355  1.7156863  1.85809664
## b_GC  -0.8389537 0.10614045 -1.0085867 -0.66932077
## sigma  1.4094891 0.07011139  1.2974375  1.52154063
```


<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L06/33.png" alt="One way to think about this is on the left we have good neighbourhoods in blue. All filled in points are where the parents are in a particular stratum. Why is it negative? Focus only on parents in the narrow range of educational outcomes. Parents in the good neighbourhoods, to be within this range, they must have had less educated grandparents. There are two ways to become a highly-educated parent. Either you are in a good neighbourhood, or you had an educated parent yourself. Each end the P box. " width="80%" />
<p class="caption">One way to think about this is on the left we have good neighbourhoods in blue. All filled in points are where the parents are in a particular stratum. Why is it negative? Focus only on parents in the narrow range of educational outcomes. Parents in the good neighbourhoods, to be within this range, they must have had less educated grandparents. There are two ways to become a highly-educated parent. Either you are in a good neighbourhood, or you had an educated parent yourself. Each end the P box. </p>
</div>

What can we do about this? We have to measure $U$:


```r
m6.12 <- quap(
  alist(
    C ~ dnorm( mu , sigma ),
    mu <- a + b_PC*P + b_GC*G + b_U*U,
    a ~ dnorm( 0 , 1 ) ,
    c(b_PC,b_GC,b_U) ~ dnorm( 0 , 1 ),
    sigma ~ dexp( 1 )
  ), data=d )
precis(m6.12)
```

```
##              mean         sd       5.5%        94.5%
## a     -0.12197510 0.07192588 -0.2369265 -0.007023655
## b_PC   1.01161103 0.06597258  0.9061741  1.117047948
## b_GC  -0.04081373 0.09728716 -0.1962974  0.114669941
## b_U    1.99648992 0.14770462  1.7604294  2.232550439
## sigma  1.01959911 0.05080176  0.9384081  1.100790130
```

And those are the slopes we simulated with.

## Confronting confounding

***6.4.1. Shutting the backdoor***

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L06/34.png" alt="The back door criterion is that you want to figure out the true causal impact on some outcome, you need to shut all backdoor paths from the treatment to the outcome. We have to shut that arrow off to infer a true causal effect. In experiments you shut all the backdoor paths by randomising. But in observational studies, you want some set of criteria for what variables you should include to shut the paths." width="80%" />
<p class="caption">The back door criterion is that you want to figure out the true causal impact on some outcome, you need to shut all backdoor paths from the treatment to the outcome. We have to shut that arrow off to infer a true causal effect. In experiments you shut all the backdoor paths by randomising. But in observational studies, you want some set of criteria for what variables you should include to shut the paths.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L06/35.png" alt="These are the only ways that variables interact in these graphs. " width="80%" />
<p class="caption">These are the only ways that variables interact in these graphs. </p>
</div>

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L06/36.png" width="80%" />

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L06/37.png" width="80%" />


```r
slides_dir = here::here("docs/slides/L07")
```

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L07/01.png" width="80%" />


<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L07/02.png" alt="You can solve causal inference by assuming the DAG is true. There is a framework that unites all these examples: the **back-door criterion**. We need to shut all the back door paths into the exposure. There are only really three different ways they can meet in the DAG." width="80%" />
<p class="caption">You can solve causal inference by assuming the DAG is true. There is a framework that unites all these examples: the **back-door criterion**. We need to shut all the back door paths into the exposure. There are only really three different ways they can meet in the DAG.</p>
</div>


<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L07/03.png" alt="Break the fork by conditioning on Z. Block the pipe by conditioning on Z. The collider only opens the path if you condition on it. Conditioning on a descendant of a collider is like conditioning on a collider, depending on how strong the relationship is. " width="80%" />
<p class="caption">Break the fork by conditioning on Z. Block the pipe by conditioning on Z. The collider only opens the path if you condition on it. Conditioning on a descendant of a collider is like conditioning on a collider, depending on how strong the relationship is. </p>
</div>



<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L07/04.png" alt="The classic confound involves some exposure $E$. A lot of research goes into understanding what the returns on education are. There are a lot of confounds $U$. How do we de-confound this DAG using the back-door criterion? $E \leftarrow  U \rightarrow W$. How to shut this? It's a fork, and you close it by conditioning on $U$. But here it's unobserved, so we can't condition on it. You therefore can't get an unbiased estimate. But that's an achievement, because we've wasted less time. " width="80%" />
<p class="caption">The classic confound involves some exposure $E$. A lot of research goes into understanding what the returns on education are. There are a lot of confounds $U$. How do we de-confound this DAG using the back-door criterion? $E \leftarrow  U \rightarrow W$. How to shut this? It's a fork, and you close it by conditioning on $U$. But here it's unobserved, so we can't condition on it. You therefore can't get an unbiased estimate. But that's an achievement, because we've wasted less time. </p>
</div>


<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L07/05.png" alt="If we want to estimate the direct causal influence from grandparents to kids, we see there are three paths from G to C. If we condition on $P$, that closes the second path through parents. Since that's a pipe, you condition on parents, but that opens the other path, because they're a collider between grandparents and unobserved neighbourhood effects. So we can't get a valid estimate unless we measure it. This is happy news, because we know we're being fooled." width="80%" />
<p class="caption">If we want to estimate the direct causal influence from grandparents to kids, we see there are three paths from G to C. If we condition on $P$, that closes the second path through parents. Since that's a pipe, you condition on parents, but that opens the other path, because they're a collider between grandparents and unobserved neighbourhood effects. So we can't get a valid estimate unless we measure it. This is happy news, because we know we're being fooled.</p>
</div>


<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L07/06.png" alt="We want to know the causal effect of $X$ on $Y$. We have an unobserved cause of $X$, then three covariates. What do you need to condition on, and what should you absolutely not condition on? The backdoor criterion is sufficient to figure it out. Find each backdoor path, and figure out which ones to open and close. Just three paths." width="80%" />
<p class="caption">We want to know the causal effect of $X$ on $Y$. We have an unobserved cause of $X$, then three covariates. What do you need to condition on, and what should you absolutely not condition on? The backdoor criterion is sufficient to figure it out. Find each backdoor path, and figure out which ones to open and close. Just three paths.</p>
</div>

Can get `dagitty` to do it for us:


```r
library(dagitty)
dag_6.1 <- dagitty( "dag {
  U [unobserved]
  X -> Y
  X <- U <- A -> C -> Y
  U -> B <- C
}")
adjustmentSets( dag_6.1 , exposure="X" , outcome="Y" )
```

```
## { C }
## { A }
```

Conditioning on either $C$ or $A$ would suffice. Conditioning on $C$ is the better idea, from the perspective of efficiency, since it could also help with the precision of the estimate of $X \rightarrow Y$. 

Now consider the second path, passing through $B$. This path does contain a collider, $U → B ← C$ It is therefore already closed, which is why `adjustmentSets` did not mention $B$.


<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L07/07.png" alt="What should we prefer between A or C? Just pick the one that's measured better. By the way, you need both good estimation, and a causal framework. Both are necessary." width="80%" />
<p class="caption">What should we prefer between A or C? Just pick the one that's measured better. By the way, you need both good estimation, and a causal framework. Both are necessary.</p>
</div>

***6.4.3. Backdoor waffles***

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L07/08.png" alt="Statistical assocation between Waffle Houses and divorce rate. What do we need to control for to remove spurious causation? Same elemental confounds as before. Backdoor into Waffle Houses through South. What do we have to do to estimate the causal impact of Waffles? Come out the backdoor of Waffle House, and find all the paths to get to D. It's sufficient to condition on A and M too. But it's sufficient to just condition on S." width="80%" />
<p class="caption">Statistical assocation between Waffle Houses and divorce rate. What do we need to control for to remove spurious causation? Same elemental confounds as before. Backdoor into Waffle Houses through South. What do we have to do to estimate the causal impact of Waffles? Come out the backdoor of Waffle House, and find all the paths to get to D. It's sufficient to condition on A and M too. But it's sufficient to just condition on S.</p>
</div>


```r
library(dagitty)
dag_6.2 <- dagitty( "dag {
  A -> D
  A -> M -> D
  A <- S -> M
  S -> W -> D
}")
adjustmentSets( dag_6.2 , exposure="W", outcome="D" )
```

```
## { A, M }
## { S }
```


<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L07/09.png" width="80%" />



<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L07/10.png" alt="Good news. There are a number of packages where you give them the DAG, and then you can get it to algorithmically tell you things about the DAG. You can test your DAG, bu inspecting the implied conditional dependencies. The causal structure implies that some things are independent on others. A and W should have no correlation after conditioning on S. It's a fork from S. Parts of the DAG may be wrong. It's a good lesson that the answers require the data, but aren't in the data." width="80%" />
<p class="caption">Good news. There are a number of packages where you give them the DAG, and then you can get it to algorithmically tell you things about the DAG. You can test your DAG, bu inspecting the implied conditional dependencies. The causal structure implies that some things are independent on others. A and W should have no correlation after conditioning on S. It's a fork from S. Parts of the DAG may be wrong. It's a good lesson that the answers require the data, but aren't in the data.</p>
</div>


```r
impliedConditionalIndependencies( dag_6.2 )
```

```
## A _||_ W | S
## D _||_ S | A, M, W
## M _||_ W | S
```


<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L07/11.png" alt="Hume did more to sort out causal inference than any other thinker. The whole approach of causal inference is Humian. We ahven't solved the problem, but he'd be proud of what we've built. It shows that experiments aren't necessary. We don't need them if we can close the backdoor paths. Often experiments in the human sciences are either impractical or unethical or both. Lots of progress can come from observational studies. Also, interventions influence many variables at once. e.g. experimentally manipulate obsesity. Choosing exercise or diet will affect what you're observing. Huge advantage of observational studies." width="80%" />
<p class="caption">Hume did more to sort out causal inference than any other thinker. The whole approach of causal inference is Humian. We ahven't solved the problem, but he'd be proud of what we've built. It shows that experiments aren't necessary. We don't need them if we can close the backdoor paths. Often experiments in the human sciences are either impractical or unethical or both. Lots of progress can come from observational studies. Also, interventions influence many variables at once. e.g. experimentally manipulate obsesity. Choosing exercise or diet will affect what you're observing. Huge advantage of observational studies.</p>
</div>



<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L07/12.png" alt="The first alternative uses the existence of a mediator to remove a cofound between an exposure and an outcome. The second is used a lot in behavioural genetics and economics. We'll learn how to use these." width="80%" />
<p class="caption">The first alternative uses the existence of a mediator to remove a cofound between an exposure and an outcome. The second is used a lot in behavioural genetics and economics. We'll learn how to use these.</p>
</div>



<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L07/13.png" alt="Shouldn't get cocky. DAGs are heuristic models. Still a lot of residual confounding. You can put measurement error into a DAG. We'll get there near the end. This is important if you're say an anthropologist, half your measurements are error. Phylogenetic trees: big nest of error. Last is that you shouldn't let DAGs stop you from making a real causal model. Physicists don't need DAGs because they have real models, with causal implications. That's what you want to drive towards." width="80%" />
<p class="caption">Shouldn't get cocky. DAGs are heuristic models. Still a lot of residual confounding. You can put measurement error into a DAG. We'll get there near the end. This is important if you're say an anthropologist, half your measurements are error. Phylogenetic trees: big nest of error. Last is that you shouldn't let DAGs stop you from making a real causal model. Physicists don't need DAGs because they have real models, with causal implications. That's what you want to drive towards.</p>
</div>

## Summary

>Multiple regression is no oracle, but only a golem. It is logical, but the relationships it describes are conditional associations, not causal influences. Therefore additional information, from outside the model, is needed to make sense of it. This chapter presented introductory examples of some common frustrations: multicollinearity, post-treatment bias, and collider bias. Solutions to these frustrations can be organized under a coherent framework in which hypothetical causal relations among variables are analyzed to cope with confounding. In all cases, causal models exist outside the statistical model and can be difficult to test. However, it is possible to reach valid causal inferences in the absence of experiments. This is good news, because we often cannot perform experiments, both for practical and ethical reasons.

## Practice

6E1.  List three mechanisms by which multiple regression can produce false inferences about causal effects.

* Multicollinearity
* Post-treatment bias
* Collider bias


