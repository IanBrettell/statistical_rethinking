---
title: "Notes for Statistical Rethinking 2nd ed. by Richard McElreath"
date: '2021-06-08'
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

# Monsters and Mixtures


```r
library(here)
source(here::here("code/scripts/source.R"))
```


```r
slides_dir = here::here("docs/slides/L13")
```


<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L13/19.png" alt="Here we get into more elaborate types of models. Like monsters. In mythology, they're not just bigger, but bits of animals stuck together. " width="80%" />
<p class="caption">Here we get into more elaborate types of models. Like monsters. In mythology, they're not just bigger, but bits of animals stuck together. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L13/20.png" alt="If you're thkning of making a statistical monster, it's like junkyard challenge. " width="80%" />
<p class="caption">If you're thkning of making a statistical monster, it's like junkyard challenge. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L13/21.png" alt="Here, it's safe. And to make sure it works, use simulation. Use ordered categories and ranks. They look like cats, but aren't cats. Other kinds of things are mixtures, like beta-binomials. Zero-inflations are counts that arise from more than one process. So there are more than one way that you could get 0. YOur detection isn't good enough. " width="80%" />
<p class="caption">Here, it's safe. And to make sure it works, use simulation. Use ordered categories and ranks. They look like cats, but aren't cats. Other kinds of things are mixtures, like beta-binomials. Zero-inflations are counts that arise from more than one process. So there are more than one way that you could get 0. YOur detection isn't good enough. </p>
</div>

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L13/22.png" width="80%" />

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L13/23.png" alt="Here it's a simulation model. Silly, but there's a real problem here. You're a medieval investor who buys monasteries. Your issue is the output rate. How many manuscripts can you make per day? They copy manuscripts, but they also drink. We want to infer the number of days they get drunk." width="80%" />
<p class="caption">Here it's a simulation model. Silly, but there's a real problem here. You're a medieval investor who buys monasteries. Your issue is the output rate. How many manuscripts can you make per day? They copy manuscripts, but they also drink. We want to infer the number of days they get drunk.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L13/24.png" alt="Let's build up the problem scientifically. There's a hidden state we can't observe. The question is: were they dryinking that day? Maybe they finished a bunch previously. If you observe a non-0, they weren't all drunk. Even though you can't say on any particular day whether they were drinking, you can say on average how often they drink. This arises in any kind of detection problems. e.g. counting birds. Does 0 mean no birds? Maybe you were distracted, or visibility wasn't good. Many ways to get 0. Also 0 augmentation in chemistry, where it needs to reach a certain level to be detected, but many reasons it didn't reach that level." width="80%" />
<p class="caption">Let's build up the problem scientifically. There's a hidden state we can't observe. The question is: were they dryinking that day? Maybe they finished a bunch previously. If you observe a non-0, they weren't all drunk. Even though you can't say on any particular day whether they were drinking, you can say on average how often they drink. This arises in any kind of detection problems. e.g. counting birds. Does 0 mean no birds? Maybe you were distracted, or visibility wasn't good. Many ways to get 0. Also 0 augmentation in chemistry, where it needs to reach a certain level to be detected, but many reasons it didn't reach that level.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L13/25.png" alt="1-p is the time they work. Even fi tehy work, you could still get a 0. The blank ones are a pure Poisson process. The extra blue bit are the drunk days, where you get extra 0s. The aggregated data is not Poisson-distribued. " width="80%" />
<p class="caption">1-p is the time they work. Even fi tehy work, you could still get a 0. The blank ones are a pure Poisson process. The extra blue bit are the drunk days, where you get extra 0s. The aggregated data is not Poisson-distribued. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L13/26.png" alt="We need a function for the probability of any given observation. Need to count the number of ways you observe that thing conditional on your assumptions. Going to walk through the garden again. " width="80%" />
<p class="caption">We need a function for the probability of any given observation. Need to count the number of ways you observe that thing conditional on your assumptions. Going to walk through the garden again. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L13/27.png" alt="Say you observe a 0. There are two ways to do that." width="80%" />
<p class="caption">Say you observe a 0. There are two ways to do that.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L13/28.png" alt="We need both of those terms, and they're alternatives. Either p or 1-p exp(-lambda). " width="80%" />
<p class="caption">We need both of those terms, and they're alternatives. Either p or 1-p exp(-lambda). </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L13/29.png" alt="Then there's only one way to observe *n*. " width="80%" />
<p class="caption">Then there's only one way to observe *n*. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L13/30.png" alt="To summarise, there are two ways. This is a DAG by the way, but a statistical one not a causal one. " width="80%" />
<p class="caption">To summarise, there are two ways. This is a DAG by the way, but a statistical one not a causal one. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L13/31.png" alt="This general strategy works for anything." width="80%" />
<p class="caption">This general strategy works for anything.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L13/32.png" alt="Usually there are all these ones that construct the right probability for every observation. We have two parameters - p, whether they drink or work, and you can make a model out of that. For example, the weather may determine whether they work or not, but how hard they work. But you need link functions on them. We have taken the cat and the dog and stuck them together. Really powerful, because natural observable processes are mixtures like this." width="80%" />
<p class="caption">Usually there are all these ones that construct the right probability for every observation. We have two parameters - p, whether they drink or work, and you can make a model out of that. For example, the weather may determine whether they work or not, but how hard they work. But you need link functions on them. We have taken the cat and the dog and stuck them together. Really powerful, because natural observable processes are mixtures like this.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L13/33.png" alt="In the book we simulate the data. When createing bespoke models, want to make sure the code works. We can do this dummy data process. The goal is to recover estimates and test the limits of the model." width="80%" />
<p class="caption">In the book we simulate the data. When createing bespoke models, want to make sure the code works. We can do this dummy data process. The goal is to recover estimates and test the limits of the model.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L13/34.png" alt="Here's the whole simulation. This is the same model, but going forward. All Bayesian models are generative, which means you can run them in either direction. If you don't have data, you can plug in parameters and produce data. That's waht we're doing here. If you have data but no paramteres, it's create a distibution of parameters based on their plausibility. Non-genersative models are harder to understand. Here we're saying the probability of working is 20%. We're going to have a whole year sampled. Then we just simulate. Then we simulate a binomial first, whether they drink or not. Then we simulate the manuscripts, which is conditional on the drinking. " width="80%" />
<p class="caption">Here's the whole simulation. This is the same model, but going forward. All Bayesian models are generative, which means you can run them in either direction. If you don't have data, you can plug in parameters and produce data. That's waht we're doing here. If you have data but no paramteres, it's create a distibution of parameters based on their plausibility. Non-genersative models are harder to understand. Here we're saying the probability of working is 20%. We're going to have a whole year sampled. Then we just simulate. Then we simulate a binomial first, whether they drink or not. Then we simulate the manuscripts, which is conditional on the drinking. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L13/35.png" alt="`dzipois` is interpreted by `ulam` as meaning you want to do this multiple choice thing. To show you at the bottom that the machine works. The posterior mean is a little over 20%. The rate of production is around 1. YOur simluations are finite so you shouldn't be surprised that you don't recover exactly the data-generating parameters. But if it's doing the right thing, it should cover them. " width="80%" />
<p class="caption">`dzipois` is interpreted by `ulam` as meaning you want to do this multiple choice thing. To show you at the bottom that the machine works. The posterior mean is a little over 20%. The rate of production is around 1. YOur simluations are finite so you shouldn't be surprised that you don't recover exactly the data-generating parameters. But if it's doing the right thing, it should cover them. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L13/36.png" alt="The overthiking box shows how to code this without the helper functions. This is the same `ulam` model. All `dzpois` does is replace the two lines at the top. " width="80%" />
<p class="caption">The overthiking box shows how to code this without the helper functions. This is the same `ulam` model. All `dzpois` does is replace the two lines at the top. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L13/37.png" alt="There's no reason you can't also do 0-inflated things in other ways. There's this bernouli process. The model stays exactly the same. Also hurdle models that are common with continuous distributions. Get lots of this with benchwork. This happens all the time because say you're a forager, and often come back with nothing. 50-70% of hunting expeditions result in nothing. There are two models there based on whether you catch something, and if you do, how much." width="80%" />
<p class="caption">There's no reason you can't also do 0-inflated things in other ways. There's this bernouli process. The model stays exactly the same. Also hurdle models that are common with continuous distributions. Get lots of this with benchwork. This happens all the time because say you're a forager, and often come back with nothing. 50-70% of hunting expeditions result in nothing. There are two models there based on whether you catch something, and if you do, how much.</p>
</div>

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L13/38.png" width="80%" />

