---
title: "Notes for Statistical Rethinking 2nd ed. by Richard McElreath"
date: '2021-06-20'
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

# God Spiked the Integers


```r
library(here)
source(here::here("code/scripts/source.R"))
```


```r
slides_dir = here::here("docs/slides/L12")
```


<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L12/01.png" width="80%" />

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L12/02.png" alt="Some motivation. These are simulated fireflies. They synchronise their flashes. The whole forest will flash at once. They're slowly synchroninising. Each is a clock, and when it hits 12 it flashes, but they turn their clocks forward each time a firefly near them flashes. That's all that's required to get perfect synchrony. Heartbeats do this. We're stuyding discrete phenomena. And what's interesting is that underneath they aren't discrete. Just like the GLMs I'm teaching. " width="80%" />
<p class="caption">Some motivation. These are simulated fireflies. They synchronise their flashes. The whole forest will flash at once. They're slowly synchroninising. Each is a clock, and when it hits 12 it flashes, but they turn their clocks forward each time a firefly near them flashes. That's all that's required to get perfect synchrony. Heartbeats do this. We're stuyding discrete phenomena. And what's interesting is that underneath they aren't discrete. Just like the GLMs I'm teaching. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L12/03.png" alt="Number of belts close together, like Saturn's rings. There are significant gaps, and they occur at even integer ratios of Jupite's orbits. It's like God spiked the integers. " width="80%" />
<p class="caption">Number of belts close together, like Saturn's rings. There are significant gaps, and they occur at even integer ratios of Jupite's orbits. It's like God spiked the integers. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L12/04.png" alt="Jupiter is like a large parent pushing you on a swing. It pushes asteroids out of orbit when it gets to push them at the same orbit at every time. When it's not at some integer resonance, it'll stay there to be found as an asteroid. Nature is full of discrete phenomena, but underneath they're not discrete; they're complicated. " width="80%" />
<p class="caption">Jupiter is like a large parent pushing you on a swing. It pushes asteroids out of orbit when it gets to push them at the same orbit at every time. When it's not at some integer resonance, it'll stay there to be found as an asteroid. Nature is full of discrete phenomena, but underneath they're not discrete; they're complicated. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L12/05.png" alt="We turn to these models. To remind you, we're processesing chimp lever-pulling data. We're dealing with getting sinsible priors. Last time it was about slope. Now we're also thinking about treatments. There are 4 treatments. Partner at the table or not, and whether the food is on the left or right. We want to measure unqiue log-odds for each of those. Flat prior on the logit scale is definitely not flat on the probability scale. Same problem for the treatment. For the prior predictives, we want to look at the distribution of differences." width="80%" />
<p class="caption">We turn to these models. To remind you, we're processesing chimp lever-pulling data. We're dealing with getting sinsible priors. Last time it was about slope. Now we're also thinking about treatments. There are 4 treatments. Partner at the table or not, and whether the food is on the left or right. We want to measure unqiue log-odds for each of those. Flat prior on the logit scale is definitely not flat on the probability scale. Same problem for the treatment. For the prior predictives, we want to look at the distribution of differences.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L12/06.png" alt="I'm using `rnorm` to sample some parameter values and look at some differences. Left is simulating the intercept alpha. A flat prior transformed to the probability scale it puts all the mass at 0 and 1, so we use 1.5. On the right we have the difference. The biggest difference is 1, smallest is 0. Again if you iuse something large on the logit scale, on the probability scale assumes that the treatments are either 0 or 1. We want it to reflect that the differences probably aren't large. To be near 0 you need a tighter scale parameter." width="80%" />
<p class="caption">I'm using `rnorm` to sample some parameter values and look at some differences. Left is simulating the intercept alpha. A flat prior transformed to the probability scale it puts all the mass at 0 and 1, so we use 1.5. On the right we have the difference. The biggest difference is 1, smallest is 0. Again if you iuse something large on the logit scale, on the probability scale assumes that the treatments are either 0 or 1. We want it to reflect that the differences probably aren't large. To be near 0 you need a tighter scale parameter.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L12/07.png" alt="Ran four chains and here's the summary. 7 chimp parameters and 4 treatment parameters. Each posterior mean is on the logit scale, so this is the log-odds handedness preference. Above 0 means they pull the left lever more than chance. You can see there's a tendency for right-handedness. Chimp 2 knows what chimp 2 wants, which is the left lever. " width="80%" />
<p class="caption">Ran four chains and here's the summary. 7 chimp parameters and 4 treatment parameters. Each posterior mean is on the logit scale, so this is the log-odds handedness preference. Above 0 means they pull the left lever more than chance. You can see there's a tendency for right-handedness. Chimp 2 knows what chimp 2 wants, which is the left lever. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L12/08.png" alt="Let's look at the individual difference parameters. Chimp 2 is 'lefty'. He never pulled the right lever. The others have some more variation, with a slight tnedency for handedness. 7 has no preference. So handedness adds noise. It's not technically a confound, but it makes measurement harder. Backdoor criterion doesn't tell you to control for handedness. We don't need it because this is an experiment." width="80%" />
<p class="caption">Let's look at the individual difference parameters. Chimp 2 is 'lefty'. He never pulled the right lever. The others have some more variation, with a slight tnedency for handedness. 7 has no preference. So handedness adds noise. It's not technically a confound, but it makes measurement harder. Backdoor criterion doesn't tell you to control for handedness. We don't need it because this is an experiment.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L12/09.png" alt="N = no partner; P = partner. This is an example of how hard it is to figure out what happened in the experiment. The contrasts of interest are the interaction. We need them to choose the prosocial option more when there's a parter on the other end, not just because there's more food on that side. When the prosocial option is on the left, we'd expect higher estimates. For the other two treatments are on the right hand side, and they do, but there's not much of an interaction effect. The side of the prosocial option has more effect, but not as much of the handedness. " width="80%" />
<p class="caption">N = no partner; P = partner. This is an example of how hard it is to figure out what happened in the experiment. The contrasts of interest are the interaction. We need them to choose the prosocial option more when there's a parter on the other end, not just because there's more food on that side. When the prosocial option is on the left, we'd expect higher estimates. For the other two treatments are on the right hand side, and they do, but there's not much of an interaction effect. The side of the prosocial option has more effect, but not as much of the handedness. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L12/10.png" alt="It's much easier to just plot this stuff on the outcome scale. Just push the posterior distribution out through the model onto the prediction scale. This is the raw data, with some augmented lines. Each group is an actor, and I've taken all pulls and averaged them. The different treatment are points. Filled are partners. You can see that other than 2, they pull the left lever more when there is more food on that side. But the lines are pretty horizontal. If they titled more, you'd get a big change when you added a partner, but we don't see that consistently. That's the raw data. " width="80%" />
<p class="caption">It's much easier to just plot this stuff on the outcome scale. Just push the posterior distribution out through the model onto the prediction scale. This is the raw data, with some augmented lines. Each group is an actor, and I've taken all pulls and averaged them. The different treatment are points. Filled are partners. You can see that other than 2, they pull the left lever more when there is more food on that side. But the lines are pretty horizontal. If they titled more, you'd get a big change when you added a partner, but we don't see that consistently. That's the raw data. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L12/11.png" alt="Now look at the posterior predictions. This is what it thinks. Sees that every chimp has the same partner effect. Can't vary based on actor. If anything, adding a partner reduced the tendency to pull left. Look at actor 2's predictions. The model is not sure that it would never pull it again. So even though the data has no variation in it, the model does. With 5-year-old kids, adding a partner changes everything." width="80%" />
<p class="caption">Now look at the posterior predictions. This is what it thinks. Sees that every chimp has the same partner effect. Can't vary based on actor. If anything, adding a partner reduced the tendency to pull left. Look at actor 2's predictions. The model is not sure that it would never pull it again. So even though the data has no variation in it, the model does. With 5-year-old kids, adding a partner changes everything.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L12/12.png" alt="If you want to do model comparison, you'll have to add this `log_lik` which computes the log probability of each observation. Once you hav those, they get spit out of the chain. Have to do it optionally because it can exhaust the memory on your computer. So if you don't need it, don't add it. Here I'm using `LOO` to compare. There's no interaction because there's no unique parameter for that. Now we can confirm that the interaction is not doing any work, because the models are the same on the prediction scale." width="80%" />
<p class="caption">If you want to do model comparison, you'll have to add this `log_lik` which computes the log probability of each observation. Once you hav those, they get spit out of the chain. Have to do it optionally because it can exhaust the memory on your computer. So if you don't need it, don't add it. Here I'm using `LOO` to compare. There's no interaction because there's no unique parameter for that. Now we can confirm that the interaction is not doing any work, because the models are the same on the prediction scale.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L12/13.png" alt="You'll get used to bionmial and logistical regression through examples. You can talk about effect scales in two different ways. And you need both. When you're looking at differences between parameters on the log-odds scale, they're relative. Why? Because you're not talking abou tthe probbaiblity of the event happening. But if you want to predict how it happens in the real world, then the base rate matters. That's absolute. Something can seem really big when the absolute effect is small. The proportional odds adjustment is 0.9. SO that's 90% of the preivous odds. If you switch the lever, you reduce the odds by 90%. The risk with this is that unimportant things  can seem super important on the relative scale... because of base rate effects." width="80%" />
<p class="caption">You'll get used to bionmial and logistical regression through examples. You can talk about effect scales in two different ways. And you need both. When you're looking at differences between parameters on the log-odds scale, they're relative. Why? Because you're not talking abou tthe probbaiblity of the event happening. But if you want to predict how it happens in the real world, then the base rate matters. That's absolute. Something can seem really big when the absolute effect is small. The proportional odds adjustment is 0.9. SO that's 90% of the preivous odds. If you switch the lever, you reduce the odds by 90%. The risk with this is that unimportant things  can seem super important on the relative scale... because of base rate effects.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L12/14.png" alt="The parable of absolute shark and relative penguin. This says don't worry about sharks. Why is it easy to believe that more deer kill people than sharks? Because people aren't aquatic. There's an exposure effect. Each individual deer is less dangerous. THe absolute danger of a shark conditioning on the distibution of people acorss the earth is very small. But what if you're a penguin? HTen the absolute risk is much larger. " width="80%" />
<p class="caption">The parable of absolute shark and relative penguin. This says don't worry about sharks. Why is it easy to believe that more deer kill people than sharks? Because people aren't aquatic. There's an exposure effect. Each individual deer is less dangerous. THe absolute danger of a shark conditioning on the distibution of people acorss the earth is very small. But what if you're a penguin? HTen the absolute risk is much larger. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L12/15.png" alt="Relative effects are useful, but misused in epidemiological risk because it can make a very rare disease look dangerous when something you do doubles the risk. 3/4 of all lung cancer is cauised by smoking, but lung cancer is still very rare. MOst of the risk is from heart disease. But you really need relative effect to do cuasual inference to transfer results to things with different base rates. YOu need to think about both. " width="80%" />
<p class="caption">Relative effects are useful, but misused in epidemiological risk because it can make a very rare disease look dangerous when something you do doubles the risk. 3/4 of all lung cancer is cauised by smoking, but lung cancer is still very rare. MOst of the risk is from heart disease. But you really need relative effect to do cuasual inference to transfer results to things with different base rates. YOu need to think about both. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L12/16.png" alt="We worry about lots of public health risks. Here's a famous case from the UK. Study of the way that a pill could create blood clots. Turns out that on average they develop in the absence of the pill at 1/1000. (In reality more like 1/10000). Lots of women stopped taking birth control and got pregrant, wihicn is much more dangerous. THis happens whenever th econdition of interest has a really low baserate. A big change in relative risk doesn't make a big absolute difference. But it does when the base rate is large." width="80%" />
<p class="caption">We worry about lots of public health risks. Here's a famous case from the UK. Study of the way that a pill could create blood clots. Turns out that on average they develop in the absence of the pill at 1/1000. (In reality more like 1/10000). Lots of women stopped taking birth control and got pregrant, wihicn is much more dangerous. THis happens whenever th econdition of interest has a really low baserate. A big change in relative risk doesn't make a big absolute difference. But it does when the base rate is large.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L12/17.png" alt="Bionial regression takes two flavours. Either Bernoulli as before, or here, 'aggregated bionmial'. Same kind of model with difference in how the data is coded. Graduate admissions data from Berkeley. Worried they might get sued for gender discrimination. See whether there's any evidence of gender bias. " width="80%" />
<p class="caption">Bionial regression takes two flavours. Either Bernoulli as before, or here, 'aggregated bionmial'. Same kind of model with difference in how the data is coded. Graduate admissions data from Berkeley. Worried they might get sued for gender discrimination. See whether there's any evidence of gender bias. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L12/18.png" alt="This is the whole dataset. Each application is like a coin flip, with a probabilityt htat the candidate is admitted. There are 6 anonymised departments. `admit` is total offered, `reject` is the complement, and `applications` is the total. You could disaggregate them but it would be a really long table with a row of applications. This is a nice compact way to represent it and run exactly the same model either way." width="80%" />
<p class="caption">This is the whole dataset. Each application is like a coin flip, with a probabilityt htat the candidate is admitted. There are 6 anonymised departments. `admit` is total offered, `reject` is the complement, and `applications` is the total. You could disaggregate them but it would be a really long table with a row of applications. This is a nice compact way to represent it and run exactly the same model either way.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L12/19.png" alt="Here's the model. Start by considering just hte index for the applcant's gender, male 1 female 2. Run this model, the marginal posterior distributions. This is log-odds. Lower numbers have lower probability on the outcome scale. Males have -0.22 and females -0.83, so it looks like it's biased in favour of males." width="80%" />
<p class="caption">Here's the model. Start by considering just hte index for the applcant's gender, male 1 female 2. Run this model, the marginal posterior distributions. This is log-odds. Lower numbers have lower probability on the outcome scale. Males have -0.22 and females -0.83, so it looks like it's biased in favour of males.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L12/20.png" alt="Let's calculate the relative and absolute effect sizes. `diff_a` is the difference in log-odds between male and females. Summarise with `precis`. On the probability scale it's between 0.12 and 0.16. That's a huge advantage. If you could swithc your gender, you would get a 10% advantage in admission. That's a big effect. Very fewe things have equally big effects." width="80%" />
<p class="caption">Let's calculate the relative and absolute effect sizes. `diff_a` is the difference in log-odds between male and females. Summarise with `precis`. On the probability scale it's between 0.12 and 0.16. That's a huge advantage. If you could swithc your gender, you would get a 10% advantage in admission. That's a big effect. Very fewe things have equally big effects.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L12/21.png" alt="Now push the posterior out through the model and get predictions. Ugly graph. Blue is raw data. Black is predictions. Open circle is posterior mean for each case in data (combination of department and gender). The posteriro predictions go down as you go from male to female, but at the department level, all except 1 are admitted at a higher rate. " width="80%" />
<p class="caption">Now push the posterior out through the model and get predictions. Ugly graph. Blue is raw data. Black is predictions. Open circle is posterior mean for each case in data (combination of department and gender). The posteriro predictions go down as you go from male to female, but at the department level, all except 1 are admitted at a higher rate. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L12/22.png" alt="There's a backdoor path into gender. One of them is department. They have idfferent overall admission rates. e.g. physics has small number of applicants, and they take half. Social psychology has many more applicants,a nd take 10%. The applicant for these departments differ on gender. Gender influences which department you apply to. Then department influence probability of admission. Interpretation is legally distinct. One leads to Berkeley getting sued, the other gets them off. There are other backdoors, to explore in the homework. Add another vector of parameters. Estiamte them with deltas. " width="80%" />
<p class="caption">There's a backdoor path into gender. One of them is department. They have idfferent overall admission rates. e.g. physics has small number of applicants, and they take half. Social psychology has many more applicants,a nd take 10%. The applicant for these departments differ on gender. Gender influences which department you apply to. Then department influence probability of admission. Interpretation is legally distinct. One leads to Berkeley getting sued, the other gets them off. There are other backdoors, to explore in the homework. Add another vector of parameters. Estiamte them with deltas. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L12/23.png" alt="Let's first think about what the previous model actually asked. They're like hostile genies, who will answer your questions extremely literally. The first model is not asking what the direct path is. It's asking the total causal effect of gender, not the discrimination effect. If you want just that one path, you have to use a different model. You need to close the back door. " width="80%" />
<p class="caption">Let's first think about what the previous model actually asked. They're like hostile genies, who will answer your questions extremely literally. The first model is not asking what the direct path is. It's asking the total causal effect of gender, not the discrimination effect. If you want just that one path, you have to use a different model. You need to close the back door. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L12/24.png" alt="Need to condition on the department's average admission rates. Both causal questions, but different ones. " width="80%" />
<p class="caption">Need to condition on the department's average admission rates. Both causal questions, but different ones. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L12/25.png" alt="Code for the model on the previous slide. Bunch of delta estimates. Notice that some of them are high. Greater than 0 is more than half of applications. Think they're electrical engineering and physics. Then 6 I think is social psychology. Most applications are rejected. Don't have enough slots for the interest. `a` parameters are basically the same. " width="80%" />
<p class="caption">Code for the model on the previous slide. Bunch of delta estimates. Notice that some of them are high. Greater than 0 is more than half of applications. Think they're electrical engineering and physics. Then 6 I think is social psychology. Most applications are rejected. Don't have enough slots for the interest. `a` parameters are basically the same. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L12/26.png" alt="Again, same code. On the relative scale, codnitioning on department, is on averge -0.1. On the probability scale, it's on average a 2% disadvantage for males, but overlaps 0 a little bit. This is Simpson's paradox, where you add a variable and the effect flips. You can do this endlessly. It has to do with backdoor paths. It could be a spurious reversal, or it could be a causal one. " width="80%" />
<p class="caption">Again, same code. On the relative scale, codnitioning on department, is on averge -0.1. On the probability scale, it's on average a 2% disadvantage for males, but overlaps 0 a little bit. This is Simpson's paradox, where you add a variable and the effect flips. You can do this endlessly. It has to do with backdoor paths. It could be a spurious reversal, or it could be a causal one. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L12/27.png" alt="In this case, the reversal tells us something about teh reason. The system is discrimintory, but the departments would not. " width="80%" />
<p class="caption">In this case, the reversal tells us something about teh reason. The system is discrimintory, but the departments would not. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L12/28.png" alt="I have a homework problem where you can explore other paths. It's very hard to make causal inference from these samples, because it's not experimental. If you're doing an intervention to fix this, you need more slots for social psychology." width="80%" />
<p class="caption">I have a homework problem where you can explore other paths. It's very hard to make causal inference from these samples, because it's not experimental. If you're doing an intervention to fix this, you need more slots for social psychology.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L12/29.png" alt="Like binomial models, in whcih the number of trials is unknown and very large, but the probability the event happens is very small. lambda is the average number of events. The variance is also lambda." width="80%" />
<p class="caption">Like binomial models, in whcih the number of trials is unknown and very large, but the probability the event happens is very small. lambda is the average number of events. The variance is also lambda.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L12/30.png" alt="Famous dataset of Prussian soliders getting killed by horse kicks." width="80%" />
<p class="caption">Famous dataset of Prussian soliders getting killed by horse kicks.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L12/31.png" alt="Michelle does ethnographic field work. Interestd in Oceania as a natural experiment in cultutral evolution. Theoretical model that says that cultural evolution is proportional to the logarithm of population size. Even these islands have a small population, they might have a high contact rate." width="80%" />
<p class="caption">Michelle does ethnographic field work. Interestd in Oceania as a natural experiment in cultutral evolution. Theoretical model that says that cultural evolution is proportional to the logarithm of population size. Even these islands have a small population, they might have a high contact rate.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L12/32.png" alt="We'll use a Poisson GLM to model this. Our link is a log-link. This ensures that a parameter is positive. Lambda has to be positive because it's an expected count. " width="80%" />
<p class="caption">We'll use a Poisson GLM to model this. Our link is a log-link. This ensures that a parameter is positive. Lambda has to be positive because it's an expected count. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L12/33.png" alt="Can't have a negative expected count. Maps all negative real numbers to the 0,1 interval. e^0 is 1. All of the positive real numbers get mapped from 1 to infinity. It's really explosive. Literally exponential. We exponentiate the curve. 0 or the left scale is mapped to 1. So you get a massive compression of small numbers. And the other half is 1 to infinity. Hard to have intuitions about it, so we should simulate. " width="80%" />
<p class="caption">Can't have a negative expected count. Maps all negative real numbers to the 0,1 interval. e^0 is 1. All of the positive real numbers get mapped from 1 to infinity. It's really explosive. Literally exponential. We exponentiate the curve. 0 or the left scale is mapped to 1. So you get a massive compression of small numbers. And the other half is 1 to infinity. Hard to have intuitions about it, so we should simulate. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L12/34.png" alt="Need to do prior predictive simulation because of this explosive scaling. Play with some rudimentary Poisson with something 'benign' liek Normal(0,10). Plotted that distribution in black. Doesn't look very flat. The mean of this distribution. The tail goes for a very long time. So something like norm(3, 0.5) gives something that we see in these kinds of archaeological datasets. At least now the prior mean isn't in the billions. 9^12 is a lot of tools. An island full of tools." width="80%" />
<p class="caption">Need to do prior predictive simulation because of this explosive scaling. Play with some rudimentary Poisson with something 'benign' liek Normal(0,10). Plotted that distribution in black. Doesn't look very flat. The mean of this distribution. The tail goes for a very long time. So something like norm(3, 0.5) gives something that we see in these kinds of archaeological datasets. At least now the prior mean isn't in the billions. 9^12 is a lot of tools. An island full of tools.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L12/35.png" alt="On the left we have the slopes for the log population. If we put a normal(0,10) prior, it's explosive. That's a problem. Expect that you'll get a billion tools again. On the right something a lot tighter with 0.2, and a lot flatter on the outcome scale. WIth a GLM, if it's flat ont he linear model scale, it's not going to be falt on the outcome scale. But you hav ethe power of prior predictive simulation to sort this out." width="80%" />
<p class="caption">On the left we have the slopes for the log population. If we put a normal(0,10) prior, it's explosive. That's a problem. Expect that you'll get a billion tools again. On the right something a lot tighter with 0.2, and a lot flatter on the outcome scale. WIth a GLM, if it's flat ont he linear model scale, it's not going to be falt on the outcome scale. But you hav ethe power of prior predictive simulation to sort this out.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L12/36.png" alt="`dpois` is R's Poisson. The top model is intercept only. The model of interest at the bottom. " width="80%" />
<p class="caption">`dpois` is R's Poisson. The top model is intercept only. The model of interest at the bottom. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L12/37.png" alt="We can compare the two. This shows that once you get into GLMs, the efffective number of parameters have very little to do with the actual parameter count. The law in GLMs. All that nice relationship in Gausssian, which is a measure of your overfitting risk, is correlated with yoiur paramter count. Why? Ceiling and floor effects. LOO will still measure your overfitting risk. The model with more parameters has less overfitting risk that the model with only one parameter." width="80%" />
<p class="caption">We can compare the two. This shows that once you get into GLMs, the efffective number of parameters have very little to do with the actual parameter count. The law in GLMs. All that nice relationship in Gausssian, which is a measure of your overfitting risk, is correlated with yoiur paramter count. Why? Ceiling and floor effects. LOO will still measure your overfitting risk. The model with more parameters has less overfitting risk that the model with only one parameter.</p>
</div>

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L12/38.png" width="80%" />

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L12/39.png" width="80%" />

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L12/40.png" width="80%" />

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L12/41.png" width="80%" />

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L12/42.png" width="80%" />

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L12/43.png" width="80%" />

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L12/44.png" width="80%" />

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L12/45.png" width="80%" />

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L12/46.png" width="80%" />

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L12/47.png" width="80%" />

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L12/48.png" width="80%" />

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L12/49.png" width="80%" />

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L12/50.png" width="80%" />

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L12/51.png" width="80%" />

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L12/52.png" width="80%" />

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L12/53.png" width="80%" />

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L12/54.png" alt="Scientific grant awards. " width="80%" />
<p class="caption">Scientific grant awards. </p>
</div>


