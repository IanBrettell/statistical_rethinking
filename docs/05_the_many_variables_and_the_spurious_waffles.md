---
title: "Notes for Statistical Rethinking 2nd ed. by Richard McElreath"
date: '2021-05-31'
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
##    toc_float: true
#    dev: 'svg'
##    number_sections: true
#    pandoc_args: --lua-filter=color-text.lua
#    highlight: pygments
#    link-citations: yes
---

# The Many Variables & The Spurious Waffles


```r
library(here)
source(here::here("code/scripts/source.R"))
```


```r
slides_dir = here::here("docs/slides/L05")
```

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L05/01.png" width="80%" />

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L05/02.png" alt="Went to College in Atlanta. Has Waffle Houses. Always open. Sometimes there are two Waffle Houses. Other things in the South include Hurricanes." width="80%" />
<p class="caption">Went to College in Atlanta. Has Waffle Houses. Always open. Sometimes there are two Waffle Houses. Other things in the South include Hurricanes.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L05/03.png" alt="Because Waffle House is in the South, they invest in disaster preparedness, and even during a storm they stay open." width="80%" />
<p class="caption">Because Waffle House is in the South, they invest in disaster preparedness, and even during a storm they stay open.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L05/04.png" alt="They even have a Waffle House index. If it's closed, it's a really bad storm. FEMA uses the index internally at FEMA." width="80%" />
<p class="caption">They even have a Waffle House index. If it's closed, it's a really bad storm. FEMA uses the index internally at FEMA.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L05/05.png" alt="There are other things in the South. They have the highest divorce rates in the South. This sets up spurious correlations with anything in the South. So does Waffle House cause divorce? But in regression it's quite robust. Statistically, it's quite hard to get rid of it. But nature is full of stuff like this." width="80%" />
<p class="caption">There are other things in the South. They have the highest divorce rates in the South. This sets up spurious correlations with anything in the South. So does Waffle House cause divorce? But in regression it's quite robust. Statistically, it's quite hard to get rid of it. But nature is full of stuff like this.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L05/06.png" alt="Correlation is commonplace. Great example of the divorce rate in Maine with the per capita consumption of margarine. Lot's of things will cause a high correlation between variables, even if they have to relation." width="80%" />
<p class="caption">Correlation is commonplace. Great example of the divorce rate in Maine with the per capita consumption of margarine. Lot's of things will cause a high correlation between variables, even if they have to relation.</p>
</div>



<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L05/07.png" alt="Have the goal of both building it up and breaking it down. Can remove spurious correlations, and uncover masked associations you wouldn't see otheriwse. But adding variables can cause as much harm as good. You can actually hide associations as well. So you need a broader structure to think about this. " width="80%" />
<p class="caption">Have the goal of both building it up and breaking it down. Can remove spurious correlations, and uncover masked associations you wouldn't see otheriwse. But adding variables can cause as much harm as good. You can actually hide associations as well. So you need a broader structure to think about this. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L05/08.png" alt="Making decisions between good and bad will mean forming a framework to make them. The goal is to learn the back-door criterion. Waffle House doesn't cause divorce, but something does. The South is more religious. Lot's of things that are correlated with divorce rate. Marriage rate? Can't get divorce if you haven't been married, but could also be spurious. Might indicate that it's a society that views things favourably. " width="80%" />
<p class="caption">Making decisions between good and bad will mean forming a framework to make them. The goal is to learn the back-door criterion. Waffle House doesn't cause divorce, but something does. The South is more religious. Lot's of things that are correlated with divorce rate. Marriage rate? Can't get divorce if you haven't been married, but could also be spurious. Might indicate that it's a society that views things favourably. </p>
</div>

## Spurious association

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L05/09.png" alt="Another variable - median age at marriage, could also be causal. Which could it be? We want to now put both in the same model, which reveals that one of these is an imposter." width="80%" />
<p class="caption">Another variable - median age at marriage, could also be causal. Which could it be? We want to now put both in the same model, which reveals that one of these is an imposter.</p>
</div>


