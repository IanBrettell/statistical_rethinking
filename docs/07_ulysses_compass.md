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

# Ulysses' Compass


```r
library(here)
source(here::here("code/scripts/source.R"))
```


```r
slides_dir = here::here("docs/slides/L07")
```

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L07/14.png" alt="Polish astronomer and ecclesiastical lawyer. Famous for arguing about the heliocentric model. What's missing is that Copernicus's model was terrible. No better than the Ptolemaic model." width="80%" />
<p class="caption">Polish astronomer and ecclesiastical lawyer. Famous for arguing about the heliocentric model. What's missing is that Copernicus's model was terrible. No better than the Ptolemaic model.</p>
</div>



<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L07/15.png" alt="Keppler later figured out that orbits were ellipses. If you're committed to circles, you can't make it work unless you stack circles on circles. Was an equivalent model. Copernican needed fewer epicricles.. it's simpler, and therefore more beautiful. " width="80%" />
<p class="caption">Keppler later figured out that orbits were ellipses. If you're committed to circles, you can't make it work unless you stack circles on circles. Was an equivalent model. Copernican needed fewer epicricles.. it's simpler, and therefore more beautiful. </p>
</div>



<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L07/16.png" alt="Not a fully-developed research program. Need something more substantial if we wantto chose between models based on complexity." width="80%" />
<p class="caption">Not a fully-developed research program. Need something more substantial if we wantto chose between models based on complexity.</p>
</div>



<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L07/17.png" alt="Often we have to make trade-offs between complexity and accuracy. Usually what we're trading off. So Ockham's Razor is one-sided. Let's think of _The Odyssey_. He gets near Sicily, and there are two monsters, Scylla and Charybdis, who eat most of his crew." width="80%" />
<p class="caption">Often we have to make trade-offs between complexity and accuracy. Usually what we're trading off. So Ockham's Razor is one-sided. Let's think of _The Odyssey_. He gets near Sicily, and there are two monsters, Scylla and Charybdis, who eat most of his crew.</p>
</div>



<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L07/18.png" alt="Metaphor for how complexity and accuracy trade off. There are monsters on both sides, with different characteristics. " width="80%" />
<p class="caption">Metaphor for how complexity and accuracy trade off. There are monsters on both sides, with different characteristics. </p>
</div>



<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L07/19.png" alt="In the wilds of the sciences, the standard method is &quot;star-gazing&quot;, because you run a regression and you keep the asterisks. There's nothing about p-values, but whether you use them or not, they're not designed for this, so they do a bad job at it. Statistical significance is not a criterion about predictive accuracy, but rather Type 1 error rate." width="80%" />
<p class="caption">In the wilds of the sciences, the standard method is "star-gazing", because you run a regression and you keep the asterisks. There's nothing about p-values, but whether you use them or not, they're not designed for this, so they do a bad job at it. Statistical significance is not a criterion about predictive accuracy, but rather Type 1 error rate.</p>
</div>



<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L07/20.png" alt="Scylla and Charybdis. Regularization teaches statistical models to expect overfitting and guard against it. CV and information cirteria are tools to cope with it,  by not solving it, but measuiring it. Want to emphasise that finding a model that makes good predictions is different from causal inference. Netflix predicts your viewing habits. No one understands how those systems work. But in the basic sciences we intend to intervene. " width="80%" />
<p class="caption">Scylla and Charybdis. Regularization teaches statistical models to expect overfitting and guard against it. CV and information cirteria are tools to cope with it,  by not solving it, but measuiring it. Want to emphasise that finding a model that makes good predictions is different from causal inference. Netflix predicts your viewing habits. No one understands how those systems work. But in the basic sciences we intend to intervene. </p>
</div>



