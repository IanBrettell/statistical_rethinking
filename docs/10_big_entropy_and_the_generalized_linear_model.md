---
title: "Notes for Statistical Rethinking 2nd ed. by Richard McElreath"
date: '2021-07-02'
#output: html_notebook
editor_options: 
  chunk_output_type: inline
#output:
#  bookdown::tufte_html_book:
#    toc: yes
#    css: toc.css
#    pandoc_args: --lua-filter=color-text.lua
#    highlight: pygments
#    link-citations: yes
---

# Big Entropy and the Generalized Linear Model


```r
library(here)
source(here::here("code/scripts/source.R"))
```


```r
slides_dir = here::here("docs/slides/L11")
```


<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L11/01.png" alt="We'll move conceptually at a slow rate, which will set up a bunch of different models for this week and next." width="80%" />
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
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L11/02.png" alt="Imagine you have buckets equidistant from you. At your feet you have 100 pebbles, each painted with a number. Unique pebbles. " width="80%" />
<p class="caption">Imagine you have buckets equidistant from you. At your feet you have 100 pebbles, each painted with a number. Unique pebbles. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L11/03.png" alt="What happens when we toss pebbles one at a time into the buckets at random. Eventually all 100 pebbles end up in the buckets, and you count them, and you get a distribution of pebbles. What types of distributions are really common, and what types are really rare?" width="80%" />
<p class="caption">What happens when we toss pebbles one at a time into the buckets at random. Eventually all 100 pebbles end up in the buckets, and you count them, and you get a distribution of pebbles. What types of distributions are really common, and what types are really rare?</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L11/04.png" alt="Think about extreme distributions first. There's only 1 way to get all 100 pebbles in bucket 1. " width="80%" />
<p class="caption">Think about extreme distributions first. There's only 1 way to get all 100 pebbles in bucket 1. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L11/05.png" alt="Same with bucket 5. So there are 5 unique distributions with all pebbles in a single bucket." width="80%" />
<p class="caption">Same with bucket 5. So there are 5 unique distributions with all pebbles in a single bucket.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L11/06.png" alt="There are a bunch of distributions that will happen in a bunch of different ways. We could take a pebble from bucket 2 and swap it with one from bucket 3. How many ways could you get the same distribution. This very problem is the basis of Bayesian inference. Some distributions can arise in many more ways. It's a principle called Maximum Entropy, and it justifies Bayesian inference." width="80%" />
<p class="caption">There are a bunch of distributions that will happen in a bunch of different ways. We could take a pebble from bucket 2 and swap it with one from bucket 3. How many ways could you get the same distribution. This very problem is the basis of Bayesian inference. Some distributions can arise in many more ways. It's a principle called Maximum Entropy, and it justifies Bayesian inference.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L11/07.png" alt="We can replace the integers with $n$s. In some point, you learned that there's a formula for the number of arrangements of the pebbles." width="80%" />
<p class="caption">We can replace the integers with $n$s. In some point, you learned that there's a formula for the number of arrangements of the pebbles.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L11/08.png" alt="This is called the multiplicity. It's the foundation of statistical inference. It gets big really fast when the Ns get equal. " width="80%" />
<p class="caption">This is called the multiplicity. It's the foundation of statistical inference. It gets big really fast when the Ns get equal. </p>
</div>

Let’s put each distribution of pebbles in a list:


```r
p <- list()
p$A <- c(0,0,10,0,0)
p$B <- c(0,1,8,1,0)
p$C <- c(0,2,6,2,0)
p$D <- c(1,2,4,2,1)
p$E <- c(2,2,2,2,2)
```

And let’s normalize each such that it is a probability distribution. 


```r
p_norm <- lapply( p , function(q) q/sum(q))
```

Since these are now probability distributions, we can compute the information entropy of each


```r
( H <- sapply( p_norm , function(q) -sum(ifelse(q==0,0,q*log(q))) ) )
```

```
##         A         B         C         D         E 
## 0.0000000 0.6390319 0.9502705 1.4708085 1.6094379
```

