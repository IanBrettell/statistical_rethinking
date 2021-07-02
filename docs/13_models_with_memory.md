---
title: "Notes for Statistical Rethinking 2nd ed. by Richard McElreath"
date: '2021-06-22'
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

# Models With Memory


```r
library(here)
source(here::here("code/scripts/source.R"))
```


```r
slides_dir = here::here("docs/slides/L15")
```

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L15/01.png" width="80%" />

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L15/02.png" alt="Way to justify multi-level models is that it's better to remember things than not to. Most of the statistical models we've considered up to this point is like this." width="80%" />
<p class="caption">Way to justify multi-level models is that it's better to remember things than not to. Most of the statistical models we've considered up to this point is like this.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L15/03.png" alt="In statistical language, they've all been fixed effects models. They have amnesia in that every time you move to a new cluster (indivdual, pond, block), it forgets everything it's seen about the thigns they visited previously. Learning develops expectations and lets us learn. MLMs develop expectations about all clusters in the data. They learn in a way that's invariant to the order that they miight visit them. That's the optimal way to learn. Some metaphors to latch onto..." width="80%" />
<p class="caption">In statistical language, they've all been fixed effects models. They have amnesia in that every time you move to a new cluster (indivdual, pond, block), it forgets everything it's seen about the thigns they visited previously. Learning develops expectations and lets us learn. MLMs develop expectations about all clusters in the data. They learn in a way that's invariant to the order that they miight visit them. That's the optimal way to learn. Some metaphors to latch onto...</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L15/04.png" alt="Imagine you're visiting some cafes. The experience is largely the same. Here we're contrasting Paris and Berlin. Let's focus on one aspect of ordering - how long you wait for your cofffee. If you've never been to a cafe, you have no expectation of how long it takes. Then you go to Paris, and it takes 5 minutes. Then when you go to Berlin, you don't forget that experience, but you also don't think it's going to be exactly the same. A remmbering model treats a cafe as a population. And you can transfer infomration among units in that population. And that allows for better estaimtes for every cafe. Other thing to think is if it takes 10 minutes in Berlin, you had your 5 mintue prior, you update that with Bayesian updating, but the time order should be irrelevant to your learning. Now you need to update Paris too, because you have a limited sample in Paris, and you've got data from Berlin. So data from both are relevant to updating both of them. " width="80%" />
<p class="caption">Imagine you're visiting some cafes. The experience is largely the same. Here we're contrasting Paris and Berlin. Let's focus on one aspect of ordering - how long you wait for your cofffee. If you've never been to a cafe, you have no expectation of how long it takes. Then you go to Paris, and it takes 5 minutes. Then when you go to Berlin, you don't forget that experience, but you also don't think it's going to be exactly the same. A remmbering model treats a cafe as a population. And you can transfer infomration among units in that population. And that allows for better estaimtes for every cafe. Other thing to think is if it takes 10 minutes in Berlin, you had your 5 mintue prior, you update that with Bayesian updating, but the time order should be irrelevant to your learning. Now you need to update Paris too, because you have a limited sample in Paris, and you've got data from Berlin. So data from both are relevant to updating both of them. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L15/05.png" alt="How much information you transfer across depends on how variable they are. You learnn this variance as well. Different metaphor now. In East Africa, one of the strategies for not getting intestinal infections was to carry around a bunch of chillies. These are goat peppers. Their spiciness is quite random. One could be a dud, and the next one will kill you. When estiamting the spiciness of one particular plant, you can use your expectation from the whole population but because the plants are so variable, it's hard to transfer informtaion. It woud be as if with cafes, some give it instantly, others make you wait half an hour, so it's hard to estimate how long you'll wait. This variation is another thing we have to learn." width="80%" />
<p class="caption">How much information you transfer across depends on how variable they are. You learnn this variance as well. Different metaphor now. In East Africa, one of the strategies for not getting intestinal infections was to carry around a bunch of chillies. These are goat peppers. Their spiciness is quite random. One could be a dud, and the next one will kill you. When estiamting the spiciness of one particular plant, you can use your expectation from the whole population but because the plants are so variable, it's hard to transfer informtaion. It woud be as if with cafes, some give it instantly, others make you wait half an hour, so it's hard to estimate how long you'll wait. This variation is another thing we have to learn.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L15/06.png" alt="In this course, we have to wage our statistical battles on two fronts: causal inference. Avoid causal salad - they typical way it's done. Having a DAG you believe in is a small victory, but not the only thing. Getting precise estiamates is a whole separate technology. Today we'll be talking about the second. If we can use the data in more powerful ways, that's what we'll do. " width="80%" />
<p class="caption">In this course, we have to wage our statistical battles on two fronts: causal inference. Avoid causal salad - they typical way it's done. Having a DAG you believe in is a small victory, but not the only thing. Getting precise estiamates is a whole separate technology. Today we'll be talking about the second. If we can use the data in more powerful ways, that's what we'll do. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L15/07.png" alt="There are some really good defaults. Unfortuatnely they're not currently. As a default, you should always use multi-level regression. Single-level is always a bad idea. This is my favourite example of defaults. In some countries you are automatically. In others you have to opt in. In Germany, if you ask them if you should dontate your organs, most say yes. But the defaults are powerful, and MLMs are like that." width="80%" />
<p class="caption">There are some really good defaults. Unfortuatnely they're not currently. As a default, you should always use multi-level regression. Single-level is always a bad idea. This is my favourite example of defaults. In some countries you are automatically. In others you have to opt in. In Germany, if you ask them if you should dontate your organs, most say yes. But the defaults are powerful, and MLMs are like that.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L15/08.png" alt="There are always reasons to use them, but they're always important. Typically they're better. " width="80%" />
<p class="caption">There are always reasons to use them, but they're always important. Typically they're better. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L15/09.png" alt="Here's what I want to get across today. Why shrinkage and pooling are good. How to do this with `ulam`. Show you how to plot and compre them. And going forward, this will open up a lot of model types. Factor models are a kind of MLM. Turtles all the way down; parameters all the way down. Model in a model. " width="80%" />
<p class="caption">Here's what I want to get across today. Why shrinkage and pooling are good. How to do this with `ulam`. Show you how to plot and compre them. And going forward, this will open up a lot of model types. Factor models are a kind of MLM. Turtles all the way down; parameters all the way down. Model in a model. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L15/10.png" alt="What are they for? We're interested in what they can do for us: They help us with clustering in our dataset. e.g. you have a single dataset on educatioal tests, you can have a bunch of different levels nested within one another, and repeated observations at each of those levels. This is especially important when there's imbalance in sampling. Some of the clusters have been visited more than others, and you don't want that imbalance to let them dominate inference by regarding them separately. In biology, there's this term pseudoreplication. These models handle that." width="80%" />
<p class="caption">What are they for? We're interested in what they can do for us: They help us with clustering in our dataset. e.g. you have a single dataset on educatioal tests, you can have a bunch of different levels nested within one another, and repeated observations at each of those levels. This is especially important when there's imbalance in sampling. Some of the clusters have been visited more than others, and you don't want that imbalance to let them dominate inference by regarding them separately. In biology, there's this term pseudoreplication. These models handle that.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L15/11.png" alt="We already had examples in this course. All of these things are clusters. " width="80%" />
<p class="caption">We already had examples in this course. All of these things are clusters. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L15/12.png" alt="Reed frog tadpoles. Quasi-experimental field experiment. Eggs were suspended on leaves above buckets. When they hatch, the tadpoles fall down below. In this experiment they land in the bucket, which are microcosms which you can manipulate. The outcome of interest is the number of surivivors in each bucket (pond). " width="80%" />
<p class="caption">Reed frog tadpoles. Quasi-experimental field experiment. Eggs were suspended on leaves above buckets. When they hatch, the tadpoles fall down below. In this experiment they land in the bucket, which are microcosms which you can manipulate. The outcome of interest is the number of surivivors in each bucket (pond). </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L15/13.png" alt="We have tadpoles in tanks (buckets). They're at different densities. Different maximums can survive. This will be binomial regression. Number at start and end. Dummy variable is what we've done before. Now MLM with different intercepts." width="80%" />
<p class="caption">We have tadpoles in tanks (buckets). They're at different densities. Different maximums can survive. This will be binomial regression. Number at start and end. Dummy variable is what we've done before. Now MLM with different intercepts.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L15/14.png" alt="This is what we've done before. We have na index variable for tank. Different alpha. Regularising prior. Extreme mortality or survival will be viewed skeptivcally because of that 1.5. This is a fine model, but not a multi-level model. It has amnesia as you move from tank to tank. The only data in the dataset that informs each alpha is the data for that tank only. It learns about tank 1, using 7 tadpoles, estimates the alpha, then moves to the next tank and forgets all about it.  " width="80%" />
<p class="caption">This is what we've done before. We have na index variable for tank. Different alpha. Regularising prior. Extreme mortality or survival will be viewed skeptivcally because of that 1.5. This is a fine model, but not a multi-level model. It has amnesia as you move from tank to tank. The only data in the dataset that informs each alpha is the data for that tank only. It learns about tank 1, using 7 tadpoles, estimates the alpha, then moves to the next tank and forgets all about it.  </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L15/15.png" alt="We can do better than this. This is a reminder on how it's fitted." width="80%" />
<p class="caption">We can do better than this. This is a reminder on how it's fitted.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L15/16.png" alt="Now let's try something different. Added some stuff in blue. Let's step through. " width="80%" />
<p class="caption">Now let's try something different. Added some stuff in blue. Let's step through. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L15/17.png" alt="$\alpha_j$ is still there. But I've made it into this magical thing called varying intercetps by inserting parameters inside the prior. Where there used to be (0, 1.5). $\bar{\alpha}$ is a parameter in and of itself that we're going to estimate. Represents the mean $\alpha$. Then $\sigma$, which is the SD in this population. So each $\alpha_j$ where $j$ is a tank has this prior. Then for these new parameters we have to give them priors. We give $\bar{\alpha}$ our regularizing prior, same with $\sigma$." width="80%" />
<p class="caption">$\alpha_j$ is still there. But I've made it into this magical thing called varying intercetps by inserting parameters inside the prior. Where there used to be (0, 1.5). $\bar{\alpha}$ is a parameter in and of itself that we're going to estimate. Represents the mean $\alpha$. Then $\sigma$, which is the SD in this population. So each $\alpha_j$ where $j$ is a tank has this prior. Then for these new parameters we have to give them priors. We give $\bar{\alpha}$ our regularizing prior, same with $\sigma$.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L15/18.png" alt="Why would we do this? What are varying intercepts? What's distinctive about this model, and the parameters inside the prior, is that you learn the prior from the data. So we'll regularise because it gives better predictions. Now we'll learn it from the data itself, and it's like visiting cafés. As you learn the variation among them, you pool the information across. " width="80%" />
<p class="caption">Why would we do this? What are varying intercepts? What's distinctive about this model, and the parameters inside the prior, is that you learn the prior from the data. So we'll regularise because it gives better predictions. Now we'll learn it from the data itself, and it's like visiting cafés. As you learn the variation among them, you pool the information across. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L15/19.png" alt="We have to learn those parameters and get posterior distributions for each from the data." width="80%" />
<p class="caption">We have to learn those parameters and get posterior distributions for each from the data.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L15/20.png" alt="Then each of those gets a prior. A prior of a prior is called a hyperprior. They're all just priors. But now they're feeding up, with multiple levels of inference. You'll notice the line for $\alpha_j$ looks like the top line. The fact that it's not observed is irrelevant.  " width="80%" />
<p class="caption">Then each of those gets a prior. A prior of a prior is called a hyperprior. They're all just priors. But now they're feeding up, with multiple levels of inference. You'll notice the line for $\alpha_j$ looks like the top line. The fact that it's not observed is irrelevant.  </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L15/21.png" alt="In code. Just write what's up there into `ulam`. " width="80%" />
<p class="caption">In code. Just write what's up there into `ulam`. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L15/22.png" alt="If you focus on the model structure, you can understand things. If you focus on terminology, you'll get confused. Let's compare these models. Want to show you something about flexibilty in random effects 13.1 is fixed effects. 13.2 is MLM. In terms of WAIC, they're very similar. Not much of a difference. But look at the effective number of parameters. 131. has 48 paramaters because there are 48 tanks. One parameter for each. It ends up with 25 effective. Why? Because of the regularising prior. It wasn't flat. That means there are tank where all the tadploles survived. What's the log-odds of that? Infinite. But because of the piror, you don't end up with an alpha of infinity. What's happening with 13.2 is we've addedd two more parameters  ($\bar{\alpha}$ and $\sigma$). But fewer effective parameters. When teaching you about overfitting, the caveat was that every time you add a paramter the fit in-sample imporoves. *Other than* with MLMs. They learn how regular to be from the data itself. The regularising prior ends up being narrower. One of the coolest facts in statistics. Deep learning works because it's deep. Parameters stacked on parameters.  " width="80%" />
<p class="caption">If you focus on the model structure, you can understand things. If you focus on terminology, you'll get confused. Let's compare these models. Want to show you something about flexibilty in random effects 13.1 is fixed effects. 13.2 is MLM. In terms of WAIC, they're very similar. Not much of a difference. But look at the effective number of parameters. 131. has 48 paramaters because there are 48 tanks. One parameter for each. It ends up with 25 effective. Why? Because of the regularising prior. It wasn't flat. That means there are tank where all the tadploles survived. What's the log-odds of that? Infinite. But because of the piror, you don't end up with an alpha of infinity. What's happening with 13.2 is we've addedd two more parameters  ($\bar{\alpha}$ and $\sigma$). But fewer effective parameters. When teaching you about overfitting, the caveat was that every time you add a paramter the fit in-sample imporoves. *Other than* with MLMs. They learn how regular to be from the data itself. The regularising prior ends up being narrower. One of the coolest facts in statistics. Deep learning works because it's deep. Parameters stacked on parameters.  </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L15/23.png" alt="Graphically, we'll compare the two models. Across the horizontal is all 48 tanks. They come in three sizes. You'll see that experimentally they were set up to be small, medium and large. Very cool experiment. Small have smaller initial density. Medium and large likewise. On the vertical, we're looking at the proportion survive. The outcome scale. Or the probability of survival. Blue dots are raw data. So you'll see the 1s on top. That's where all the lucky tadpoles lived. The open cricles are the multi-level estimates. THere's a pattern here - shrinkage. The model is not retrodicting the sample, but that's why it's a good model. Wnat to learn the regular features to make better predictions. The regularizing prior was learned from teh data so it knows how to treat all the data. The dashed line is the popoulation mean, $\bar{\alpha}$that we have estimated from the data." width="80%" />
<p class="caption">Graphically, we'll compare the two models. Across the horizontal is all 48 tanks. They come in three sizes. You'll see that experimentally they were set up to be small, medium and large. Very cool experiment. Small have smaller initial density. Medium and large likewise. On the vertical, we're looking at the proportion survive. The outcome scale. Or the probability of survival. Blue dots are raw data. So you'll see the 1s on top. That's where all the lucky tadpoles lived. The open cricles are the multi-level estimates. THere's a pattern here - shrinkage. The model is not retrodicting the sample, but that's why it's a good model. Wnat to learn the regular features to make better predictions. The regularizing prior was learned from teh data so it knows how to treat all the data. The dashed line is the popoulation mean, $\bar{\alpha}$that we have estimated from the data.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L15/24.png" alt="The raw mean is in a different place. Why? The raw mean comes from taking all the tadpoles and putting them into one group. The ones on the right bias the estimate because ethe survival rate is lower. If you want the mean of a population in idniviaul tanks, it's not pappropriate. " width="80%" />
<p class="caption">The raw mean is in a different place. Why? The raw mean comes from taking all the tadpoles and putting them into one group. The ones on the right bias the estimate because ethe survival rate is lower. If you want the mean of a population in idniviaul tanks, it's not pappropriate. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L15/25.png" alt="Above the dashed line, the open circles are off the blue lines towards the dashed line. The closer you are to it, the less difference between the two. If you're below the dashed line, you go up. This is shrinkage - shirnakge toward the poupatlion mean. If the divergence formt eh popuation mean is extreme, it's more sceptical and shrinks more. " width="80%" />
<p class="caption">Above the dashed line, the open circles are off the blue lines towards the dashed line. The closer you are to it, the less difference between the two. If you're below the dashed line, you go up. This is shrinkage - shirnakge toward the poupatlion mean. If the divergence formt eh popuation mean is extreme, it's more sceptical and shrinks more. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L15/26.png" alt="Large tanks you see the shrinkage is smaller because there's more evidence in each tank - greater sample size. So more precise estimate in each tank. Each tank can overwhelm the information in the population. Only observations are 0 or 1. Otherwise we'd have massive overfitting. In any particualr dataset the exact amount of shrinkage will depend on many variables. Here it's reducing the fit-to-sample to improve rpedictive accuracy. You add parameters, and get better predictions out-of-sample.  " width="80%" />
<p class="caption">Large tanks you see the shrinkage is smaller because there's more evidence in each tank - greater sample size. So more precise estimate in each tank. Each tank can overwhelm the information in the population. Only observations are 0 or 1. Otherwise we'd have massive overfitting. In any particualr dataset the exact amount of shrinkage will depend on many variables. Here it's reducing the fit-to-sample to improve rpedictive accuracy. You add parameters, and get better predictions out-of-sample.  </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L15/27.png" alt="The more often you go to a cafe, the more data you have on that cafe, the less you need the population information. Extreme values are treated with sceticism of getting the same ones in the future." width="80%" />
<p class="caption">The more often you go to a cafe, the more data you have on that cafe, the less you need the population information. Extreme values are treated with sceticism of getting the same ones in the future.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L15/28.png" alt="All of this is really dealing with over/under-fitting. No pooling because there's no information being excahnged among clusters. How much pooling? Depends on variation among clusters. " width="80%" />
<p class="caption">All of this is really dealing with over/under-fitting. No pooling because there's no information being excahnged among clusters. How much pooling? Depends on variation among clusters. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L15/29.png" alt="Try to back this up with a picture. MLM at the top. Focus on $\sigma$. If this was the cafes, it's the variation in wait times. " width="80%" />
<p class="caption">Try to back this up with a picture. MLM at the top. Focus on $\sigma$. If this was the cafes, it's the variation in wait times. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L15/30.png" alt="On the left it has a minimum of 0. If we fix it at 0 or put a really strong prior on it, it converges to the pooling model. All clusters are the same, and it will converge to the grand mean. Exactly one alpha. They're all there, but all the same." width="80%" />
<p class="caption">On the left it has a minimum of 0. If we fix it at 0 or put a really strong prior on it, it converges to the pooling model. All clusters are the same, and it will converge to the grand mean. Exactly one alpha. They're all there, but all the same.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L15/31.png" alt="On the other extreme, it's infinity. If sigma goes there, you get no pooling. Statistically assuming all tanks are infinteily different from each other. As a vertebrate, as you go from cafe to cafe, you do the pooling. YOur brain won't let you ignore the variation. But a statistical model won't do that unless you tell it to. If you want to program a robot to borrow information across clusters, you can't let $\sigma$ be infinity. The estimate for any particular alpha will be a mix of the data in that tank and all of the other tanks. The mix depends on the variation on the tanks. If there's no variation across tanks, then the whole population is used. If sigma goes to infitnty , you ignore the population." width="80%" />
<p class="caption">On the other extreme, it's infinity. If sigma goes there, you get no pooling. Statistically assuming all tanks are infinteily different from each other. As a vertebrate, as you go from cafe to cafe, you do the pooling. YOur brain won't let you ignore the variation. But a statistical model won't do that unless you tell it to. If you want to program a robot to borrow information across clusters, you can't let $\sigma$ be infinity. The estimate for any particular alpha will be a mix of the data in that tank and all of the other tanks. The mix depends on the variation on the tanks. If there's no variation across tanks, then the whole population is used. If sigma goes to infitnty , you ignore the population.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L15/32.png" alt="In this paritcular model, you estimate sigma for the data, and it turns out to be this posterior here. Can get an almost Gaussian posterior. And that's the extreme amount of variation. What does this population look like? Not a real population, but a statistical one." width="80%" />
<p class="caption">In this paritcular model, you estimate sigma for the data, and it turns out to be this posterior here. Can get an almost Gaussian posterior. And that's the extreme amount of variation. What does this population look like? Not a real population, but a statistical one.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L15/33.png" alt="The population-generating process is called an ecologist. Those processes generate popualations with real mortality effects. We can draw this statistical population. Combinations of alphas and betes produce lines. Alphas and betas are correlated, which is why you need to draw correlated smaples from the posterior. Now the lines are a distribution of distributions. We don't know the distribution. Let's draw it. We could just draw correlated pairs as densities. On the left is a gaussian distribution of log-odds probability. Why Gaussian? Because we said it was. Most tadpoles survive. But there's a lot of heterogeneity. You can see that in the distribution. Ont he right I've transofrmed to the outcome probability scale. About half of the tanks we get a high survival rate. " width="80%" />
<p class="caption">The population-generating process is called an ecologist. Those processes generate popualations with real mortality effects. We can draw this statistical population. Combinations of alphas and betes produce lines. Alphas and betas are correlated, which is why you need to draw correlated smaples from the posterior. Now the lines are a distribution of distributions. We don't know the distribution. Let's draw it. We could just draw correlated pairs as densities. On the left is a gaussian distribution of log-odds probability. Why Gaussian? Because we said it was. Most tadpoles survive. But there's a lot of heterogeneity. You can see that in the distribution. Ont he right I've transofrmed to the outcome probability scale. About half of the tanks we get a high survival rate. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L15/34.png" alt="So I keep asserting that the shrinkage estiamtes are better. Let's demonstrate it. We do better in prediction. WAIC works in theory, predicting the out-of-sample accuracy. Regularisation is good. Simulate a bunch of ponds, 60 of them, with different densities of tadpoles in each of 15 ponds. `true.a` is the true log-oddds survival rate. True because we' ve simulated it. THen simulated surivval events. `s`. Therea re some wipeouts, like pond 5. Then the next two are statsitcal estiamtes. `p.nopool` is the raw fixed effects estiamte. The MLM estimate is `p.partpool`. Then `p.true` is the inverse logit of `true.a`. Now we can assess because we can compare it to the truth." width="80%" />
<p class="caption">So I keep asserting that the shrinkage estiamtes are better. Let's demonstrate it. We do better in prediction. WAIC works in theory, predicting the out-of-sample accuracy. Regularisation is good. Simulate a bunch of ponds, 60 of them, with different densities of tadpoles in each of 15 ponds. `true.a` is the true log-oddds survival rate. True because we' ve simulated it. THen simulated surivval events. `s`. Therea re some wipeouts, like pond 5. Then the next two are statsitcal estiamtes. `p.nopool` is the raw fixed effects estiamte. The MLM estimate is `p.partpool`. Then `p.true` is the inverse logit of `true.a`. Now we can assess because we can compare it to the truth.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L15/35.png" alt="On the left we have tiny ponds. The blue points are the raw proportions survived. The open points are the partial pooling estimates. The error is the absolute error from the true value. 0 is totally correct. A lot of error here because you've only got 5 tadpoles. Hard to estimate the probability of heads if you only flip the coin 5 times. THe blue horizontal bar is the average of the raw estimates, the dashed is for the MLM. They're not perfect, but they're better. THis is all shrinkage. " width="80%" />
<p class="caption">On the left we have tiny ponds. The blue points are the raw proportions survived. The open points are the partial pooling estimates. The error is the absolute error from the true value. 0 is totally correct. A lot of error here because you've only got 5 tadpoles. Hard to estimate the probability of heads if you only flip the coin 5 times. THe blue horizontal bar is the average of the raw estimates, the dashed is for the MLM. They're not perfect, but they're better. THis is all shrinkage. </p>
</div>

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L15/36.png" width="80%" />

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L15/37.png" alt="The other tanks. The pattern holds as you go across. The amount of error declines, because we have more data. The difference, the advantage of MLMs, shrinks. But still estimates the popualtion, which is important for prediction. So even when it doesn't give you bettre predictions, it allows you to make them in the right way because it takes account of populations. " width="80%" />
<p class="caption">The other tanks. The pattern holds as you go across. The amount of error declines, because we have more data. The difference, the advantage of MLMs, shrinks. But still estimates the popualtion, which is important for prediction. So even when it doesn't give you bettre predictions, it allows you to make them in the right way because it takes account of populations. </p>
</div>