<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L07/21.png" alt="Think about a contest between different models. In a given race (sample), one horse will win (fit it the best). The distance between the horses gives us information about the relative performance on average across tracks. You want to make a bet on the _next_ race. The quantiative differences between the finishing times is what you want to use. The finishing times won't be exactly the same. What you shouldn't do is alwasy choose the horse that runs the fastest." width="80%" />
<p class="caption">Think about a contest between different models. In a given race (sample), one horse will win (fit it the best). The distance between the horses gives us information about the relative performance on average across tracks. You want to make a bet on the _next_ race. The quantiative differences between the finishing times is what you want to use. The finishing times won't be exactly the same. What you shouldn't do is alwasy choose the horse that runs the fastest.</p>
</div>



<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L07/22.png" alt="The basic problem is that models that are too simple don't know enough; and models that are too complex learn too much. On the extrmee, you can encrypt every data point as a parameter, but it will make terrible predictions. Want to learn the &quot;regular features&quot; of the sample. Multilevel models don't work like this because they're less liekly to overfit. I have a model with 27K parameters, and it overfits very little because of this hierarchical structure." width="80%" />
<p class="caption">The basic problem is that models that are too simple don't know enough; and models that are too complex learn too much. On the extrmee, you can encrypt every data point as a parameter, but it will make terrible predictions. Want to learn the "regular features" of the sample. Multilevel models don't work like this because they're less liekly to overfit. I have a model with 27K parameters, and it overfits very little because of this hierarchical structure.</p>
</div>



<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L07/23.png" alt="Humans have big brains. If we look at body mass v brain volume, there is some association. What's the statistical relationship?" width="80%" />
<p class="caption">Humans have big brains. If we look at body mass v brain volume, there is some association. What's the statistical relationship?</p>
</div>



<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L07/24.png" alt="$R^2$ is one of the most over-used measures. If there's no variance in the residuals, $R^2$ = 1. It's trivial to get there. A bit of a joke, but I've seen it in _Nature_." width="80%" />
<p class="caption">$R^2$ is one of the most over-used measures. If there's no variance in the residuals, $R^2$ = 1. It's trivial to get there. A bit of a joke, but I've seen it in _Nature_.</p>
</div>



<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L07/25.png" alt="This isn't a bad model. $R^2$ is 0.5 - that's pretty good. But can you do better?" width="80%" />
<p class="caption">This isn't a bad model. $R^2$ is 0.5 - that's pretty good. But can you do better?</p>
</div>



<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L07/26.png" alt="Sure, make it a parabola. Does a little better. Why stop there?" width="80%" />
<p class="caption">Sure, make it a parabola. Does a little better. Why stop there?</p>
</div>



<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L07/27.png" alt="We can make it all the way to 6 parameters, then we run out of data points." width="80%" />
<p class="caption">We can make it all the way to 6 parameters, then we run out of data points.</p>
</div>



<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L07/28.png" width="80%" />



<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L07/29.png" alt="Maybe brain evolution is cubic." width="80%" />
<p class="caption">Maybe brain evolution is cubic.</p>
</div>



<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L07/30.png" width="80%" />



<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L07/31.png" width="80%" />



<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L07/32.png" alt="Finally, we've reached nirvana - the singularity. If all you do basing your model on $R^2$, this is the danger. In multiple regression, it's less obvious that it's happening." width="80%" />
<p class="caption">Finally, we've reached nirvana - the singularity. If all you do basing your model on $R^2$, this is the danger. In multiple regression, it's less obvious that it's happening.</p>
</div>



<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L07/33.png" alt="The model is overly sensitive. We can repeat the linear regression, removing one data point at a time. The lines don't move very much. Drops a lot when we drop _homo sapiens_." width="80%" />
<p class="caption">The model is overly sensitive. We can repeat the linear regression, removing one data point at a time. The lines don't move very much. Drops a lot when we drop _homo sapiens_.</p>
</div>



<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L07/34.png" alt="This fifth-order polynomial." width="80%" />
<p class="caption">This fifth-order polynomial.</p>
</div>