So distribution E, which can realized by far the greatest number of ways, also has the biggest entropy.


<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L11/09.png" alt="Only one way to get all the pebbles in bucket 3. " width="80%" />
<p class="caption">Only one way to get all the pebbles in bucket 3. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L11/10.png" alt="How many ways to get the second distribution?" width="80%" />
<p class="caption">How many ways to get the second distribution?</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L11/11.png" alt="It's massively bigger. This will accelerate. People have really bad intuitions regarding combinatorics." width="80%" />
<p class="caption">It's massively bigger. This will accelerate. People have really bad intuitions regarding combinatorics.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L11/12.png" alt="Now we've got two in bucket 2. Now we're getting an order of magnitude increase." width="80%" />
<p class="caption">Now we've got two in bucket 2. Now we're getting an order of magnitude increase.</p>
</div>

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L11/13.png" width="80%" />

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L11/14.png" width="80%" />

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L11/15.png" width="80%" />

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L11/16.png" alt="General principle: Distributions that are flat can happen in many many more ways. And this is why we bet on them. They have high entropy. Flat distributions are closer, less surprised when the distribution turns out to be different. Then become really good foundations for statistical inference, because they distribute the possibilities as widely as possible." width="80%" />
<p class="caption">General principle: Distributions that are flat can happen in many many more ways. And this is why we bet on them. They have high entropy. Flat distributions are closer, less surprised when the distribution turns out to be different. Then become really good foundations for statistical inference, because they distribute the possibilities as widely as possible.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L11/17.png" alt="This is a unique way to derive the formula. It's nothing more than the multiplicity. W is the multiplicity (number of ways to get the N). Then we've normalised it across the number of the pebbles. And that turns out to be a good approximation. Information entropy is just the logarithm of the number of ways to realise a distribution. And it's maximised when the distribution is flat. And flatter distributions have higher entropy." width="80%" />
<p class="caption">This is a unique way to derive the formula. It's nothing more than the multiplicity. W is the multiplicity (number of ways to get the N). Then we've normalised it across the number of the pebbles. And that turns out to be a good approximation. Information entropy is just the logarithm of the number of ways to realise a distribution. And it's maximised when the distribution is flat. And flatter distributions have higher entropy.</p>
</div>

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L11/18.png" width="80%" />

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L11/19.png" alt="Most centrally associated with Jaynes. If you choose any other distribution to characterise your state of knowledge, you will be implicitly adding other information into your distribution. So if you lay out all the constraints, then solve for the distribution that's as flat as possible under those constraints, you do the best you possibly can. You're honestly characterising your ignorance." width="80%" />
<p class="caption">Most centrally associated with Jaynes. If you choose any other distribution to characterise your state of knowledge, you will be implicitly adding other information into your distribution. So if you lay out all the constraints, then solve for the distribution that's as flat as possible under those constraints, you do the best you possibly can. You're honestly characterising your ignorance.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L11/20.png" alt="Lots of conceptual examples for. What is the information content of a prior distribution? It turns out that Bayesian updating is a special case of this principle. You can input the data as constraints, and you get the posterior distribution by solving the maximum entropy problem. High entropy is good because the distance from the truth is smaller. One way to thing about it is it's deflationary. No matter what happens, and even distrubtion is bound to arise. We put in a tiny sliver of scientific information in our model, and the rest we just bet on entropy." width="80%" />
<p class="caption">Lots of conceptual examples for. What is the information content of a prior distribution? It turns out that Bayesian updating is a special case of this principle. You can input the data as constraints, and you get the posterior distribution by solving the maximum entropy problem. High entropy is good because the distance from the truth is smaller. One way to thing about it is it's deflationary. No matter what happens, and even distrubtion is bound to arise. We put in a tiny sliver of scientific information in our model, and the rest we just bet on entropy.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L11/21.png" alt="Motivates forward to other distributions. If we're going to maximise this function, if all the $p$s are equal, they're highest. Sometimes there are constrants that prevent us from making the $p$s equal. What kind of constraints? Known mean or variance." width="80%" />
<p class="caption">Motivates forward to other distributions. If we're going to maximise this function, if all the $p$s are equal, they're highest. Sometimes there are constrants that prevent us from making the $p$s equal. What kind of constraints? Known mean or variance.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L11/22.png" alt="This is actually what we did in Week 1. Shows that it's just counting. " width="80%" />
<p class="caption">This is actually what we did in Week 1. Shows that it's just counting. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L11/23.png" alt="Under some set of constraints, the distributions we use are maximum entropy distributions. Exponential distributions used for scale. They have a very clear maxent constraint. If a parameter is non-negative real, and has some mean value, then the exponential contains only that information." width="80%" />
<p class="caption">Under some set of constraints, the distributions we use are maximum entropy distributions. Exponential distributions used for scale. They have a very clear maxent constraint. If a parameter is non-negative real, and has some mean value, then the exponential contains only that information.</p>
</div>