```r
# load data
data("WaffleDivorce")
d = WaffleDivorce

# Standardise variables
d$D = rethinking::standardize( d$Divorce )
d$M = rethinking::standardize( d$Marriage)
d$A = rethinking::standardize( d$MedianAgeMarriage)
```




<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L05/10.png" alt="This is what multiple regression is for. We've got two questions in a model that has both questions. Do you get any predictive information from the second variable? " width="80%" />
<p class="caption">This is what multiple regression is for. We've got two questions in a model that has both questions. Do you get any predictive information from the second variable? </p>
</div>


<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L05/11.png" alt="The arrows have directions to them; can be bidirectional. They're acyclic, so they don't loop. They're called graphs because they have nodes and edges. The associations are Bayesian networks, but they don't have interactions." width="80%" />
<p class="caption">The arrows have directions to them; can be bidirectional. They're acyclic, so they don't loop. They're called graphs because they have nodes and edges. The associations are Bayesian networks, but they don't have interactions.</p>
</div>



<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L05/12.png" alt="We have here a plausible graph. How does A affect M? If the young are getting married too, then more people are getting married. Median age of marriage influences divorce rate because possibly young people make worse decisions. Is the arrow from M to D there? We want to tell the difference between A and D, and M and D. **NOTE**: when you're walking along the path, you can walk backwards along a path. " width="80%" />
<p class="caption">We have here a plausible graph. How does A affect M? If the young are getting married too, then more people are getting married. Median age of marriage influences divorce rate because possibly young people make worse decisions. Is the arrow from M to D there? We want to tell the difference between A and D, and M and D. **NOTE**: when you're walking along the path, you can walk backwards along a path. </p>
</div>


<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L05/13.png" alt="We want to tell the difference between these two things. Something causes waffle house, and something causes divorce. That thing is the South, and so they end up being correlated even though there's no causal relationship." width="80%" />
<p class="caption">We want to tell the difference between these two things. Something causes waffle house, and something causes divorce. That thing is the South, and so they end up being correlated even though there's no causal relationship.</p>
</div>

`|` means "conditional on".


<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L05/14.png" alt="Already know how to do these, just need to do extra stuff. Linear regression is a special type of Bayesian network where there's an outcome variable, which is assigned Gaussian probability with some mean that is conditional based on some variable, and a standard deviation. The `i`s are states. Have some intercepts. " width="80%" />
<p class="caption">Already know how to do these, just need to do extra stuff. Linear regression is a special type of Bayesian network where there's an outcome variable, which is assigned Gaussian probability with some mean that is conditional based on some variable, and a standard deviation. The `i`s are states. Have some intercepts. </p>
</div>


<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L05/15.png" alt="Have to think harder about priors now. It help a lot by standardising the priors - converting them into Z-scores. If you make all your variables z-scores, you make you life easier. (But not in all cases.) " width="80%" />
<p class="caption">Have to think harder about priors now. It help a lot by standardising the priors - converting them into Z-scores. If you make all your variables z-scores, you make you life easier. (But not in all cases.) </p>
</div>


```marginfigure
When you standardise your predictors, you're setting your mean as 0. The regression line has to go through 0, and so alpha should be 0, We'll give it a Gaussian prior with a tight SD. Maybe should even be tighter. 

Slopes are a little harder. You don't want to use flat priors because you don't want it to think wildly impossible slopes are possible to start. That's why we do some prior predictive simulation.
```

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L05/16.png" alt="You can fit your model. You can run that model. `extract.prior` samples from the prior to simulate. Then pass it to `link` to create predictions based on the prior. Then you can plot the regression lines. " width="80%" />
<p class="caption">You can fit your model. You can run that model. `extract.prior` samples from the prior to simulate. Then pass it to `link` to create predictions based on the prior. Then you can plot the regression lines. </p>
</div>
If $\beta_A = 1$, that would imply that a change of one standard deviation in age at marriage is assocatied with a change of one standard deviation in divorce.