<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L07/35.png" alt="Multiple strategies. In Bayesian statistics, we regularise. Can be even omre aggressive. In non-Bayesian, it's mathematically identical to using a prior. Why do machine leanring people regularise? Because it makes better predictions. " width="80%" />
<p class="caption">Multiple strategies. In Bayesian statistics, we regularise. Can be even omre aggressive. In non-Bayesian, it's mathematically identical to using a prior. Why do machine leanring people regularise? Because it makes better predictions. </p>
</div>



<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L07/36.png" alt="We want to get to CV and WAIC, which replaced AIC. The jounrey to these appraoches requires some setups. First thing to answer is how to measure accuracy. Many bad ways to measure it. There's an actual gold standard. And once we've got it, we want to measure distance from the target. How do we decide how close the models are getting to it? Then we learn how to develop these instruments." width="80%" />
<p class="caption">We want to get to CV and WAIC, which replaced AIC. The jounrey to these appraoches requires some setups. First thing to answer is how to measure accuracy. Many bad ways to measure it. There's an actual gold standard. And once we've got it, we want to measure distance from the target. How do we decide how close the models are getting to it? Then we learn how to develop these instruments.</p>
</div>



<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L07/37.png" width="80%" />

-----


```r
slides_dir = here::here("docs/slides/L08")
```

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L08/01.png" width="60%" />

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L08/02.png" alt="We need to appeal to information theory because machine prediction works by following the laws of information theory. We'll drive the single gold-standard way to score a model's accuracy. Here's the basic problem information theory sets out to address. When we have some unknown event, there is uncertainty. When we know more, we become less uncertain. IC is a principle for saying when something is more uncertain than something else. There's uncertainty about the weather tomorrow. We may use cues from today to predict tomorrow." width="60%" />
<p class="caption">We need to appeal to information theory because machine prediction works by following the laws of information theory. We'll drive the single gold-standard way to score a model's accuracy. Here's the basic problem information theory sets out to address. When we have some unknown event, there is uncertainty. When we know more, we become less uncertain. IC is a principle for saying when something is more uncertain than something else. There's uncertainty about the weather tomorrow. We may use cues from today to predict tomorrow.</p>
</div>



<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L08/03.png" alt="Presume you know that LA has no weather. Always sunny. 15-20 degrees. Little uncertainty. If it does rain, you'll be shocked. Contrast this with Glasgow, where it rains a lot. More rain than not. NY has highly-variable weather. There's great uncertainty about what the weather would be like, unlike the other two. This uncertainty arises from the frequency distributions of these microclimates." width="60%" />
<p class="caption">Presume you know that LA has no weather. Always sunny. 15-20 degrees. Little uncertainty. If it does rain, you'll be shocked. Contrast this with Glasgow, where it rains a lot. More rain than not. NY has highly-variable weather. There's great uncertainty about what the weather would be like, unlike the other two. This uncertainty arises from the frequency distributions of these microclimates.</p>
</div>



<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L08/04.png" alt="Uncertainty $H$ of $p$, which is a vector of probability, is just the average log-probability of the event. This is a unique criterion. If you want a reasonable measure of surprise, you have to adopt something that is this or something proportional to this. Your mobile phones (3G and above) work because of this." width="60%" />
<p class="caption">Uncertainty $H$ of $p$, which is a vector of probability, is just the average log-probability of the event. This is a unique criterion. If you want a reasonable measure of surprise, you have to adopt something that is this or something proportional to this. Your mobile phones (3G and above) work because of this.</p>
</div>


<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L08/05.png" alt="What's the **potential for surprise**?. We are interested in this. Want to calculate the entropy of our model, and then there's the entropy of the true distribution, of nature. And we want to minimise the difference between them. This is called the $D_{KL}$ divergence. Two probabilities $p$ and $q$. $p$ is nature, say the frequencies of weather events, and $q$ is our forecast. If we want to score $q$, we look at the divergence. K is for Kulbak. The distance from $p$ to $q$ is the sum (averaging) between $p$ and $q$. It's a distance, but it's not symmetric. " width="60%" />
<p class="caption">What's the **potential for surprise**?. We are interested in this. Want to calculate the entropy of our model, and then there's the entropy of the true distribution, of nature. And we want to minimise the difference between them. This is called the $D_{KL}$ divergence. Two probabilities $p$ and $q$. $p$ is nature, say the frequencies of weather events, and $q$ is our forecast. If we want to score $q$, we look at the divergence. K is for Kulbak. The distance from $p$ to $q$ is the sum (averaging) between $p$ and $q$. It's a distance, but it's not symmetric. </p>
</div>



