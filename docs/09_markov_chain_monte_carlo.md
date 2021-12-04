# Markov Chain Monte Carlo


```r
library(here)
source(here::here("code/scripts/source.R"))
```


```r
slides_dir = here::here("docs/slides/L10")
```

This chapter introduces one commonplace example of Fortuna and Minerva’s cooperation: the estimation of posterior probability distributions using a stochastic process known as MARKOV CHAIN MONTE CARLO (MCMC). Unlike earlier chapters in this book, here we’ll produce samples from the joint posterior without maximizing anything. Instead of having to lean on quadratic and other approximations of the shape of the posterior, now we’ll be able to sample directly from the posterior without assuming a Gaussian, or any other, shape.

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L10/01.png" alt="Major transition point where we switch over algorithms for estimating the posterior." width="80%" />
<p class="caption">Major transition point where we switch over algorithms for estimating the posterior.</p>
</div>

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L10/02.png" alt="As a reminder, Bayesian inference is not about how to get the posterior, it's just about the posterior distribution. There are a lot of ways to get it. In this case, you can calculate it a huge number of ways and they're all valid. In biology, Bayesian is thought of as synonymous with Markov Chains. But you can use Markov chains for lots of things. There's a bunch of additional machinery you need to fool around with when you play with Markov chains." width="80%" />
<p class="caption">As a reminder, Bayesian inference is not about how to get the posterior, it's just about the posterior distribution. There are a lot of ways to get it. In this case, you can calculate it a huge number of ways and they're all valid. In biology, Bayesian is thought of as synonymous with Markov Chains. But you can use Markov chains for lots of things. There's a bunch of additional machinery you need to fool around with when you play with Markov chains.</p>
</div>

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L10/03.png" alt="We'll discuss for ways to compute the posterior. The analytical approach was used to create the previous slide. Interesting models, but almost always impossible. So you need another way to do the numerical differentiation. Grid I showed you earlier. You've been using `quap` for months now. Unreasonably effective for lots of models. If you're doing maximum likelihood estimation, you're doing the same steps. There's a connection there between lots of standard tools. But now we're going to get into things that make the connection a lot blurrier." width="80%" />
<p class="caption">We'll discuss for ways to compute the posterior. The analytical approach was used to create the previous slide. Interesting models, but almost always impossible. So you need another way to do the numerical differentiation. Grid I showed you earlier. You've been using `quap` for months now. Unreasonably effective for lots of models. If you're doing maximum likelihood estimation, you're doing the same steps. There's a connection there between lots of standard tools. But now we're going to get into things that make the connection a lot blurrier.</p>
</div>

## Good King Markov and his island kingdom

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L10/04.png" alt="King Markov rules a bunch of islands." width="80%" />
<p class="caption">King Markov rules a bunch of islands.</p>
</div>

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L10/05.png" alt="There are 10, with different population sizes and densities." width="80%" />
<p class="caption">There are 10, with different population sizes and densities.</p>
</div>

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L10/06.png" alt="They'll let you tax them as long as you visit them. You must visit them in proportion to their population density. So you need some simple algorithm." width="80%" />
<p class="caption">They'll let you tax them as long as you visit them. You must visit them in proportion to their population density. So you need some simple algorithm.</p>
</div>

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L10/07.png" alt="You start on a particular island. Now you're ready to move to another one. You flip a coin to decide on which island." width="80%" />
<p class="caption">You start on a particular island. Now you're ready to move to another one. You flip a coin to decide on which island.</p>
</div>

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L10/08.png" alt="Then you send a servant across to the proposed island and they take a survey of how many people are on the island. You do the same for the island you're on. We'll call that $p_5$, and the current island $p_4$." width="80%" />
<p class="caption">Then you send a servant across to the proposed island and they take a survey of how many people are on the island. You do the same for the island you're on. We'll call that $p_5$, and the current island $p_4$.</p>
</div>

<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L10/09.png" width="80%" />

<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L10/10.png" width="80%" />

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L10/11.png" alt="You want to compare these two numbers in a particular way." width="80%" />
<p class="caption">You want to compare these two numbers in a particular way.</p>
</div>

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L10/12.png" alt="You want to take the ratio of them, and that will be the probability of accepting the proposal of moving from island 4 to 5. If it's greater than 1, you'll move. " width="80%" />
<p class="caption">You want to take the ratio of them, and that will be the probability of accepting the proposal of moving from island 4 to 5. If it's greater than 1, you'll move. </p>
</div>

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L10/13.png" alt="So you move to the proposal island with that probability." width="80%" />
<p class="caption">So you move to the proposal island with that probability.</p>
</div>

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L10/14.png" alt="This is a valid way to fill the contract. It guarantees that in the long run, you will visit each island in proportion to its relative populations size. This is an example of Markov Chain Monte Carlo." width="80%" />
<p class="caption">This is a valid way to fill the contract. It guarantees that in the long run, you will visit each island in proportion to its relative populations size. This is an example of Markov Chain Monte Carlo.</p>
</div>



<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L10/15.png" alt="It's the most famous, and the most primitive. The huge advantage is if you don't know the distribution of population sizes, you actually don't need to actually visit each of the islands in proportion to their population sizes. We don't know the posterior distribution, but we can visit each part of it in proportion to its relative probability. That's the magic: we can sample from the distribution that we don't know. Also going to introduce you to Stan. `ulam` is a simplified input that will make a custom Markov chain for you." width="80%" />
<p class="caption">It's the most famous, and the most primitive. The huge advantage is if you don't know the distribution of population sizes, you actually don't need to actually visit each of the islands in proportion to their population sizes. We don't know the posterior distribution, but we can visit each part of it in proportion to its relative probability. That's the magic: we can sample from the distribution that we don't know. Also going to introduce you to Stan. `ulam` is a simplified input that will make a custom Markov chain for you.</p>
</div>

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L10/16.png" alt="Here is the R script version of King Monty's royal tour. Metropolis was also a person. Let's walk through each line to get a sense of how simple it is. Positions is an empty vector. We'll store the islands the King is on here. Then we'll just put him on island 10 (`current`). Then we loop over the weeks, and record where the king is now. Then we'll flip a coin to generate the proposal. Finally there's the action. We've got the ratio, where we're asserting the relative popn size is the same as their number. " width="80%" />
<p class="caption">Here is the R script version of King Monty's royal tour. Metropolis was also a person. Let's walk through each line to get a sense of how simple it is. Positions is an empty vector. We'll store the islands the King is on here. Then we'll just put him on island 10 (`current`). Then we loop over the weeks, and record where the king is now. Then we'll flip a coin to generate the proposal. Finally there's the action. We've got the ratio, where we're asserting the relative popn size is the same as their number. </p>
</div>