To know if that's strong, how big is a standard deviation of age at marriage?


```r
sd( d$MedianAgeMarriage )
```

```
## [1] 1.24363
```



```r
m5.1 = rethinking::quap(
  alist(
    D ~ dnorm( mu , sigma ) ,
    mu <- a + bA * A ,
    a ~ dnorm( 0 , 0.2 ) ,
    bA ~ dnorm( 0 , 0.5 ) ,
    sigma ~ dexp( 1 )
  ) , data = d )
```


<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L05/17.png" alt="This is 50 regression lines from the prior. Standardised deviation of marriage. 2 SD is almost all. If your model thinks a possible divorce rate is outside the observable range of divorce rates, then they're bad. This prior allows really strong relationships. Allows it to govern nearly all the variation in divorce rate. But we'll move forward with this. This is the flattest prior you could justify scientifically. Priors by frequentists consider even crazier priors, just as vertical lines." width="80%" />
<p class="caption">This is 50 regression lines from the prior. Standardised deviation of marriage. 2 SD is almost all. If your model thinks a possible divorce rate is outside the observable range of divorce rates, then they're bad. This prior allows really strong relationships. Allows it to govern nearly all the variation in divorce rate. But we'll move forward with this. This is the flattest prior you could justify scientifically. Priors by frequentists consider even crazier priors, just as vertical lines.</p>
</div>


```r
set.seed(10)
prior = rethinking::extract.prior( m5.1 )
mu <- rethinking::link( m5.1 , 
            post=prior , 
            data=list( A=c(-2,2) ) )

plot( NULL , xlim=c(-2,2) , ylim=c(-2,2) )
for ( i in 1:50 ) lines( c(-2,2) , mu[i,] , col=col.alpha("black",0.4) )
```

<img src="05_the_many_variables_and_the_spurious_waffles_files/figure-html/5.4-1.svg" width="672" />

Now for the posterior predictions:


```r
# compute percentile interval of mean
A_seq = seq( from=-3 , to=3.2 , length.out=30 )
mu = link( m5.1 , data=list(A=A_seq) )
mu.mean = apply( mu , 2, mean )
mu.PI = apply( mu , 2 , PI )

# plot it all
plot( D ~ A , data=d , col=rangi2 )
lines( A_seq , mu.mean , lwd=2 )
shade( mu.PI , A_seq )
```

<img src="05_the_many_variables_and_the_spurious_waffles_files/figure-html/5.5-1.svg" width="672" />
$\beta_A$ is reliably negative. You can fit a similar regression for the relationship in the left-hand plot:


```r
m5.2 <- rethinking::quap(
  alist(
    D ~ dnorm( mu , sigma ) ,
    mu <- a + bM * M ,
    a ~ dnorm( 0 , 0.2 ) ,
    bM ~ dnorm( 0 , 0.5 ) ,
    sigma ~ dexp( 1 )
  ) , data = d )
```

Drawing a DAG


```r
dag5.1 <- dagitty::dagitty( "dag{ A -> D; A -> M; M -> D }" )
dagitty::coordinates(dag5.1) <- list( x=c(A=0,D=1,M=2) , y=c(A=0,D=1,M=0) )
rethinking::drawdag( dag5.1 )
```

<img src="05_the_many_variables_and_the_spurious_waffles_files/figure-html/5.7-1.svg" width="672" />

***5.1.2 Testable implications***


```r
DMA_dag2 <- dagitty('dag{ D <- A -> M }')
impliedConditionalIndependencies( DMA_dag2 )
```

```
## D _||_ M | A
```


```r
DMA_dag1 <- dagitty('dag{ D <- A -> M -> D }')
impliedConditionalIndependencies( DMA_dag1 )
```