<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L08/06.png" alt="Easy to code. Take the vector `p`. Sum `p` time the difference between `log(p)` and `log(q)`. It's only 0 where `q = p`. " width="60%" />
<p class="caption">Easy to code. Take the vector `p`. Sum `p` time the difference between `log(p)` and `log(q)`. It's only 0 where `q = p`. </p>
</div>



<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L08/07.png" alt="Here's a cartoon version. You're heading to Mars, or a Mars-like planet, but you don't know much about it. You can't control your rocket and you want to predict whether you'll land on water or land. You'll use Earth as your only model. Earth is a high-entropy planet because it has a lot of water and land. So you won't be surprised whether you get land or water. " width="60%" />
<p class="caption">Here's a cartoon version. You're heading to Mars, or a Mars-like planet, but you don't know much about it. You can't control your rocket and you want to predict whether you'll land on water or land. You'll use Earth as your only model. Earth is a high-entropy planet because it has a lot of water and land. So you won't be surprised whether you get land or water. </p>
</div>



<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L08/08.png" alt="But say you're going in the other direction. Your potential for surprise is now very high. When you get to Earth and discover all this blue liquid, you'll be surprised. Mars is the LA of planets. And as a consequence, the information distance from Earth to Mars is smaller than the information distance from Mars to Earth. Because if your model is the Earth, it expects all sorts of events, which means that it's less surprised, which means that its prediction error is lower, on average, across a huge number of potential planets across the universe, than if you came from Mars, where you'll be surprised by water all the time. **This is why simpler models work better - because they have higher entropy.** The distance between a simpler model and other things are on average lower, because it expects many things. Gneeralized linear models have higher entropy. All machine learning works this way." width="60%" />
<p class="caption">But say you're going in the other direction. Your potential for surprise is now very high. When you get to Earth and discover all this blue liquid, you'll be surprised. Mars is the LA of planets. And as a consequence, the information distance from Earth to Mars is smaller than the information distance from Mars to Earth. Because if your model is the Earth, it expects all sorts of events, which means that it's less surprised, which means that its prediction error is lower, on average, across a huge number of potential planets across the universe, than if you came from Mars, where you'll be surprised by water all the time. **This is why simpler models work better - because they have higher entropy.** The distance between a simpler model and other things are on average lower, because it expects many things. Gneeralized linear models have higher entropy. All machine learning works this way.</p>
</div>



<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L08/09.png" alt="How to estimate this in practice: we want the gold standard way to score, but the problem is we can't score the truth. Turns out we don't need the truth part because it's just an additive term, so you can get the relative scores of the models without knowning the truth. THe log score is the gold standard, whether you're Bayesian or not. In practice, there's not a single log score, but a distribution of log scores. So we want the average log score, which unfortunately is called the *log-pointwise-predictive-density*. For each point `i`, we're taking the average probability of that observation conditional on the samples, and we average over the samples, and find the average probabiltiy that the model expects, then we take the log and sum across all observations in the model." width="60%" />
<p class="caption">How to estimate this in practice: we want the gold standard way to score, but the problem is we can't score the truth. Turns out we don't need the truth part because it's just an additive term, so you can get the relative scores of the models without knowning the truth. THe log score is the gold standard, whether you're Bayesian or not. In practice, there's not a single log score, but a distribution of log scores. So we want the average log score, which unfortunately is called the *log-pointwise-predictive-density*. For each point `i`, we're taking the average probability of that observation conditional on the samples, and we average over the samples, and find the average probabiltiy that the model expects, then we take the log and sum across all observations in the model.</p>
</div>