Simulate it yourself:


```r
set.seed(9)

num_weeks <- 1e5
positions <- rep(0, num_weeks) 
current   <- 10

for (i in 1:num_weeks) {
  
  # record current position 
  positions[i] <- current
  # flip coin to generate proposal
  proposal <- current + sample(c(-1, 1), size = 1)
  # now make sure he loops around the archipelago 
  if (proposal < 1) proposal <- 10
  if (proposal > 10) proposal <- 1
  # move?
  prob_move <- proposal/current
  current <- ifelse(runif(1) < prob_move, proposal, current)
  
}  
```


```r
library(ggpomological)
pomological_palette <- ggpomological:::pomological_palette
```


<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L10/17.png" alt="Run that code and plot it out, and you'll get this. You can see the King zig-zagging around. You can see he gets stuck on densely populated islands. In the long run, it's in the right proportions." width="80%" />
<p class="caption">Run that code and plot it out, and you'll get this. You can see the King zig-zagging around. You can see he gets stuck on densely populated islands. In the long run, it's in the right proportions.</p>
</div>



```r
tibble(week   = 1:1e5,
       island = positions) %>%
  ggplot(aes(x = week, y = island)) +
  geom_point(shape = 1, color = pomological_palette[1]) +
  scale_x_continuous(breaks = seq(from = 0, to = 100, by = 20)) +
  scale_y_continuous(breaks = seq(from = 0, to = 10, by = 2)) +
  coord_cartesian(xlim = c(0, 100)) +
  labs(title = "Behold the Metropolis algorithm in action!",
       subtitle = "The dots show the king's path over the first 100 weeks.") +
  theme_pomological_fancy(base_family = "Marck Script")
```

```
## Warning: Font 'Marck Script' isn't in the extrafont font list (but it may still
## work). If recently installed, you can try running `extrafont::font_import()`. To
## install, visit: https://fonts.google.com/specimen/Marck+Script/
```

<img src="09_markov_chain_monte_carlo_files/figure-html/9.2-1.png" width="672" />


```r
tibble(week   = 1:1e5,
       island = positions) %>%
  mutate(island = factor(island)) %>%
  
  ggplot(aes(x = island)) +
  geom_bar(fill = pomological_palette[2]) +
  scale_y_continuous("number of weeks", expand = expansion(mult = c(0, 0.05))) +
  labs(title = "Old Metropolis shines in the long run.",
       subtitle = "Sure enough, the time the king spent on each island\nwas proportional to its population size.") +
  theme_pomological_fancy(base_family = "Marck Script")
```

```
## Warning: Font 'Marck Script' isn't in the extrafont font list (but it may still
## work). If recently installed, you can try running `extrafont::font_import()`. To
## install, visit: https://fonts.google.com/specimen/Marck+Script/
```

<img src="09_markov_chain_monte_carlo_files/figure-html/9.3-1.png" width="672" />

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L10/18.png" alt="Chain is more obvious here." width="80%" />
<p class="caption">Chain is more obvious here.</p>
</div>

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L10/19.png" alt="Starting to emerge that he's visiting 10 more. After 2000 weeks, we're almost there. Guaranteed to work in the long run. What the 'long run' means is controversial." width="80%" />
<p class="caption">Starting to emerge that he's visiting 10 more. After 2000 weeks, we're almost there. Guaranteed to work in the long run. What the 'long run' means is controversial.</p>
</div>

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L10/20.png" alt="Summary slide. Not sensitive to initial conditions. In this algorithm you need symmetric proposals... there are other algorithms without this condition, which improves them. " width="80%" />
<p class="caption">Summary slide. Not sensitive to initial conditions. In this algorithm you need symmetric proposals... there are other algorithms without this condition, which improves them. </p>
</div>

## Metropolis algorithm

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L10/21.png" alt="The population size is the posterior probability. This works no matter how many parameters you have, in the long run. The long run is really long if you have a lot of parameters. That's the snag." width="80%" />
<p class="caption">The population size is the posterior probability. This works no matter how many parameters you have, in the long run. The long run is really long if you have a lot of parameters. That's the snag.</p>
</div>

***9.2.1. Gibbs sampling***

Why would we want an algorithm that allows asymmetric proposals? One reason is that it makes it easier to handle parameters, like standard deviations, that have boundaries at zero. A better reason, however, is that it allows us to generate savvy proposals that explore the posterior distribution more efficiently. By “more efficiently,” I mean that we can acquire an equally good image of the posterior distribution in fewer steps.
The most common way to generate savvy proposals is a technique known as GIBBS SAMPLING.

***9.2.2. High-dimensional problems***


<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L10/22.png" alt="Here's the famous paper where they first implemented it. Some famous people here. Rosenbluth did most of the programming, and Teller figured out the memory. The fed the tape in with a bicycle wheel. This was all part of the Manhattan project - for making fusion bombs post-war. " width="80%" />
<p class="caption">Here's the famous paper where they first implemented it. Some famous people here. Rosenbluth did most of the programming, and Teller figured out the memory. The fed the tape in with a bicycle wheel. This was all part of the Manhattan project - for making fusion bombs post-war. </p>
</div>

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L10/23.png" alt="Metropolis in the foreground. MANIAC in the background. Currently a laptop can do billions of multiplications per second." width="80%" />
<p class="caption">Metropolis in the foreground. MANIAC in the background. Currently a laptop can do billions of multiplications per second.</p>
</div>

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L10/24.png" alt="What are Markov Chains? The Metropolis is the simplest verison. Named after Markov. What makes something a Markov chain only depends on where you are now, not where you've been. What matters is the current state. Great for computing because you don't need to store a bunch of numbers." width="80%" />
<p class="caption">What are Markov Chains? The Metropolis is the simplest verison. Named after Markov. What makes something a Markov chain only depends on where you are now, not where you've been. What matters is the current state. Great for computing because you don't need to store a bunch of numbers.</p>
</div>

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L10/25.png" alt="Sometimes you get a model that is to hard to integrate. Often with integrals you're guessing. Not like derivatives. Going in the other direction is much harder. Integrating is sometimes not practical. MCMC is just one of the methods of estimating it. Optimisation (like quap) often targets the wrong area of the distribution ('concentration of measure'). This is why everyone gives up on optimisation once you have more than 100 parameters. This is bread and butter sort of stuff in applied statistics. " width="80%" />
<p class="caption">Sometimes you get a model that is to hard to integrate. Often with integrals you're guessing. Not like derivatives. Going in the other direction is much harder. Integrating is sometimes not practical. MCMC is just one of the methods of estimating it. Optimisation (like quap) often targets the wrong area of the distribution ('concentration of measure'). This is why everyone gives up on optimisation once you have more than 100 parameters. This is bread and butter sort of stuff in applied statistics. </p>
</div>

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L10/26.png" alt="There are a bunch of different MCMC strategies. Hastings showed that you don't need symmetric proposals, which made them more efficient. Gibbs sampling is extremely efficient, but basically Metropolis. What they have in common is they guess and check. They make a proposal to move somewhere, check the posterior probability at that location, then decide to move. If you make dumb proposals, you won't move. The goal is to constantly move by making really smart proposals. Guess and checking gives you dumb proposals, so you need a completely different strategy: Hamiltonian. Really efficient and can make models with tens of thousands of parameters. Hamiltonians use a gradient. " width="80%" />
<p class="caption">There are a bunch of different MCMC strategies. Hastings showed that you don't need symmetric proposals, which made them more efficient. Gibbs sampling is extremely efficient, but basically Metropolis. What they have in common is they guess and check. They make a proposal to move somewhere, check the posterior probability at that location, then decide to move. If you make dumb proposals, you won't move. The goal is to constantly move by making really smart proposals. Guess and checking gives you dumb proposals, so you need a completely different strategy: Hamiltonian. Really efficient and can make models with tens of thousands of parameters. Hamiltonians use a gradient. </p>
</div>

