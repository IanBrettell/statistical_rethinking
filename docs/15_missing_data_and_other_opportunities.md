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

# Missing Data and Other Opportunities


```r
library(here)
source(here::here("code/scripts/source.R"))
```


```r
slides_dir = here::here("docs/slides/L20")
```

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L20/01.png" width="80%" />

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L20/02.png" alt="Pancakes. Hatching indicates that that side is burnt. " width="80%" />
<p class="caption">Pancakes. Hatching indicates that that side is burnt. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L20/03.png" alt="Now I serve you a burnt pancake. The probability of the other side being burnt is not half, but rather 2/3." width="80%" />
<p class="caption">Now I serve you a burnt pancake. The probability of the other side being burnt is not half, but rather 2/3.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L20/04.png" alt="Famous logic problem. Point of logic puzzles is to correct your intuitions and teach you methods for solving them. You don't have to be clever, just ruthlessley apply the rules of conditioning. Don't trust your intuitions. Theways we figure things out in probabilty theory, we condition on what we know, and seee if that updates. " width="80%" />
<p class="caption">Famous logic problem. Point of logic puzzles is to correct your intuitions and teach you methods for solving them. You don't have to be clever, just ruthlessley apply the rules of conditioning. Don't trust your intuitions. Theways we figure things out in probabilty theory, we condition on what we know, and seee if that updates. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L20/05.png" alt="We want to know the probabilty that the other side is burnt conditional on what we know, that one side is burnt. " width="80%" />
<p class="caption">We want to know the probabilty that the other side is burnt conditional on what we know, that one side is burnt. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L20/06.png" alt="We have all the information to compute this. There are three pancakes. BB is burnt-burnt. Probabillity that you would see a burnt side if it's BB is 1. " width="80%" />
<p class="caption">We have all the information to compute this. There are three pancakes. BB is burnt-burnt. Probabillity that you would see a burnt side if it's BB is 1. </p>
</div>

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L20/07.png" width="80%" />

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L20/08.png" width="80%" />

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L20/09.png" alt="In the text there's a simulation. The mistake is focusign on pancakes. You want to focus on sides. There are three burnt sides. Of the other sides of those, how many of those are burnt? 2, so 2/3. " width="80%" />
<p class="caption">In the text there's a simulation. The mistake is focusign on pancakes. You want to focus on sides. There are three burnt sides. Of the other sides of those, how many of those are burnt? 2, so 2/3. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L20/10.png" alt="Everything we've done is underlain by being ruthless. Express our information by constraints in distributions. Take this approach and show you how it produces automatic solutions. Avoid being clever and you can get useful solutions. Missing data is the extreme version of measurement error." width="80%" />
<p class="caption">Everything we've done is underlain by being ruthless. Express our information by constraints in distributions. Take this approach and show you how it produces automatic solutions. Avoid being clever and you can get useful solutions. Missing data is the extreme version of measurement error.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L20/11.png" alt="There's always some error in measurement, and ther'e always this sigma error. But what if there's also error on the predictors, and it's not consistent. Let's think about avoiding thying to be clever, and just codntiiong on what we know." width="80%" />
<p class="caption">There's always some error in measurement, and ther'e always this sigma error. But what if there's also error on the predictors, and it's not consistent. Let's think about avoiding thying to be clever, and just codntiiong on what we know.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L20/12.png" alt="The columns were standard errors on a coulpl eof the variables. The error of measurement has been quantified. We have an esimate of the divors=ce rate, and the stnadared error stells us the error rate of that estiamte. SOome of the standard errors are big. " width="80%" />
<p class="caption">The columns were standard errors on a coulpl eof the variables. The error of measurement has been quantified. We have an esimate of the divors=ce rate, and the stnadared error stells us the error rate of that estiamte. SOome of the standard errors are big. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L20/13.png" alt="Right now has the log population on the horizontal. And California is on the right. It's so big that the error rate is small." width="80%" />
<p class="caption">Right now has the log population on the horizontal. And California is on the right. It's so big that the error rate is small.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L20/14.png" alt="Let's think about this in terms of a causal model. We want to see the divorce rate we observe as a function of the true divorce rate `D`, and the population size `N`. " width="80%" />
<p class="caption">Let's think about this in terms of a causal model. We want to see the divorce rate we observe as a function of the true divorce rate `D`, and the population size `N`. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L20/15.png" alt="Let's not be clever, just apply ruthless probability theory. There's some true divorce rate, and we'd like to use that as our outcome variable. Generatively thinking, our observed data is generated from a normal disttribution. The mean of this normal distribution will be the true rate. THen there's a standard deviation. In the long run, there's some D true. But in any finite period, ther's error, and that will be inversely proportional to population size." width="80%" />
<p class="caption">Let's not be clever, just apply ruthless probability theory. There's some true divorce rate, and we'd like to use that as our outcome variable. Generatively thinking, our observed data is generated from a normal disttribution. The mean of this normal distribution will be the true rate. THen there's a standard deviation. In the long run, there's some D true. But in any finite period, ther's error, and that will be inversely proportional to population size.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L20/16.png" alt="This was our DAG before. The thing on the top is D TRUE. We're going to put a line on top of it." width="80%" />
<p class="caption">This was our DAG before. The thing on the top is D TRUE. We're going to put a line on top of it.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L20/17.png" alt="... The observation process. Now D TRUE is's a vector of unkonwn parameters, then the line at the top estimates them for us. We also have the whole regression relationship that is going to pin down values from other states. Shrinkage is going to happen. If you were going to simulate pmeaurement error, this would be the model. Then it runs backwards. **Bayesian models are generative, and you can run them in both directions. If you run them forwards you simulate fake data, and if you run them in the reverse they spit out a posterior distribution. You feed in a distirbution and the spit out data, you feed in data they spit out a distribution.** So if you were going to simulate measurement error, you use the top line.  " width="80%" />
<p class="caption">... The observation process. Now D TRUE is's a vector of unkonwn parameters, then the line at the top estimates them for us. We also have the whole regression relationship that is going to pin down values from other states. Shrinkage is going to happen. If you were going to simulate pmeaurement error, this would be the model. Then it runs backwards. **Bayesian models are generative, and you can run them in both directions. If you run them forwards you simulate fake data, and if you run them in the reverse they spit out a posterior distribution. You feed in a distirbution and the spit out data, you feed in data they spit out a distribution.** So if you were going to simulate measurement error, you use the top line.  </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L20/18.png" alt="How do we do this in a model? For every dstate, there's a D true, and that's what the vector[N] is. " width="80%" />
<p class="caption">How do we do this in a model? For every dstate, there's a D true, and that's what the vector[N] is. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L20/19.png" alt="Remember the distinction between likelihoods and priors in a Baeysian model is coginitive. Probabilityt theory don't care. When something in your dataset becomes unobserved, the model doesn't change. The model exists before you know the sample. The fact that you haven't observed some data doesn't mean the model chagnes. It cjust means you have paraemters there, because parameters are unobserved variables." width="80%" />
<p class="caption">Remember the distinction between likelihoods and priors in a Baeysian model is coginitive. Probabilityt theory don't care. When something in your dataset becomes unobserved, the model doesn't change. The model exists before you know the sample. The fact that you haven't observed some data doesn't mean the model chagnes. It cjust means you have paraemters there, because parameters are unobserved variables.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L20/20.png" alt="There's shrinkage. Plotting the relationship between median age of marriage and the divorce rate. Most of these are standardised variables. The blue points are the values that were observed. The open circles are the values fromt eh posterior distribution. The line segments connect them for each state. There's shrinkage. Some have moved more than others. You can explain this pattern. Why have some moved way more than others? Thye've moved tothe regression line because that's the expectation. How much it shrinks is also a function of standard error. For ID it says given this relationship and these variables, that measred rate is too edteme to be beileveable, party due to sampling error, so it shirnks it. Wyoming is interesitn gbecause it'snot so far but so uncertain that it gets shrunk directly to the line. Maine gets shrunk a lot too. " width="80%" />
<p class="caption">There's shrinkage. Plotting the relationship between median age of marriage and the divorce rate. Most of these are standardised variables. The blue points are the values that were observed. The open circles are the values fromt eh posterior distribution. The line segments connect them for each state. There's shrinkage. Some have moved more than others. You can explain this pattern. Why have some moved way more than others? Thye've moved tothe regression line because that's the expectation. How much it shrinks is also a function of standard error. For ID it says given this relationship and these variables, that measred rate is too edteme to be beileveable, party due to sampling error, so it shirnks it. Wyoming is interesitn gbecause it'snot so far but so uncertain that it gets shrunk directly to the line. Maine gets shrunk a lot too. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L20/21.png" alt="You can compare it to the plot with teh standard devations. Ont ehleft we've taken the differnce between the estimated and the observed. Horizontal is the standard error. Any state taht has adifference of 0 means there's no shrinkage. " width="80%" />
<p class="caption">You can compare it to the plot with teh standard devations. Ont ehleft we've taken the differnce between the estimated and the observed. Horizontal is the standard error. Any state taht has adifference of 0 means there's no shrinkage. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L20/22.png" alt="That's error on the outcome. YOu can also have error on predictor variables. Imagine sampling a predictor now with error. On the plot on this slide we have the marriage rate. On the horizontal against log population. " width="80%" />
<p class="caption">That's error on the outcome. YOu can also have error on predictor variables. Imagine sampling a predictor now with error. On the plot on this slide we have the marriage rate. On the horizontal against log population. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L20/23.png" alt="Top part is the observation process on divorce rate. Then the regression of the true divorce rate on age of marriage and marriage rate. But now inside the regression, we have..." width="80%" />
<p class="caption">Top part is the observation process on divorce rate. Then the regression of the true divorce rate on age of marriage and marriage rate. But now inside the regression, we have...</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L20/24.png" alt="M true, not the observed M, and that's a paramter. There's a parameter for each state and it goes in. It's a parameter times a parameter. Every state will have one of this M trues. Same model because it's the same generative process. Then we have the likelihood for the observed rate, the M observed for each state comes from this sampling process again.  " width="80%" />
<p class="caption">M true, not the observed M, and that's a paramter. There's a parameter for each state and it goes in. It's a parameter times a parameter. Every state will have one of this M trues. Same model because it's the same generative process. Then we have the likelihood for the observed rate, the M observed for each state comes from this sampling process again.  </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L20/25.png" alt="You ahve to put in a prior for the MTrues. What hapens as a consquence of setting it as Normal(0, 1), because it's standaredised. Not terrible. Butyou're ignoring oinfoamtion inthe data because if i tele you the age of marrige in each state, you get information about themarriage rate. If you believe the DAG, age of marrige influence marriage rate. So we can get a better prior if we put the whole DAG into the model. If we do it all ato once, there's even more infomration. " width="80%" />
<p class="caption">You ahve to put in a prior for the MTrues. What hapens as a consquence of setting it as Normal(0, 1), because it's standaredised. Not terrible. Butyou're ignoring oinfoamtion inthe data because if i tele you the age of marrige in each state, you get information about themarriage rate. If you believe the DAG, age of marrige influence marriage rate. So we can get a better prior if we put the whole DAG into the model. If we do it all ato once, there's even more infomration. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L20/26.png" alt="We've got two variables now, which are observed with error. Divorce rate on vertical; marigage rate on horitzontal. Open points are the corresponding pairs of posterior means for the esitmate true means. So we have shrinkage in two directions now towards some regression line (undrawn). Some shirnk a lot more than others. If you're really far from the line you shrink more. But also there's more shrinkage for the diveroce rate than the marriage rate. Top left is extreme in both. Comes downa  lot more on divorce rate. WHy?" width="80%" />
<p class="caption">We've got two variables now, which are observed with error. Divorce rate on vertical; marigage rate on horitzontal. Open points are the corresponding pairs of posterior means for the esitmate true means. So we have shrinkage in two directions now towards some regression line (undrawn). Some shirnk a lot more than others. If you're really far from the line you shrink more. But also there's more shrinkage for the diveroce rate than the marriage rate. Top left is extreme in both. Comes downa  lot more on divorce rate. WHy?</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L20/27.png" alt="Because the regression says marriage rate isn't strongly associtated. It doesn 't know where to move it, so it doesn't.  " width="80%" />
<p class="caption">Because the regression says marriage rate isn't strongly associtated. It doesn 't know where to move it, so it doesn't.  </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L20/28.png" alt="It comes in many disguises. Simplet is when there's variable that's called 'error'. But there are many more subtle forms. Pre-averaging removes the fact tht you have a finite sample to estimate the mean from. THat takes variation out of the dataset. If you're doing that constantly, that's cheating. Otherwise you could just use a MLM. Then the means are varying effects - parameters - and you do the averaging within the model. And all the uncertainty to do with different sample sizes is taken care of. Parentage analysis is a fun case. Say you have a popuation of wild rodents and you're tyring to figure out who was whose parents. So you get their genotypes and figure out how they're related. Phylogenetics - the example last week used a single tree. Phylogenies are rarely very scertain. Trend to plot them like ont he right, so you're showing the whole posterior distribution. You can do the analysis over the whole distribution of trees. In archaology, measurement error is the norm, e.g. radio carbon dating. People take this very seriously now. Very sdifficult to sex a fossil. Or studying a place where they don't keep track of birthdays." width="80%" />
<p class="caption">It comes in many disguises. Simplet is when there's variable that's called 'error'. But there are many more subtle forms. Pre-averaging removes the fact tht you have a finite sample to estimate the mean from. THat takes variation out of the dataset. If you're doing that constantly, that's cheating. Otherwise you could just use a MLM. Then the means are varying effects - parameters - and you do the averaging within the model. And all the uncertainty to do with different sample sizes is taken care of. Parentage analysis is a fun case. Say you have a popuation of wild rodents and you're tyring to figure out who was whose parents. So you get their genotypes and figure out how they're related. Phylogenetics - the example last week used a single tree. Phylogenies are rarely very scertain. Trend to plot them like ont he right, so you're showing the whole posterior distribution. You can do the analysis over the whole distribution of trees. In archaology, measurement error is the norm, e.g. radio carbon dating. People take this very seriously now. Very sdifficult to sex a fossil. Or studying a place where they don't keep track of birthdays.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L20/29.png" alt="Grown up measurement error. Mechanically similar but feels really different. You want to do something about missing data. Most of the standard regression tools will autoamtically remove missing cases. So all the variables are removed. This squanders information, but can also create confounds. There are ways to deal with this. So how to deal with it? Worst appraoch is to replace teh missing values with the mean of the column. Really bad idea because they model will intepret it as if you knew the value. Procedure called multiple imputation, whcih works really well. Frequentist way of doing what we're going to do. Unreasoanbly effective. Basically do the modle multiple times on samples on some stochastic model of the dataset. We're just going to go full-flavour Bayesian." width="80%" />
<p class="caption">Grown up measurement error. Mechanically similar but feels really different. You want to do something about missing data. Most of the standard regression tools will autoamtically remove missing cases. So all the variables are removed. This squanders information, but can also create confounds. There are ways to deal with this. So how to deal with it? Worst appraoch is to replace teh missing values with the mean of the column. Really bad idea because they model will intepret it as if you knew the value. Procedure called multiple imputation, whcih works really well. Frequentist way of doing what we're going to do. Unreasoanbly effective. Basically do the modle multiple times on samples on some stochastic model of the dataset. We're just going to go full-flavour Bayesian.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L20/30.png" alt="Let's talk about DAGs again. Deeply confusing, because the terminology is awful. Let's think about the primate milk data again. Interested in understanding why the energy content of milk varies so much. Is is related to the proportion of brain neocortex. U is the strong postive correlation between M and B, but we don't know what it is. Something going on here but we don't know what it is." width="80%" />
<p class="caption">Let's talk about DAGs again. Deeply confusing, because the terminology is awful. Let's think about the primate milk data again. Interested in understanding why the energy content of milk varies so much. Is is related to the proportion of brain neocortex. U is the strong postive correlation between M and B, but we don't know what it is. Something going on here but we don't know what it is.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L20/31.png" alt="This taxonomy tells us what to do. Confusingly, MCAR is totally different to MAR. " width="80%" />
<p class="caption">This taxonomy tells us what to do. Confusingly, MCAR is totally different to MAR. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L20/32.png" alt="MCAR. We're not going to get to see B, because it has missing values in it. Lot's of primates where they didn't measure percent neocortex. To get the gaps, we know it's partly caused by B, but it's also caused by the missingness process R. `R_B` creates missing values in `B`. " width="80%" />
<p class="caption">MCAR. We're not going to get to see B, because it has missing values in it. Lot's of primates where they didn't measure percent neocortex. To get the gaps, we know it's partly caused by B, but it's also caused by the missingness process R. `R_B` creates missing values in `B`. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L20/33.png" alt="We're going to condition on `B_obs`. Are there backdoors? The answer is no, but there are two paths. Direct and indirect. But the total causal effect can be estimated by simple regerssion with just `B_obs`. There's an indirect effect through M. But there's no back door. " width="80%" />
<p class="caption">We're going to condition on `B_obs`. Are there backdoors? The answer is no, but there are two paths. Direct and indirect. But the total causal effect can be estimated by simple regerssion with just `B_obs`. There's an indirect effect through M. But there's no back door. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L20/34.png" alt="There's no path that takes you through `R_B`. This means the missingness mechanism is ignorable, because it doesn't create any backdoor confound. So you don't need to know it. This is the benign case." width="80%" />
<p class="caption">There's no path that takes you through `R_B`. This means the missingness mechanism is ignorable, because it doesn't create any backdoor confound. So you don't need to know it. This is the benign case.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L20/35.png" alt="You don't have to condition on anything to keep your infnerence about K independent fromt he missingness mechanism.  " width="80%" />
<p class="caption">You don't have to condition on anything to keep your infnerence about K independent fromt he missingness mechanism.  </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L20/36.png" alt="The only way this could happen is if you had a random number generator deletes values from your dataset. I assert this is hihgly implausible in more research situations. " width="80%" />
<p class="caption">The only way this could happen is if you had a random number generator deletes values from your dataset. I assert this is hihgly implausible in more research situations. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L20/37.png" alt="This is something else that could be going on. This will give us MAR. M is now entering/influencing R_B. Now the missingness mechanism depends on the body mass values. Large or small body masses are more likely to have missing body mass values. Different species are more or less attractive to study. That generates a pattern where some features are associated causally with the missingness. " width="80%" />
<p class="caption">This is something else that could be going on. This will give us MAR. M is now entering/influencing R_B. Now the missingness mechanism depends on the body mass values. Large or small body masses are more likely to have missing body mass values. Different species are more or less attractive to study. That generates a pattern where some features are associated causally with the missingness. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L20/38.png" alt="As before, is there a backdoor path. Now because there's an arrow entering R_B.." width="80%" />
<p class="caption">As before, is there a backdoor path. Now because there's an arrow entering R_B..</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L20/39.png" alt="You have a complete path. How to close the backdoor? Condition on M. Here you don't have to knwo the missingness mechanism, but do need to do imputation." width="80%" />
<p class="caption">You have a complete path. How to close the backdoor? Condition on M. Here you don't have to knwo the missingness mechanism, but do need to do imputation.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L20/40.png" alt="There's some variable in the graph we can condition on, and separate the two. This is a nice situation to be in, and probably the most common. Why need to impute? Because you'd be polluting the other variables with this missngness pattern, whcihc an create really strong biases." width="80%" />
<p class="caption">There's some variable in the graph we can condition on, and separate the two. This is a nice situation to be in, and probably the most common. Why need to impute? Because you'd be polluting the other variables with this missngness pattern, whcihc an create really strong biases.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L20/41.png" alt="Worst case. In this case, the most obvious way to get iit si the variable itself causes the missngieesss. Cerain values of neoxortex percetn are more likely to go missing. How? Maybe species with low neocortex weren't measured." width="80%" />
<p class="caption">Worst case. In this case, the most obvious way to get iit si the variable itself causes the missngieesss. Cerain values of neoxortex percetn are more likely to go missing. How? Maybe species with low neocortex weren't measured.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L20/42.png" alt="This is nasty because you get a backdoor you can't close. Your only hope is to model the missngness mechanism and thereby condition on it." width="80%" />
<p class="caption">This is nasty because you get a backdoor you can't close. Your only hope is to model the missngness mechanism and thereby condition on it.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L20/43.png" alt="The other way to get it would be to have a missingness variable. Here there's fork, like phylogeny. We like to study animals closer to us. That will influence neoxotrex percent, and also influence missingness." width="80%" />
<p class="caption">The other way to get it would be to have a missingness variable. Here there's fork, like phylogeny. We like to study animals closer to us. That will influence neoxotrex percent, and also influence missingness.</p>
</div>

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L20/44.png" width="80%" />

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L20/45.png" alt="Imagine a DAG iwth four variables. R is nowD, a dog. In the first, the dog will eat any homework. In the middle, teh dog eats particular students' homework. The attribute could be attention span, as in they turn away and the dog eats it. Finally, the dog only eats bad homework. Or, more liekly, the stuent feeds it to the dog. But it depends ont he score ofthe homework. " width="80%" />
<p class="caption">Imagine a DAG iwth four variables. R is nowD, a dog. In the first, the dog will eat any homework. In the middle, teh dog eats particular students' homework. The attribute could be attention span, as in they turn away and the dog eats it. Finally, the dog only eats bad homework. Or, more liekly, the stuent feeds it to the dog. But it depends ont he score ofthe homework. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L20/46.png" alt="Let's go through the mechanics of this. " width="80%" />
<p class="caption">Let's go through the mechanics of this. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L20/47.png" alt="We'll replace the NAs with a parameter, and get posteriro distributions for each of the missing values. " width="80%" />
<p class="caption">We'll replace the NAs with a parameter, and get posteriro distributions for each of the missing values. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L20/48.png" alt="Now they get assigned a parameter. They'll be imputed by the modeo." width="80%" />
<p class="caption">Now they get assigned a parameter. They'll be imputed by the modeo.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L20/49.png" alt="B is now a vector in which some values are observed, and toehrs are paratmets. We'll stick them in an ordianry regression modeo. But now we have a prior. When B is observed, it infomrs the parameters in side it. Those will be estimated from teh observed values." width="80%" />
<p class="caption">B is now a vector in which some values are observed, and toehrs are paratmets. We'll stick them in an ordianry regression modeo. But now we have a prior. When B is observed, it infomrs the parameters in side it. Those will be estimated from teh observed values.</p>
</div>

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L20/50.png" width="80%" />

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L20/51.png" width="80%" />

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L20/52.png" alt="Looks exavtly the same, but we add this prior. `ulam` automates this." width="80%" />
<p class="caption">Looks exavtly the same, but we add this prior. `ulam` automates this.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L20/53.png" alt=" You can see 12 imputes. What does this do to the slopes in the model?" width="80%" />
<p class="caption"> You can see 12 imputes. What does this do to the slopes in the model?</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L20/54.png" alt="Let's compare the same model. Now we can compare the slopes. Two predictors assocaited with the outcome variable in opposite directions. NOtice that the esimates have got more precise. They've also moved closer to the mean. " width="80%" />
<p class="caption">Let's compare the same model. Now we can compare the slopes. Two predictors assocaited with the outcome variable in opposite directions. NOtice that the esimates have got more precise. They've also moved closer to the mean. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L20/55.png" alt="We can plot the values up, but they'll have standard errors on them. Open circles is imputed. Posterior means follow the regression line. " width="80%" />
<p class="caption">We can plot the values up, but they'll have standard errors on them. Open circles is imputed. Posterior means follow the regression line. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L20/56.png" alt="The disappointing thing about this midel is that the relationship between the imputed values adn the predictor is 0, which is wrong. THat's because we dodn't tell it they're assocaited." width="80%" />
<p class="caption">The disappointing thing about this midel is that the relationship between the imputed values adn the predictor is 0, which is wrong. THat's because we dodn't tell it they're assocaited.</p>
</div>

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L20/57.png" width="80%" />

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L20/58.png" alt=" We fix this by making it a MVNormal. " width="80%" />
<p class="caption"> We fix this by making it a MVNormal. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L20/59.png" alt="Need to manually construct it. " width="80%" />
<p class="caption">Need to manually construct it. </p>
</div>

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L20/60.png" width="80%" />

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L20/61.png" alt="Then happy days, you get even more precision." width="80%" />
<p class="caption">Then happy days, you get even more precision.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L20/62.png" alt="This is a really big topic. One ofthe areas that is most important is with occupancy. Really missing data problems. There's a true occupancy but 0s are not trustworthy. They ahve a special preocess that comes from the detection process that you model." width="80%" />
<p class="caption">This is a really big topic. One ofthe areas that is most important is with occupancy. Really missing data problems. There's a true occupancy but 0s are not trustworthy. They ahve a special preocess that comes from the detection process that you model.</p>
</div>

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L20/63.png" width="80%" />

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L20/64.png" width="80%" />