<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L08/10.png" alt="Why does this all matter in a practical sense? We can measure overfitting. Look at the difference between in- and out-of-sample. Smaller is better. The more negative it is, the better it is. Two samples from the same generative process. Training and testing set. Fit our model to the training sample, and get the deviance of train. Then we force it to predict the out-of-sample. The difference between them are our measure of overfitting." width="60%" />
<p class="caption">Why does this all matter in a practical sense? We can measure overfitting. Look at the difference between in- and out-of-sample. Smaller is better. The more negative it is, the better it is. Two samples from the same generative process. Training and testing set. Fit our model to the training sample, and get the deviance of train. Then we force it to predict the out-of-sample. The difference between them are our measure of overfitting.</p>
</div>



<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L08/11.png" alt="We'll generate some samples based on a known &quot;truth&quot;. The first is our intercept model. " width="60%" />
<p class="caption">We'll generate some samples based on a known "truth". The first is our intercept model. </p>
</div>



<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L08/12.png" alt="This is what happens in-sample. Lower deviance is better. The point is the average across all simulations, with one standard deviation on either side. Note the more complicated models do better. They're always going to fit in-sample better. Note there's a big jump at 3, then very little after 3. " width="60%" />
<p class="caption">This is what happens in-sample. Lower deviance is better. The point is the average across all simulations, with one standard deviation on either side. Note the more complicated models do better. They're always going to fit in-sample better. Note there's a big jump at 3, then very little after 3. </p>
</div>



<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L08/13.png" alt="Here's out-of-sample. Unsurprisingly, everything does worse out-of-sample. There's a pattern to the amount of overfitting. You can see that model 3 is best on average. Models 4 and 5 get progressively worse, because they're fitting noise. " width="60%" />
<p class="caption">Here's out-of-sample. Unsurprisingly, everything does worse out-of-sample. There's a pattern to the amount of overfitting. You can see that model 3 is best on average. Models 4 and 5 get progressively worse, because they're fitting noise. </p>
</div>



<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L08/14.png" alt="In anthropology we're happy with 20. But with N = 100, you can more precisely estimate when a data point doesn't matter. So 4 and 5 are only slightly worse. Because you can get a really good posterior distribution. But they pattern is the same. There's a very special pattern in the distances between these points. On the left, you can see the distances are growing, and approximately twice the number of parameters in each case. Hold that in your mind." width="60%" />
<p class="caption">In anthropology we're happy with 20. But with N = 100, you can more precisely estimate when a data point doesn't matter. So 4 and 5 are only slightly worse. Because you can get a really good posterior distribution. But they pattern is the same. There's a very special pattern in the distances between these points. On the left, you can see the distances are growing, and approximately twice the number of parameters in each case. Hold that in your mind.</p>
</div>



<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L08/15.png" alt="The first thing to do is regularize. We don't want to use flat priors. We have to be skeptical. We have to build scepticiism into the models. Choose priors that only give us possible outcomes. That helps to regularise - to reduce overfitting. " width="60%" />
<p class="caption">The first thing to do is regularize. We don't want to use flat priors. We have to be skeptical. We have to build scepticiism into the models. Choose priors that only give us possible outcomes. That helps to regularise - to reduce overfitting. </p>
</div>



<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L08/16.png" alt="The model on the left is the linear regression model. We're going to use different standard deviations to deduce different amounts of skeptisism to large effects. SD of 0.2 is the very peaked one. Which of these will be best?" width="60%" />
<p class="caption">The model on the left is the linear regression model. We're going to use different standard deviations to deduce different amounts of skeptisism to large effects. SD of 0.2 is the very peaked one. Which of these will be best?</p>
</div>



<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L08/17.png" alt="On average, how did they do in-sample? The more sceptical prior does worse." width="60%" />
<p class="caption">On average, how did they do in-sample? The more sceptical prior does worse.</p>
</div>



<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L08/18.png" width="60%" />



