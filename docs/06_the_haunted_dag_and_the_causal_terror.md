---
title: "Notes for Statistical Rethinking 2nd ed. by Richard McElreath"
date: '2021-05-26'
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

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L06/13.png" alt="The confound that gets created is the &quot;post-treatment bias&quot;, Z. Post-treatment variables arise as a consequence of treatment. This happens a lot. The bias occurs when you're not aware of Z, and end up inferring something wrong. " width="80%" />
<p class="caption">The confound that gets created is the "post-treatment bias", Z. Post-treatment variables arise as a consequence of treatment. This happens a lot. The bias occurs when you're not aware of Z, and end up inferring something wrong. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L06/14.png" alt="Let's imagine an experiment where there's fungal growth in a greenhouse, and you have an anti-fungal treatment, and you randomly assign plants to either the treatment or control. The initial height of the plant is H0. The anti-fungal treatment is upstream from the fungus, but doesn't influence it directly. What happens here in a regression is if you measure fungus - which is how you test for mediation - but what you're interested in is the full path from T to H1. If you condition on F, it'll look like the treatment doesn't work. If you condition on F, you block the pipe, and information doesn't flow from T to H1. In observational studies, the terror is real. " width="80%" />
<p class="caption">Let's imagine an experiment where there's fungal growth in a greenhouse, and you have an anti-fungal treatment, and you randomly assign plants to either the treatment or control. The initial height of the plant is H0. The anti-fungal treatment is upstream from the fungus, but doesn't influence it directly. What happens here in a regression is if you measure fungus - which is how you test for mediation - but what you're interested in is the full path from T to H1. If you condition on F, it'll look like the treatment doesn't work. If you condition on F, you block the pipe, and information doesn't flow from T to H1. In observational studies, the terror is real. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L06/15.png" alt="Frustrating thing for statisticians is that if you condition on career choice, there's basically no wage gap. But that doesn't mean gender and race isn't causal, because there are streams where something downstream knocks it out. If you look at funding rates for the sciences, women get way less grant money. But not if you condition on field. " width="80%" />
<p class="caption">Frustrating thing for statisticians is that if you condition on career choice, there's basically no wage gap. But that doesn't mean gender and race isn't causal, because there are streams where something downstream knocks it out. If you look at funding rates for the sciences, women get way less grant money. But not if you condition on field. </p>
</div>

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



<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L06/23.png" alt="Let's do an example. Image this causal graph at the bottom. Imagine it's true that getting married is positively, causally associated with happiness, and age. Now our question is, is there any causal impact of age on happiness? Here's a simulation where it's totally spurious. " width="80%" />
<p class="caption">Let's do an example. Image this causal graph at the bottom. Imagine it's true that getting married is positively, causally associated with happiness, and age. Now our question is, is there any causal impact of age on happiness? Here's a simulation where it's totally spurious. </p>
</div>



<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L06/24.png" alt="Here the simulation is slightly different to the usual `rnorm`. Here's the algorithm. Uniform happiness at birth. Distributed from 0 to 1. Reality is more complicated, even harder to figure out. At 18 years old, you're eligible to marry. Then you have your coin-flip chance to get married. The chance is proportional to your happiness, which is constant. Age itself doesn't cause marriage, but each year you're alive you have another chance to get married. Married people remain married unto death. Then everyone moves to Spain. 1300 people, 3 variables, over 1000 years." width="80%" />
<p class="caption">Here the simulation is slightly different to the usual `rnorm`. Here's the algorithm. Uniform happiness at birth. Distributed from 0 to 1. Reality is more complicated, even harder to figure out. At 18 years old, you're eligible to marry. Then you have your coin-flip chance to get married. The chance is proportional to your happiness, which is constant. Age itself doesn't cause marriage, but each year you're alive you have another chance to get married. Married people remain married unto death. Then everyone moves to Spain. 1300 people, 3 variables, over 1000 years.</p>
</div>



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

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L06/32.png" alt="We end up concluding that grandparents hurt their kids. How does this work? Conditioning on a collider opens a path. It's closed by default. This oepns a path from G through U to see, which creates a spurious correlation." width="80%" />
<p class="caption">We end up concluding that grandparents hurt their kids. How does this work? Conditioning on a collider opens a path. It's closed by default. This oepns a path from G through U to see, which creates a spurious correlation.</p>
</div>