<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L10/27.png" width="80%" />

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L10/28.png" alt="Simulation of the MC run. Red it stays, green is moves. It stacks the distribution as it moves. Metropolis works really well. The problem comes when the distribution is not as nice as a Gaussian hill." width="80%" />
<p class="caption">Simulation of the MC run. Red it stays, green is moves. It stacks the distribution as it moves. Metropolis works really well. The problem comes when the distribution is not as nice as a Gaussian hill.</p>
</div>

<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L10/29.png" width="80%" />

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L10/30.png" alt="... like a donut. In high-dimensional spaces, it gets concentrated into thin shells. Picture a hyper-donut. We must sample from it. And the Metropolialogrithm is really bad like that, because it makes a lot of proposals into dead space. You can see it's a donut, but it doesn't. Now the long run is very long indeed. It gets stuck in narrow regions. The basic problem is that the proposals don't know the shape of the distribution." width="80%" />
<p class="caption">... like a donut. In high-dimensional spaces, it gets concentrated into thin shells. Picture a hyper-donut. We must sample from it. And the Metropolialogrithm is really bad like that, because it makes a lot of proposals into dead space. You can see it's a donut, but it doesn't. Now the long run is very long indeed. It gets stuck in narrow regions. The basic problem is that the proposals don't know the shape of the distribution.</p>
</div>

As models become more complex and contain hundreds or thousands or tens of thousands of parameters, both Metropolis and Gibbs sampling become shockingly inefficient. The reason is that they tend to get stuck in small regions of the posterior for potentially a long time. The high number of parameters isn’t the problem so much as the fact that models with many parameters nearly always have regions of high correlation in the posterior. This means that two or more parameters are highly correlated with one another in the posterior samples. You’ve seen this before with, for example, the two legs example in Chapter 6. Why is this a problem? Because high correlation means a narrow ridge of high probability combinations, and both Metropolis and Gibbs make too many dumb proposals of where to go next. So they get stuck.

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L10/31.png" alt="You can tune it, but there's a really tight trade-off. On the left we start with the Markov chain. Filled circles are accepted. If you only consider points near you, you'll get more valid proposals, but you'll move really slow. If we lengthen, then we reject more. This is the fundamental trade-off. Really you can't win. Gibbs can do a little better. Butas soon as the dimensions increase, the problem eventually appears. The issue is guess and check." width="80%" />
<p class="caption">You can tune it, but there's a really tight trade-off. On the left we start with the Markov chain. Filled circles are accepted. If you only consider points near you, you'll get more valid proposals, but you'll move really slow. If we lengthen, then we reject more. This is the fundamental trade-off. Really you can't win. Gibbs can do a little better. Butas soon as the dimensions increase, the problem eventually appears. The issue is guess and check.</p>
</div>

## Hamiltonian Monte Carlo

>It appears to be a quite general principle that, whenever there is a randomized way of doing something, then there is a nonrandomized way that delivers better performance but requires more thought. —E. T. Jaynes

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L10/32.png" alt="So what do we do instead? This is a different process entirely. No guess and check. Instead, it runs a physics simulation. We'll represent our parameter state as a coordinate in some high-dimensional space. In more dimensions, you have some hyperspace. You're a particle in this space in some position. Then we'll flick you, and it'll cruise on some surface - the posterior distribution - and record where you stop, then do it again. Because it follows the curvature, it always makes good proposals because it doesn't go into bad areas. So there's no more guessing and checking, all proposals are good proposals." width="80%" />
<p class="caption">So what do we do instead? This is a different process entirely. No guess and check. Instead, it runs a physics simulation. We'll represent our parameter state as a coordinate in some high-dimensional space. In more dimensions, you have some hyperspace. You're a particle in this space in some position. Then we'll flick you, and it'll cruise on some surface - the posterior distribution - and record where you stop, then do it again. Because it follows the curvature, it always makes good proposals because it doesn't go into bad areas. So there's no more guessing and checking, all proposals are good proposals.</p>
</div>

***9.3.1. Another parable***

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L10/33.png" alt="Continuous urban smear. More living in the bottom. How to use this? Hamiltonian." width="80%" />
<p class="caption">Continuous urban smear. More living in the bottom. How to use this? Hamiltonian.</p>
</div>

<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L10/34.png" width="80%" />

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L10/35.png" alt="In the book, here's a simulation. Time on the horizontal. It's Gaussian. You take the log of a Gaussian and it's a parabola. So you start in the middle. But you need to know the contour." width="80%" />
<p class="caption">In the book, here's a simulation. Time on the horizontal. It's Gaussian. You take the log of a Gaussian and it's a parabola. So you start in the middle. But you need to know the contour.</p>
</div>

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L10/36.png" alt="Roll the marble and periodically stop and record the position. Over time you get position samples that are proportional to the shape, as if there is more probability in the bottom." width="80%" />
<p class="caption">Roll the marble and periodically stop and record the position. Over time you get position samples that are proportional to the shape, as if there is more probability in the bottom.</p>
</div>

<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L10/37.png" width="80%" />

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L10/38.png" alt="Again, 2D Gaussian hill. It's a bowl now. Flick the simulation and do the pass. Always ends up inside the bowl. What stops you from getting into the silly spots. Better living through physics." width="80%" />
<p class="caption">Again, 2D Gaussian hill. It's a bowl now. Flick the simulation and do the pass. Always ends up inside the bowl. What stops you from getting into the silly spots. Better living through physics.</p>
</div>

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L10/39.png" alt="Because each proposal is accepted, you need many many fewer. So a lot of efficiency. Using the code in the chapter, we get tours. Start with x on the left, and it rolls down the valley. Eventually we stop, then flick it again. High acceptance rate, but the sequential auto-correlation is very low. " width="80%" />
<p class="caption">Because each proposal is accepted, you need many many fewer. So a lot of efficiency. Using the code in the chapter, we get tours. Start with x on the left, and it rolls down the valley. Eventually we stop, then flick it again. High acceptance rate, but the sequential auto-correlation is very low. </p>
</div>