<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L08/19.png" alt="But out of sample, it's the opposite. Why? Because it learns less from the sample. It's skeptical. Out of sample, it predicts best because it ignored irregular distractions. Now in any particular problem the pattern might be different. Too skeptical and you can overshoot. But some scepticism helps you make good predictions. That's why you should never use flat priors. Even slightly curved and you'll do better. The order is the same, but the differences are tiny. Because if you have enough data, the regularisation isnt' doing any heavy work for you. But for a small sample, regularization does a lot. With multi-level models, we have to revisit, because even in really big smaple sizes there are some parameters with not big datasets." width="60%" />
<p class="caption">But out of sample, it's the opposite. Why? Because it learns less from the sample. It's skeptical. Out of sample, it predicts best because it ignored irregular distractions. Now in any particular problem the pattern might be different. Too skeptical and you can overshoot. But some scepticism helps you make good predictions. That's why you should never use flat priors. Even slightly curved and you'll do better. The order is the same, but the differences are tiny. Because if you have enough data, the regularisation isnt' doing any heavy work for you. But for a small sample, regularization does a lot. With multi-level models, we have to revisit, because even in really big smaple sizes there are some parameters with not big datasets.</p>
</div>



<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L08/20.png" alt="In industry, there's a lot of regularisation, because they're scored on it. But they do care about predictive accuracy. Why do scientists care less? Maybe because we're not taught to. Functionally, it makes getting significant results harder. Maybe the biggest thing is that we're not judged on the accuracy of future predictions. We don't have a strong philosophy on how it's connected to inference." width="60%" />
<p class="caption">In industry, there's a lot of regularisation, because they're scored on it. But they do care about predictive accuracy. Why do scientists care less? Maybe because we're not taught to. Functionally, it makes getting significant results harder. Maybe the biggest thing is that we're not judged on the accuracy of future predictions. We don't have a strong philosophy on how it's connected to inference.</p>
</div>


<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L08/21.png" alt="If we regularize correctly, we'll do better out-of-sample. We can actually predict the amount of overfitting, even when you don't have the out-of-sample. This is all small-world stuff, so be sceptical, but it gives us a principled way of talking about a model in terms of its overfitting risk. " width="60%" />
<p class="caption">If we regularize correctly, we'll do better out-of-sample. We can actually predict the amount of overfitting, even when you don't have the out-of-sample. This is all small-world stuff, so be sceptical, but it gives us a principled way of talking about a model in terms of its overfitting risk. </p>
</div>



<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L08/22.png" alt="If you do this across lots of left-out bits from your sample, that turns out to be a really good approximation of your model. These prediction contests in industry. Motivated this on Monday talking about under- vs over-fitted model. There's a LOOCV function for `quap`. Huge literature about how many to leave out. But the general idea is to use this. " width="60%" />
<p class="caption">If you do this across lots of left-out bits from your sample, that turns out to be a really good approximation of your model. These prediction contests in industry. Motivated this on Monday talking about under- vs over-fitted model. There's a LOOCV function for `quap`. Huge literature about how many to leave out. But the general idea is to use this. </p>
</div>



<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L08/23.png" alt="These days you have too many data points. Really good analytical approximations, like Pareto-smoothed. Incredibly accurate. Pareto-smoothed is useful because you get a lot of diagnostic information." width="60%" />
<p class="caption">These days you have too many data points. Really good analytical approximations, like Pareto-smoothed. Incredibly accurate. Pareto-smoothed is useful because you get a lot of diagnostic information.</p>
</div>



<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L08/24.png" alt="Other approach, stemming from Akaike. To get an analytical approximation, a lot of assumptions are made, including that you need a Gaussian distribution. If that's true, you can get a really nice approxiatmion of the performance of the log score out-of-sample. Just the training deviance time twice th enumber of parameters. Incredible acheivement." width="60%" />
<p class="caption">Other approach, stemming from Akaike. To get an analytical approximation, a lot of assumptions are made, including that you need a Gaussian distribution. If that's true, you can get a really nice approxiatmion of the performance of the log score out-of-sample. Just the training deviance time twice th enumber of parameters. Incredible acheivement.</p>
</div>