<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L06/33.png" alt="One way to think about this is on the left we have good neighbourhoods in blue. All filled in points are where the parents are in a particular stratum. Why is it negative? Focus only on parents in the narrow range of educational outcomes. Parents in the good neighbourhoods, to be within this range, they must have had less educated grandparents. There are two ways to become a highly-educated parent. Either you are in a good neighbourhood, or you had an educated parent yourself. Each end the P box. " width="80%" />
<p class="caption">One way to think about this is on the left we have good neighbourhoods in blue. All filled in points are where the parents are in a particular stratum. Why is it negative? Focus only on parents in the narrow range of educational outcomes. Parents in the good neighbourhoods, to be within this range, they must have had less educated grandparents. There are two ways to become a highly-educated parent. Either you are in a good neighbourhood, or you had an educated parent yourself. Each end the P box. </p>
</div>

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



<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L07/04.png" width="80%" />


```marginfigure
The classic confound involves some exposure $E$. A lot of research goes into understanding what the returns on education are. There are a lot of confounds $U$. How do we de-confound this DAG using the back-door criterion? $E \leftarrow  U \rightarrow W$. How to shut this? It's a fork, and you close it by conditioning on $U$. But here it's unobserved, so we can't condition on it. You therefore can't get an unbiased estimate. But that's an achievement, because we've wasted less time. 
```

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L07/05.png" alt="If we want to estimate the direct causal influence from grandparents to kids, we see there are three paths from G to C. If we condition on $P$, that closes the second path through parents. Since that's a pipe, you condition on parents, but that opens the other path, because they're a collider between grandparents and unobserved neighbourhood effects. So we can't get a valid estimate unless we measure it. This is happy news, because we know we're being fooled." width="80%" />
<p class="caption">If we want to estimate the direct causal influence from grandparents to kids, we see there are three paths from G to C. If we condition on $P$, that closes the second path through parents. Since that's a pipe, you condition on parents, but that opens the other path, because they're a collider between grandparents and unobserved neighbourhood effects. So we can't get a valid estimate unless we measure it. This is happy news, because we know we're being fooled.</p>
</div>


<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L07/06.png" alt="We want to know the causal effect of $X$ on $Y$. We have an unobserved cause of $X$, then three covariates. What do you need to condition on, and what should you absolutely not condition on? The backdoor criterion is sufficient to figure it out. Find each backdoor path, and figure out which ones to open and close. Just three paths." width="80%" />
<p class="caption">We want to know the causal effect of $X$ on $Y$. We have an unobserved cause of $X$, then three covariates. What do you need to condition on, and what should you absolutely not condition on? The backdoor criterion is sufficient to figure it out. Find each backdoor path, and figure out which ones to open and close. Just three paths.</p>
</div>


<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L07/07.png" alt="What should we prefer between A or C? Just pick the one that's measured better. By the way, you need both good estimation, and a causal framework. Both are necessary." width="80%" />
<p class="caption">What should we prefer between A or C? Just pick the one that's measured better. By the way, you need both good estimation, and a causal framework. Both are necessary.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L07/08.png" alt="Statistical assocation between Waffle Houses and divorce rate. What do we need to control for to remove spurious causation? Same elemental confounds as before. Backdoor into Waffle Houses through South. What do we have to do to estimate the causal impact of Waffles? Come out the backdoor of Waffle House, and find all the paths to get to D. It's sufficient to condition on A and M too. But it's sufficient to just condition on S." width="80%" />
<p class="caption">Statistical assocation between Waffle Houses and divorce rate. What do we need to control for to remove spurious causation? Same elemental confounds as before. Backdoor into Waffle Houses through South. What do we have to do to estimate the causal impact of Waffles? Come out the backdoor of Waffle House, and find all the paths to get to D. It's sufficient to condition on A and M too. But it's sufficient to just condition on S.</p>
</div>

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L07/09.png" width="80%" />



<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L07/10.png" alt="Good news. There are a number of packages where you give them the DAG, and then you can get it to algorithmically tell you things about the DAG. You can test your DAG, bu inspecting the implied conditional dependencies. The causal structure implies that some things are independent on others. A and W should have no correlation after conditioning on S. It's a fork from S. Parts of the DAG may be wrong. It's a good lesson that the answers require the data, but aren't in the data." width="80%" />
<p class="caption">Good news. There are a number of packages where you give them the DAG, and then you can get it to algorithmically tell you things about the DAG. You can test your DAG, bu inspecting the implied conditional dependencies. The causal structure implies that some things are independent on others. A and W should have no correlation after conditioning on S. It's a fork from S. Parts of the DAG may be wrong. It's a good lesson that the answers require the data, but aren't in the data.</p>
</div>



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