-----


```r
slides_dir = here::here("docs/slides/L14")
```

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L14/01.png" alt="Today is entirely one kind of outcome variable. To make it more exciting, it's one of the most common - and most commonly mistreated - type of data in the behavioural sciences." width="80%" />
<p class="caption">Today is entirely one kind of outcome variable. To make it more exciting, it's one of the most common - and most commonly mistreated - type of data in the behavioural sciences.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L14/02.png" alt="When categories are ordered, they're not exchangeable. The world is full of this stuff because of the way we measure it." width="80%" />
<p class="caption">When categories are ordered, they're not exchangeable. The world is full of this stuff because of the way we measure it.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L14/03.png" alt="In terms of constraints, they're discrete outcomes, like counts, but they're not counting anyting. There's an arbitrary minimum and maximum. The important thing we need to model is that the distance *underlying metric change) between categories aren't constant. They could vary a lot. " width="80%" />
<p class="caption">In terms of constraints, they're discrete outcomes, like counts, but they're not counting anyting. There's an arbitrary minimum and maximum. The important thing we need to model is that the distance *underlying metric change) between categories aren't constant. They could vary a lot. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L14/04.png" alt="These things are difficult to model, but people have figured out ways to do it. Need to do it on both ends - outcomes and predictors. Going to start with an example dealing with the outcome. Leads to a kind of GLM known as *ordered logistic regression.*" width="80%" />
<p class="caption">These things are difficult to model, but people have figured out ways to do it. Need to do it on both ends - outcomes and predictors. Going to start with an example dealing with the outcome. Leads to a kind of GLM known as *ordered logistic regression.*</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L14/05.png" alt="Why we need them. The trolley problem. Going down the track. Turns out there are five people lashed to the track. " width="80%" />
<p class="caption">Why we need them. The trolley problem. Going down the track. Turns out there are five people lashed to the track. </p>
</div>

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L14/06.png" width="80%" />

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L14/07.png" alt="There's a swith in the track ahead where there's only one person lashed to the track." width="80%" />
<p class="caption">There's a swith in the track ahead where there's only one person lashed to the track.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L14/08.png" alt="You're standing next to the switch control. If you pull the switch, it will move to B and kill only one person." width="80%" />
<p class="caption">You're standing next to the switch control. If you pull the switch, it will move to B and kill only one person.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L14/09.png" alt="Data is collected by explaining the story then asking this question." width="80%" />
<p class="caption">Data is collected by explaining the story then asking this question.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L14/10.png" alt="It's measuring something substantial. " width="80%" />
<p class="caption">It's measuring something substantial. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L14/11.png" alt="These come in big flavours. Second version is now a side view. Black thing is an overpass. " width="80%" />
<p class="caption">These come in big flavours. Second version is now a side view. Black thing is an overpass. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L14/12.png" alt="5 doomed individuals." width="80%" />
<p class="caption">5 doomed individuals.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L14/13.png" alt="There's a large individual next to you. You can push the Rock off the bridge and his mass would stop the trolley. " width="80%" />
<p class="caption">There's a large individual next to you. You can push the Rock off the bridge and his mass would stop the trolley. </p>
</div>

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L14/14.png" width="80%" />

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L14/15.png" alt="Then ask the same question." width="80%" />
<p class="caption">Then ask the same question.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L14/16.png" alt="Third example. Same setup as the first." width="80%" />
<p class="caption">Third example. Same setup as the first.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L14/17.png" alt="But now the switch is set such that it'll veer off to the one individual. " width="80%" />
<p class="caption">But now the switch is set such that it'll veer off to the one individual. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L14/18.png" alt="On a logical basis, it's the same, but people feel completely different about this." width="80%" />
<p class="caption">On a logical basis, it's the same, but people feel completely different about this.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L14/19.png" alt="Big literature about this, with real moral intuitions. One way it's organised is under these principles. Designed to probe these principles. Contact is like a subset of action. " width="80%" />
<p class="caption">Big literature about this, with real moral intuitions. One way it's organised is under these principles. Designed to probe these principles. Contact is like a subset of action. </p>
</div>

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L14/20.png" width="80%" />

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L14/21.png" alt="First story has action, but no intention or contact." width="80%" />
<p class="caption">First story has action, but no intention or contact.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L14/22.png" alt="Here the Rock's death is instrumental." width="80%" />
<p class="caption">Here the Rock's death is instrumental.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L14/23.png" alt="The last one has none of them. " width="80%" />
<p class="caption">The last one has none of them. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L14/24.png" alt="Different mix and match of these features, plus different stories. This is averaged across all scenarios. Something that's quite typical in ordered categorical data - usually a spike in the middle. Also true that the distribution can often be quite flat. Can take any shape." width="80%" />
<p class="caption">Different mix and match of these features, plus different stories. This is averaged across all scenarios. Something that's quite typical in ordered categorical data - usually a spike in the middle. Also true that the distribution can often be quite flat. Can take any shape.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L14/25.png" alt="Can break this down. Action is different in that the mass has shifted a little to above. Intention has more 1s. Contact has a lot of 1s. " width="80%" />
<p class="caption">Can break this down. Action is different in that the mass has shifted a little to above. Intention has more 1s. Contact has a lot of 1s. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L14/26.png" alt="Essentially like a categorical model, li,e a bionial model with more than two categories. Log-cumulative-odds link works like this: We want a model that descrbies this on the logit scale. We'll need 6 parameters, one less than the number of categories. " width="80%" />
<p class="caption">Essentially like a categorical model, li,e a bionial model with more than two categories. Log-cumulative-odds link works like this: We want a model that descrbies this on the logit scale. We'll need 6 parameters, one less than the number of categories. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L14/27.png" alt="Think of it as a cumulative distribution. A little over 20% is 2 or less. 7 always has 1. " width="80%" />
<p class="caption">Think of it as a cumulative distribution. A little over 20% is 2 or less. 7 always has 1. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L14/28.png" alt="Then we'll transform them onto the logit scale. What are the log odds? Probability of something over the probabilty of everything else. The log odds are the log of that ratio. So if it's a cumulative proportion, these are just the log cumulative proportions. On the logit scale, 0 is 50%. " width="80%" />
<p class="caption">Then we'll transform them onto the logit scale. What are the log odds? Probability of something over the probabilty of everything else. The log odds are the log of that ratio. So if it's a cumulative proportion, these are just the log cumulative proportions. On the logit scale, 0 is 50%. </p>
</div>

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L14/29.png" width="80%" />

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L14/30.png" alt="Log of the probability of something over the 1-probability of something." width="80%" />
<p class="caption">Log of the probability of something over the 1-probability of something.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L14/31.png" alt="So you're saying what's the cumulative probability of 6? It's the proportion of responses that are 6 or less. Then we take the log of that. In a logistic regression, the probability is discrete. Here it's either geater, or less than or equal to, k. " width="80%" />
<p class="caption">So you're saying what's the cumulative probability of 6? It's the proportion of responses that are 6 or less. Then we take the log of that. In a logistic regression, the probability is discrete. Here it's either geater, or less than or equal to, k. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L14/32.png" alt="$\phi$ is where the action happens." width="80%" />
<p class="caption">$\phi$ is where the action happens.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L14/33.png" alt="As a consequence, if you solve this, you get the logistic function, because it's the same link." width="80%" />
<p class="caption">As a consequence, if you solve this, you get the logistic function, because it's the same link.</p>
</div>

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L14/34.png" width="80%" />

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L14/35.png" width="80%" />

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L14/36.png" alt="These grey bars are the probabilities on the left. For every $k$ value, there's a different bar. Just proportions." width="80%" />
<p class="caption">These grey bars are the probabilities on the left. For every $k$ value, there's a different bar. Just proportions.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L14/37.png" alt="When we run a ststatical model, we need the probability of each discrete $y$. To get those, we need to sbustract adjacent grey bars.The whole reason it uses a cumulative link is to establish the order. Very clever trick. " width="80%" />
<p class="caption">When we run a ststatical model, we need the probability of each discrete $y$. To get those, we need to sbustract adjacent grey bars.The whole reason it uses a cumulative link is to establish the order. Very clever trick. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L14/38.png" alt="If you try to take it down, it looks horrible. Because all that fiddling is just a bunch of algebraic transformations. No one ever does this. But just shows you that it's all algorithmic. Just a categorical distribution." width="80%" />
<p class="caption">If you try to take it down, it looks horrible. Because all that fiddling is just a bunch of algebraic transformations. No one ever does this. But just shows you that it's all algorithmic. Just a categorical distribution.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L14/39.png" alt="All you specified is two things. The linear model. You don't have one intercept, you have a lot. With 7 categories, you have 6. Why? To get the histogram. You need a unique intercept for the log cumulative proportion of that type. You don't need the last one because you know it's 100%. Called `cutpoints` here. If you" width="80%" />
<p class="caption">All you specified is two things. The linear model. You don't have one intercept, you have a lot. With 7 categories, you have 6. Why? To get the histogram. You need a unique intercept for the log cumulative proportion of that type. You don't need the last one because you know it's 100%. Called `cutpoints` here. If you</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L14/40.png" alt="4 means always, -4 means never. Run this model and spit out the cutpoints. 6 of them. Totally uninterpretable. These are log-cumulative probabilities. Can interpret them by converting back." width="80%" />
<p class="caption">4 means always, -4 means never. Run this model and spit out the cutpoints. 6 of them. Totally uninterpretable. These are log-cumulative probabilities. Can interpret them by converting back.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L14/41.png" alt="Just need `inv_logit`. " width="80%" />
<p class="caption">Just need `inv_logit`. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L14/42.png" alt="Let's compare them to the picture again. What has it done more than that? Cutpoint 1 is about 1.3. It isn't exactly redescribing the sample, but it's close. There's posterior uncertainty." width="80%" />
<p class="caption">Let's compare them to the picture again. What has it done more than that? Cutpoint 1 is about 1.3. It isn't exactly redescribing the sample, but it's close. There's posterior uncertainty.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L14/43.png" alt="Now we think about all the cutpoints as alphas. And we'll subtract it from all the cutpoints. Why do we subtract it? Because we want to shift probability mass down when ratings go up. It's like we need to re-allocate mass. You can use any linear model. Notice there's no intercept, because you already did them with the cutpoints. We're going to be interested in interactions as well, of action and contact with intent. $A_i$ is action $I_i$ is intent. $C_i$ is contact. If you multiply those out, you get product terms. " width="80%" />
<p class="caption">Now we think about all the cutpoints as alphas. And we'll subtract it from all the cutpoints. Why do we subtract it? Because we want to shift probability mass down when ratings go up. It's like we need to re-allocate mass. You can use any linear model. Notice there's no intercept, because you already did them with the cutpoints. We're going to be interested in interactions as well, of action and contact with intent. $A_i$ is action $I_i$ is intent. $C_i$ is contact. If you multiply those out, you get product terms. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L14/44.png" alt="Write this into `ulam`. Give all the others priors. cutpoints on the logit scale. " width="80%" />
<p class="caption">Write this into `ulam`. Give all the others priors. cutpoints on the logit scale. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L14/45.png" alt="What these coefficients do is tell you how the cutpoints get distorted when you add or subtract a feature from a story. Can't tell much from just looking at the parameters, but you can see they're all negative = each adds disapproval. Interaction for IC is the worst. " width="80%" />
<p class="caption">What these coefficients do is tell you how the cutpoints get distorted when you add or subtract a feature from a story. Can't tell much from just looking at the parameters, but you can see they're all negative = each adds disapproval. Interaction for IC is the worst. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L14/46.png" alt="These models are complicated. There are lots of options for plotting like this. Will show you the personally most useful. Also helps to explain how the linear model works." width="80%" />
<p class="caption">These models are complicated. There are lots of options for plotting like this. Will show you the personally most useful. Also helps to explain how the linear model works.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L14/47.png" alt="The thing about the posterior is that it's predicting a distribution. So it gives you a probability for every observable value from 0 to 7. So it's a vector, also called a simplex. So we have to plot that vector to see what happens. We have the two possible values of intent. Blue points are the data, and we're only lookking at scenarios when action and contact are 0, and seeing how intention affects it. Black lines are 50 samples from the posterior. Can see the model isn't exactly describing the sample, but is describing the changes in an accurate way. Why do the lines tilt up? Because you squeeze probabiltiy off the top and reallocate to the bottom. **When the lines tilt up, the mean goes down**, beucase there's more mass at the bottom. That makes the average response go down. The cutpoints determine the lines. But your attention should be on the gaps. " width="80%" />
<p class="caption">The thing about the posterior is that it's predicting a distribution. So it gives you a probability for every observable value from 0 to 7. So it's a vector, also called a simplex. So we have to plot that vector to see what happens. We have the two possible values of intent. Blue points are the data, and we're only lookking at scenarios when action and contact are 0, and seeing how intention affects it. Black lines are 50 samples from the posterior. Can see the model isn't exactly describing the sample, but is describing the changes in an accurate way. Why do the lines tilt up? Because you squeeze probabiltiy off the top and reallocate to the bottom. **When the lines tilt up, the mean goes down**, beucase there's more mass at the bottom. That makes the average response go down. The cutpoints determine the lines. But your attention should be on the gaps. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L14/48.png" alt="Now looking at the interaction effect. In the middle we look at where action's present, and we add intent. The lines tilt up again, but more. So there's more interaction, making it even worse. On the right, pushing the Rock off the footbridge, contact implies action, so we've got both action and contact. They tilt up, but a lot more, so there's a lot more probability mass. Especially if there's intent. Lots of these plots in policy journals. " width="80%" />
<p class="caption">Now looking at the interaction effect. In the middle we look at where action's present, and we add intent. The lines tilt up again, but more. So there's more interaction, making it even worse. On the right, pushing the Rock off the footbridge, contact implies action, so we've got both action and contact. They tilt up, but a lot more, so there's a lot more probability mass. Especially if there's intent. Lots of these plots in policy journals. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L14/49.png" alt="Try to summarise this. We're going through all of this fuss because the spaces are different. We can luckily do that. Going to use same dataset, but we're going to add another variable, `edu`, indicating completed education. An important category here is `Some College`. " width="80%" />
<p class="caption">Try to summarise this. We're going through all of this fuss because the spaces are different. We can luckily do that. Going to use same dataset, but we're going to add another variable, `edu`, indicating completed education. An important category here is `Some College`. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L14/50.png" alt="There's an ordering here. A cumulative, monotonic idea. If we treated this as a metric, you could maybe get away with that, but ignores the discreate category, because it assumes that each level contributes the same amount of effect on your response. The trick here is if you want to assign a prior and not go insance, you want to code it in a particular way. " width="80%" />
<p class="caption">There's an ordering here. A cumulative, monotonic idea. If we treated this as a metric, you could maybe get away with that, but ignores the discreate category, because it assumes that each level contributes the same amount of effect on your response. The trick here is if you want to assign a prior and not go insance, you want to code it in a particular way. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L14/51.png" alt="Here's how you do it. You've got $\phi$. We're going to add the $\delta$ parameters. Someone who completed the first level of education will get $\delta_1$ " width="80%" />
<p class="caption">Here's how you do it. You've got $\phi$. We're going to add the $\delta$ parameters. Someone who completed the first level of education will get $\delta_1$ </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L14/52.png" alt="Someone with second gets both $\delta_1$ *and* $\delta_2$." width="80%" />
<p class="caption">Someone with second gets both $\delta_1$ *and* $\delta_2$.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L14/53.png" alt="In our case we have 7, and we sum over all our different deltas. It's a single predictor, but it implies a bunch of parameters. " width="80%" />
<p class="caption">In our case we have 7, and we sum over all our different deltas. It's a single predictor, but it implies a bunch of parameters. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L14/54.png" alt="In practice we have plenty of these. We factor out the sum of all the deltas, and that's the maximum possible effect. Whatever that sum is, here we've called it $\beta_E$ and that's the maximum effect of education. All the deltas now sum to 1. We can lose the delta. Where does the free delta go? It becomes beta. Then the priors on the deltas you could make them all the same." width="80%" />
<p class="caption">In practice we have plenty of these. We factor out the sum of all the deltas, and that's the maximum possible effect. Whatever that sum is, here we've called it $\beta_E$ and that's the maximum effect of education. All the deltas now sum to 1. We can lose the delta. Where does the free delta go? It becomes beta. Then the priors on the deltas you could make them all the same.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L14/55.png" alt="The Dirichlet distribution is a distribution for probability distributions with discrete outcomes. It has one argument, $\alpha$, which is a vector, and when you sample from it, you get probiablitiies, one for each of the categories. It's everywhere. It's a genralisation of the beta distribution. You could have a million in principle. " width="80%" />
<p class="caption">The Dirichlet distribution is a distribution for probability distributions with discrete outcomes. It has one argument, $\alpha$, which is a vector, and when you sample from it, you get probiablitiies, one for each of the categories. It's everywhere. It's a genralisation of the beta distribution. You could have a million in principle. </p>
</div>

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L14/56.png" width="80%" />

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L14/57.png" alt="In this case we have a 7-dimensional Dirichlet. What's the relative importance of completing each level of education? We set every alpha value to 2, and sample from them, you get different distributions. When you set all the alphas equal, that isn't saying you think all the probabilities are the same, but that you have no reason to think they're different. Most samples don't give you distributions where they're all the same. " width="80%" />
<p class="caption">In this case we have a 7-dimensional Dirichlet. What's the relative importance of completing each level of education? We set every alpha value to 2, and sample from them, you get different distributions. When you set all the alphas equal, that isn't saying you think all the probabilities are the same, but that you have no reason to think they're different. Most samples don't give you distributions where they're all the same. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L14/58.png" alt="There are some ghost similarities. By the time you get to alpha = 64, it's saying they're all about equal. We'll say alpha = 2. " width="80%" />
<p class="caption">There are some ghost similarities. By the time you get to alpha = 64, it's saying they're all about equal. We'll say alpha = 2. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L14/59.png" alt="So if you want to do this with `ulam`. This is what your computer is doing. " width="80%" />
<p class="caption">So if you want to do this with `ulam`. This is what your computer is doing. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L14/60.png" alt="When you run this model, look at the first parameter, `bE`. Notice that it's negative. So individuals who have completed a degree give more disapproval. Education makes you more judgy. The treatment effects are much bigger than educuation levels. Then in this pairs plot you see the deltas. Some are bigger than others. Lots of individuals with some college tells you nothing. There's no effect. " width="80%" />
<p class="caption">When you run this model, look at the first parameter, `bE`. Notice that it's negative. So individuals who have completed a degree give more disapproval. Education makes you more judgy. The treatment effects are much bigger than educuation levels. Then in this pairs plot you see the deltas. Some are bigger than others. Lots of individuals with some college tells you nothing. There's no effect. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L14/61.png" alt="If you run the model with education as a metric effect, we run it as an ordinary regression, and it overlaps 0. Why? Because of the some college effect. A linear treatment of it get dampened out. " width="80%" />
<p class="caption">If you run the model with education as a metric effect, we run it as an ordinary regression, and it overlaps 0. Why? Because of the some college effect. A linear treatment of it get dampened out. </p>
</div>

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L14/62.png" width="80%" />