<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L08/25.png" alt="It has since been eclipsed. Another theoretical statistician has developed this new, more capable version. This thing looks complicated, but lppd is the Bayesian distance, and the penalty term on the right is the point-wise variance of the log probability of each observation. That's the generalised parameter count you want. This works for anything. Turns out in general the parameter count isn't what matters, rather the variance in the posterior distribution. And for models with flat priors and Gaussian distributions, it gives you the same value as AIC. But in general we won't use flat priors, and it often has interesting information." width="60%" />
<p class="caption">It has since been eclipsed. Another theoretical statistician has developed this new, more capable version. This thing looks complicated, but lppd is the Bayesian distance, and the penalty term on the right is the point-wise variance of the log probability of each observation. That's the generalised parameter count you want. This works for anything. Turns out in general the parameter count isn't what matters, rather the variance in the posterior distribution. And for models with flat priors and Gaussian distributions, it gives you the same value as AIC. But in general we won't use flat priors, and it often has interesting information.</p>
</div>



<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L08/26.png" alt="Now we'll score them on their error. All are trying to estimate the prediction error. So how close do they get? Top are flat priors. Open circles and the actual generalisation errors. Each trend line is a different metric for calculating it. WAIC is getting closer, but the differences are really small. LOOIC is a really good approximation. At the bottom we have regularising priors. Everything does better, but the differences are about the same. Unit difference on the vertical is tiny." width="60%" />
<p class="caption">Now we'll score them on their error. All are trying to estimate the prediction error. So how close do they get? Top are flat priors. Open circles and the actual generalisation errors. Each trend line is a different metric for calculating it. WAIC is getting closer, but the differences are really small. LOOIC is a really good approximation. At the bottom we have regularising priors. Everything does better, but the differences are about the same. Unit difference on the vertical is tiny.</p>
</div>



<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L08/27.png" alt="Target we're trying to get is the out-of-sample error. These differences are tiny. All of these things work amazingly well." width="60%" />
<p class="caption">Target we're trying to get is the out-of-sample error. These differences are tiny. All of these things work amazingly well.</p>
</div>



<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L08/28.png" alt="When samples are large, they all work identically." width="60%" />
<p class="caption">When samples are large, they all work identically.</p>
</div>



<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L08/29.png" alt="Avoid model selection. We want to score the expected overfitting models to understand their properties. In the sciences we usually have an inferential objective, rather than a predictive one. But if you intend to intervene in the world, then we don't want to use these criteria to select a model, but rather to compare them." width="60%" />
<p class="caption">Avoid model selection. We want to score the expected overfitting models to understand their properties. In the sciences we usually have an inferential objective, rather than a predictive one. But if you intend to intervene in the world, then we don't want to use these criteria to select a model, but rather to compare them.</p>
</div>



<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L08/30.png" alt="Smaller numbers are better, so the top model is 6.7 that includes the fungus. Can probably see the difference here. The fungus is what's causal. Inference about cause and finding a predictive model aren't the same thing. So you need to do both, but keep in mind that they're different. Because you haven't necessarily inferred a cause if you have good prediction error, because you might have blocked a pipe. Even spurious correlations are useful. The confounding really matters when you want to intervene. The highest preditive model won't necessary predict what will happen when you intervene. " width="60%" />
<p class="caption">Smaller numbers are better, so the top model is 6.7 that includes the fungus. Can probably see the difference here. The fungus is what's causal. Inference about cause and finding a predictive model aren't the same thing. So you need to do both, but keep in mind that they're different. Because you haven't necessarily inferred a cause if you have good prediction error, because you might have blocked a pipe. Even spurious correlations are useful. The confounding really matters when you want to intervene. The highest preditive model won't necessary predict what will happen when you intervene. </p>
</div>



<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L08/31.png" width="60%" />



<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L08/32.png" width="60%" />