No conditional independencies, so no output.

***5.1.3 Multiple regression notation***

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L05/18.png" alt="Linear means additive, so the model makes a plane. You keep adding them together. There are four parameters. $\alpha$, two slopes $\beta_1$ and $\beta_2$, and the standard deviation $\sigma$." width="80%" />
<p class="caption">Linear means additive, so the model makes a plane. You keep adding them together. There are four parameters. $\alpha$, two slopes $\beta_1$ and $\beta_2$, and the standard deviation $\sigma$.</p>
</div>

***5.1.4 Approximating the posterior***


```r
m5.3 <- quap(
  alist(
    D ~ dnorm( mu , sigma ) ,
    mu <- a + bM*M + bA*A ,
    a ~ dnorm( 0 , 0.2 ) ,
    bM ~ dnorm( 0 , 0.5 ) ,
    bA ~ dnorm( 0 , 0.5 ) ,
    sigma ~ dexp( 1 )
  ) , data = d )
precis( m5.3 )
```

```
##                mean         sd       5.5%      94.5%
## a     -2.828642e-05 0.09707123 -0.1551669  0.1551103
## bM    -6.553086e-02 0.15076312 -0.3064794  0.1754177
## bA    -6.136370e-01 0.15097351 -0.8549218 -0.3723521
## sigma  7.850672e-01 0.07783076  0.6606786  0.9094558
```



<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L05/19.png" width="80%" />
Here's the quap code, and we get a table of coefficients. Look for the mean, and as I promised, $\alpha$ is 0. ``bM` is about twice the size of the posterior value itself. No consistent relationship. Age of marriage however, is -.6, but now the posterior mass is entirely below 0. What's the lesson here? There's probably no causal relationship between marriage rate and divorce, and that's because it was confounded by age of marriage. 


<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L05/20.png" alt="This shows all three models. Bottom is age of marriage only. The one with marriage rates in the middle. Then marriage rate and and age of marriage in the bottom." width="80%" />
<p class="caption">This shows all three models. Bottom is age of marriage only. The one with marriage rates in the middle. Then marriage rate and and age of marriage in the bottom.</p>
</div>


```r
# Faulty code
#plot( rethinking::coeftab(m5.1,m5.2,m5.3), par=c("bA","bM") )
```

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L05/21.png" alt="This is the graph. Once you know the median age of marriage, you get little extra information in marriage. But when you ad A, it does give you information. If you just wanted to make a prediction, M is useful, but if you wanted to change D, you need to change other things like A." width="80%" />
<p class="caption">This is the graph. Once you know the median age of marriage, you get little extra information in marriage. But when you ad A, it does give you information. If you just wanted to make a prediction, M is useful, but if you wanted to change D, you need to change other things like A.</p>
</div>


You have to be clear about whether you're interesting in predicting things, or understanding the true nature of things. 


<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L05/22.png" alt="How do we visualise models like this? Lots of ways. Usually the most useful way to visualise depends on the model. You want to think about what you're trying to communicate. The first are predictor residual plots, not that you need to do them, but good for understanding how these linear regressions works." width="80%" />
<p class="caption">How do we visualise models like this? Lots of ways. Usually the most useful way to visualise depends on the model. You want to think about what you're trying to communicate. The first are predictor residual plots, not that you need to do them, but good for understanding how these linear regressions works.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L05/23.png" alt="Purpose is to show how the association looks, having controlled for the other predictors. We want to calculate the intermediate states. Great for intuition but terrible for analysis. Never any statistical justification for running regression over residuals. Why? Gives you the wrong answer, because it gives you bias estimates. What to do instead? Multiple regressions." width="80%" />
<p class="caption">Purpose is to show how the association looks, having controlled for the other predictors. We want to calculate the intermediate states. Great for intuition but terrible for analysis. Never any statistical justification for running regression over residuals. Why? Gives you the wrong answer, because it gives you bias estimates. What to do instead? Multiple regressions.</p>
</div>