<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L10/40.png" width="80%" />

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L10/41.png" alt="Hamiltonian MC does really well with the donut. It knows the curvature. Tours the whole thing, and you don't get stuck. If you have 27K parameters, that's really handy. " width="80%" />
<p class="caption">Hamiltonian MC does really well with the donut. It knows the curvature. Tours the whole thing, and you don't get stuck. If you have 27K parameters, that's really handy. </p>
</div>

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L10/42.png" alt="You need to put in momentum variables now. You need to choose the mass. The system has energy, which is how to check that it's working. If energy is not conserved, the simulation stops working. With Metropolis, you won't know. But this breaks dramatically. Also need gradients - the log posterior at a particular point." width="80%" />
<p class="caption">You need to put in momentum variables now. You need to choose the mass. The system has energy, which is how to check that it's working. If energy is not conserved, the simulation stops working. With Metropolis, you won't know. But this breaks dramatically. Also need gradients - the log posterior at a particular point.</p>
</div>

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L10/43.png" alt="Not that complicated, so tour through it. " width="80%" />
<p class="caption">Not that complicated, so tour through it. </p>
</div>


<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L10/44.png" alt="Problem is that there's stuff to pick, namely the step size (the length of time we run a segment). You want basically the biggest step size, but if you make it too big, you can overshoot the shape. THen you need to choose the number of steps you'll take in each trajectory. If you choose bad values for those, you'll have a bad time. In general it's not as bad as it gets in a 2D Gaussian. Since it's a parabolic bowl, you can get these parabolic loops. In the long run it'll still work, but it's super inefficient. How do you fix it? Choose good values for the tuning parameters, which is annoying." width="80%" />
<p class="caption">Problem is that there's stuff to pick, namely the step size (the length of time we run a segment). You want basically the biggest step size, but if you make it too big, you can overshoot the shape. THen you need to choose the number of steps you'll take in each trajectory. If you choose bad values for those, you'll have a bad time. In general it's not as bad as it gets in a 2D Gaussian. Since it's a parabolic bowl, you can get these parabolic loops. In the long run it'll still work, but it's super inefficient. How do you fix it? Choose good values for the tuning parameters, which is annoying.</p>
</div>

<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L10/45.png" width="80%" />

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L10/46.png" alt="Here's the simulation where it resembles an Ouroboros. Since you don't know the distribution, it's hard to say what the best tuning parameters are." width="80%" />
<p class="caption">Here's the simulation where it resembles an Ouroboros. Since you don't know the distribution, it's hard to say what the best tuning parameters are.</p>
</div>

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L10/47.png" alt="Stan does two things: 1) Warm up phase, then maximises the step size. 2) Runs the NUTS2 algorithm. " width="80%" />
<p class="caption">Stan does two things: 1) Warm up phase, then maximises the step size. 2) Runs the NUTS2 algorithm. </p>
</div>

<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L10/48.png" width="80%" />

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L10/49.png" alt="Here's NUTS. It runs the simulation in both directions in time. It imagines a simulation that loops back on itself, and runs it backwards from teh starting point, and goes backdwards at the same time, but when it sees itself turning around, it stops. This means it figures out a good number of leapfrog steps for each trajectory. So you don't need to make a bunch of decisions." width="80%" />
<p class="caption">Here's NUTS. It runs the simulation in both directions in time. It imagines a simulation that loops back on itself, and runs it backwards from teh starting point, and goes backdwards at the same time, but when it sees itself turning around, it stops. This means it figures out a good number of leapfrog steps for each trajectory. So you don't need to make a bunch of decisions.</p>
</div>

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L10/50.png" alt="One of the mathematicians working with Metropolis. Built mechnical MCMC simulators. Also did important work in biology. Could run Stan on anything you like. " width="80%" />
<p class="caption">One of the mathematicians working with Metropolis. Built mechnical MCMC simulators. Also did important work in biology. Could run Stan on anything you like. </p>
</div>

<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L10/51.png" width="80%" />

<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L10/52.png" width="80%" />

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L10/53.png" alt="There are still problems. If you have multiple separated hills, like in factored analytical models, the wait between hills can be long indeed. In my experience you handle this by changing the geometry of the model. We get these with item-response theory models." width="80%" />
<p class="caption">There are still problems. If you have multiple separated hills, like in factored analytical models, the wait between hills can be long indeed. In my experience you handle this by changing the geometry of the model. We get these with item-response theory models.</p>
</div>

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L10/54.png" alt="SWant you to recognise a bad chain when you see it." width="80%" />
<p class="caption">SWant you to recognise a bad chain when you see it.</p>
</div>

## Easy HMC: `ulam`

* Preprocess any variable transformations
* Construct a clean data list with only the variables you will use.


```r
data(rugged, package = "rethinking")
d <- rugged
rm(rugged)

d <- 
  d %>%
  mutate(log_gdp = log(rgdppc_2000))

dd <-
  d %>%
  drop_na(rgdppc_2000) %>% 
  mutate(log_gdp_std = log_gdp / mean(log_gdp),
         rugged_std  = rugged / max(rugged),
         cid         = ifelse(cont_africa == 1, "1", "2")) %>% 
  mutate(rugged_std_c = rugged_std - mean(rugged_std))
```


<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L10/55.png" alt="Run quap as before. Now let's do this with a MC." width="80%" />
<p class="caption">Run quap as before. Now let's do this with a MC.</p>
</div>


***9.4.1. Preparation***

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L10/56.png" alt="Same formula, but slim dataset with just the variables of interest. 4 chains on separate cores." width="80%" />
<p class="caption">Same formula, but slim dataset with just the variables of interest. 4 chains on separate cores.</p>
</div>



***9.4.2. Sampling from the posterior***


```r
b9.1 <- 
  brm(data = dd, 
      family = gaussian,
      bf(log_gdp_std ~ 0 + a + b * (rugged_std - 0.215), 
         a ~ 0 + cid, 
         b ~ 0 + cid,
         nl = TRUE),
      prior = c(prior(normal(1, 0.1), class = b, coef = cid1, nlpar = a),
                prior(normal(1, 0.1), class = b, coef = cid2, nlpar = a),
                prior(normal(0, 0.3), class = b, coef = cid1, nlpar = b),
                prior(normal(0, 0.3), class = b, coef = cid2, nlpar = b),
                prior(exponential(1), class = sigma)),
      chains = 1, cores = 1,
      seed = 9,
      file = "fits/b09.01")
```