<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L08/33.png" alt="Incredibly clever and diabolical. Interested in life history evolution. Something to understand by looking at the whole field. Here's a dataset to consider. Why does lifespan vary so much? A typcial kind of conceptual model is this idea that body mass = fewer things kill you = living longer. And brain size = smart = avoiding danger. Should also season your DAG with some unobserved confounds." width="60%" />
<p class="caption">Incredibly clever and diabolical. Interested in life history evolution. Something to understand by looking at the whole field. Here's a dataset to consider. Why does lifespan vary so much? A typcial kind of conceptual model is this idea that body mass = fewer things kill you = living longer. And brain size = smart = avoiding danger. Should also season your DAG with some unobserved confounds.</p>
</div>



<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L08/34.png" alt="After you remove all the missing values, you get three models. The first is the industry standard m7.8 everyone expects to be the right prediction model. WIf we wnat ot figure out the infleucne of brainsize on lifespan, we need to block the backdoor path on body mass. Black dots are the in-sample, and open are the WAIC scores. Bars are standard errors. 7.8 and 7.9 are basically equivalent in their out-of-sample predictions. When you see something like this, you should see this as an invitiation to poke inside them. You can use IC to do that poiking." width="60%" />
<p class="caption">After you remove all the missing values, you get three models. The first is the industry standard m7.8 everyone expects to be the right prediction model. WIf we wnat ot figure out the infleucne of brainsize on lifespan, we need to block the backdoor path on body mass. Black dots are the in-sample, and open are the WAIC scores. Bars are standard errors. 7.8 and 7.9 are basically equivalent in their out-of-sample predictions. When you see something like this, you should see this as an invitiation to poke inside them. You can use IC to do that poiking.</p>
</div>



<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L08/35.png" alt="bM is the slope for body mass, and bB is the slope for brain size. 7.9 only has bM, and says there's a positive correlation. The model with both has this catastrophic flipping. Now bM is negative? What's going on here? " width="60%" />
<p class="caption">bM is the slope for body mass, and bB is the slope for brain size. 7.9 only has bM, and says there's a positive correlation. The model with both has this catastrophic flipping. Now bM is negative? What's going on here? </p>
</div>



<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L08/36.png" alt="The thing to do here is to do WAIC point-wise. For each species in the sample, say the Capuchin monkey which has those life history characteristics, which model expects to do the best out-of-sample on organisms with those same covariates? Or you could think about it as entropy scores, or divergence scores, to say how surprised is this model by a Capuchin monkey? The relative surprise between these models is plotted. " width="60%" />
<p class="caption">The thing to do here is to do WAIC point-wise. For each species in the sample, say the Capuchin monkey which has those life history characteristics, which model expects to do the best out-of-sample on organisms with those same covariates? Or you could think about it as entropy scores, or divergence scores, to say how surprised is this model by a Capuchin monkey? The relative surprise between these models is plotted. </p>
</div>



<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L08/37.png" alt="The model with brain + mass does better with Capuchins because they have small brains, but they're really big for their body size. So if you don't control for body size, you can't explain their longevity. So the model without body size is really surprised by Cebus. Lepilemur on the other extreme with small brains and extremely short lifespans, where you'd be surprised if you ignore body size." width="60%" />
<p class="caption">The model with brain + mass does better with Capuchins because they have small brains, but they're really big for their body size. So if you don't control for body size, you can't explain their longevity. So the model without body size is really surprised by Cebus. Lepilemur on the other extreme with small brains and extremely short lifespans, where you'd be surprised if you ignore body size.</p>
</div>



<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L08/38.png" alt="On the other hand, for these you can make fine predictions by knowing body size. So you can understand how they perform if you look point-wise. This is a principled way to inspect and understand your golem. Also a way to find your high-leverage points." width="60%" />
<p class="caption">On the other hand, for these you can make fine predictions by knowing body size. So you can understand how they perform if you look point-wise. This is a principled way to inspect and understand your golem. Also a way to find your high-leverage points.</p>
</div>

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L08/39.png" width="80%" />

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L08/40.png" width="80%" />

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L08/41.png" width="80%" />

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L08/42.png" width="80%" />