Recipe:

1. Regress a predictor, and find the extra variance left over, and look at the pattern of the relationship between the residuals and the outcome.


<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L05/24.png" alt="Here's our first residual plot" width="80%" />
<p class="caption">Here's our first residual plot</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L05/25.png" alt="What are we looking at here? Marriage rate, standardised. THe distance from the regression line - the expected value of M conditional on A, is the residual. THe unexplained bit from the model. Highlighted some states with high residuals. Now we'll take the absolute distances for each point." width="80%" />
<p class="caption">What are we looking at here? Marriage rate, standardised. THe distance from the regression line - the expected value of M conditional on A, is the residual. THe unexplained bit from the model. Highlighted some states with high residuals. Now we'll take the absolute distances for each point.</p>
</div>


<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L05/26.png" alt="Now take those residuals, and look at the correlation between the residuals of M and D. And you can see nothing. Shows you what the model is doing inside. If you do the multiple regresssion all at once, it handles all of that. If you do it this way you don't. But really good for intuition. Point of Maine with a really high divorce rate. " width="80%" />
<p class="caption">Now take those residuals, and look at the correlation between the residuals of M and D. And you can see nothing. Shows you what the model is doing inside. If you do the multiple regresssion all at once, it handles all of that. If you do it this way you don't. But really good for intuition. Point of Maine with a really high divorce rate. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L05/27.png" alt="Still no explanation about why ME is so high. Now you can pivot A on M. " width="80%" />
<p class="caption">Still no explanation about why ME is so high. Now you can pivot A on M. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L05/28.png" alt="Then put those on the plot on the bottom. So now that you know M, there's considerable information in also knowing A. But the reverse is not true. " width="80%" />
<p class="caption">Then put those on the plot on the bottom. So now that you know M, there's considerable information in also knowing A. But the reverse is not true. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L05/29.png" alt="This is one of the things we mean. In observational studies like this one, there's no ethical intervention we can make. But we want to make causal information. Linear regression allows you to do that, but only if you have an idea of the causal relationship between the variables. To interpret, you need a causal framework. We'll have an example latter when controlling can *create* a confound." width="80%" />
<p class="caption">This is one of the things we mean. In observational studies like this one, there's no ethical intervention we can make. But we want to make causal information. Linear regression allows you to do that, but only if you have an idea of the causal relationship between the variables. To interpret, you need a causal framework. We'll have an example latter when controlling can *create* a confound.</p>
</div>


```marginfigure
These models are not magic. You shouldn't get cocky. This is the kind of study where you use average data. Quite a pathological dataset.
```

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L05/30.png" alt="Cases where you hold other predictor variables constant. All the code for generating them is in the text. In the real world we can't do that. If we're right in our DAG here, and we manipulate A, you'll also manipulate M as well. " width="80%" />
<p class="caption">Cases where you hold other predictor variables constant. All the code for generating them is in the text. In the real world we can't do that. If we're right in our DAG here, and we manipulate A, you'll also manipulate M as well. </p>
</div>

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L05/31.png" width="80%" />

Goals:
1. Figure out whether the approximation of the posterior works. Compare the predictions with the raw data. If they're different, they fail. 
2. It can inspire you to look at the cases that don't fit well, and figure out what you need to make better causal inferences.

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L05/32.png" alt="Diagonal is unity - perfect prediction. But there are states where they're making bad predictions, like ID. Has a very low D. That's why there's a mismatch. It's getting it really wrong. Why? The Mormons. They have a very low divorce rate. UT as well." width="80%" />
<p class="caption">Diagonal is unity - perfect prediction. But there are states where they're making bad predictions, like ID. Has a very low D. That's why there's a mismatch. It's getting it really wrong. Why? The Mormons. They have a very low divorce rate. UT as well.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L05/33.png" alt="Another good thing regression can do is reveal spurious correlations. When there are two predictors that both influence the outcome in different directions, you can get the total causal effect between the two. This tends to arise where you have two predictors, and they act in different directions, and cancel each other out, so if you don't model both of them individually, it looks like they have no effect. " width="80%" />
<p class="caption">Another good thing regression can do is reveal spurious correlations. When there are two predictors that both influence the outcome in different directions, you can get the total causal effect between the two. This tends to arise where you have two predictors, and they act in different directions, and cancel each other out, so if you don't model both of them individually, it looks like they have no effect. </p>
</div>