```r
print(b9.1)
```

```
##  Family: gaussian 
##   Links: mu = identity; sigma = identity 
## Formula: log_gdp_std ~ 0 + a + b * (rugged_std - 0.215) 
##          a ~ 0 + cid
##          b ~ 0 + cid
##    Data: dd (Number of observations: 170) 
## Samples: 1 chains, each with iter = 2000; warmup = 1000; thin = 1;
##          total post-warmup samples = 1000
## 
## Population-Level Effects: 
##        Estimate Est.Error l-95% CI u-95% CI Rhat Bulk_ESS Tail_ESS
## a_cid1     0.89      0.02     0.86     0.92 1.00     1114      721
## a_cid2     1.05      0.01     1.03     1.07 1.00     1106      658
## b_cid1     0.13      0.08    -0.01     0.29 1.00     1015      773
## b_cid2    -0.14      0.06    -0.26    -0.03 1.01     1241      712
## 
## Family Specific Parameters: 
##       Estimate Est.Error l-95% CI u-95% CI Rhat Bulk_ESS Tail_ESS
## sigma     0.11      0.01     0.10     0.13 1.00      997      720
## 
## Samples were drawn using sampling(NUTS). For each parameter, Bulk_ESS
## and Tail_ESS are effective sample size measures, and Rhat is the potential
## scale reduction factor on split chains (at convergence, Rhat = 1).
```


<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L10/57.png" alt="`ulam` translates this into raw Stan code. A bunch of formal variable definitions. " width="80%" />
<p class="caption">`ulam` translates this into raw Stan code. A bunch of formal variable definitions. </p>
</div>

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L10/58.png" alt="What happens here is it reports each chain. Warmup figures out the step size. Total samples is the length of each chain minus the warmup. You won't need more than a couple of thousand samples to get a good estimate." width="80%" />
<p class="caption">What happens here is it reports each chain. Warmup figures out the step size. Total samples is the length of each chain minus the warmup. You won't need more than a couple of thousand samples to get a good estimate.</p>
</div>

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L10/59.png" alt=" `n_eff` is the number of effective samples. Note that it's greater than the number of samples from the MC. True because it takes dispersed samples. The number of samples you would get if there was no auto-correlation between sequential samples. `Rhat` is the Gelman-Ruben diagnostic. You want it to converge across chains. They should all look the same and be exchangeable." width="80%" />
<p class="caption"> `n_eff` is the number of effective samples. Note that it's greater than the number of samples from the MC. True because it takes dispersed samples. The number of samples you would get if there was no auto-correlation between sequential samples. `Rhat` is the Gelman-Ruben diagnostic. You want it to converge across chains. They should all look the same and be exchangeable.</p>
</div>


```r
post <- brms::posterior_samples(b9.1)

post %>% 
  pivot_longer(-lp__) %>% 
  group_by(name) %>% 
  mean_hdi(value, .width = .89)  # note our rare use of 89% intervals
```

```
## # A tibble: 5 × 7
##   name      value  .lower  .upper .width .point .interval
##   <chr>     <dbl>   <dbl>   <dbl>  <dbl> <chr>  <chr>    
## 1 b_a_cid1  0.887  0.858   0.910    0.89 mean   hdi      
## 2 b_a_cid2  1.05   1.03    1.07     0.89 mean   hdi      
## 3 b_b_cid1  0.132  0.0101  0.245    0.89 mean   hdi      
## 4 b_b_cid2 -0.144 -0.228  -0.0505   0.89 mean   hdi      
## 5 sigma     0.112  0.102   0.123    0.89 mean   hdi
```


***9.4.3. Sampling again, in parallel***


```r
b9.1b <- 
  brm(data = dd, 
      family = gaussian,
      bf(log_gdp_std ~ 0 + a + b * (rugged_std - 0.215), 
         a ~ 0 + cid, 
         b ~ 0 + cid,
         nl = TRUE),
      prior = c(prior(normal(1, 0.1), class = b, coef = cid1, nlpar = a),
                prior(normal(1, 0.1), class = b, coef = cid2, nlpar = a),
                prior(normal(0, 0.3), class = b, coef = cid1, nlpar = b),
                prior(normal(0, 0.3), class = b, coef = cid2, nlpar = b),
                prior(exponential(1), class = sigma)),
      chains = 4, cores = 4,
      seed = 9,
      file = "fits/b09.01b")
```


```r
print(b9.1b)
```

```
##  Family: gaussian 
##   Links: mu = identity; sigma = identity 
## Formula: log_gdp_std ~ 0 + a + b * (rugged_std - 0.215) 
##          a ~ 0 + cid
##          b ~ 0 + cid
##    Data: dd (Number of observations: 170) 
## Samples: 4 chains, each with iter = 2000; warmup = 1000; thin = 1;
##          total post-warmup samples = 4000
## 
## Population-Level Effects: 
##        Estimate Est.Error l-95% CI u-95% CI Rhat Bulk_ESS Tail_ESS
## a_cid1     0.89      0.02     0.86     0.92 1.00     4613     2993
## a_cid2     1.05      0.01     1.03     1.07 1.00     4782     3058
## b_cid1     0.13      0.07    -0.01     0.28 1.00     4397     2724
## b_cid2    -0.14      0.06    -0.25    -0.03 1.00     5029     3104
## 
## Family Specific Parameters: 
##       Estimate Est.Error l-95% CI u-95% CI Rhat Bulk_ESS Tail_ESS
## sigma     0.11      0.01     0.10     0.12 1.00     4693     3152
## 
## Samples were drawn using sampling(NUTS). For each parameter, Bulk_ESS
## and Tail_ESS are effective sample size measures, and Rhat is the potential
## scale reduction factor on split chains (at convergence, Rhat = 1).
```

Look at the `formula` and prior

```r
b9.1b$formula
```

```
## log_gdp_std ~ 0 + a + b * (rugged_std - 0.215) 
## a ~ 0 + cid
## b ~ 0 + cid
```

```r
b9.1b$prior
```

```
##           prior class coef group resp dpar nlpar bound  source
##          (flat)     b                          a       default
##  normal(1, 0.1)     b cid1                     a          user
##  normal(1, 0.1)     b cid2                     a          user
##          (flat)     b                          b       default
##  normal(0, 0.3)     b cid1                     b          user
##  normal(0, 0.3)     b cid2                     b          user
##  exponential(1) sigma                                     user
```

```r
prior_summary(b9.1b)
```