***10.1.1. Gaussian***

To appreciate why the Gaussian shape has the biggest entropy for any continuous distribution with this variance, consider that entropy increases as we make a distribution flatter. So we could easily make up a probability distribution with larger entropy than the blue distribution in Figure 10.2: Just take probability from the center and put it in the tails. The more uniform the distribution looks, the higher its entropy will be. But there are limits on how much of this we can do and maintain the same variance, $\sigma^2 = 1$.

Then the Gaussian distribution gets its shape by being as spread out as possible for a distribution with fixed variance.

***10.1.2. Binomial***


```r
# build list of the candidate distributions
p <- list()
p[[1]] <- c(1/4,1/4,1/4,1/4)
p[[2]] <- c(2/6,1/6,1/6,2/6)
p[[3]] <- c(1/6,2/6,2/6,1/6)
p[[4]] <- c(1/8,4/8,2/8,1/8)

# compute expected value of each
sapply( p , function(p) sum(p*c(0,1,1,2)) )
```

```
## [1] 1 1 1 1
```

Compute the entropy of each distribution:


```r
# compute entropy of each distribution
sapply( p , function(p) -sum( p*log(p) ) )
```

```
## [1] 1.386294 1.329661 1.329661 1.213008
```

The binomial with this expected value is:


```r
p <- 0.7
( A <- c( (1-p)^2 , p*(1-p) , (1-p)*p , p^2 ) )
```

```
## [1] 0.09 0.21 0.21 0.49
```

This distribution is definitely not flat. So to appreciate how this distribution has maximum entropy—is the flattest distribution with expected value 1.4—we’ll simulate a bunch of distributions with the same expected value and then compare entropies. The entropy of the distribution above is just:


```r
-sum( A*log(A) )
```

```
## [1] 1.221729
```

So if we randomly generate thousands of distributions with expected value 1.4, we expect that none will have a larger entropy than this.

We can use a short R function to simulate random probability distributions that have any specified expected value. The code below will do the job. Don’t worry about how it works (unless you want to).


```r
sim.p <- function(G=1.4) {
  x123 <- runif(3)
  x4 <- ( (G)*sum(x123)-x123[2]-x123[3] )/(2-G)
  z <- sum( c(x123,x4) )
  p <- c( x123 , x4 )/z
  list( H=-sum( p*log(p) ) , p=p )
}
```


```r
H <- replicate( 1e5 , sim.p(1.4) )
dens( as.numeric(H[1,]) , adj=0.1 )
```

<img src="10_big_entropy_and_the_generalized_linear_model_files/figure-html/10.10-1.png" width="672" />

Let’s split out the entropies and distributions, so that it’s easier to work with them:


```r
entropies <- as.numeric(H[1,])
distributions <- H[2,]
```