-----


```r
slides_dir = here::here("docs/slides/L16")
```

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L16/01.png" width="80%" />

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L16/02.png" alt="Experiment with a small number of chimps. Replicated on each. 4 treatments with prosocial option. Question is do they intepret it that way? " width="80%" />
<p class="caption">Experiment with a small number of chimps. Replicated on each. 4 treatments with prosocial option. Question is do they intepret it that way? </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L16/03.png" alt="Want to use it to learn how to build a more complex vasrying effects model when we have more than one type of cluster. Called cross-classfication. The indivdual chimps are cross-classified, as is experimental day. In this dataset everything is balanced. All the chimps in all the blocks. Going to use both these types of clusters. Actors is a clsuter so we can estimate parameters specific to the chimp, like handedness. Also have repeated observations inside blocks. You can just design them liek a varying intercept model. " width="80%" />
<p class="caption">Want to use it to learn how to build a more complex vasrying effects model when we have more than one type of cluster. Called cross-classfication. The indivdual chimps are cross-classified, as is experimental day. In this dataset everything is balanced. All the chimps in all the blocks. Going to use both these types of clusters. Actors is a clsuter so we can estimate parameters specific to the chimp, like handedness. Also have repeated observations inside blocks. You can just design them liek a varying intercept model. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L16/04.png" alt="Here's the MLM with both actor and block intercepts. Alpha for each actor, gamma for each block, and beta for each treatment. Ordinary fixed effects, regularising, not adaptive. Just like tank effects. Interpretation is the handedness. Adaptive prior, with alpha bar. And a sigma alpha. So the model will learn the prior from the data." width="80%" />
<p class="caption">Here's the MLM with both actor and block intercepts. Alpha for each actor, gamma for each block, and beta for each treatment. Ordinary fixed effects, regularising, not adaptive. Just like tank effects. Interpretation is the handedness. Adaptive prior, with alpha bar. And a sigma alpha. So the model will learn the prior from the data.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L16/05.png" alt="Then another adaptive prior, gamma for each block. It's conditional on each parameter. No gamma bar. You could put it there, but it would be redundant. Could just put a 0 there. Hyperpriors at the bottom. Blue bits are the block. You can extend this strategy for as many cluster types as you like. " width="80%" />
<p class="caption">Then another adaptive prior, gamma for each block. It's conditional on each parameter. No gamma bar. You could put it there, but it would be redundant. Could just put a 0 there. Hyperpriors at the bottom. Blue bits are the block. You can extend this strategy for as many cluster types as you like. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L16/06.png" alt="Just a logistic regression with a bunch of stuff. `a[actor]`. " width="80%" />
<p class="caption">Just a logistic regression with a bunch of stuff. `a[actor]`. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L16/07.png" alt="`a` for each actor. Vector of those. They each have a common prior, with two parameters inside it. Conditional on other parameters (which makes it adaptive.) Then at the bottom it gives it shape. " width="80%" />
<p class="caption">`a` for each actor. Vector of those. They each have a common prior, with two parameters inside it. Conditional on other parameters (which makes it adaptive.) Then at the bottom it gives it shape. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L16/08.png" alt="Same thing for blocks. Block in the model, black adaptive prior, then sigma. " width="80%" />
<p class="caption">Same thing for blocks. Block in the model, black adaptive prior, then sigma. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L16/09.png" alt="Run this model at home. WOn't encounter any problems. Plot the precis on the left. Treatment parameters. No new story here. Atraacted to the prosocial option, but not more when there's a partner. `a[2]` has a big intecetpt. Why such a wide marginal posterior for left? `g` are block effects. All very small, around 0. Which means there's not much variation among blocks. Then down the bottom we have alpha bar, which is lslightly left-handed. THen the two sigmas teell the same story. The variation among actor and block, you cna see the actors vary more, and the sigmas are picking them up. For actor, sigma of 2 is very big. sigma[g] is practically 0. Plotted the two densities for the sigma variables. The consequence of this is there's a lot more shrinkage among blocks. The actors had very little shrinkage, becuase lefty proves that indibvdiuals are indiviuals, with personality." width="80%" />
<p class="caption">Run this model at home. WOn't encounter any problems. Plot the precis on the left. Treatment parameters. No new story here. Atraacted to the prosocial option, but not more when there's a partner. `a[2]` has a big intecetpt. Why such a wide marginal posterior for left? `g` are block effects. All very small, around 0. Which means there's not much variation among blocks. Then down the bottom we have alpha bar, which is lslightly left-handed. THen the two sigmas teell the same story. The variation among actor and block, you cna see the actors vary more, and the sigmas are picking them up. For actor, sigma of 2 is very big. sigma[g] is practically 0. Plotted the two densities for the sigma variables. The consequence of this is there's a lot more shrinkage among blocks. The actors had very little shrinkage, becuase lefty proves that indibvdiuals are indiviuals, with personality.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L16/10.png" alt="Natural to ask then, should we even have varying intercepts on bllock. Doesn't matter. Levae them out and get the same inference. Nice feature of varying effects is if there's not much vasriation, not harmful to add varying effects. Here's the sam emodel, but we've taken out the block effects eentirely, but with varying intercepts on indviuals, and can compare with WAIC or LOO, and see that they're very similar models. Effectively the same. Notice the parameter counts have a small difference. 2 effective parameter difference, even though it has 7 more parameters. Lots of machine learning works this way.  " width="80%" />
<p class="caption">Natural to ask then, should we even have varying intercepts on bllock. Doesn't matter. Levae them out and get the same inference. Nice feature of varying effects is if there's not much vasriation, not harmful to add varying effects. Here's the sam emodel, but we've taken out the block effects eentirely, but with varying intercepts on indviuals, and can compare with WAIC or LOO, and see that they're very similar models. Effectively the same. Notice the parameter counts have a small difference. 2 effective parameter difference, even though it has 7 more parameters. Lots of machine learning works this way.  </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L16/11.png" alt="Let's add some more random effects. Synonym of varying effects. Rnadom has a tendency to interpret effects in a stronger way. Just a statistcal way to regularise inference. Source of clusters is irrelevant to whethr to add random effects or not. Wnat to regularise, but not adaptively. If you care about mroe accurate inferences, use adaptive priors. All we have ot do is add a sigma beta. Give it a parameter and we learn it. " width="80%" />
<p class="caption">Let's add some more random effects. Synonym of varying effects. Rnadom has a tendency to interpret effects in a stronger way. Just a statistcal way to regularise inference. Source of clusters is irrelevant to whethr to add random effects or not. Wnat to regularise, but not adaptively. If you care about mroe accurate inferences, use adaptive priors. All we have ot do is add a sigma beta. Give it a parameter and we learn it. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L16/12.png" alt="One more sigma down the bottom. Run it and compare to the preivous. They're basiclaly the same estimates. Why? Because there's tonnes of data per treatment. It trims the posterior uncertainty a little bit, but doesn't change the effective inference." width="80%" />
<p class="caption">One more sigma down the bottom. Run it and compare to the preivous. They're basiclaly the same estimates. Why? Because there's tonnes of data per treatment. It trims the posterior uncertainty a little bit, but doesn't change the effective inference.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L16/13.png" alt="You will get these warnings. Divergent transitions. They are your friend, in the sense that they are telling you something numerically inefficient about ht emodel. Easy to get rid of them. Teaches you someting really important. Even though mathematiclaly equivalent, the Markvov Chain will see them as quite different. Need to swtich between different ways of writing the same model. Gives you advice to increase `adapt_delta`. But sometimes that won't save you, and you just need to re-parameterise the modeo." width="80%" />
<p class="caption">You will get these warnings. Divergent transitions. They are your friend, in the sense that they are telling you something numerically inefficient about ht emodel. Easy to get rid of them. Teaches you someting really important. Even though mathematiclaly equivalent, the Markvov Chain will see them as quite different. Need to swtich between different ways of writing the same model. Gives you advice to increase `adapt_delta`. But sometimes that won't save you, and you just need to re-parameterise the modeo.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L16/14.png" alt="Imagine you're on a frictionless rollercoaster. As it moves from A to D, there are two forms of energy. The energy is in two buckets. Start at A and going to B, it lost potential gravitational energy, and is converted to kinetic energy, to motion. Then as it goes from B to C, that conversion goes the other way. Then C to D, and will do it again. The sum of those two things is constant in a frictionless system." width="80%" />
<p class="caption">Imagine you're on a frictionless rollercoaster. As it moves from A to D, there are two forms of energy. The energy is in two buckets. Start at A and going to B, it lost potential gravitational energy, and is converted to kinetic energy, to motion. Then as it goes from B to C, that conversion goes the other way. Then C to D, and will do it again. The sum of those two things is constant in a frictionless system.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L16/15.png" alt="Divergent transitions are when your rollercoaster pops off the track. In Hamiltonian dynamics, it is the total energy in the system. If energy isn't conserved in the chain, something is wrong. We have little steps, we calculate the gradient, find a step, and get a piecewise approximation. When the rollercoaster track bends really biolently, or the stepsize is big, it can happen. Divergent means it pops off the true surface. On the right is a posterior distribution that tends towards divergent transitions. It happens when you have parameters that is conditional on other parameters. Gibbs and Metropolis experience the same thing, but don't tell you when it's happening. Hamiltonian just works better especially in high dimensions, but also gives you diagnostic information." width="80%" />
<p class="caption">Divergent transitions are when your rollercoaster pops off the track. In Hamiltonian dynamics, it is the total energy in the system. If energy isn't conserved in the chain, something is wrong. We have little steps, we calculate the gradient, find a step, and get a piecewise approximation. When the rollercoaster track bends really biolently, or the stepsize is big, it can happen. Divergent means it pops off the true surface. On the right is a posterior distribution that tends towards divergent transitions. It happens when you have parameters that is conditional on other parameters. Gibbs and Metropolis experience the same thing, but don't tell you when it's happening. Hamiltonian just works better especially in high dimensions, but also gives you diagnostic information.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L16/16.png" alt="This is a routine situation where you get divergent transitions. Arises often in the funnel. Turn it on its side. Very simple posterior with two parameters, $v$ and $x$. $x$ is conditional on $v$. When this is true you can get very interesting shapes. As $v$ gets small, $x$ contracts and you get a very narrow valley. Curvature is really tight there. Out in the big plane you can take big steps. But out in the valley, there's no single step size that can efficiently explore both. You want a bigger one int he open area, and a smaller one in the tight area." width="80%" />
<p class="caption">This is a routine situation where you get divergent transitions. Arises often in the funnel. Turn it on its side. Very simple posterior with two parameters, $v$ and $x$. $x$ is conditional on $v$. When this is true you can get very interesting shapes. As $v$ gets small, $x$ contracts and you get a very narrow valley. Curvature is really tight there. Out in the big plane you can take big steps. But out in the valley, there's no single step size that can efficiently explore both. You want a bigger one int he open area, and a smaller one in the tight area.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L16/17.png" alt="When energy at the start is different form the energy at the end, that's divergent. This doesn't necessarily corrupt your chain, but it's less efficient. The places where you do the rejections are particular regions of the posterior, and you won't be sampling that area of it. We can also make the step size small, but spend your time missing your funnel completely. Stan will do better than this, but as you increase the dimensionality, it gets pathological. So what do we do?" width="80%" />
<p class="caption">When energy at the start is different form the energy at the end, that's divergent. This doesn't necessarily corrupt your chain, but it's less efficient. The places where you do the rejections are particular regions of the posterior, and you won't be sampling that area of it. We can also make the step size small, but spend your time missing your funnel completely. Stan will do better than this, but as you increase the dimensionality, it gets pathological. So what do we do?</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L16/18.png" alt="The first mean you could spend a long time finding the funnel. Also makes the chain run slower. Second is to re-parameterize. When the chain is inefficient, it's usually because I did something stupid, like leave out a prior." width="80%" />
<p class="caption">The first mean you could spend a long time finding the funnel. Also makes the chain run slower. Second is to re-parameterize. When the chain is inefficient, it's usually because I did something stupid, like leave out a prior.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L16/19.png" alt="It's a wonderful fact that any statistical model can be expressed in a few identical ways. Alpha is conditional on mu and sigma. " width="80%" />
<p class="caption">It's a wonderful fact that any statistical model can be expressed in a few identical ways. Alpha is conditional on mu and sigma. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L16/20.png" alt="Alpha has some probability distribution. This is another way to do it. Now alpha has the same distribution of alpha at the top, just took mu out and then added it back later. " width="80%" />
<p class="caption">Alpha has some probability distribution. This is another way to do it. Now alpha has the same distribution of alpha at the top, just took mu out and then added it back later. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L16/21.png" alt="We can go one step further and get $z$. When we multiply the zs by sigma, we're back on the scale. And add mu back in and we're in the same place." width="80%" />
<p class="caption">We can go one step further and get $z$. When we multiply the zs by sigma, we're back on the scale. And add mu back in and we're in the same place.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L16/22.png" alt="Why do this? Even though it's mathematically the same, the geometry is different. On the left we have the default (centered) form. There are parameters inside the distribution. Non-centered is wehre we take all the conditioniing out. Let's look at the geometry of these equivalent distributions." width="80%" />
<p class="caption">Why do this? Even though it's mathematically the same, the geometry is different. On the left we have the default (centered) form. There are parameters inside the distribution. Non-centered is wehre we take all the conditioniing out. Let's look at the geometry of these equivalent distributions.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L16/23.png" alt="Same thing but we've got a Guassian bucket again. Same distribution, you can convert between them, but the one on the right is way easier to cruise around in. Can get many more effective samples." width="80%" />
<p class="caption">Same thing but we've got a Guassian bucket again. Same distribution, you can convert between them, but the one on the right is way easier to cruise around in. Can get many more effective samples.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L16/24.png" alt="Red points are transitions that are rejected. Start back over where you started again. A lot of them are down in the funnel. A loit of them start in the funnel. On the right, no divergences at all. So this is a big difference. " width="80%" />
<p class="caption">Red points are transitions that are rejected. Start back over where you started again. A lot of them are down in the funnel. A loit of them start in the funnel. On the right, no divergences at all. So this is a big difference. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L16/25.png" alt="This is what it looks like in a real model. As before, it's a centered model because it has paramters insdie the adaptive priors. And it sampled fine. But if we de-center it, it'll be more efficient.  " width="80%" />
<p class="caption">This is what it looks like in a real model. As before, it's a centered model because it has paramters insdie the adaptive priors. And it sampled fine. But if we de-center it, it'll be more efficient.  </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L16/26.png" alt="Let's focus on the linear model now. It's going to be written with the z socres in it. One zs per actor, times the sigma among actors, which rescales it. Alpha bar is outside too. Same for block. Treatments are still fixed effects so we leave them." width="80%" />
<p class="caption">Let's focus on the linear model now. It's going to be written with the z socres in it. One zs per actor, times the sigma among actors, which rescales it. Alpha bar is outside too. Same for block. Treatments are still fixed effects so we leave them.</p>
</div>

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L16/27.png" width="80%" />

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L16/28.png" alt="The new bit is where we had alpha and gamma. We now have z and x Normal(0,1). This is the most importnat thing to get varying effects models working right. " width="80%" />
<p class="caption">The new bit is where we had alpha and gamma. We now have z and x Normal(0,1). This is the most importnat thing to get varying effects models working right. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L16/29.png" alt="In code, this is what it looks like. " width="80%" />
<p class="caption">In code, this is what it looks like. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L16/30.png" alt="What does this get us? Going to compare the effective number of sample. Going to compare the effective number of samples per parameter for both models. Same posterior distribution, and the precis shows they're basically the same. `neff_c` is centered. Per parameter, those numbers are always bigger for the non-centered model. Means you don't need to run the model for that long. " width="80%" />
<p class="caption">What does this get us? Going to compare the effective number of sample. Going to compare the effective number of samples per parameter for both models. Same posterior distribution, and the precis shows they're basically the same. `neff_c` is centered. Per parameter, those numbers are always bigger for the non-centered model. Means you don't need to run the model for that long. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L16/31.png" alt="Last thing to talk about is how to do posterior predictions. You have to make some choices. You get to decide how to think about the generalisation of the model. The most direct way to consider the choices is, when you generalise inferences, are you interested in new units, or the same chimps. If you interested in new ones, you wouldn't get to use the alphas. However the other parameters are definitely relevant, because you've learned about the variation in a popoulation of chimps, which would give you a prior. So here's an example." width="80%" />
<p class="caption">Last thing to talk about is how to do posterior predictions. You have to make some choices. You get to decide how to think about the generalisation of the model. The most direct way to consider the choices is, when you generalise inferences, are you interested in new units, or the same chimps. If you interested in new ones, you wouldn't get to use the alphas. However the other parameters are definitely relevant, because you've learned about the variation in a popoulation of chimps, which would give you a prior. So here's an example.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L16/32.png" alt="Let's consider. Different ways to draw this. Take the statsitically average chimpanzee, and ask what the nmodel says it owuld do. Marginal of actor says let's sampel a bunch of chimps and average over their variation. this is differnet beause it cincludes the population variation. Then show the sample of actors fromt eh posterior." width="80%" />
<p class="caption">Let's consider. Different ways to draw this. Take the statsitically average chimpanzee, and ask what the nmodel says it owuld do. Marginal of actor says let's sampel a bunch of chimps and average over their variation. this is differnet beause it cincludes the population variation. Then show the sample of actors fromt eh posterior.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L16/33.png" alt="Chimp with alpha bar. All we have to do is replace all the intercepts with 0, then we can use link. Extract the samples, then put in a big matrix of 0s and run the link. " width="80%" />
<p class="caption">Chimp with alpha bar. All we have to do is replace all the intercepts with 0, then we can use link. Extract the samples, then put in a big matrix of 0s and run the link. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L16/34.png" alt="Here's the average actor. There's uncertainty about it. " width="80%" />
<p class="caption">Here's the average actor. There's uncertainty about it. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L16/35.png" alt="Now we have to create a prediction interval for all chimps. There's uncretainty re: handedness, which makes it wider." width="80%" />
<p class="caption">Now we have to create a prediction interval for all chimps. There's uncretainty re: handedness, which makes it wider.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L16/36.png" alt="Why wider? Because chimps vary a lto. " width="80%" />
<p class="caption">Why wider? Because chimps vary a lto. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L16/37.png" alt="Finally, sample a bunch of chimps and draw them. One of the things that happens is because there's a posterior distribution for each parameter, the model things it's possible to get completely right-handed chimps. But the treatment effect is still there. " width="80%" />
<p class="caption">Finally, sample a bunch of chimps and draw them. One of the things that happens is because there's a posterior distribution for each parameter, the model things it's possible to get completely right-handed chimps. But the treatment effect is still there. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L16/38.png" alt="Focus on the variation that adds to the tanks. Look at the sigma across different models, and there will be a pattern. The second dataset is a historical Bangladeshi dataset. Also will be a varying interecepts model, but now youll be exploring shrinkage. " width="80%" />
<p class="caption">Focus on the variation that adds to the tanks. Look at the sigma across different models, and there will be a pattern. The second dataset is a historical Bangladeshi dataset. Also will be a varying interecepts model, but now youll be exploring shrinkage. </p>
</div>