```
##           prior class coef group resp dpar nlpar bound  source
##          (flat)     b                          a       default
##  normal(1, 0.1)     b cid1                     a          user
##  normal(1, 0.1)     b cid2                     a          user
##          (flat)     b                          b       default
##  normal(0, 0.3)     b cid1                     b          user
##  normal(0, 0.3)     b cid2                     b          user
##  exponential(1) sigma                                     user
```

If there were only 2000 samples in total, how can we have more than 2000 effective samples for each parameter? It’s no mistake. The adaptive sampler that Stan uses is so good, it can actually produce sequential samples that are better than uncorrelated. They are anti-correlated. This means it can explore the posterior distribution so efficiently that it can beat random.

***9.4.4. Visualization***

<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L10/60.png" width="80%" />



```r
pairs(b9.1b,
      off_diag_args = list(size = 1/5, alpha = 1/5))
```

<img src="09_markov_chain_monte_carlo_files/figure-html/9.19-1.png" width="672" />


```r
vcov(b9.1b, correlation = T) %>% round(digits = 2)
```

```
##        a_cid1 a_cid2 b_cid1 b_cid2
## a_cid1   1.00  -0.03   0.17   0.05
## a_cid2  -0.03   1.00   0.01  -0.09
## b_cid1   0.17   0.01   1.00  -0.03
## b_cid2   0.05  -0.09  -0.03   1.00
```


```r
post <- posterior_samples(b9.1b)

glimpse(post)
```

```
## Rows: 4,000
## Columns: 6
## $ b_a_cid1 <dbl> 0.9064987, 0.8718809, 0.9012252, 0.8977892, 0.8703916, 0.9253…
## $ b_a_cid2 <dbl> 1.050241, 1.060212, 1.044918, 1.047780, 1.041505, 1.035713, 1…
## $ b_b_cid1 <dbl> 0.05395168, 0.17354574, 0.10481150, 0.12121863, 0.24473996, 0…
## $ b_b_cid2 <dbl> -0.12886759, -0.12364289, -0.19158438, -0.18779887, -0.177450…
## $ sigma    <dbl> 0.11045080, 0.11337407, 0.10222348, 0.10314139, 0.09620476, 0…
## $ lp__     <dbl> 133.1505, 133.4317, 132.5007, 133.3072, 128.2402, 129.3591, 1…
```


```r
post %>%
  dplyr::select(-lp__ ) %>%
  GGally::ggpairs()
```

<img src="09_markov_chain_monte_carlo_files/figure-html/unnamed-chunk-68-1.png" width="672" />


***9.4.5. Checking the chain***

<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L10/61.png" width="80%" />

<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L10/62.png" width="80%" />


```r
plot(b9.1b)
```

<img src="09_markov_chain_monte_carlo_files/figure-html/unnamed-chunk-71-1.png" width="672" />



```r
library(bayesplot)

post <- brms::posterior_samples(b9.1b, add_chain = T)

bayesplot::mcmc_trace(post[, c(1:5, 7)],  # we need to include column 7 because it contains the chain info 
           facet_args = list(ncol = 3), 
           size = .15) +
  scale_color_pomological() +
  labs(title = "My custom trace plots") +
  theme_pomological_fancy(base_family = "Marck Script") +
  theme(legend.position = c(.95, .2))
```


```r
post %>% 
  bayesplot::mcmc_rank_overlay(pars = vars(b_a_cid1:sigma)) +
  scale_color_pomological() +
  ggtitle("My custom trank plots") +
  coord_cartesian(ylim = c(25, NA)) +
  theme_pomological_fancy(base_family = "Marck Script") +
  theme(legend.position = c(.95, .2))
```

```
## Scale for 'colour' is already present. Adding another scale for 'colour',
## which will replace the existing scale.
```

```
## Warning: Font 'Marck Script' isn't in the extrafont font list (but it may still
## work). If recently installed, you can try running `extrafont::font_import()`. To
## install, visit: https://fonts.google.com/specimen/Marck+Script/
```

<img src="09_markov_chain_monte_carlo_files/figure-html/9.21-1.png" width="672" />


<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L10/63.png" alt="What you want to see are these hairy caterpillars." width="80%" />
<p class="caption">What you want to see are these hairy caterpillars.</p>
</div>

Now, how is this chain a healthy one? Typically we look for three things in these trace plots: (1) stationarity, (2) good mixing, and (3) convergence.

## Care and feeding of your Markov chain

***9.5.1. How many samples do you need?***

First, what really matters is the effective number of samples, not the raw number. You can think of `n_eff` as the length of a Markov chain with no autocorrelation that would provide the same quality of estimate as your chain. One consequence of this definition, as you saw earlier in the chapter, is that `n_eff` can be larger than the length of your chain, provided sequential samples are anti-correlated in the right way. While n_eff is only an estimate, it is usually better than the raw number of samples, which can be very misleading.

Second, what do you want to know? If all you want are posterior means, it doesn’t take many samples at all to get very good estimates. Even a couple hundred samples will do. But if you care about the exact shape in the extreme tails of the posterior, the 99th percentile or so, then you’ll need many more.

<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L10/64.png" width="80%" />

The warmup setting is more subtle. On the one hand, you want to have the shortest warmup period necessary, so you can get on with real sampling. But on the other hand, more warmup can mean more efficient sampling. With Stan models, typically you can devote as much as half of your total samples, the iter value, to warmup and come out very well. But for simple models like those you’ve fit so far, much less warmup is really needed. Models can vary a lot in the shape of their posterior distributions, so again there is no universally best answer. But if you are having trouble, you might try increasing the warmup. If not, you might try reducing it. 

***9.5.2. How many chains do you need?***

So the question naturally arises: How many chains do we need? There are three answers to this question. First, when initially debugging a model, use a single chain. There are some error messages that don’t display unless you use only one chain. The chain will fail with more than one chain, but the reason may not be displayed. This is why the `ulam` default is `chains=1`. Second, when deciding whether the chains are valid, you need more than one chain. Third, when you begin the final run that you’ll make inferences from, you only really need one chain.

There are exotic situations in which all of the advice above must be modified. But for typical regression models, you can live by the motto:
>One short chain to debug, four chains for verification and inference.

<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L10/65.png" width="80%" />

***9.5.3. Taming a wild chain***

<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L10/66.png" width="80%" />


```r
b9.2 <-
  brm(data = list(y = c(-1, 1)), 
      family = gaussian,
      y ~ 1,
      prior = c(prior(normal(0, 1000), class = Intercept),
                prior(exponential(0.0001), class = sigma)),
      iter = 2000, warmup = 1000, chains = 3,
      seed = 9,
      file = "fits/b09.02")
```


```r
print(b9.2)
```

```
## Warning: Parts of the model have not converged (some Rhats are > 1.05). Be
## careful when analysing the results! We recommend running more iterations and/or
## setting stronger priors.
```