```marginfigure
Noise can also cause you not to see a relationship.
```

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L05/34.png" alt="Relationship between milk energy and how brainy they are? Intersted in things that are interested in what makes us unique. Primates are mammals, and some mammals have very highly energetic milk, like seals basically ooze butter. Primates in contrast carry their offspring on them. As a consequence, the energy density is lower. Human milk is not energetically rich. 75% of our brain mass is neocortex. Then the brainiest primate is *Cebus*. Can we see a signal of selection on milk energy from braininess?" width="80%" />
<p class="caption">Relationship between milk energy and how brainy they are? Intersted in things that are interested in what makes us unique. Primates are mammals, and some mammals have very highly energetic milk, like seals basically ooze butter. Primates in contrast carry their offspring on them. As a consequence, the energy density is lower. Human milk is not energetically rich. 75% of our brain mass is neocortex. Then the brainiest primate is *Cebus*. Can we see a signal of selection on milk energy from braininess?</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L05/35.png" alt="Sample of primate species. Pairs plot. Particularly strong correlation between the magnitude of body mass (log(mass)) is strongly correlated with neocortex. No particular strong relationship between `log(mass)` and `kcal.per.g`." width="80%" />
<p class="caption">Sample of primate species. Pairs plot. Particularly strong correlation between the magnitude of body mass (log(mass)) is strongly correlated with neocortex. No particular strong relationship between `log(mass)` and `kcal.per.g`.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L05/36.png" alt="We need to do some prior predictive simulation. Left is not a good prior. All we need to do to get the regression lines to live in the outcome space, we can contract $lpha$ - should be about 0, and the slope should be about 0.5 to be tighter. If you standardise the predictor and outcome, Normal(0, 0.5) should keep you in the outcome space." width="80%" />
<p class="caption">We need to do some prior predictive simulation. Left is not a good prior. All we need to do to get the regression lines to live in the outcome space, we can contract $lpha$ - should be about 0, and the slope should be about 0.5 to be tighter. If you standardise the predictor and outcome, Normal(0, 0.5) should keep you in the outcome space.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L05/37.png" alt="There's a slight relationship between brain and milk energy, and a slightly negative relationship with body mass. Look what happens when you include both in a model." width="80%" />
<p class="caption">There's a slight relationship between brain and milk energy, and a slightly negative relationship with body mass. Look what happens when you include both in a model.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L05/38.png" alt="Now very strong relationship between both." width="80%" />
<p class="caption">Now very strong relationship between both.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L05/39.png" alt="You can see strong relationships, but only when they're both present in the model. This is the masking effect. One is positively related to the outcome, the other is negatively related to the outcome, and they're correlated with one another. Bigger primates need bigger brains, bigger brains need more energy, bigger bodies need less because they're are longer developmental times. THey're antagonistic effects, but correlated in same species. This sort of effect can happen a lot. " width="80%" />
<p class="caption">You can see strong relationships, but only when they're both present in the model. This is the masking effect. One is positively related to the outcome, the other is negatively related to the outcome, and they're correlated with one another. Bigger primates need bigger brains, bigger brains need more energy, bigger bodies need less because they're are longer developmental times. THey're antagonistic effects, but correlated in same species. This sort of effect can happen a lot. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L05/40.png" alt="Fake data that causes this relationship. `U` is unobserved, some life history variable. Then the causal influence on each of those. This relationship is sufficient to create what we saw." width="80%" />
<p class="caption">Fake data that causes this relationship. `U` is unobserved, some life history variable. Then the causal influence on each of those. This relationship is sufficient to create what we saw.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L05/41.png" alt="Often we have data that represents discrete categories. Want to include those, but they're not continuous. Useful variables because the mean varies, but can't add them as they are" width="80%" />
<p class="caption">Often we have data that represents discrete categories. Want to include those, but they're not continuous. Useful variables because the mean varies, but can't add them as they are</p>
</div>