<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L11/24.png" alt="Larger family of geocentric linear models. We want to connect a linear model to a mean to the distribution. Unreasonably effective given how geocentric it is. We pick an outcome distribution, then model the parameters using weird things called links, whcih link the distribution to some model. Can do all kinds of fancy things with the same basic strategy. Often if you don't want to play this game, when you write it down, it'll turn out to be a linear model anyway. In most cases, you probably want a GLM." width="80%" />
<p class="caption">Larger family of geocentric linear models. We want to connect a linear model to a mean to the distribution. Unreasonably effective given how geocentric it is. We pick an outcome distribution, then model the parameters using weird things called links, whcih link the distribution to some model. Can do all kinds of fancy things with the same basic strategy. Often if you don't want to play this game, when you write it down, it'll turn out to be a linear model anyway. In most cases, you probably want a GLM.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L11/25.png" alt="Distributions arise from natural processes. And resist histomancy. This doesn't make sense under any framework. You want to use knowledge of your constraints to figure it out. There's no statistical framework where the aggregate outcomes is going to have any particular distribution." width="80%" />
<p class="caption">Distributions arise from natural processes. And resist histomancy. This doesn't make sense under any framework. You want to use knowledge of your constraints to figure it out. There's no statistical framework where the aggregate outcomes is going to have any particular distribution.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L11/26.png" alt="Going to build GLMs with these different outcome distributions. Just an extension of what you've already been doing. Exponential is everyone's favourite because it only has 1 parameter. Lambda is a rate, and the mean is 1/lambda. Generatively it can arise from a machine with a number of parts. If one part breaks, the whole thing stops working. A fruit fly is the same. Bunch of parts inside the washing machine, and each part has a chance of breaking at a particular time, the waiting time until the washing machine stops is exponentially distributed. " width="80%" />
<p class="caption">Going to build GLMs with these different outcome distributions. Just an extension of what you've already been doing. Exponential is everyone's favourite because it only has 1 parameter. Lambda is a rate, and the mean is 1/lambda. Generatively it can arise from a machine with a number of parts. If one part breaks, the whole thing stops working. A fruit fly is the same. Bunch of parts inside the washing machine, and each part has a chance of breaking at a particular time, the waiting time until the washing machine stops is exponentially distributed. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L11/27.png" alt="If you count events arising from exponential distributions. Mortality rates of fruit flies is bionimal. Like coin flips. Each fly could or could not ascend. And the binomial is maxent. " width="80%" />
<p class="caption">If you count events arising from exponential distributions. Mortality rates of fruit flies is bionimal. Like coin flips. Each fly could or could not ascend. And the binomial is maxent. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L11/28.png" alt="Poisson. Two ways of thinking about it. If you have a binomially distributed variable, but the probabiity of success is low and there are lots of flies oserved over a long time. " width="80%" />
<p class="caption">Poisson. Two ways of thinking about it. If you have a binomially distributed variable, but the probabiity of success is low and there are lots of flies oserved over a long time. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L11/29.png" alt="If you think about the time to the event of the exponential - how long did you wait until the washing machine broke, if you start adding up that time, those waiting times are distributed like Gamma. Also maxent. e.g. age of onset of cancer, perhaps because there are a lot of cellular defence mechanisms, and all of them need to fail. " width="80%" />
<p class="caption">If you think about the time to the event of the exponential - how long did you wait until the washing machine broke, if you start adding up that time, those waiting times are distributed like Gamma. Also maxent. e.g. age of onset of cancer, perhaps because there are a lot of cellular defence mechanisms, and all of them need to fail. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L11/30.png" alt="If you get a Gamma with a really large mean, it converges to a Normal. But not the only way - all roads lead to normal. And it's hard to leave. So these are generative processes, based on the constraints. Doesn't mean that they're correct, but it's the betting part." width="80%" />
<p class="caption">If you get a Gamma with a really large mean, it converges to a Normal. But not the only way - all roads lead to normal. And it's hard to leave. So these are generative processes, based on the constraints. Doesn't mean that they're correct, but it's the betting part.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L11/31.png" alt="Tide prediction engine. When we get to GLMs, the metaphor is very potent. It's a mechinical computer, and a part of it is the prediction of times, and then there's messy stuff at the bottom that's calculating the output. You're absolutely wedded to the prediction perspective. Hard to have intuition about the parameters. You want to understand the prediction space, and you understand the parameters by observing their effects on prediction." width="80%" />
<p class="caption">Tide prediction engine. When we get to GLMs, the metaphor is very potent. It's a mechinical computer, and a part of it is the prediction of times, and then there's messy stuff at the bottom that's calculating the output. You're absolutely wedded to the prediction perspective. Hard to have intuition about the parameters. You want to understand the prediction space, and you understand the parameters by observing their effects on prediction.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L11/32.png" alt="Just need to think about before the data have arrived, you know things about the outcome variable. e.g. count variables are integers starting at 0, so there are no negative counts. So from the beginning you know things about them. That constrains the distributions before they arrive. Next week we'll move onto monsters because we glue together different models using links. Likhert scales are ordinal scales, but they're not numeric. What it takes to get from 1 to 2 might be different from what it takes to go from 2 to 3. Fight monsters by making monsters. Mixture models are super useful. Bear a lot of resemblance to multi-level models." width="80%" />
<p class="caption">Just need to think about before the data have arrived, you know things about the outcome variable. e.g. count variables are integers starting at 0, so there are no negative counts. So from the beginning you know things about them. That constrains the distributions before they arrive. Next week we'll move onto monsters because we glue together different models using links. Likhert scales are ordinal scales, but they're not numeric. What it takes to get from 1 to 2 might be different from what it takes to go from 2 to 3. Fight monsters by making monsters. Mixture models are super useful. Bear a lot of resemblance to multi-level models.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L11/33.png" alt="Consider the Gaussian linear regression. It's super benign, and that's because it has a special property: the scientific measurement units and the parameter for the mean are the same. " width="80%" />
<p class="caption">Consider the Gaussian linear regression. It's super benign, and that's because it has a special property: the scientific measurement units and the parameter for the mean are the same. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L11/34.png" alt="The much more typical case is the binomial model. If you want to connect a linear model to $p$, it's a probability. Probability is unitless. They're divided out. But the outcome has counts. So now the units aren't the same, and we need something that connects the parameter to the outcome scale. We need some function to put in wehre the question mark is so that it obeys physics." width="80%" />
<p class="caption">The much more typical case is the binomial model. If you want to connect a linear model to $p$, it's a probability. Probability is unitless. They're divided out. But the outcome has counts. So now the units aren't the same, and we need something that connects the parameter to the outcome scale. We need some function to put in wehre the question mark is so that it obeys physics.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L11/35.png" alt="We're going to wrap $p$ in some function which constraitns it. say there's some function we can apply to the probability so that it's linear in the outcome scale." width="80%" />
<p class="caption">We're going to wrap $p$ in some function which constraitns it. say there's some function we can apply to the probability so that it's linear in the outcome scale.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L11/36.png" alt="Searching is hearder. OLS can be used, but can be fragile. We're just going to use MCMC because we don't want to worry about it." width="80%" />
<p class="caption">Searching is hearder. OLS can be used, but can be fragile. We're just going to use MCMC because we don't want to worry about it.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L11/37.png" alt="One of the fun things is that suddenly all the varibles automatically interact with each others. Imagine you're trying to understand the habitat preferences of a reptile. If it gets really cold, probability of surivival is low, but hot they're fine. On the porobability scale, evenutally things get cold enough that you're dead no matter what. If any one varible will kill the lizxard, it doesn't matter what the other variables are doing. That's an interaction. No matter how much food you give it, it's going to die if it's really cold. You want your model to do this." width="80%" />
<p class="caption">One of the fun things is that suddenly all the varibles automatically interact with each others. Imagine you're trying to understand the habitat preferences of a reptile. If it gets really cold, probability of surivival is low, but hot they're fine. On the porobability scale, evenutally things get cold enough that you're dead no matter what. If any one varible will kill the lizxard, it doesn't matter what the other variables are doing. That's an interaction. No matter how much food you give it, it's going to die if it's really cold. You want your model to do this.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L11/38.png" alt="If you like to think about the rate of change in a linear regression, you take a partial slope. Do this with any GLM, and the chain rule kicks in. And you get a much less nice expression. In a logistic regression, that's the equation. If you take the partial derivative, you get this thing in teh right That's the rate of change. " width="80%" />
<p class="caption">If you like to think about the rate of change in a linear regression, you take a partial slope. Do this with any GLM, and the chain rule kicks in. And you get a much less nice expression. In a logistic regression, that's the equation. If you take the partial derivative, you get this thing in teh right That's the rate of change. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L11/39.png" alt="Let's move into doing some good work. We'll model some counts of events. What the Bionimal distriibution for? Counts of success out of trials. There's some constant expected value condtioinal on a set of predictor variables. Under those conditions the maxent distribution is binomial. " width="80%" />
<p class="caption">Let's move into doing some good work. We'll model some counts of events. What the Bionimal distriibution for? Counts of success out of trials. There's some constant expected value condtioinal on a set of predictor variables. Under those conditions the maxent distribution is binomial. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L11/40.png" alt="The expected value is $np$. Note the variance is related to the expected value. In general, the Guassian is the only distrubiton where the mean and the variance are independent. With all others, if the mean gets big, so does the variance. " width="80%" />
<p class="caption">The expected value is $np$. Note the variance is related to the expected value. In general, the Guassian is the only distrubiton where the mean and the variance are independent. With all others, if the mean gets big, so does the variance. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L11/41.png" alt="So we're going to plug a linear model and attach it to $p$." width="80%" />
<p class="caption">So we're going to plug a linear model and attach it to $p$.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L11/42.png" alt="On the horizontal I have some predictor $x$. What are the log odds? The log of $p$. " width="80%" />
<p class="caption">On the horizontal I have some predictor $x$. What are the log odds? The log of $p$. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L11/43.png" alt="If you do this, there's a really nice mapping onto the probability scale, where x is linear on the log odds scale, and constrained to the (0,1) internval on teh probability scale. This arises from the maxent derivation of the binomial distribution. In machine learnign they call it the maxent classifier." width="80%" />
<p class="caption">If you do this, there's a really nice mapping onto the probability scale, where x is linear on the log odds scale, and constrained to the (0,1) internval on teh probability scale. This arises from the maxent derivation of the binomial distribution. In machine learnign they call it the maxent classifier.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L11/44.png" alt="Logit means 'log odds'. $p$ is the probaility scale.  " width="80%" />
<p class="caption">Logit means 'log odds'. $p$ is the probaility scale.  </p>
</div>

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L11/45.png" width="80%" />

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L11/46.png" width="80%" />

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L11/47.png" width="80%" />

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L11/48.png" alt="It really is just log odds. If you measure stuff in odds, you can measure things really well. Log odds are just the log of the odds. That's linear. How do you get back to the linear scale? Solve for $p$. " width="80%" />
<p class="caption">It really is just log odds. If you measure stuff in odds, you can measure things really well. Log odds are just the log of the odds. That's linear. How do you get back to the linear scale? Solve for $p$. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L11/49.png" alt="This is the conventional way to link, because it has lots of good mathematical properties." width="80%" />
<p class="caption">This is the conventional way to link, because it has lots of good mathematical properties.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L11/50.png" alt="For intuition, you want to relate the two scales. Horizontal is probability. Vertical is log-odds. Log odds 0 is equal chance. There's this compression effect, so you need some scale. Log odds of -1 is 1/4. This is really important for defining priors. " width="80%" />
<p class="caption">For intuition, you want to relate the two scales. Horizontal is probability. Vertical is log-odds. Log odds 0 is equal chance. There's this compression effect, so you need some scale. Log odds of -1 is 1/4. This is really important for defining priors. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L11/51.png" alt="We use this thing because its the natural link within the probability formula. It arises naturally in the derivation of the distribution. Big and legitimate links. If you have a scientific model, you can derive the link automatically. " width="80%" />
<p class="caption">We use this thing because its the natural link within the probability formula. It arises naturally in the derivation of the distribution. Big and legitimate links. If you have a scientific model, you can derive the link automatically. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L11/52.png" alt="Example dataset. Imagien you're a chimp on the close side. If you pull a lever, it's expand out on both sides. There may or may not be food in both trays. If you pull the right, they other chimp will get the snack too. Interested in whetehr chimps care about this distinction. It's not enough to do the experiment. They might pull the right because there's more food there. One of the treatments is to remove the partner from the other end. Also chimpanzees are handed, so you have to adjust for that. BUt you want to know the differnce - do they pulll the prosocial option more if there's a chimp on the other end. " width="80%" />
<p class="caption">Example dataset. Imagien you're a chimp on the close side. If you pull a lever, it's expand out on both sides. There may or may not be food in both trays. If you pull the right, they other chimp will get the snack too. Interested in whetehr chimps care about this distinction. It's not enough to do the experiment. They might pull the right because there's more food there. One of the treatments is to remove the partner from the other end. Also chimpanzees are handed, so you have to adjust for that. BUt you want to know the differnce - do they pulll the prosocial option more if there's a chimp on the other end. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L11/53.png" alt="Alone with no other chimp. Prosocial and asocial option is balanced across left and right. We want to predict the outcome as a function of the condition -the total treatment. " width="80%" />
<p class="caption">Alone with no other chimp. Prosocial and asocial option is balanced across left and right. We want to predict the outcome as a function of the condition -the total treatment. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L11/54.png" alt="Four possible distinct unordered treatments. Wnat to estimate the tendency to pull the lever. The linear model on teh left is the Binomial. $lpha$ measures handedness. Then we have a vector of four $\beta$ parameters$, one for each treatment. Note that the Bernoullli is just the Binomial with one trial." width="80%" />
<p class="caption">Four possible distinct unordered treatments. Wnat to estimate the tendency to pull the lever. The linear model on teh left is the Binomial. $lpha$ measures handedness. Then we have a vector of four $\beta$ parameters$, one for each treatment. Note that the Bernoullli is just the Binomial with one trial.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L11/55.png" alt="How to do priors? They behave in GLMs in very unpredictable ways. So need to do prior simulation. Let's consider a skeletal verison of Bionmal regression where the linear model is some alpha, some intercept, the average log odds across all trials. What kind of prior to set on that. Let's set a Gaussian. Centered on a half. But what about the scale? What happens when you pick $\omega$." width="80%" />
<p class="caption">How to do priors? They behave in GLMs in very unpredictable ways. So need to do prior simulation. Let's consider a skeletal verison of Bionmal regression where the linear model is some alpha, some intercept, the average log odds across all trials. What kind of prior to set on that. Let's set a Gaussian. Centered on a half. But what about the scale? What happens when you pick $\omega$.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L11/56.png" alt="Let's try with $''omega = 10$. " width="80%" />
<p class="caption">Let's try with $''omega = 10$. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L11/57.png" alt="What happens is we have the prior proabability scale. THe black density curve is the prior hwere you assign alpha the normal 0,10. Because a Gaussian distribution has huge amount of mass beyond absolute 3. Most of the mass is outside the extremes. Because the range of the log-odds scale is -4,4. So when you change it to the probabilty scale, it puts a lot of probability in the tails. We can adopt this heuritsitc postiion of having something flat, which is normal with omega of 1.5" width="80%" />
<p class="caption">What happens is we have the prior proabability scale. THe black density curve is the prior hwere you assign alpha the normal 0,10. Because a Gaussian distribution has huge amount of mass beyond absolute 3. Most of the mass is outside the extremes. Because the range of the log-odds scale is -4,4. So when you change it to the probabilty scale, it puts a lot of probability in the tails. We can adopt this heuritsitc postiion of having something flat, which is normal with omega of 1.5</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L11/58.png" alt="Next we'll talk about slopes." width="80%" />
<p class="caption">Next we'll talk about slopes.</p>
</div>

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L11/59.png" width="80%" />

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L11/60.png" width="80%" />

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L11/61.png" width="80%" />

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L11/62.png" width="80%" />

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L11/63.png" width="80%" />

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L11/64.png" width="80%" />

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L11/65.png" width="80%" />

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L11/66.png" width="80%" />

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L11/67.png" width="80%" />

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L11/68.png" width="80%" />

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L11/69.png" width="80%" />