```
## Warning: There were 393 divergent transitions after warmup. Increasing
## adapt_delta above 0.8 may help. See http://mc-stan.org/misc/
## warnings.html#divergent-transitions-after-warmup
```

```
##  Family: gaussian 
##   Links: mu = identity; sigma = identity 
## Formula: y ~ 1 
##    Data: list(y = c(-1, 1)) (Number of observations: 2) 
## Samples: 3 chains, each with iter = 2000; warmup = 1000; thin = 1;
##          total post-warmup samples = 3000
## 
## Population-Level Effects: 
##           Estimate Est.Error l-95% CI u-95% CI Rhat Bulk_ESS Tail_ESS
## Intercept    10.68    270.90  -579.92   700.75 1.05      475      297
## 
## Family Specific Parameters: 
##       Estimate Est.Error l-95% CI u-95% CI Rhat Bulk_ESS Tail_ESS
## sigma   453.49   1148.02     7.77  3254.50 1.06       63       50
## 
## Samples were drawn using sampling(NUTS). For each parameter, Bulk_ESS
## and Tail_ESS are effective sample size measures, and Rhat is the potential
## scale reduction factor on split chains (at convergence, Rhat = 1).
```

Whoa! This posterior can’t be right. The mean of −1 and 1 is zero, so we’re hoping to get a mean value for alpha around zero. Instead we get crazy values and implausibly wide intervals. Inference for sigma is no better. The n_eff and Rhat diagnostics don’t look good either.

You should see something like:

```
Warning messages:
1: There were 67 divergent transitions after warmup. Increasing adapt_delta
above 0.95 may help. See
http://mc-stan.org/misc/warnings.html#divergent-transitions-after-warmup
```

The warnings say that Stan detected problems in exploring all of the posterior. These are **divergent transitions**.

You should also see a second warning:

```
2: Examine the pairs() plot to diagnose sampling problems
```

This refers to Stan’s pairs method, not `ulam`’s.

Let's look at the unhealthy chains:


```r
pairs(b9.2, 
      np = brms::nuts_params(b9.2),
      off_diag_args = list(size = 1/4))
```

<img src="09_markov_chain_monte_carlo_files/figure-html/unnamed-chunk-76-1.png" width="672" />


```r
post <- posterior_samples(b9.2, add_chain = T)

p1 <-
  post %>% 
  mcmc_trace(pars = vars(b_Intercept:sigma),
             size = .25)

p2 <-
  post %>% 
  mcmc_rank_overlay(pars = vars(b_Intercept:sigma))

(
  (p1 / p2) &
    scale_color_pomological() &
    theme_pomological_fancy(base_family = "Marck Script") &
    theme(legend.position = "none")
) +
  plot_annotation(subtitle = "These chains are not healthy")
```

```
## Scale for 'colour' is already present. Adding another scale for 'colour',
## which will replace the existing scale.
## Scale for 'colour' is already present. Adding another scale for 'colour',
## which will replace the existing scale.
```

```
## Warning: Font 'Marck Script' isn't in the extrafont font list (but it may still
## work). If recently installed, you can try running `extrafont::font_import()`. To
## install, visit: https://fonts.google.com/specimen/Marck+Script/
```

<img src="09_markov_chain_monte_carlo_files/figure-html/unnamed-chunk-77-1.png" width="672" />

They show the chains spend long periods with one chain above or below the others. This indicates poor exploration of the posterior.

It’s easy to tame this particular chain by using weakly informative priors. 


<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L10/67.png" width="80%" />

<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L10/68.png" width="80%" />

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L10/69.png" alt="You might get something like this instead. Not good." width="80%" />
<p class="caption">You might get something like this instead. Not good.</p>
</div>

<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L10/70.png" width="80%" />

<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L10/71.png" width="80%" />


```r
b9.3 <-
  brm(data = list(y = c(-1, 1)), 
      family = gaussian,
      y ~ 1,
      prior = c(prior(normal(1, 10), class = Intercept),
                prior(exponential(1), class = sigma)),
      iter = 2000, warmup = 1000, chains = 3,
      seed = 9,
      file = "fits/b09.03")
```


```r
print(b9.3)
```

```
##  Family: gaussian 
##   Links: mu = identity; sigma = identity 
## Formula: y ~ 1 
##    Data: list(y = c(-1, 1)) (Number of observations: 2) 
## Samples: 3 chains, each with iter = 2000; warmup = 1000; thin = 1;
##          total post-warmup samples = 3000
## 
## Population-Level Effects: 
##           Estimate Est.Error l-95% CI u-95% CI Rhat Bulk_ESS Tail_ESS
## Intercept     0.04      1.18    -2.55     2.43 1.00     1126     1158
## 
## Family Specific Parameters: 
##       Estimate Est.Error l-95% CI u-95% CI Rhat Bulk_ESS Tail_ESS
## sigma     1.54      0.78     0.59     3.60 1.00      961      994
## 
## Samples were drawn using sampling(NUTS). For each parameter, Bulk_ESS
## and Tail_ESS are effective sample size measures, and Rhat is the potential
## scale reduction factor on split chains (at convergence, Rhat = 1).
```


```r
post <- posterior_samples(b9.3, add_chain = T)

p1 <-
  post %>% 
  mcmc_trace(pars = vars(b_Intercept:sigma),
             size = .25)

p2 <-
  post %>% 
  mcmc_rank_overlay(pars = vars(b_Intercept:sigma)) +
  ylim(35, NA)
```

```
## Scale for 'y' is already present. Adding another scale for 'y', which will
## replace the existing scale.
```

```r
(
  (p1 / p2) &
    scale_color_pomological() &
    theme_pomological_fancy(base_family = "Marck Script") &
    theme(legend.position = "none")
) +
  plot_annotation(subtitle = "Weakly informative priors cleared up the condition right away")
```

```
## Scale for 'colour' is already present. Adding another scale for 'colour',
## which will replace the existing scale.
```

```
## Scale for 'colour' is already present. Adding another scale for 'colour',
## which will replace the existing scale.
```

```
## Warning: Font 'Marck Script' isn't in the extrafont font list (but it may still
## work). If recently installed, you can try running `extrafont::font_import()`. To
## install, visit: https://fonts.google.com/specimen/Marck+Script/
```

<img src="09_markov_chain_monte_carlo_files/figure-html/unnamed-chunk-84-1.png" width="672" />


<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L10/72.png" width="80%" />

<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L10/73.png" width="80%" />

<div class="figure">
<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L10/74.png" alt="Typically when you're having trouble getting your chain to work, it's because there's something wrong with your model definition. So first check the model. " width="80%" />
<p class="caption">Typically when you're having trouble getting your chain to work, it's because there's something wrong with your model definition. So first check the model. </p>
</div>

