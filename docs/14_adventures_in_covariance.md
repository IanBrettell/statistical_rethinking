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

# Adventures in Covariance


```r
library(here)
source(here::here("code/scripts/source.R"))
```


```r
slides_dir = here::here("docs/slides/L17")
```

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L17/01.png" alt="Today we'll take the basic MLM strategy into higher dimensions." width="80%" />
<p class="caption">Today we'll take the basic MLM strategy into higher dimensions.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L17/02.png" alt="Last week was all about varying intercepts, the simplest type of MLM. Pooling estimates are biased estimators, but they're better than unbiased ones. One datapoint is an unbiased estimate of the mean, but it's probably not good to estimate it based on that. But being biased, we get better estimates out of sample. We can extend this strategy to slopes. Slopes are treatment effects, another feature of how the subjects respond to treatments. We can distinguish those among the clusters as well, and apply partial pooling, and get better estimates as before. In the upper plot you just have varying intercepts. Each line is a differen tcluster (chimp or tank). They all have the same response (slope). In the lower one we let the slopes vary. We want to do this quite often. " width="80%" />
<p class="caption">Last week was all about varying intercepts, the simplest type of MLM. Pooling estimates are biased estimators, but they're better than unbiased ones. One datapoint is an unbiased estimate of the mean, but it's probably not good to estimate it based on that. But being biased, we get better estimates out of sample. We can extend this strategy to slopes. Slopes are treatment effects, another feature of how the subjects respond to treatments. We can distinguish those among the clusters as well, and apply partial pooling, and get better estimates as before. In the upper plot you just have varying intercepts. Each line is a differen tcluster (chimp or tank). They all have the same response (slope). In the lower one we let the slopes vary. We want to do this quite often. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L17/03.png" alt="There are lots of domain-specific scientific reasons to consider varying slopes. Different people respond to different pain relief in different ways. There could be 0 average, but some poeple could benefit hugely from it. Personalised medicine is trying to leverage this. e.g education. Not everyone benefits from after school programs, but some do, so looking at average effects is not useful. " width="80%" />
<p class="caption">There are lots of domain-specific scientific reasons to consider varying slopes. Different people respond to different pain relief in different ways. There could be 0 average, but some poeple could benefit hugely from it. Personalised medicine is trying to leverage this. e.g education. Not everyone benefits from after school programs, but some do, so looking at average effects is not useful. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L17/04.png" alt="Statistically, the major conceptual innovation is that with varying slopes is you could treat them the same as varying intercepts. But you can do even better than that by noticing that the intercepts adn slopes are related in the population. When you learn about the intercetpp, you often get informatyion about the slope. Why? Because tye're lines, adn when you change the slope, you change the intercept. Now think about a single prior that has botht eh intercepts and slopes inside it. We'lll have a popualtion of features. There's a correlation structure among those features, which lets you transfer infomraiton across the features. Think about your friends or family, There is a correlation structure. There are now other things you expect Brendan to like when you find out he likes Death Metal. That's correlation structure." width="80%" />
<p class="caption">Statistically, the major conceptual innovation is that with varying slopes is you could treat them the same as varying intercepts. But you can do even better than that by noticing that the intercepts adn slopes are related in the population. When you learn about the intercetpp, you often get informatyion about the slope. Why? Because tye're lines, adn when you change the slope, you change the intercept. Now think about a single prior that has botht eh intercepts and slopes inside it. We'lll have a popualtion of features. There's a correlation structure among those features, which lets you transfer infomraiton across the features. Think about your friends or family, There is a correlation structure. There are now other things you expect Brendan to like when you find out he likes Death Metal. That's correlation structure.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L17/05.png" alt="Think back to the cafe example. Before you order your coffee in Berlin, you should update your estimate for Paris even though you left it behind. Now let's extend it. Your robot is your model. How do you get it to learn by visiting cafes. Now it keeps track of the time of day. Average wait time at 9am is longer than at 2pm. So we want to make that distinction. Code it as the difference between afternoon and evening. These two things are related by teh causal properties of cafes. This is toy data. Top is a popular cafe, with a big drop in wait time between morning and afternoon. Cafe B has a much smaller diffference in wait time because there's no morning saturation." width="80%" />
<p class="caption">Think back to the cafe example. Before you order your coffee in Berlin, you should update your estimate for Paris even though you left it behind. Now let's extend it. Your robot is your model. How do you get it to learn by visiting cafes. Now it keeps track of the time of day. Average wait time at 9am is longer than at 2pm. So we want to make that distinction. Code it as the difference between afternoon and evening. These two things are related by teh causal properties of cafes. This is toy data. Top is a popular cafe, with a big drop in wait time between morning and afternoon. Cafe B has a much smaller diffference in wait time because there's no morning saturation.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L17/06.png" alt="Now we have some statistical population, and there's a negative correlation between the intercepts (average wait time in the morning, standardsied), and the slope (dfiference between morning and afternooon). Higher intercepts = lower slopes. So there are two sets of parameteres, and we could treat them as completely separate." width="80%" />
<p class="caption">Now we have some statistical population, and there's a negative correlation between the intercepts (average wait time in the morning, standardsied), and the slope (dfiference between morning and afternooon). Higher intercepts = lower slopes. So there are two sets of parameteres, and we could treat them as completely separate.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L17/07.png" alt="The agent of our pooling now is a 2D Gaussian. We're going to have both parameters inside it. You need both a vector of means (average intercept and average slope). Then you need a variance-covarinace matrix. It assumes the posterior was multivariate Guassian, and approximated with this kind of entity. Now we'll be more explicit about it. We'll have covariances as part of the model now. THe simplest one is shown here - tey multi-dimensional analogue of sigma. If you add more dimensions to the Guassian distribution. Then there's the correlation between the two. SO you need three parameters to describe the covariance. $\sigma_a$ is the standard deviation of the intercepts. Square that for the variance. Then there's the covariance, which is the product of the two variances times this correlation coefficient $\rho$. The book has a box that explains why the covariance is the product of the variances times the correlation coefficient. That's the definition of correlation. " width="80%" />
<p class="caption">The agent of our pooling now is a 2D Gaussian. We're going to have both parameters inside it. You need both a vector of means (average intercept and average slope). Then you need a variance-covarinace matrix. It assumes the posterior was multivariate Guassian, and approximated with this kind of entity. Now we'll be more explicit about it. We'll have covariances as part of the model now. THe simplest one is shown here - tey multi-dimensional analogue of sigma. If you add more dimensions to the Guassian distribution. Then there's the correlation between the two. SO you need three parameters to describe the covariance. $\sigma_a$ is the standard deviation of the intercepts. Square that for the variance. Then there's the covariance, which is the product of the two variances times this correlation coefficient $\rho$. The book has a box that explains why the covariance is the product of the variances times the correlation coefficient. That's the definition of correlation. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L17/08.png" alt="Let's do some work with this. Simulate the journey of your coffee robot. 10 data points per cafe. Small sample, so we'll do some pooling. " width="80%" />
<p class="caption">Let's do some work with this. Simulate the journey of your coffee robot. 10 data points per cafe. Small sample, so we'll do some pooling. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L17/09.png" alt="This is your robot's brain. Step by step: Outcome variabes $W$ is the wait time for some cafe $i$. " width="80%" />
<p class="caption">This is your robot's brain. Step by step: Outcome variabes $W$ is the wait time for some cafe $i$. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L17/10.png" alt="Then we have varying intercepts and slopes (difference between mornign and afternoon, denoted by the dummy variable $A$. If $A$ is 1, it's $\alpha + \beta$. " width="80%" />
<p class="caption">Then we have varying intercepts and slopes (difference between mornign and afternoon, denoted by the dummy variable $A$. If $A$ is 1, it's $\alpha + \beta$. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L17/11.png" alt="Here's the action. Wehn we wnat to pool across alphas and betas, we have this 2D prior. For each cafe, there's a pair of parameters, alpha and beta, and they're distributed as a 2D normal They're averages are alpha and beta. Then they have this $S$, which si the covariance matrix. " width="80%" />
<p class="caption">Here's the action. Wehn we wnat to pool across alphas and betas, we have this 2D prior. For each cafe, there's a pair of parameters, alpha and beta, and they're distributed as a 2D normal They're averages are alpha and beta. Then they have this $S$, which si the covariance matrix. </p>
</div>

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L17/12.png" width="80%" />

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L17/13.png" alt="Where does this covariance matrix come from? 5 slides on matrix multiplication. Thing to understand is they're matrixes, way sof working with systems of equations. Just a compact form to do things faster. It's compressed. That's all it is. Let's think about our covariance matrix, shuffle it around to put priors on the parameters. $m$ is some dimension (2, going to be 4 by the end of the day). That means you need $m$ standard deviations. And you need the correlations. Just a formula for how many unordered pairs there are. Still a very small number of parameters relative to varying effects." width="80%" />
<p class="caption">Where does this covariance matrix come from? 5 slides on matrix multiplication. Thing to understand is they're matrixes, way sof working with systems of equations. Just a compact form to do things faster. It's compressed. That's all it is. Let's think about our covariance matrix, shuffle it around to put priors on the parameters. $m$ is some dimension (2, going to be 4 by the end of the day). That means you need $m$ standard deviations. And you need the correlations. Just a formula for how many unordered pairs there are. Still a very small number of parameters relative to varying effects.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L17/14.png" alt="So how to put priors on all these parameters. Lots of different conventions. There's a big litereature on what's wrong with the inverse-Wishart. We can do much better in practical terms. Want ot assign priors independently to each sigma and correlation coefficient. So we'll decompose our covariance matrix into three different matrices. Turns out it's a  product of a diagonal matrix with the two sigmas, times a correlation matrix, times the diagonal matrix again." width="80%" />
<p class="caption">So how to put priors on all these parameters. Lots of different conventions. There's a big litereature on what's wrong with the inverse-Wishart. We can do much better in practical terms. Want ot assign priors independently to each sigma and correlation coefficient. So we'll decompose our covariance matrix into three different matrices. Turns out it's a  product of a diagonal matrix with the two sigmas, times a correlation matrix, times the diagonal matrix again.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L17/15.png" alt="They're very nice, because they're shortcuts. Matrix derived from 'mother' or 'womb'. Something that somethign develops in. There are a few simple rules, which are ways to deal with systems of equations." width="80%" />
<p class="caption">They're very nice, because they're shortcuts. Matrix derived from 'mother' or 'womb'. Something that somethign develops in. There are a few simple rules, which are ways to deal with systems of equations.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L17/16.png" alt="Two-minute version just to demystify. If you have two square matrixes with capital and lower case letters. Set them up like this. The rule is you take the row and the column relevant to it. " width="80%" />
<p class="caption">Two-minute version just to demystify. If you have two square matrixes with capital and lower case letters. Set them up like this. The rule is you take the row and the column relevant to it. </p>
</div>

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L17/17.png" width="80%" />

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L17/18.png" width="80%" />

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L17/19.png" width="80%" />

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L17/20.png" width="80%" />

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L17/21.png" alt="Sometimes written as $\boldsymbol{SRS}$" width="80%" />
<p class="caption">Sometimes written as $\boldsymbol{SRS}$</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L17/22.png" alt="You do two matrix multiplications and get the original back." width="80%" />
<p class="caption">You do two matrix multiplications and get the original back.</p>
</div>

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L17/23.png" width="80%" />

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L17/24.png" width="80%" />

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L17/25.png" width="80%" />

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L17/26.png" alt="Now we can specify independent priors ont he correaltions adn the standard deviations. " width="80%" />
<p class="caption">Now we can specify independent priors ont he correaltions adn the standard deviations. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L17/27.png" alt="Need priors. Three SDs for this model. One at the top, one for the intercepts, one for the slopes." width="80%" />
<p class="caption">Need priors. Three SDs for this model. One at the top, one for the intercepts, one for the slopes.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L17/28.png" alt="How do you put a prior on a matrix? In ngeratl the matrix could be very big. You can't assign priors independnetly, because there are contstraints. The values can constrain one another. If you only have one correlation, it can vary between 1 and -1. If you have two values with a really strong correlation, that constrains the other values because they're also correlated with those two. As the matrix gets really big, the constraints get really strong. And in a big correlation matrix, it's really hard to get strong correlations. You can, but then all the others have to be really small. So you need a family of priors that deal with this problem. " width="80%" />
<p class="caption">How do you put a prior on a matrix? In ngeratl the matrix could be very big. You can't assign priors independnetly, because there are contstraints. The values can constrain one another. If you only have one correlation, it can vary between 1 and -1. If you have two values with a really strong correlation, that constrains the other values because they're also correlated with those two. As the matrix gets really big, the constraints get really strong. And in a big correlation matrix, it's really hard to get strong correlations. You can, but then all the others have to be really small. So you need a family of priors that deal with this problem. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L17/29.png" alt="So there's this really nice family of priors. Present in almos tall recent textbooks. LKJ named after the authors. There's one parameter that determines the shape, which specifies how concentrated it is relative to the identify matrix, which has no correlations. So if *eta* is higher, there are no correaltions. If lower, then flatter, and many more correaltions are possible. Eta = 1 is uniform. As you increase eta, you get more concentration around 0, which is the identity matrix. Usually you want to use somethign that is regularizing, sceptical of high correlations." width="80%" />
<p class="caption">So there's this really nice family of priors. Present in almos tall recent textbooks. LKJ named after the authors. There's one parameter that determines the shape, which specifies how concentrated it is relative to the identify matrix, which has no correlations. So if *eta* is higher, there are no correaltions. If lower, then flatter, and many more correaltions are possible. Eta = 1 is uniform. As you increase eta, you get more concentration around 0, which is the identity matrix. Usually you want to use somethign that is regularizing, sceptical of high correlations.</p>
</div>

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L17/30.png" width="80%" />

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L17/31.png" alt="Have both random intercepts and slopes. Vector of alphas for each cafe, and beta for each cafe. Here's the most transparent - use `c` to put `a` and `b` together like making a two-column matrix. Then we write `multi_normal` instead of normal. Then a vector of means. Then our correlation matrix `Rho`. " width="80%" />
<p class="caption">Have both random intercepts and slopes. Vector of alphas for each cafe, and beta for each cafe. Here's the most transparent - use `c` to put `a` and `b` together like making a two-column matrix. Then we write `multi_normal` instead of normal. Then a vector of means. Then our correlation matrix `Rho`. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L17/32.png" alt="WHen this builds in Stan, it knows that `sigma_cafe` is fo length 2 because `multi_normal` has two elements. Does it automatically. But later we can specify the link manually because we have to. " width="80%" />
<p class="caption">WHen this builds in Stan, it knows that `sigma_cafe` is fo length 2 because `multi_normal` has two elements. Does it automatically. But later we can specify the link manually because we have to. </p>
</div>

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L17/33.png" width="80%" />

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L17/34.png" alt="Run the posterior distribution for the correlation. Extract the posterior and plot the density for the correlation matrix. [1,1] is always  1. [1,2] and [2,1] is the same value. The black dashed density is the prior. The blue is the posterior. Almost all the mass is below 0. What's the consequence of this? You get shrinkage." width="80%" />
<p class="caption">Run the posterior distribution for the correlation. Extract the posterior and plot the density for the correlation matrix. [1,1] is always  1. [1,2] and [2,1] is the same value. The black dashed density is the prior. The blue is the posterior. Almost all the mass is below 0. What's the consequence of this? You get shrinkage.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L17/35.png" alt="Horizontal are the intercept estimates for each cafe. Vertical are th slope estimates. Drawn like a statistical population. Blue points are the raw data values. Fixed effect estimates. Raw, unregularised fixed effects estimate. Open circles are varying effects estimates." width="80%" />
<p class="caption">Horizontal are the intercept estimates for each cafe. Vertical are th slope estimates. Drawn like a statistical population. Blue points are the raw data values. Fixed effect estimates. Raw, unregularised fixed effects estimate. Open circles are varying effects estimates.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L17/36.png" alt="First thing to notice are the elipses. The contours of theinferred populations. The alpha and beta means and covrainces weren't nkown. Plotted the contours of the population with these ellipses. Any 2D Gaussian implies an ellipse. This is the statistical pouplation that generates shrinkage. Remember shinkage works where if the estimate is extrmee, thenn it gets shrunk towards the mean. We can highlight particular cafes liek the red one, and it has a very typical intercept, right in the middle of the popualtion. Boring, avergae cafe. Butits slope is unusual. Very extreme, out on the edges of theh population. Since it's extreme, it gets shrunk, but it also notices that intercepts and slopes are negatively correlated, so it also moves the intercept to the right. Even though the intercept is not extreme, it makes sense to adjust it because of the correlation strucutre. Why is this good? Helps to reduce overfitting. You can tour through. They're being drawn towards some contour twoards the angled middle. " width="80%" />
<p class="caption">First thing to notice are the elipses. The contours of theinferred populations. The alpha and beta means and covrainces weren't nkown. Plotted the contours of the population with these ellipses. Any 2D Gaussian implies an ellipse. This is the statistical pouplation that generates shrinkage. Remember shinkage works where if the estimate is extrmee, thenn it gets shrunk towards the mean. We can highlight particular cafes liek the red one, and it has a very typical intercept, right in the middle of the popualtion. Boring, avergae cafe. Butits slope is unusual. Very extreme, out on the edges of theh population. Since it's extreme, it gets shrunk, but it also notices that intercepts and slopes are negatively correlated, so it also moves the intercept to the right. Even though the intercept is not extreme, it makes sense to adjust it because of the correlation strucutre. Why is this good? Helps to reduce overfitting. You can tour through. They're being drawn towards some contour twoards the angled middle. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L17/37.png" alt="Can also transform to the outcome scale. Now there's a positive correlation, and would expect to wait more int he morning than the afternoon. But everything is still being shrunk towards the middle. " width="80%" />
<p class="caption">Can also transform to the outcome scale. Now there's a positive correlation, and would expect to wait more int he morning than the afternoon. But everything is still being shrunk towards the middle. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L17/38.png" alt="Exploting multi-dimensional shrinkage here. Even better than pooling wihtin. Depends upon the correaltion between effects. " width="80%" />
<p class="caption">Exploting multi-dimensional shrinkage here. Even better than pooling wihtin. Depends upon the correaltion between effects. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L17/39.png" alt="Grown up version of this. Many effects, many types of clusters. Back to the chimp data. Four treatments. Trying to estimate theaverage behaviour in each of these treatments. Howw often the left lever is pulled can vary by treatment. TID is treatment IDs 1 to 4, and for ecah there's an avergae rate of pulling the leve. BUt each chimp and blcok has a deviation from that mean. Alpha sub actor i, TID[i] measn the alpha deviation from the mean in this treatment, for actor[i]. Each actor gets four parameters. 7 actors. 7 x 4 parameters. RThen beta parameters for the block effects - deviations for the gamma means for each block. 4 parameters, times 6 blocks. Want to do some shrinkage. Rawest empirical descrption for this dataset yet. For eery little box, that has a unique idnetity, there's a uknique treatment and blocka dn actor that has its own deviation. But we'll need to do some shrinkage to deal with overfitting." width="80%" />
<p class="caption">Grown up version of this. Many effects, many types of clusters. Back to the chimp data. Four treatments. Trying to estimate theaverage behaviour in each of these treatments. Howw often the left lever is pulled can vary by treatment. TID is treatment IDs 1 to 4, and for ecah there's an avergae rate of pulling the leve. BUt each chimp and blcok has a deviation from that mean. Alpha sub actor i, TID[i] measn the alpha deviation from the mean in this treatment, for actor[i]. Each actor gets four parameters. 7 actors. 7 x 4 parameters. RThen beta parameters for the block effects - deviations for the gamma means for each block. 4 parameters, times 6 blocks. Want to do some shrinkage. Rawest empirical descrption for this dataset yet. For eery little box, that has a unique idnetity, there's a uknique treatment and blocka dn actor that has its own deviation. But we'll need to do some shrinkage to deal with overfitting.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L17/40.png" alt="One matrix for each cluster type. So 28 actors, 24 blocks. Means are all 0. Then the covariance matrix." width="80%" />
<p class="caption">One matrix for each cluster type. So 28 actors, 24 blocks. Means are all 0. Then the covariance matrix.</p>
</div>

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L17/41.png" width="80%" />

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L17/42.png" alt="Actor effects in red. Think of alphas as a matrix, with each row as an actor, and each column as a treatment. Then we define it down int he adaptive priors. `vector[4]` defines the matrix. 4 things minus the numbers of actors. Then there's this `multi_normal`. Multiplies the 4. `sigma_actor` and `Rho_actor`." width="80%" />
<p class="caption">Actor effects in red. Think of alphas as a matrix, with each row as an actor, and each column as a treatment. Then we define it down int he adaptive priors. `vector[4]` defines the matrix. 4 things minus the numbers of actors. Then there's this `multi_normal`. Multiplies the 4. `sigma_actor` and `Rho_actor`.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L17/43.png" alt="Now we have a matrix of betas. Row for each block, column for each treatment. The different treatment effects hav ea correlation across actors and blocks. What doe sthat mean? It's handedness. Actor number 2 always pulls the left. THe correlation among treatment effects is high. Really strong correlations, arising from handedness. With these models, part of learning is to run these, and then make the priors stronger. Try 64, 128. And see what happens to the posterior. Since you can't plot a 4D matrix. " width="80%" />
<p class="caption">Now we have a matrix of betas. Row for each block, column for each treatment. The different treatment effects hav ea correlation across actors and blocks. What doe sthat mean? It's handedness. Actor number 2 always pulls the left. THe correlation among treatment effects is high. Really strong correlations, arising from handedness. With these models, part of learning is to run these, and then make the priors stronger. Try 64, 128. And see what happens to the posterior. Since you can't plot a 4D matrix. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L17/44.png" alt="One of my favourite topics. The rollercoaster really pops off the rail with these." width="80%" />
<p class="caption">One of my favourite topics. The rollercoaster really pops off the rail with these.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L17/45.png" alt="To do a non-cetnered parameterisation, you factor all of the parameters out of the prior, into the linear model. For a 1D normal that's easy, because you can take hte mean and sigma out. But now we have a whole matrix. Sigmas aren't a problem, but still have a correlation matrix as a prior. Answer courtesy fo this guy. Figured out a cool trick to figure out a system of equations. " width="80%" />
<p class="caption">To do a non-cetnered parameterisation, you factor all of the parameters out of the prior, into the linear model. For a 1D normal that's easy, because you can take hte mean and sigma out. But now we have a whole matrix. Sigmas aren't a problem, but still have a correlation matrix as a prior. Answer courtesy fo this guy. Figured out a cool trick to figure out a system of equations. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L17/46.png" alt="Cholesky factor or decomposition is a workhorse. Artillery officer in WWI. Died in the war, but his colleagues had rescued his notes, where he had solved linear equations by solving fewer than you started with." width="80%" />
<p class="caption">Cholesky factor or decomposition is a workhorse. Artillery officer in WWI. Died in the war, but his colleagues had rescued his notes, where he had solved linear equations by solving fewer than you started with.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L17/47.png" alt="Why do we care? We've got this correlation matrix, and we need to somehow blend it with a vector of z scores. This is the cnon-centered prior business - you have independnet z-scores, and blend them with a correaltkno matrix ot get thisngs back on the right scale. This is what his technqiue lets us do. Imagine you wanted to simulated two vectors with a particular correlations. You could siulate independent random numbers. And you want their correlation to be 0.6. z1 is just a nuch of z scores, like z2. Then we can get `a1` as a funtion by multiplyign by sigma to put it on the normal scale. The last things is the Cholesky factor. This works for any size matrix. We'll pick up the rest in the next lecture." width="80%" />
<p class="caption">Why do we care? We've got this correlation matrix, and we need to somehow blend it with a vector of z scores. This is the cnon-centered prior business - you have independnet z-scores, and blend them with a correaltkno matrix ot get thisngs back on the right scale. This is what his technqiue lets us do. Imagine you wanted to simulated two vectors with a particular correlations. You could siulate independent random numbers. And you want their correlation to be 0.6. z1 is just a nuch of z scores, like z2. Then we can get `a1` as a funtion by multiplyign by sigma to put it on the normal scale. The last things is the Cholesky factor. This works for any size matrix. We'll pick up the rest in the next lecture.</p>
</div>

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L17/48.png" width="80%" />

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L17/49.png" width="80%" />

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L17/50.png" width="80%" />

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L17/51.png" width="80%" />

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L17/52.png" width="80%" />

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L17/53.png" width="80%" />

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L17/54.png" alt=" " width="80%" />
<p class="caption"> </p>
</div>

----


```r
slides_dir = here::here("docs/slides/L18")
```

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L18/01.png" width="80%" />

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L18/02.png" alt="We had specified this complicated random model. Now trying to show you non-centering reparameterising when you have random slopes. French guy called Cholesky figured out this cool technique. Way to take a bunch of uncorrelated values and give them any correlation you want. Here it's not what you want, it's the one the data wants. To get a non-cetnerd parameterisation, we nee the prior not to be conditonal on other parameters. For some datasets and models, some centering is better. You need to be flexible. " width="80%" />
<p class="caption">We had specified this complicated random model. Now trying to show you non-centering reparameterising when you have random slopes. French guy called Cholesky figured out this cool technique. Way to take a bunch of uncorrelated values and give them any correlation you want. Here it's not what you want, it's the one the data wants. To get a non-cetnerd parameterisation, we nee the prior not to be conditonal on other parameters. For some datasets and models, some centering is better. You need to be flexible. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L18/03.png" alt="In red all the bits that have to do with actor effects. Parameter for each actor and treatment, doing it with shrinkage and pooling. That's what this `alpha[actor,tid]` is. Green is the analagous block effects. Column is again a treatment. So what's the average treatment on that day? Need to check for block effects. What we're doing here is almost exactly Stan code. What you want to see is that we're creating the matrix. Defined by `compose_noncentered`. Multiply them by the z-score gives us the right scale again. Last bit down the bottom, now it doesn't contain a correlation matrix, it's a cholesky factor. " width="80%" />
<p class="caption">In red all the bits that have to do with actor effects. Parameter for each actor and treatment, doing it with shrinkage and pooling. That's what this `alpha[actor,tid]` is. Green is the analagous block effects. Column is again a treatment. So what's the average treatment on that day? Need to check for block effects. What we're doing here is almost exactly Stan code. What you want to see is that we're creating the matrix. Defined by `compose_noncentered`. Multiply them by the z-score gives us the right scale again. Last bit down the bottom, now it doesn't contain a correlation matrix, it's a cholesky factor. </p>
</div>

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L18/04.png" width="80%" />

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L18/05.png" alt="What you get from this is really amazing. They produce the same inferences, but some do them more effectively than others. Each point is a parameter in the posterior distribution. The horizontal axis is the number of effective samples from the centered model, that looks how the way we talk about MLMs. The vertical si the corresponding number of effective samples. So sometimes there are more than double the number of effective samples. This is not unqiue to Hamiltonian Monte Carlo, but the difference is that it tells you." width="80%" />
<p class="caption">What you get from this is really amazing. They produce the same inferences, but some do them more effectively than others. Each point is a parameter in the posterior distribution. The horizontal axis is the number of effective samples from the centered model, that looks how the way we talk about MLMs. The vertical si the corresponding number of effective samples. So sometimes there are more than double the number of effective samples. This is not unqiue to Hamiltonian Monte Carlo, but the difference is that it tells you.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L18/06.png" alt="Why are we doing this? We care about inference. Just the standard deviations from the random effects. For now, what do we learn from the SDs? They generate the stregth of pooling. The amount of variation is learned, and these are embodying that learning or information. The first four are actor effects that correspond to treatment factors. 1 was prosocial option on the right, and no partner present. 2 was prosocial left, no partner. 3 was prosocial right, parter, 4 prosocial left, partner present. And there's a lot less variation in treatment 2. The blocks are pretty much all the same. So it does more shrinkage than on actors, because the actors are diffferent due to handedlness. " width="80%" />
<p class="caption">Why are we doing this? We care about inference. Just the standard deviations from the random effects. For now, what do we learn from the SDs? They generate the stregth of pooling. The amount of variation is learned, and these are embodying that learning or information. The first four are actor effects that correspond to treatment factors. 1 was prosocial option on the right, and no partner present. 2 was prosocial left, no partner. 3 was prosocial right, parter, 4 prosocial left, partner present. And there's a lot less variation in treatment 2. The blocks are pretty much all the same. So it does more shrinkage than on actors, because the actors are diffferent due to handedlness. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L18/07.png" alt="Here are the correlation efffects. You can transform the Choleky factors by tranposing - rotating and multiplying by itself to get the correlation matrix. Diagonal is all 1s. All the things on the 1s show up as points. Then the others are correlations between the different treatments. Note they're all positive. What does that mean? It's handedness. At the individual level, the correlations are hgih because of handedness. Now you see it arises as a correlation among the treatments at the actor level. A lot of the information is like this where you can capture it. Looks different when you inspect it. But if you made parameters for left and right, these correlations won't appear. Homework has a similar problem. " width="80%" />
<p class="caption">Here are the correlation efffects. You can transform the Choleky factors by tranposing - rotating and multiplying by itself to get the correlation matrix. Diagonal is all 1s. All the things on the 1s show up as points. Then the others are correlations between the different treatments. Note they're all positive. What does that mean? It's handedness. At the individual level, the correlations are hgih because of handedness. Now you see it arises as a correlation among the treatments at the actor level. A lot of the information is like this where you can capture it. Looks different when you inspect it. But if you made parameters for left and right, these correlations won't appear. Homework has a similar problem. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L18/08.png" alt="Posterior predictions. Take the posterior and push it back through the model. Why? To make sure the model works, adn caputres the texture of the data, but isn't identical due to shrinkage. Each actor going across. Each is a point. Tilt tells you what happens when you add the partner. Answer is not much. But moving the food to the other side of the table makes them attracted to more food. Actor 2 doesn't respond that way because actor 2 doesn't change. But notic ehthe model doesn't retrodict, because of shrinkage. SO the predictions are pulled a little bit towards the mean of the population, and most in treatment 2. The variance of treatment 2 was lower, so you get more shirnkage. sigma actor 2 is about 1, where sigma for the others were above 1." width="80%" />
<p class="caption">Posterior predictions. Take the posterior and push it back through the model. Why? To make sure the model works, adn caputres the texture of the data, but isn't identical due to shrinkage. Each actor going across. Each is a point. Tilt tells you what happens when you add the partner. Answer is not much. But moving the food to the other side of the table makes them attracted to more food. Actor 2 doesn't respond that way because actor 2 doesn't change. But notic ehthe model doesn't retrodict, because of shrinkage. SO the predictions are pulled a little bit towards the mean of the population, and most in treatment 2. The variance of treatment 2 was lower, so you get more shirnkage. sigma actor 2 is about 1, where sigma for the others were above 1.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L18/09.png" alt="Only advice I can often give is horoscopic. The design of a proper analysis is outside the table, so the table is not enough. Nevertheless, it's nice to have a default; a place to start. I fyou had the bare minimum of information, you could use a horoscopes, adn the predictions are terrible. So you should feel fine about deviating from them when you learn something. So use a causal model first. Start with the empty model. Itdentify the clusters of interest (chimps, blocks, treatments) then put them in as varying intercepts. Like a shriking ANOVA. Where's the variation? Then you get the machine humming before you start adding predictors. Standardise unless ordered categories. Good default behaviour. Always pregularise by simulating from the piror. THen add in predictors and vary their slopes. Find to drop varying effects whens sigmas are small, but you could also leave them in and they'll aggressively shrink. Consider if you're trying to expmlain the sample, you'll focus on the units. More linkely that you're not interested in lefty, but in the variation in the population. We care about the indivdiuals, but they're exchangeable in the sense we're trying to generalise to the population, not making predictions about the same individuals.  " width="80%" />
<p class="caption">Only advice I can often give is horoscopic. The design of a proper analysis is outside the table, so the table is not enough. Nevertheless, it's nice to have a default; a place to start. I fyou had the bare minimum of information, you could use a horoscopes, adn the predictions are terrible. So you should feel fine about deviating from them when you learn something. So use a causal model first. Start with the empty model. Itdentify the clusters of interest (chimps, blocks, treatments) then put them in as varying intercepts. Like a shriking ANOVA. Where's the variation? Then you get the machine humming before you start adding predictors. Standardise unless ordered categories. Good default behaviour. Always pregularise by simulating from the piror. THen add in predictors and vary their slopes. Find to drop varying effects whens sigmas are small, but you could also leave them in and they'll aggressively shrink. Consider if you're trying to expmlain the sample, you'll focus on the units. More linkely that you're not interested in lefty, but in the variation in the population. We care about the indivdiuals, but they're exchangeable in the sense we're trying to generalise to the population, not making predictions about the same individuals.  </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L18/10.png" alt="Quick conceptual introduction to two families of covariance models that go beyond random slopes. All the cool things we can do with covariance matrixes. Quick guide to say that lods of models focus on covariance matrixes. Going to look at instrumental variables. MR *is* instrumental variables. Then social relations model. Network models also depend on covariation of behaviour among nodes. Factor analysis is also covariance. And animal model. Shows that height is just a big covariance matrix. (Probably want to de-center.) Spatial distances are another kind of distance you can specify the covariaiton of." width="80%" />
<p class="caption">Quick conceptual introduction to two families of covariance models that go beyond random slopes. All the cool things we can do with covariance matrixes. Quick guide to say that lods of models focus on covariance matrixes. Going to look at instrumental variables. MR *is* instrumental variables. Then social relations model. Network models also depend on covariation of behaviour among nodes. Factor analysis is also covariance. And animal model. Shows that height is just a big covariance matrix. (Probably want to de-center.) Spatial distances are another kind of distance you can specify the covariaiton of.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L18/11.png" alt="This is a cool technqiue that goes beyond the backdoor crioterion. Sometimes it tells you you can't remove the confounding. But all is not lost - you can still deconfound. Imagine this classic case where we're interested in some E for education, and W for wages. Many people are interested in measuring the ffect of education on wages. Unviersity funding hinges on it. The problem is that there are a huge umber of confounds, labelled U. Could just be personality effects, like your laziness. There are going to be lots like this in any observational system. Can't condition on you because we don't have it measured. " width="80%" />
<p class="caption">This is a cool technqiue that goes beyond the backdoor crioterion. Sometimes it tells you you can't remove the confounding. But all is not lost - you can still deconfound. Imagine this classic case where we're interested in some E for education, and W for wages. Many people are interested in measuring the ffect of education on wages. Unviersity funding hinges on it. The problem is that there are a huge umber of confounds, labelled U. Could just be personality effects, like your laziness. There are going to be lots like this in any observational system. Can't condition on you because we don't have it measured. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L18/12.png" alt="But if you can get an instrument Q, there's some hope. It's a variable that affects the exposure of interest, but not the outcome. Here it's birthday position in year. Q for quarter. Famous exampel form the economics literature. Pepople born earlier consume less eudcation. Why? First, age is a social variable. The age you're assigned is randomly cut off in January. So you can be biolgically almost a year older than someone the same social age. And it's your social age that determines when you start school. So earlier in the year are older when they start school, and graduate having completed less school. You're also eligible to quit school earlier. So you will have consumed less school if you drop out at the same time as someone younger. This is a natural experiment, assigned by the hand of god, interacts with the social system. Adjusts your education independent of the confounds, which are probably not associated with January - people born in January probably aren't lazier, but we need to check this." width="80%" />
<p class="caption">But if you can get an instrument Q, there's some hope. It's a variable that affects the exposure of interest, but not the outcome. Here it's birthday position in year. Q for quarter. Famous exampel form the economics literature. Pepople born earlier consume less eudcation. Why? First, age is a social variable. The age you're assigned is randomly cut off in January. So you can be biolgically almost a year older than someone the same social age. And it's your social age that determines when you start school. So earlier in the year are older when they start school, and graduate having completed less school. You're also eligible to quit school earlier. So you will have consumed less school if you drop out at the same time as someone younger. This is a natural experiment, assigned by the hand of god, interacts with the social system. Adjusts your education independent of the confounds, which are probably not associated with January - people born in January probably aren't lazier, but we need to check this.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L18/13.png" alt="Why does this help? It turns E into a collider. If we condition on E, which we're going ot do, and we know Q, we get information about U. Like the light switch - if the ligth is on, and the conditions for that are that the switch is on and there needs to be electricity, conditioning on E is like saying I know the light is on. Conditioning on Q is like saying I know the switch is thrown. Now you know U, that electricyt is there. So what's happening here? Next slide. Let's talk about correlation first. Q tells us something about the strength of the corrleation U. " width="80%" />
<p class="caption">Why does this help? It turns E into a collider. If we condition on E, which we're going ot do, and we know Q, we get information about U. Like the light switch - if the ligth is on, and the conditions for that are that the switch is on and there needs to be electricity, conditioning on E is like saying I know the light is on. Conditioning on Q is like saying I know the switch is thrown. Now you know U, that electricyt is there. So what's happening here? Next slide. Let's talk about correlation first. Q tells us something about the strength of the corrleation U. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L18/14.png" alt="Imagine on average Q1 people consume 10 years more. Then we look a ta parituclar Q1 person who consumed more than the average. We just learned seomething about the confound. That they're not more lazy. We find out about them when we find out about their education, because we now something about Q. " width="80%" />
<p class="caption">Imagine on average Q1 people consume 10 years more. Then we look a ta parituclar Q1 person who consumed more than the average. We just learned seomething about the confound. That they're not more lazy. We find out about them when we find out about their education, because we now something about Q. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L18/15.png" alt="Often these are called natural experiments in biology. If we fould experiemntally maniputlate education, we woudl do that, but can't. We'd satisfy the backdoor criterion. Not ethical to do that. The birthday is random, so now it's liek a weak experiemnt, where we've partially closed the backdoor. Like an experiemnt that doesn't always take. Q is suggesting to indiviuals they should do more or less education. The tendencies to follow the experiemnt give you information about the confound. If you follow up on the litereature, many experiements are actually like this, because we only suggest treatments to poeple. Epidemiologicla experiments are like this, becuase you only suggest treatment - they walk out the door and some take it and some don't. This is called *intent to treat*, and you have to estimate it. Really famous case with anti-retroviral trials. People taking them knew there was a control arm, so they blended up their medications. Turns out this isn't rare. This instrumental variable analysis is the correct way to anlysis an epxeriemtbn where the treatment is not enforced, but only suggested. Happens in psychology. Did they really look at the stimulus?  " width="80%" />
<p class="caption">Often these are called natural experiments in biology. If we fould experiemntally maniputlate education, we woudl do that, but can't. We'd satisfy the backdoor criterion. Not ethical to do that. The birthday is random, so now it's liek a weak experiemnt, where we've partially closed the backdoor. Like an experiemnt that doesn't always take. Q is suggesting to indiviuals they should do more or less education. The tendencies to follow the experiemnt give you information about the confound. If you follow up on the litereature, many experiements are actually like this, because we only suggest treatments to poeple. Epidemiologicla experiments are like this, becuase you only suggest treatment - they walk out the door and some take it and some don't. This is called *intent to treat*, and you have to estimate it. Really famous case with anti-retroviral trials. People taking them knew there was a control arm, so they blended up their medications. Turns out this isn't rare. This instrumental variable analysis is the correct way to anlysis an epxeriemtbn where the treatment is not enforced, but only suggested. Happens in psychology. Did they really look at the stimulus?  </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L18/16.png" alt="Generatively, what to do. Take the DAG and simulate from it. There's a model for wages as a function of education and the confound. " width="80%" />
<p class="caption">Generatively, what to do. Take the DAG and simulate from it. There's a model for wages as a function of education and the confound. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L18/17.png" alt="Then education is there. " width="80%" />
<p class="caption">Then education is there. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L18/18.png" alt="Then quarter of birth. Not true, but for the sake of the example." width="80%" />
<p class="caption">Then quarter of birth. Not true, but for the sake of the example.</p>
</div>

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L18/19.png" width="80%" />

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L18/20.png" alt="Making the effect of E 0. " width="80%" />
<p class="caption">Making the effect of E 0. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L18/21.png" alt="Rn the naive regression. Strong and reliable effect. Purely the confound. Can't interpret these things." width="80%" />
<p class="caption">Rn the naive regression. Strong and reliable effect. Purely the confound. Can't interpret these things.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L18/22.png" alt="Now add the instrument. And you could estimate all the $U$s as parameters, one for each of the 500 individuals in the sample. But the way better way to do that, is to use the MVNOrmal as your outcome distribution. So now as the likelihood, the top part of the model, we're going to say that $W$ and $E$ are drawn from a common distribtuion with some correlation. Where does the correlation come from? From the confound." width="80%" />
<p class="caption">Now add the instrument. And you could estimate all the $U$s as parameters, one for each of the 500 individuals in the sample. But the way better way to do that, is to use the MVNOrmal as your outcome distribution. So now as the likelihood, the top part of the model, we're going to say that $W$ and $E$ are drawn from a common distribtuion with some correlation. Where does the correlation come from? From the confound.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L18/23.png" alt="First path we'll worry about is the instrument to education. Expected amount of education is some intercept then slope for quartr of birth." width="80%" />
<p class="caption">First path we'll worry about is the instrument to education. Expected amount of education is some intercept then slope for quartr of birth.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L18/24.png" alt="Siomuiltaenosuly we'll runt he other model of effect of education on wages. " width="80%" />
<p class="caption">Siomuiltaenosuly we'll runt he other model of effect of education on wages. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L18/25.png" alt="Then at the top we deal with the confound. Generates correlated devaitions after we'd conditioned on other things. This is the same gerative model, but we've marginalised over all the $U$ values, by making a correlation matrix." width="80%" />
<p class="caption">Then at the top we deal with the confound. Generates correlated devaitions after we'd conditioned on other things. This is the same gerative model, but we've marginalised over all the $U$ values, by making a correlation matrix.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L18/26.png" alt="SO now we have this at the top of the mdoel." width="80%" />
<p class="caption">SO now we have this at the top of the mdoel.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L18/27.png" alt="This works. First thignnto look at are the regression effects. No confound there. Now look at our unconfounded education. Notice that `Rho[1,2]` is the correlation between education and wages, after having conditioned on the instrument - so it's the effect of the confound. Positive correlations, which give you clues about what it could be. " width="80%" />
<p class="caption">This works. First thignnto look at are the regression effects. No confound there. Now look at our unconfounded education. Notice that `Rho[1,2]` is the correlation between education and wages, after having conditioned on the instrument - so it's the effect of the confound. Positive correlations, which give you clues about what it could be. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L18/28.png" alt="Instruments are limited. THe hardest part is finding a plausible instrument. Cannot test whetehr seomethig is a good instrument! DAG depends upon scientific infomratyion, not the data alone. Weak instruments maybe not useful. Try some simulations from the chapters. Now we'll instoduce other things likwe the front door criterions." width="80%" />
<p class="caption">Instruments are limited. THe hardest part is finding a plausible instrument. Cannot test whetehr seomethig is a good instrument! DAG depends upon scientific infomratyion, not the data alone. Weak instruments maybe not useful. Try some simulations from the chapters. Now we'll instoduce other things likwe the front door criterions.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L18/29.png" alt="One of my favourite types of models. Often in the social sciences and organismal biology, we're interested in dyadic interactionsb etween units. Complicated because there's a field of interactions. Pulling apart can be difficult. " width="80%" />
<p class="caption">One of my favourite types of models. Often in the social sciences and organismal biology, we're interested in dyadic interactionsb etween units. Complicated because there's a field of interactions. Pulling apart can be difficult. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L18/30.png" alt="Example from a collaborator. 25 households from rural Nicaragua. Outcome is gifts, usually of meat, from one household to another. Lots of reciprocity in these networks, but meausuring is tricky, becuase there are also generalised effects. 300 dyads. This dataset has 300 rows. Modest correalation of 0.24. But this isn't the way to measure reciprocity. " width="80%" />
<p class="caption">Example from a collaborator. 25 households from rural Nicaragua. Outcome is gifts, usually of meat, from one household to another. Lots of reciprocity in these networks, but meausuring is tricky, becuase there are also generalised effects. 300 dyads. This dataset has 300 rows. Modest correalation of 0.24. But this isn't the way to measure reciprocity. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L18/31.png" alt="Here's the problem. TThe 0.24 correlation is produced both by generalised effects, and household-specific (or dyadic) effects. Also a lot of predictors like kinship in the datsaaaset. We're going to ignore it. We think about the count from A to B. There's some average $\alpha$. There's also a generosity rate. Some households are more generous to others. There's also generalised receiving, $r_B$. These generalised effects are contaminating. Then there are dyad effects, consdiering only the household A and B, how much does A give to B, and how is that correlation to how much B gives to A. " width="80%" />
<p class="caption">Here's the problem. TThe 0.24 correlation is produced both by generalised effects, and household-specific (or dyadic) effects. Also a lot of predictors like kinship in the datsaaaset. We're going to ignore it. We think about the count from A to B. There's some average $\alpha$. There's also a generosity rate. Some households are more generous to others. There's also generalised receiving, $r_B$. These generalised effects are contaminating. Then there are dyad effects, consdiering only the household A and B, how much does A give to B, and how is that correlation to how much B gives to A. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L18/32.png" alt="How to model it? We need covariances! One covariance matrix for the generalised effects. For each hosuefhold $i$, you have two parameters, $g$ - gleneralised offset, as in how much it's giving on average, offset, adn $r$, which is how much more than alpha it tends to receive. They're going to be correlated. We set upt this 2x2 covariance matrix as before. Variation in the givingness offset, and variation in the recivingness offset. Nothing new here really.  " width="80%" />
<p class="caption">How to model it? We need covariances! One covariance matrix for the generalised effects. For each hosuefhold $i$, you have two parameters, $g$ - gleneralised offset, as in how much it's giving on average, offset, adn $r$, which is how much more than alpha it tends to receive. They're going to be correlated. We set upt this 2x2 covariance matrix as before. Variation in the givingness offset, and variation in the recivingness offset. Nothing new here really.  </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L18/33.png" alt="Next we have the dyad effects. FOr each dyad $i$ and $j$, they're donation offsets in both directions. A can tend to give a lot to B, and B gives little to A, then these d parameters willh have low correaltion. If they're neggative, the pairs end up in depednence relationships. We capture these effects iwth this covariance matrix. It's new, and special, beacuse it only has one sigma isndie of it. Why? Because it's symmetrical. A and B are th same type of parameter. Like judo - blue and read shorts are random, so the variance between their wins must be the same because it's randomised." width="80%" />
<p class="caption">Next we have the dyad effects. FOr each dyad $i$ and $j$, they're donation offsets in both directions. A can tend to give a lot to B, and B gives little to A, then these d parameters willh have low correaltion. If they're neggative, the pairs end up in depednence relationships. We capture these effects iwth this covariance matrix. It's new, and special, beacuse it only has one sigma isndie of it. Why? Because it's symmetrical. A and B are th same type of parameter. Like judo - blue and read shorts are random, so the variance between their wins must be the same because it's randomised.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L18/34.png" alt="Just copy the sigma twice into the matrix. Details are boring. Just one sigma - $\sigma_d$." width="80%" />
<p class="caption">Just copy the sigma twice into the matrix. Details are boring. Just one sigma - $\sigma_d$.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L18/35.png" alt="Correlation matrix for the GR effects and the two SDs for it. Look at the correaltion: -0.4." width="80%" />
<p class="caption">Correlation matrix for the GR effects and the two SDs for it. Look at the correaltion: -0.4.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L18/36.png" alt="Generalised giving  for each household against generalised receiving. Negative correlation meaning that generous households receive less, because thy're rich. Then poor households on the left. Having conditioned on dyad effects. Can see the needs-based structure. Parameters on both axes. Drawn an ellipss. " width="80%" />
<p class="caption">Generalised giving  for each household against generalised receiving. Negative correlation meaning that generous households receive less, because thy're rich. Then poor households on the left. Having conditioned on dyad effects. Can see the needs-based structure. Parameters on both axes. Drawn an ellipss. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L18/37.png" alt="Now let's think about dyads. `Rho_d` is 0.88. " width="80%" />
<p class="caption">Now let's think about dyads. `Rho_d` is 0.88. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L18/38.png" alt="Some of these devaitions are small. 0s are very balanced. Reciprocity on 0s, and also for kinships. " width="80%" />
<p class="caption">Some of these devaitions are small. 0s are very balanced. Reciprocity on 0s, and also for kinships. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L18/39.png" alt="Very pleased with this homework set. Going to go back to the Bangladesh data, going to do random slopes, then adding predictor variables: the woman's age, and the number of kids she already has. Big effects on contrcetpive use. Draw a DAG and use it to anlayse the causal influence of age and kids on contreption." width="80%" />
<p class="caption">Very pleased with this homework set. Going to go back to the Bangladesh data, going to do random slopes, then adding predictor variables: the woman's age, and the number of kids she already has. Big effects on contrcetpive use. Draw a DAG and use it to anlayse the causal influence of age and kids on contreption.</p>
</div>


```r
slides_dir = here::here("docs/slides/L19")
```

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L19/01.png" alt="Get to take everything we've learned and put it together." width="80%" />
<p class="caption">Get to take everything we've learned and put it together.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L19/02.png" alt="Data story. General phenomoent that doesn't just applhy to American politics. Birth year of voters. On the veritcal we have the Republican vote share of individuals in that birth year. Share of the vote they have to the presidential candidates in that year. Each of the colours is a different election year. As you get closer to the present, younger people are allowed to vote, so you can seee the curves are shifting to the left. If you plotted this graph by age, you would see this view. Interesting view that the hills and valleys line up, even though in any particular year it can move up and down quite a lot. 2008 is much lower down across all age groups. Bu tthe peaks and valleys are in teh same place. These are cohort effecs. Something abou thteh year you're born in sets your politial preference for live. It's something that heppns to people born around that time that happens in their life. " width="80%" />
<p class="caption">Data story. General phenomoent that doesn't just applhy to American politics. Birth year of voters. On the veritcal we have the Republican vote share of individuals in that birth year. Share of the vote they have to the presidential candidates in that year. Each of the colours is a different election year. As you get closer to the present, younger people are allowed to vote, so you can seee the curves are shifting to the left. If you plotted this graph by age, you would see this view. Interesting view that the hills and valleys line up, even though in any particular year it can move up and down quite a lot. 2008 is much lower down across all age groups. Bu tthe peaks and valleys are in teh same place. These are cohort effecs. Something abou thteh year you're born in sets your politial preference for live. It's something that heppns to people born around that time that happens in their life. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L19/03.png" alt="They fit a bit heirarchical Bayesian model to find the age it is that sets their poltical orientation. What matters is that when your're 18, who is present, what party theyr'e from, and are they popular. THen you can predict their political orientation for the rest of their life. Things that happen when you're older don't have nearly as much of an effect. Year of birth is linear, but also a category. It's an orderd category. If we can to take effects like this seriously, we need to take them into account. Called continuous cateogries. Trough in 1950 is the Nixon effect. Most conservative is the Reagan effect. He was winnign the Cold War. " width="80%" />
<p class="caption">They fit a bit heirarchical Bayesian model to find the age it is that sets their poltical orientation. What matters is that when your're 18, who is present, what party theyr'e from, and are they popular. THen you can predict their political orientation for the rest of their life. Things that happen when you're older don't have nearly as much of an effect. Year of birth is linear, but also a category. It's an orderd category. If we can to take effects like this seriously, we need to take them into account. Called continuous cateogries. Trough in 1950 is the Nixon effect. Most conservative is the Reagan effect. He was winnign the Cold War. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L19/04.png" alt="You can assert that they have linear effects, but then you're giving up on thise non-monotonic cohort effects. Or ny number of other interesting things as well, like income. No reaon that every paddditnoal percent of income has the same effect. How is location a category? It's a proxy of things you haven't measured. Location is a proxy for common exposures. Phylogentic distance analagous to location. No obvious cutpoints, but similar values are similar in their effects. If you want an infinite number of categories, buecasue it's continuous, you want pooling. So we'll make models with infiinte cateogories, and fit arbitrary function swith pooling, and it'll work great. In machine learning is Gaussain process regression. " width="80%" />
<p class="caption">You can assert that they have linear effects, but then you're giving up on thise non-monotonic cohort effects. Or ny number of other interesting things as well, like income. No reaon that every paddditnoal percent of income has the same effect. How is location a category? It's a proxy of things you haven't measured. Location is a proxy for common exposures. Phylogentic distance analagous to location. No obvious cutpoints, but similar values are similar in their effects. If you want an infinite number of categories, buecasue it's continuous, you want pooling. So we'll make models with infiinte cateogories, and fit arbitrary function swith pooling, and it'll work great. In machine learning is Gaussain process regression. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L19/05.png" alt="Two examples with code on how to do this. First is with spatial autocorrelation, where shared space is a proxy for unmeasured confounds. Let's go back to tools. Interested in predicting number of tools based on size of population. One of the problems is that islands that are close to others can just go and get the tools rather than inventing them. Certainly down near Tonga there were a lo tof effects. So distance between islands is a proxy for contact. " width="80%" />
<p class="caption">Two examples with code on how to do this. First is with spatial autocorrelation, where shared space is a proxy for unmeasured confounds. Let's go back to tools. Interested in predicting number of tools based on size of population. One of the problems is that islands that are close to others can just go and get the tools rather than inventing them. Certainly down near Tonga there were a lo tof effects. So distance between islands is a proxy for contact. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L19/06.png" alt="Here's the idea. You construct a distance matrix. Could probably do better than this based on sailing routes, but this will suffice here. This is like our map of confoud threats. What could make the tools counts similar is correlation between islands that are closer together. " width="80%" />
<p class="caption">Here's the idea. You construct a distance matrix. Could probably do better than this based on sailing routes, but this will suffice here. This is like our map of confoud threats. What could make the tools counts similar is correlation between islands that are closer together. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L19/07.png" alt="Let's build the matrix into the model. We've got expected tools $\lambda$. $\alpha$ is the propoertinaly constant, i..e number of tools per member, then $\beta$ is elasticity, then $\gamma$ is the loss rate." width="80%" />
<p class="caption">Let's build the matrix into the model. We've got expected tools $\lambda$. $\alpha$ is the propoertinaly constant, i..e number of tools per member, then $\beta$ is elasticity, then $\gamma$ is the loss rate.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L19/08.png" alt="We can add the Guassian process by adding a factor on the front of it. Added this exponent to the $k_{SOCIETY}. It's like a varying intercept. It's a parameter that is estimated for each society, with a normal prior, but exponentitated to make it positive. This makes it a facotr." width="80%" />
<p class="caption">We can add the Guassian process by adding a factor on the front of it. Added this exponent to the $k_{SOCIETY}. It's like a varying intercept. It's a parameter that is estimated for each society, with a normal prior, but exponentitated to make it positive. This makes it a facotr.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L19/09.png" alt="$k$ = 0 is just the model prediction. Not inated or deflated at all. This factor is increasing or decreasing the expectation from other factors. Some will get inflated because the're near other islands with tools. If you ahd a linear model, you owulnd't do the exponnetiation, you'd just stik the $k$ on there." width="80%" />
<p class="caption">$k$ = 0 is just the model prediction. Not inated or deflated at all. This factor is increasing or decreasing the expectation from other factors. Some will get inflated because the're near other islands with tools. If you ahd a linear model, you owulnd't do the exponnetiation, you'd just stik the $k$ on there.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L19/10.png" alt="WHere to get the $k$s from? This matrix. Big prior with all these varying effects. Big vecotr for a ll the $k$,s  10 becuase 1 for each island. Come form teh same multi-variate normal prior. How do you build this thing? Going to generate the whole matrix from that distance matrix, and use it to parameterise how the correlation falls off at distance. Going to show you the most common way to do with with so calle dL2Noral at the bottom, where each cell int he matrix $K$ is given by that expression. Note it only has three parameters in it. 300x300 matrix, which we could have by the end of the day. " width="80%" />
<p class="caption">WHere to get the $k$s from? This matrix. Big prior with all these varying effects. Big vecotr for a ll the $k$,s  10 becuase 1 for each island. Come form teh same multi-variate normal prior. How do you build this thing? Going to generate the whole matrix from that distance matrix, and use it to parameterise how the correlation falls off at distance. Going to show you the most common way to do with with so calle dL2Noral at the bottom, where each cell int he matrix $K$ is given by that expression. Note it only has three parameters in it. 300x300 matrix, which we could have by the end of the day. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L19/11.png" alt="This is what the L2Normal matrix means. eta squared is the maximum covaiance between any two isaldn,s fit from the data. Then multplied by the thing in the middle. Rho squared i st he rateo fo decline with distance, and Distance ist he squared distance from the distance matrix. THis is the Guassian part, buecause this is a bell curve. the e(-something^2) is what gives you something gaussian. Deltaij turns sigma squared on and off. So if you have multiple observations from each island, you neex thtis factor there so they're not all predicted to be the same.  " width="80%" />
<p class="caption">This is what the L2Normal matrix means. eta squared is the maximum covaiance between any two isaldn,s fit from the data. Then multplied by the thing in the middle. Rho squared i st he rateo fo decline with distance, and Distance ist he squared distance from the distance matrix. THis is the Guassian part, buecause this is a bell curve. the e(-something^2) is what gives you something gaussian. Deltaij turns sigma squared on and off. So if you have multiple observations from each island, you neex thtis factor there so they're not all predicted to be the same.  </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L19/12.png" alt="Gaussian decline, or squared distance. Horitzontal is diwstance between two islands, and vertical is the correlation, standardised. And I'v e made up some values for Rho. Squared idstance function gets the solid curve. Starts with a slow decline, gthen accelerates liek a Gaussain curve. End up with this accelerating rate to get to the flat part of the tail really fast. If you choose a linear distance instead, you take the square off the D, then you get the dahssed linear curve. Nothign wrong with that, but it has a different set of assumpotions: that the rate of loss is the fastests at the start. The amount gyou lose is fastests at the start. Probably not the case." width="80%" />
<p class="caption">Gaussian decline, or squared distance. Horitzontal is diwstance between two islands, and vertical is the correlation, standardised. And I'v e made up some values for Rho. Squared idstance function gets the solid curve. Starts with a slow decline, gthen accelerates liek a Gaussain curve. End up with this accelerating rate to get to the flat part of the tail really fast. If you choose a linear distance instead, you take the square off the D, then you get the dahssed linear curve. Nothign wrong with that, but it has a different set of assumpotions: that the rate of loss is the fastests at the start. The amount gyou lose is fastests at the start. Probably not the case.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L19/13.png" alt="All we're doing is all in the prior. Varying effects drawn from one giant Gaussian. Rest of the model is what we've done before. You could have all the pariwise differece between ages, and all the particular effects.  Vector of $k$s. Priors from eta nd rho, both squared. Don't have to be squared, by why? Convention. Want to simulate from these priors and see what they imply. " width="80%" />
<p class="caption">All we're doing is all in the prior. Varying effects drawn from one giant Gaussian. Rest of the model is what we've done before. You could have all the pariwise differece between ages, and all the particular effects.  Vector of $k$s. Priors from eta nd rho, both squared. Don't have to be squared, by why? Convention. Want to simulate from these priors and see what they imply. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L19/14.png" alt="If almbda is 2, the mean is 0.5. The rate is the inverse of the mean in an exponential. So sample randomly, and draw a curve. 50 samples from the prior distribution. In this prior, most fall off pretty rapidly, so the prior assumes that it could be anything from moderatley strong to aboslutely incredibly weak, but all of them drop off really fast. POsterior will look really different." width="80%" />
<p class="caption">If almbda is 2, the mean is 0.5. The rate is the inverse of the mean in an exponential. So sample randomly, and draw a curve. 50 samples from the prior distribution. In this prior, most fall off pretty rapidly, so the prior assumes that it could be anything from moderatley strong to aboslutely incredibly weak, but all of them drop off really fast. POsterior will look really different.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L19/15.png" alt="As you might expect, only thing that changes is this Guassian process. Helper function in `ulam`" width="80%" />
<p class="caption">As you might expect, only thing that changes is this Guassian process. Helper function in `ulam`</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L19/16.png" alt="`k`s for each society, a vector of lenght 10. Just like a varying intercept vector. Come from this MVnOrmal distirbution. " width="80%" />
<p class="caption">`k`s for each society, a vector of lenght 10. Just like a varying intercept vector. Come from this MVnOrmal distirbution. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L19/17.png" alt="Sigma is a 10x10 matrix. GPL2 is Gaussian process L2Norm. Do some loops to do what's on the previous slide. If you look at the Stan code, there's just a loop that calculates every trajectory. " width="80%" />
<p class="caption">Sigma is a 10x10 matrix. GPL2 is Gaussian process L2Norm. Do some loops to do what's on the previous slide. If you look at the Stan code, there's just a loop that calculates every trajectory. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L19/18.png" alt="Action inside this is Dmat, the distance matrix, then the parameters etasq and rhosq. Then the final term, which needs to be aboe 0, But we don't fit it here because we don't have multipole observations per island." width="80%" />
<p class="caption">Action inside this is Dmat, the distance matrix, then the parameters etasq and rhosq. Then the final term, which needs to be aboe 0, But we don't fit it here because we don't have multipole observations per island.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L19/19.png" alt="What happens? This is wholly uninterpretable. Tide prediction enginge agian. So we want to plot thigns. PUsh the posterior back trhough is and get retrodictions. `k` values are exponentitated. Any island with a 0 is exactly as the model expected. If negative, drageged down by some negibouir. If higher, dragged up by some neighbour beyond the expectation of the model. `zetasq` and `rhosq` are uniterpretable for a reason to be explained." width="80%" />
<p class="caption">What happens? This is wholly uninterpretable. Tide prediction enginge agian. So we want to plot thigns. PUsh the posterior back trhough is and get retrodictions. `k` values are exponentitated. Any island with a 0 is exactly as the model expected. If negative, drageged down by some negibouir. If higher, dragged up by some neighbour beyond the expectation of the model. `zetasq` and `rhosq` are uniterpretable for a reason to be explained.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L19/20.png" alt="On the left we're repeating the piror. Ont her right, 50 samples form the posterior. Relatively small, but declines more slowly. SO there's some long-distance effects driving the tools around. Can't figure out the shpaes from etasq and rhosq because they're correlated. " width="80%" />
<p class="caption">On the left we're repeating the piror. Ont her right, 50 samples form the posterior. Relatively small, but declines more slowly. SO there's some long-distance effects driving the tools around. Can't figure out the shpaes from etasq and rhosq because they're correlated. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L19/21.png" alt="For example, just plotting them on the left. Samples for the Markov chain. Non-indenpdence. If you make one smaller, the other gets bigger. Negaitve correlation. So can't interpret them indepedently." width="80%" />
<p class="caption">For example, just plotting them on the left. Samples for the Markov chain. Non-indenpdence. If you make one smaller, the other gets bigger. Negaitve correlation. So can't interpret them indepedently.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L19/22.png" alt="We want to understand this model now. We can think of this on the outcome scale by taking the posterior distribution of the covariance matrixes, then compute for each pari of ilsands the posterior mean correlation. How? We know their distance on the horizontal axis, then we cna compute form the posterior mean theyir epxected covariance, then standardise for a correlation. The diagonal is all 1s, then the off diagonals are the expected correlations and tool counts. The bottom row is Hawaii. You've got no correlation because it's really far away. " width="80%" />
<p class="caption">We want to understand this model now. We can think of this on the outcome scale by taking the posterior distribution of the covariance matrixes, then compute for each pari of ilsands the posterior mean correlation. How? We know their distance on the horizontal axis, then we cna compute form the posterior mean theyir epxected covariance, then standardise for a correlation. The diagonal is all 1s, then the off diagonals are the expected correlations and tool counts. The bottom row is Hawaii. You've got no correlation because it's really far away. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L19/23.png" alt="On a map, this is what it looks like. LIke the world's least high-tech map of the pacific ocean. Size of each point is the population size. Line setgments are the correlations. Triad of Santa Cruz, Tikopia and Malekula. Tool counts are more similar, and deviate more because of their popualtions sizes. Tonga correlated with Fiji. " width="80%" />
<p class="caption">On a map, this is what it looks like. LIke the world's least high-tech map of the pacific ocean. Size of each point is the population size. Line setgments are the correlations. Triad of Santa Cruz, Tikopia and Malekula. Tool counts are more similar, and deviate more because of their popualtions sizes. Tonga correlated with Fiji. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L19/24.png" alt="Can also plot this based ont he original hypothesis. Again, ilsand society points are proportional to their poulations. Trend is avergae prediction based on pouplation size. Can see things getting dragged around. Model thinks Fiji was dragged upwards from its population expectation." width="80%" />
<p class="caption">Can also plot this based ont he original hypothesis. Again, ilsand society points are proportional to their poulations. Trend is avergae prediction based on pouplation size. Can see things getting dragged around. Model thinks Fiji was dragged upwards from its population expectation.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L19/25.png" alt="SOmetimes called Bayesian non-parametric regression. Non-parametirc meaning infinte number of functions being considerd. They consider an infinite number of splines taht pass along continuos categories than select among them with regularisatino. Very popular with machine learning. Lots of really diverse applications. There are lots of periodic datasets, like seasonality datasets in ecology or social science, where the covariance function has cosigns in it to measure the periodicity in it. e.g. human births - cool analysis by Gelman et al using Gaussian process regression. Phylogenetic distances are like this as well. All are special cases, with particular stratgeies for building the covariance matrix. Then don't need to make assumpotions about the regression shape, you can do that with regularisation. Finally there's automatic relevance determination - terrible machien learnign term = jestimating the importane of each kind of distance in the covariance between the items." width="80%" />
<p class="caption">SOmetimes called Bayesian non-parametric regression. Non-parametirc meaning infinte number of functions being considerd. They consider an infinite number of splines taht pass along continuos categories than select among them with regularisatino. Very popular with machine learning. Lots of really diverse applications. There are lots of periodic datasets, like seasonality datasets in ecology or social science, where the covariance function has cosigns in it to measure the periodicity in it. e.g. human births - cool analysis by Gelman et al using Gaussian process regression. Phylogenetic distances are like this as well. All are special cases, with particular stratgeies for building the covariance matrix. Then don't need to make assumpotions about the regression shape, you can do that with regularisation. Finally there's automatic relevance determination - terrible machien learnign term = jestimating the importane of each kind of distance in the covariance between the items.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L19/26.png" alt="In evo bio, you worry about how long ago this pair of species diverged. Concerned about shared common history. This introduces a lot of back doors. Like a proxy of shared exposures. e.g. comon genes, kinds of ecologies, etc. YOu may not have measured all of those things. Then time since divergence is a proxy for those common exposures. We're going to use this to see how flexible it is. Lots of way st o smuggle it in. One way is Brownian motion model Simplest but also goofiest evolutionary model because no trait evolves this way. Other processes like the OU, like Brownian but variance constrained. Some attractor that pulls back traits. Any particular phylogency implies a covariance structure.  " width="80%" />
<p class="caption">In evo bio, you worry about how long ago this pair of species diverged. Concerned about shared common history. This introduces a lot of back doors. Like a proxy of shared exposures. e.g. comon genes, kinds of ecologies, etc. YOu may not have measured all of those things. Then time since divergence is a proxy for those common exposures. We're going to use this to see how flexible it is. Lots of way st o smuggle it in. One way is Brownian motion model Simplest but also goofiest evolutionary model because no trait evolves this way. Other processes like the OU, like Brownian but variance constrained. Some attractor that pulls back traits. Any particular phylogency implies a covariance structure.  </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L19/27.png" alt="Let's use this primates dataset. " width="80%" />
<p class="caption">Let's use this primates dataset. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L19/28.png" alt="Apes are the losers of the pirmates. Old World are the winners - recent diversification. Galagos and Lorises adre small and recently diverged. Tarisers tiny andvery differnt from each other. New World are Americas. A lot of them as well. " width="80%" />
<p class="caption">Apes are the losers of the pirmates. Old World are the winners - recent diversification. Galagos and Lorises adre small and recently diverged. Tarisers tiny andvery differnt from each other. New World are Americas. A lot of them as well. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L19/29.png" alt="There we are." width="80%" />
<p class="caption">There we are.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L19/30.png" alt="A large brain makes it possible to live in big groups. There's this back door through body size, which might also causally affect group size, by changing the ecology you're in. " width="80%" />
<p class="caption">A large brain makes it possible to live in big groups. There's this back door through body size, which might also causally affect group size, by changing the ecology you're in. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L19/31.png" alt="Have to trim the tree. You end up with 150. Purely treating phylogeny as some squishy common exposure measure. Definitely not super sicence. Really geocentric." width="80%" />
<p class="caption">Have to trim the tree. You end up with 150. Purely treating phylogeny as some squishy common exposure measure. Definitely not super sicence. Really geocentric.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L19/32.png" alt="To get here, this is an ordinary regression but weirded. All of the outcomes for all species is one outcome, a single big vector of group sizes, a log groupsize as a function of log body size and log brian size. Think of sampling all tips of the tree simultaneously at the smae time. Bold G is all the group sizes. Some vector mu. Then this covariance matrix S. In standard linear regression it las sigma squared along the diagonal and 0 everywhere else. So toconstrust S is by multiplying sigma squared by I. If you mutpily the scalar sigma 2 with this, there's no correaltions, and you're back to a linear regression. Why do this? We'll get back to a linear regression by replacing S. " width="80%" />
<p class="caption">To get here, this is an ordinary regression but weirded. All of the outcomes for all species is one outcome, a single big vector of group sizes, a log groupsize as a function of log body size and log brian size. Think of sampling all tips of the tree simultaneously at the smae time. Bold G is all the group sizes. Some vector mu. Then this covariance matrix S. In standard linear regression it las sigma squared along the diagonal and 0 everywhere else. So toconstrust S is by multiplying sigma squared by I. If you mutpily the scalar sigma 2 with this, there's no correaltions, and you're back to a linear regression. Why do this? We'll get back to a linear regression by replacing S. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L19/33.png" alt="Matrix with number of rows equal to numbe ro fspecies, and number o fcolumsn the same. Covariance matrix. Diagonal is sigma squared. Imat is the identity matrix. Just a linear regression, and we find a strong association between brain size and group size, and a slightly negative relationship with boyd mass. These are only direct effects. Bigger species live in bigger groups. But if you take brain size out, you'll see the coeffcient for body mass is positive. This is the direct effect of body size is negative, but not the total effect." width="80%" />
<p class="caption">Matrix with number of rows equal to numbe ro fspecies, and number o fcolumsn the same. Covariance matrix. Diagonal is sigma squared. Imat is the identity matrix. Just a linear regression, and we find a strong association between brain size and group size, and a slightly negative relationship with boyd mass. These are only direct effects. Bigger species live in bigger groups. But if you take brain size out, you'll see the coeffcient for body mass is positive. This is the direct effect of body size is negative, but not the total effect.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L19/34.png" alt="The inferentail threat is this haunting phylogeny. It gives us a tool, and instrument if you will, to measure these things. To get increased covariance for recently separated species. " width="80%" />
<p class="caption">The inferentail threat is this haunting phylogeny. It gives us a tool, and instrument if you will, to measure these things. To get increased covariance for recently separated species. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L19/35.png" alt="The traits just wander randomly. When this hapnpens, the covariance is expected to decline in a linear function since the time they divergd. We cmopute the impolied covarance matrix then plot htat against phylogenetic distance. How to get phylogenetic distance? Total branch length. No one really likes this model, but it's easy to use. " width="80%" />
<p class="caption">The traits just wander randomly. When this hapnpens, the covariance is expected to decline in a linear function since the time they divergd. We cmopute the impolied covarance matrix then plot htat against phylogenetic distance. How to get phylogenetic distance? Total branch length. No one really likes this model, but it's easy to use. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L19/36.png" alt="So you can get the covariance matrix by inverting the phylogenetic distance matrix. Then once you have that, make it into a correlation matrix so we can fit the residual variance. Then just pass it in = replace the identity matrix with this correlation matrix. That's the Brownian motion model. Run this model. Things change a lot. Brain size is nothing now. Body size is now positive, because all that baackdoor throug brain is knocked out. This says the correlation etween brian size and and group size si that closely related species have similar brains and body sizes. " width="80%" />
<p class="caption">So you can get the covariance matrix by inverting the phylogenetic distance matrix. Then once you have that, make it into a correlation matrix so we can fit the residual variance. Then just pass it in = replace the identity matrix with this correlation matrix. That's the Brownian motion model. Run this model. Things change a lot. Brain size is nothing now. Body size is now positive, because all that baackdoor throug brain is knocked out. This says the correlation etween brian size and and group size si that closely related species have similar brains and body sizes. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L19/37.png" alt="Swap the tip labels for group sizes. At the bottom we have prosimians. Gibbons in the upper left. " width="80%" />
<p class="caption">Swap the tip labels for group sizes. At the bottom we have prosimians. Gibbons in the upper left. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L19/38.png" alt="Let's do the Guassian process version of this. The only way to get linear decline with distance is thorugh no selection. Anything else, you'd get an acceleration of decline with distance. Closely-related species can be very simliar, but after som ephylogenetic sdsistance you don't expect any of thsoe confounds to be shared anynommre. You can fit a bunch of functions that way.   " width="80%" />
<p class="caption">Let's do the Guassian process version of this. The only way to get linear decline with distance is thorugh no selection. Anything else, you'd get an acceleration of decline with distance. Closely-related species can be very simliar, but after som ephylogenetic sdsistance you don't expect any of thsoe confounds to be shared anynommre. You can fit a bunch of functions that way.   </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L19/39.png" alt="We just have to change one line. Change the covariance matrix and make the right hand size the cov-GPL2. Now it's about divergence. We're going to estiamte the covariance in group sizes with genetic distance. Brain size is still basically nothing. Now group size is even stronger before. If there's any relationship with brain size, it's negative. But there are a lot of other confounds. So much other reciprocal causation. Important to see the impact that a measure of confounds cna have. " width="80%" />
<p class="caption">We just have to change one line. Change the covariance matrix and make the right hand size the cov-GPL2. Now it's about divergence. We're going to estiamte the covariance in group sizes with genetic distance. Brain size is still basically nothing. Now group size is even stronger before. If there's any relationship with brain size, it's negative. But there are a lot of other confounds. So much other reciprocal causation. Important to see the impact that a measure of confounds cna have. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L19/40.png" alt="We plot the covariance matrix here. Definitely faster than linear. 1 is the maximum phylogenetic distance. The evidence is for closely related species, there's a lot pf correlation of group size. But it declines very fast as you move away. " width="80%" />
<p class="caption">We plot the covariance matrix here. Definitely faster than linear. 1 is the maximum phylogenetic distance. The evidence is for closely related species, there's a lot pf correlation of group size. But it declines very fast as you move away. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L19/41.png" alt="One of the interesting thing is variables rates in branches. Think about apes. Some have envolved faster (like us). Other pseices are weird too, but other linearages are more conservative. Gorillas are more diverged from one another than bonobos and chimps. Hemiplasy is incomplete lineage sorting. Where no trait fits the tree because species don't splitin an instance. There's this long period where they're not bifrucating. So at different loci you can be more closely related to one species (.ike chimps) and for other loci more closely related to antoher (gorillas). Big thing to try to jreconstruct nodes. Many equilibria as well. How do all of these things trade off? Want to see group size as an emergent outcome of all these different strategies. There's no unique null in evolutionary biology. " width="80%" />
<p class="caption">One of the interesting thing is variables rates in branches. Think about apes. Some have envolved faster (like us). Other pseices are weird too, but other linearages are more conservative. Gorillas are more diverged from one another than bonobos and chimps. Hemiplasy is incomplete lineage sorting. Where no trait fits the tree because species don't splitin an instance. There's this long period where they're not bifrucating. So at different loci you can be more closely related to one species (.ike chimps) and for other loci more closely related to antoher (gorillas). Big thing to try to jreconstruct nodes. Many equilibria as well. How do all of these things trade off? Want to see group size as an emergent outcome of all these different strategies. There's no unique null in evolutionary biology. </p>
</div>