```marginfigure
First is to create a dummy, and the next is almost always superior, and that's the index. 
```

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L05/42.png" alt="Take a categorical variable and convert them to indicator variables. They stand in for something. e.g. Kalahari height data, `0` means not `male`. " width="80%" />
<p class="caption">Take a categorical variable and convert them to indicator variables. They stand in for something. e.g. Kalahari height data, `0` means not `male`. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L05/43.png" alt="Height varies by sex, so you could include it in the model. The linear model looks like a continuous predictor, because you've coded it as 0 and 1, if effectively turns the parameter off and on, and adjusts the mean. Effectively makes two intercepts, one male, one female. `alpha` is the intercept for females, and `alpha + betaM` is the intercept for males. " width="80%" />
<p class="caption">Height varies by sex, so you could include it in the model. The linear model looks like a continuous predictor, because you've coded it as 0 and 1, if effectively turns the parameter off and on, and adjusts the mean. Effectively makes two intercepts, one male, one female. `alpha` is the intercept for females, and `alpha + betaM` is the intercept for males. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L05/44.png" alt="Have to pick same number of priors for number of categories. Consequence is you end up assuming that one of the categories is less certain than all the others." width="80%" />
<p class="caption">Have to pick same number of priors for number of categories. Consequence is you end up assuming that one of the categories is less certain than all the others.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L05/45.png" alt="This is the better option." width="80%" />
<p class="caption">This is the better option.</p>
</div>

-------


```r
slides_dir = here::here("docs/slides/L06")
```

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L06/01.png" width="80%" />

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L06/02.png" alt="Pick up where we left off. How to include un-ordered categorical data in a regression? A lot of downsides for using dummy variables. Index variables have a lot of advantages, including that you can assign the same priors to each of the categories. Another reason is that when you get more and more categories, you don't have to change anything other than include more numbers in the index. Grows really nicely, and is the foundation of multi-level models." width="80%" />
<p class="caption">Pick up where we left off. How to include un-ordered categorical data in a regression? A lot of downsides for using dummy variables. Index variables have a lot of advantages, including that you can assign the same priors to each of the categories. Another reason is that when you get more and more categories, you don't have to change anything other than include more numbers in the index. Grows really nicely, and is the foundation of multi-level models.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L06/03.png" alt="Can code this in `quap`. The bracket notation means `a` for each `sex`. Now you see you get an alpha for each sex. The awkwardness is you need to make inferences." width="80%" />
<p class="caption">Can code this in `quap`. The bracket notation means `a` for each `sex`. Now you see you get an alpha for each sex. The awkwardness is you need to make inferences.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L06/04.png" alt="If you want the posterior distribution for the sexes, you extract samples from the posterior. Then compute the difference by subtracting the difference from each sample. Still it in a column called `diff_fm`. Posterior mean is -8. All the comparisons are already in the posterior, you just have to extract samples to compute them. We'll be using this kind of coding in future examples." width="80%" />
<p class="caption">If you want the posterior distribution for the sexes, you extract samples from the posterior. Then compute the difference by subtracting the difference from each sample. Still it in a column called `diff_fm`. Posterior mean is -8. All the comparisons are already in the posterior, you just have to extract samples to compute them. We'll be using this kind of coding in future examples.</p>
</div>