***9.5.4. Non-identifiable parameters***

<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L10/75.png" width="80%" />


```r
set.seed(9)
y <- rnorm(100, mean = 0, sd = 1)
```


```r
b9.4 <-
  brm(data = list(y  = y,
                  a1 = 1,
                  a2 = 1), 
      family = gaussian,
      y ~ 0 + a1 + a2,
      prior = c(prior(normal(0, 1000), class = b),
                prior(exponential(1), class = sigma)),
      iter = 2000, warmup = 1000, chains = 3,
      seed = 9,
      file = "fits/b09.04")
```


```r
print(b9.4)
```

```
## Warning: Parts of the model have not converged (some Rhats are > 1.05). Be
## careful when analysing the results! We recommend running more iterations and/or
## setting stronger priors.
```

```
##  Family: gaussian 
##   Links: mu = identity; sigma = identity 
## Formula: y ~ 0 + a1 + a2 
##    Data: list(y = y, a1 = 1, a2 = 1) (Number of observations: 100) 
## Samples: 3 chains, each with iter = 2000; warmup = 1000; thin = 1;
##          total post-warmup samples = 3000
## 
## Population-Level Effects: 
##    Estimate Est.Error l-95% CI u-95% CI Rhat Bulk_ESS Tail_ESS
## a1   113.93    563.81  -599.69  1303.63 1.87        5       17
## a2  -113.99    563.81 -1303.73   599.49 1.87        5       17
## 
## Family Specific Parameters: 
##       Estimate Est.Error l-95% CI u-95% CI Rhat Bulk_ESS Tail_ESS
## sigma     1.00      0.08     0.86     1.13 1.41        6       28
## 
## Samples were drawn using sampling(NUTS). For each parameter, Bulk_ESS
## and Tail_ESS are effective sample size measures, and Rhat is the potential
## scale reduction factor on split chains (at convergence, Rhat = 1).
```


<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L10/76.png" width="80%" />

<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L10/77.png" width="80%" />

Again, weakly regularizing priors can rescue us.


```r
b9.5 <-
  brm(data = list(y  = y,
                  a1 = 1,
                  a2 = 1), 
      family = gaussian,
      y ~ 0 + a1 + a2,
      prior = c(prior(normal(0, 10), class = b),
                prior(exponential(1), class = sigma)),
      iter = 2000, warmup = 1000, chains = 3,
      seed = 9,
      file = "fits/b09.05")
```


```r
print(b9.5)
```

```
##  Family: gaussian 
##   Links: mu = identity; sigma = identity 
## Formula: y ~ 0 + a1 + a2 
##    Data: list(y = y, a1 = 1, a2 = 1) (Number of observations: 100) 
## Samples: 3 chains, each with iter = 2000; warmup = 1000; thin = 1;
##          total post-warmup samples = 3000
## 
## Population-Level Effects: 
##    Estimate Est.Error l-95% CI u-95% CI Rhat Bulk_ESS Tail_ESS
## a1    -0.09      7.46   -14.99    14.38 1.00      574      576
## a2     0.04      7.47   -14.46    14.92 1.00      574      568
## 
## Family Specific Parameters: 
##       Estimate Est.Error l-95% CI u-95% CI Rhat Bulk_ESS Tail_ESS
## sigma     0.97      0.07     0.85     1.11 1.00     1065     1077
## 
## Samples were drawn using sampling(NUTS). For each parameter, Bulk_ESS
## and Tail_ESS are effective sample size measures, and Rhat is the potential
## scale reduction factor on split chains (at convergence, Rhat = 1).
```


```r
trace_rank <- function(data, var, subtitle = NULL, ymin = NA) {
  
  p1 <-
    data %>% 
    mcmc_trace(pars = var,
               size = .25,
               facet_args = list(ncol = 1)) +
    labs(subtitle = subtitle,
         y = NULL) +
    facet_wrap(~ parameter)
  
  p2 <-
    data %>%
    mcmc_rank_overlay(pars = var) +
    coord_cartesian(ylim = c(ymin, NA)) +
    xlab(NULL)
  
  tr <- p1 + p2
  
  tr
  
}
```



```r
# b9.4
post <- posterior_samples(b9.4, add_chain = T)

p1 <-  trace_rank(data = post, var = "b_a1", subtitle = "b9.4 (bad priors)")
p2 <-  trace_rank(data = post, var = "b_a2")
p3 <-  trace_rank(data = post, var = "sigma")

# b9.5
post <- posterior_samples(b9.5, add_chain = T)

p4 <-  trace_rank(data = post, var = "b_a1", subtitle = "b9.5 (good priors)", ymin = 30)
p5 <-  trace_rank(data = post, var = "b_a2", ymin = 30)
p6 <-  trace_rank(data = post, var = "sigma", ymin = 30)

# combine!
(p1 / p2 / p3 / p4 / p5 / p6) &
  scale_color_pomological() &
  theme_pomological_fancy(base_family = "Marck Script") &
  theme(legend.position = "none")
```

```
## Scale for 'colour' is already present. Adding another scale for 'colour',
## which will replace the existing scale.
## Scale for 'colour' is already present. Adding another scale for 'colour',
## which will replace the existing scale.
## Scale for 'colour' is already present. Adding another scale for 'colour',
## which will replace the existing scale.
## Scale for 'colour' is already present. Adding another scale for 'colour',
## which will replace the existing scale.
## Scale for 'colour' is already present. Adding another scale for 'colour',
## which will replace the existing scale.
## Scale for 'colour' is already present. Adding another scale for 'colour',
## which will replace the existing scale.
## Scale for 'colour' is already present. Adding another scale for 'colour',
## which will replace the existing scale.
## Scale for 'colour' is already present. Adding another scale for 'colour',
## which will replace the existing scale.
## Scale for 'colour' is already present. Adding another scale for 'colour',
## which will replace the existing scale.
## Scale for 'colour' is already present. Adding another scale for 'colour',
## which will replace the existing scale.
## Scale for 'colour' is already present. Adding another scale for 'colour',
## which will replace the existing scale.
## Scale for 'colour' is already present. Adding another scale for 'colour',
## which will replace the existing scale.
```

```
## Warning: Font 'Marck Script' isn't in the extrafont font list (but it may still
## work). If recently installed, you can try running `extrafont::font_import()`. To
## install, visit: https://fonts.google.com/specimen/Marck+Script/
```

<img src="09_markov_chain_monte_carlo_files/figure-html/unnamed-chunk-94-1.png" width="672" />


<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L10/78.png" width="80%" />

<img src="/hps/software/users/birney/ian/repos/statistical_rethinking/docs/slides/L10/79.png" width="80%" />