```r
slides_dir = here::here("docs/slides/L13")
```

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L13/01.png" width="80%" />

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L13/02.png" alt="This course is like this. The lectures are circles, and the homework is the owl. The book has a lot more detail. What it doesn't get quite right about science is that science doesn't know what the owl looks like. There are many many owls that would be satisfactory. There's not some perfect platonic owl." width="80%" />
<p class="caption">This course is like this. The lectures are circles, and the homework is the owl. The book has a lot more detail. What it doesn't get quite right about science is that science doesn't know what the owl looks like. There are many many owls that would be satisfactory. There's not some perfect platonic owl.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L13/03.png" alt="Poisson is a count distribution. 0 to infidinty. Arises where there's some unkown maximum count, but the rate of each trial is very low. This is a very handy way to model counts. This is a very small dataset. Theory that says you get more innovation with larger populations, and therefore more complicated toolkits. Dashed line is for low-contact, solid for high-contact. That's the other interacting effect in the model. Hawaii has low contact. All the others are near one another. Easy to get from one to the other. There's a strong relationship with log population. There's massive uncertainty with large population sizes because there are no high-contact islands with large populations. On the right it's the same curve, but squished. If you calculate the predicted out-of-sample with the Pareto-k, you can find which points are adding uncertainty in prediction. Hawaii has high leverage because it has an order of magnitude higher population, so it's the only one informing what happens on the high end. What could you do? Not drop Hawaii from the analysis, but drop Hawaii playfullly to see what happens. And perhaps you could see there's still a trend for the low-population islands." width="80%" />
<p class="caption">Poisson is a count distribution. 0 to infidinty. Arises where there's some unkown maximum count, but the rate of each trial is very low. This is a very handy way to model counts. This is a very small dataset. Theory that says you get more innovation with larger populations, and therefore more complicated toolkits. Dashed line is for low-contact, solid for high-contact. That's the other interacting effect in the model. Hawaii has low contact. All the others are near one another. Easy to get from one to the other. There's a strong relationship with log population. There's massive uncertainty with large population sizes because there are no high-contact islands with large populations. On the right it's the same curve, but squished. If you calculate the predicted out-of-sample with the Pareto-k, you can find which points are adding uncertainty in prediction. Hawaii has high leverage because it has an order of magnitude higher population, so it's the only one informing what happens on the high end. What could you do? Not drop Hawaii from the analysis, but drop Hawaii playfullly to see what happens. And perhaps you could see there's still a trend for the low-population islands.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L13/04.png" alt="Before we leave this example, here are some criticisms, which extend in general to GLMs. They're unreasonably effective. But, they generate a bunch of anomolies. If you know variables external to the model, they can produce ridiculous effects. If the first time you draw up a quantitative model, something ridiculous happens because you've left something out. Here the first weird thing is the intercept doesn't go through 0. For any real relationships, the 0s have to go together: 0 people = 0 tools. This GLM doesn't assert that because it has a free intercept. This isn't a total disaster. Also this weird thing where they cross." width="80%" />
<p class="caption">Before we leave this example, here are some criticisms, which extend in general to GLMs. They're unreasonably effective. But, they generate a bunch of anomolies. If you know variables external to the model, they can produce ridiculous effects. If the first time you draw up a quantitative model, something ridiculous happens because you've left something out. Here the first weird thing is the intercept doesn't go through 0. For any real relationships, the 0s have to go together: 0 people = 0 tools. This GLM doesn't assert that because it has a free intercept. This isn't a total disaster. Also this weird thing where they cross.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L13/05.png" alt="Let's run a simple model of the system. We want a dynamical systems model. Over time individuals make tools. We start with delta t which is the change in number of tools in a given timestep." width="80%" />
<p class="caption">Let's run a simple model of the system. We want a dynamical systems model. Over time individuals make tools. We start with delta t which is the change in number of tools in a given timestep.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L13/06.png" alt="Then there's a rate of alpha - how many tools can each person invent? You get more people, you get more tools. The beta is an elasticity. That governs the diminishing returns. People get lazy if other people are making them. So the more people you have, the fewer new inventions you get per person. " width="80%" />
<p class="caption">Then there's a rate of alpha - how many tools can each person invent? You get more people, you get more tools. The beta is an elasticity. That governs the diminishing returns. People get lazy if other people are making them. So the more people you have, the fewer new inventions you get per person. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L13/07.png" alt="Then there's the loss. People forget them, or you don't need to use them anymore. Now we'll fit this to data. We've got 3 parameters." width="80%" />
<p class="caption">Then there's the loss. People forget them, or you don't need to use them anymore. Now we'll fit this to data. We've got 3 parameters.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L13/08.png" alt="This model implies a time series. We can use the same model in a cross-sectional case - we need an expectation. We can solve them for steady states where after a while the processes are balanced, where $\Delta T = 0$. On the left we have a hat over T = AlphaP to the Beta over gamma is the expected number of tools. Still stochastic, but the mean of the stationary distribution. Then can stick it into the Poisson. Better than Generalized Linear Madness, because the intercept is fixed here. " width="80%" />
<p class="caption">This model implies a time series. We can use the same model in a cross-sectional case - we need an expectation. We can solve them for steady states where after a while the processes are balanced, where $\Delta T = 0$. On the left we have a hat over T = AlphaP to the Beta over gamma is the expected number of tools. Still stochastic, but the mean of the stationary distribution. Then can stick it into the Poisson. Better than Generalized Linear Madness, because the intercept is fixed here. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L13/09.png" alt="Can just write this into a Markov chain. Same idea, but now for lambda there's no link function. The only trick is that all these parameters needs to be positive. You have an array of tools to do that. One is to exponenentiate the parameter, which is what I've done with alpha. This is just a trick for making alpha positive. You're taking  a log normal now. For the other two I give them exponential distributions.  " width="80%" />
<p class="caption">Can just write this into a Markov chain. Same idea, but now for lambda there's no link function. The only trick is that all these parameters needs to be positive. You have an array of tools to do that. One is to exponenentiate the parameter, which is what I've done with alpha. This is just a trick for making alpha positive. You're taking  a log normal now. For the other two I give them exponential distributions.  </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L13/10.png" alt="Chains happen, and you can compare the two models. The scientific model has flaws, but now it passes through the origin. And you get real separation nwo between the solid and dashed lines. Now the violations mean something. And the parameters have biological meaning. You can use epxerimental datasets to get information about the parameters. " width="80%" />
<p class="caption">Chains happen, and you can compare the two models. The scientific model has flaws, but now it passes through the origin. And you get real separation nwo between the solid and dashed lines. Now the violations mean something. And the parameters have biological meaning. You can use epxerimental datasets to get information about the parameters. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L13/11.png" alt="Every particular scientific example has its own idiosyncracies. So why teach GLMs? Because they're useful for everyone. If the different counts have different exposures or observation windows. If someone spends twice as much time fishing, we have to adjust for the exposure difference. How to do this? Use an offset, which is a log of the amount of time spent fishing. " width="80%" />
<p class="caption">Every particular scientific example has its own idiosyncracies. So why teach GLMs? Because they're useful for everyone. If the different counts have different exposures or observation windows. If someone spends twice as much time fishing, we have to adjust for the exposure difference. How to do this? Use an offset, which is a log of the amount of time spent fishing. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L13/12.png" alt="There are other count distributions. Multinomial categorical models are extrapolations to more than two unordered outcomes. Geometric distributions are count distributions. Mixtures are binomial regressions, but allow the rates to vary in each case. Like multi-level models where you don't estimate the random effects." width="80%" />
<p class="caption">There are other count distributions. Multinomial categorical models are extrapolations to more than two unordered outcomes. Geometric distributions are count distributions. Mixtures are binomial regressions, but allow the rates to vary in each case. Like multi-level models where you don't estimate the random effects.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L13/13.png" alt="I want to motivate this. They're like count models because they have discrete events. In this dataset it's cat adoptions. But to do this properly, you need to estimate the rate of the events. The parameters are about rates, and survival is counts. So imagine some lonely cat, and it's waiting to be adopted, and then it escapes. We don't know whether the cat would ever be adopted or not. The wrong this to do is throw it away, because it's still importnat to know how long it was waiting. So we have to count things that weren't counted. e.g. escaped, died of natural causes, whatever. This is called censoring. Left-consoring is when we don't know when the cat arrived. Right censoring is where at the time of counting they haven't been adopted yet. " width="80%" />
<p class="caption">I want to motivate this. They're like count models because they have discrete events. In this dataset it's cat adoptions. But to do this properly, you need to estimate the rate of the events. The parameters are about rates, and survival is counts. So imagine some lonely cat, and it's waiting to be adopted, and then it escapes. We don't know whether the cat would ever be adopted or not. The wrong this to do is throw it away, because it's still importnat to know how long it was waiting. So we have to count things that weren't counted. e.g. escaped, died of natural causes, whatever. This is called censoring. Left-consoring is when we don't know when the cat arrived. Right censoring is where at the time of counting they haven't been adopted yet. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L13/14.png" alt="20K cats from the Austin animal facility. Lots of things we know about them. Interested in adoption rates. In particular we want to compare all other cats to black cats. There are adoption events, so given some assumption about the rate. And want to predict what will happen given you're waiting a certain amount of times. Some die, some escape, and pure censoring is the cat is still there when we pulled the data. Epidemiological studies are like this. " width="80%" />
<p class="caption">20K cats from the Austin animal facility. Lots of things we know about them. Interested in adoption rates. In particular we want to compare all other cats to black cats. There are adoption events, so given some assumption about the rate. And want to predict what will happen given you're waiting a certain amount of times. Some die, some escape, and pure censoring is the cat is still there when we pulled the data. Epidemiological studies are like this. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L13/15.png" alt="The simplest kind of distribution for survival analysis is exponential. So the probability of getting adopted that day comes fromt he exponential distribution. " width="80%" />
<p class="caption">The simplest kind of distribution for survival analysis is exponential. So the probability of getting adopted that day comes fromt he exponential distribution. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L13/16.png" alt="Measures the probability that it hasn't happened after a certain length of time. " width="80%" />
<p class="caption">Measures the probability that it hasn't happened after a certain length of time. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L13/17.png" alt="You're really just coding the log-posterior here. It's raw stuff. If adopted = 0, now we're censored, so we need CCDF. When it sees a culstom tag, you can do a lot of dangerous things. " width="80%" />
<p class="caption">You're really just coding the log-posterior here. It's raw stuff. If adopted = 0, now we're censored, so we need CCDF. When it sees a culstom tag, you can do a lot of dangerous things. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L13/18.png" alt="Black cats are discriminated against. There's a column for cat colours. " width="80%" />
<p class="caption">Black cats are discriminated against. There's a column for cat colours. </p>
</div>

