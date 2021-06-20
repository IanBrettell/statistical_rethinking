---
title: "Notes for Statistical Rethinking 2nd ed. by Richard McElreath"
date: '2021-06-20'
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
---

# Conditional Manatees


```r
library(here)
source(here::here("code/scripts/source.R"))
```


```r
slides_dir = here::here("docs/slides/L09")
```

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L09/01.png" width="80%" />

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L09/02.png" alt="There are things int he universe that really are dichotomous -- they either happen or they don't. Tests for them work really nicely. How many animals do you see? Tests for most congenital forms of colour-blindness. Most of what we do in statistics is unfortuantely like this. Most outcomes are continuous. " width="80%" />
<p class="caption">There are things int he universe that really are dichotomous -- they either happen or they don't. Tests for them work really nicely. How many animals do you see? Tests for most congenital forms of colour-blindness. Most of what we do in statistics is unfortuantely like this. Most outcomes are continuous. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L09/03.png" alt="This is why there are no tests in this course. When you do that you're making a decision way too early. Stop testing and start thinking. There are a bunch of off-the-shelf tools that have value. But eventually in your research you have to do better than off-the-shelf. You need to make it bespoke. We want besoke models and risk analyses. Your analysis needs to be bespoke to the problem at hand. It's ethically irresponsible to do anything else." width="80%" />
<p class="caption">This is why there are no tests in this course. When you do that you're making a decision way too early. Stop testing and start thinking. There are a bunch of off-the-shelf tools that have value. But eventually in your research you have to do better than off-the-shelf. You need to make it bespoke. We want besoke models and risk analyses. Your analysis needs to be bespoke to the problem at hand. It's ethically irresponsible to do anything else.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L09/04.png" alt="Here's an example. NY is getting pummelled wih blizzards right now. In Jan '15, there was a prediction of a catastrophic blizzard. The city was shut down. But the blizzard didn't come and everyone was mad. But it was the right thing to do." width="80%" />
<p class="caption">Here's an example. NY is getting pummelled wih blizzards right now. In Jan '15, there was a prediction of a catastrophic blizzard. The city was shut down. But the blizzard didn't come and everyone was mad. But it was the right thing to do.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L09/05.png" alt="Why did they shut it down? They relied on a forecast. Their forecast was way more extreme. What do you do if you're a responsible public servant? " width="80%" />
<p class="caption">Why did they shut it down? They relied on a forecast. Their forecast was way more extreme. What do you do if you're a responsible public servant? </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L09/06.png" alt="Accuracy always matters, but it's not the only thing that matters. When you make a decision, you have to take into account the costs and benefits of each course of action. Even though it was a tail probability that it could have been that bad, if it was, it would have been catastrophic. You may need to plan for the extreme events in case many people die." width="80%" />
<p class="caption">Accuracy always matters, but it's not the only thing that matters. When you make a decision, you have to take into account the costs and benefits of each course of action. Even though it was a tail probability that it could have been that bad, if it was, it would have been catastrophic. You may need to plan for the extreme events in case many people die.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L09/07.png" alt="This is a manatee. Related to an elephant. Gentle vegetarian mermaid. The only natural predator it has is the speedboat. This is quite common to manatees in Florida, where a lot of people own speedboats. Probably more manatees than not have these sorts of scars. Florida has gone to a lot of effort to avoid this. Now you can put a cage around the blades. It turns out that hasn't helped at all, for an interesting reason statistically. Rotors mainly don't kill manatees -- the keel does. You see manatees with rotor scars is because it doesn't kill them. Then you don't show up in the sample." width="80%" />
<p class="caption">This is a manatee. Related to an elephant. Gentle vegetarian mermaid. The only natural predator it has is the speedboat. This is quite common to manatees in Florida, where a lot of people own speedboats. Probably more manatees than not have these sorts of scars. Florida has gone to a lot of effort to avoid this. Now you can put a cage around the blades. It turns out that hasn't helped at all, for an interesting reason statistically. Rotors mainly don't kill manatees -- the keel does. You see manatees with rotor scars is because it doesn't kill them. Then you don't show up in the sample.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L09/08.png" alt="Same information structure with WWII bombers. They're a workhorse bomber." width="80%" />
<p class="caption">Same information structure with WWII bombers. They're a workhorse bomber.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L09/09.png" alt=" As the war dragged on, metal came in short supply. They wanted to up-armour the bombers. The RAF asked the statistician to look at the damage pattern and figure out where to put the armour. You need to armour selectively to avoid weighing the whole thing down. So what's the most crucial place? The intuition was to put the armour where the damage was. Wald went for the opposite, because he didn't condition on this collider. None of the planes that made it back had holes in the cockpit or engine. So he recommended up-armouring the parts with the least damage." width="80%" />
<p class="caption"> As the war dragged on, metal came in short supply. They wanted to up-armour the bombers. The RAF asked the statistician to look at the damage pattern and figure out where to put the armour. You need to armour selectively to avoid weighing the whole thing down. So what's the most crucial place? The intuition was to put the armour where the damage was. Wald went for the opposite, because he didn't condition on this collider. None of the planes that made it back had holes in the cockpit or engine. So he recommended up-armouring the parts with the least damage.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L09/10.png" alt="The variable we've conditioned on is survival. Selection bias. It opens the path... the rotor damage confounds survival. This is very common when there are multiple things that can affect these outcomes." width="80%" />
<p class="caption">The variable we've conditioned on is survival. Selection bias. It opens the path... the rotor damage confounds survival. This is very common when there are multiple things that can affect these outcomes.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L09/11.png" alt="We need to grow up our models. Everything we do is about conditioning. Everything is conditional. Today we'll work on how the influence of some variable is conditional on other variables. We'll build it in because nature is additive." width="80%" />
<p class="caption">We need to grow up our models. Everything we do is about conditioning. Everything is conditional. Today we'll work on how the influence of some variable is conditional on other variables. We'll build it in because nature is additive.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L09/12.png" alt="Here are some natural examples. In GLMs there necessarily are interactions." width="80%" />
<p class="caption">Here are some natural examples. In GLMs there necessarily are interactions.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L09/13.png" alt="DAGs are totally heuristic. They're not enough to make accurate predictions; they're tools to help you understand confound risk, and figure out a deconfounding strategy if one exists. " width="80%" />
<p class="caption">DAGs are totally heuristic. They're not enough to make accurate predictions; they're tools to help you understand confound risk, and figure out a deconfounding strategy if one exists. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L09/14.png" alt="On the left is a hypothetical and completely ridiculous example. Like what we've looked at so far, where there are independent additive terms. If there's sugar in there, they interact. On the right is a fanciful representation that captures that relationship." width="80%" />
<p class="caption">On the left is a hypothetical and completely ridiculous example. Like what we've looked at so far, where there are independent additive terms. If there's sugar in there, they interact. On the right is a fanciful representation that captures that relationship.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L09/15.png" alt="Economics of Africa. Africa is really really big. A lot of diversity - economies, language, environment - makes it interesting because it creates a lot of natural experiments." width="80%" />
<p class="caption">Economics of Africa. Africa is really really big. A lot of diversity - economies, language, environment - makes it interesting because it creates a lot of natural experiments.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L09/16.png" alt="There's a feature of the terrain which is ruggedness, which is bad becasuse it makes it hard to move things. On the right is normalised. 0 is perfectly flat, 1 is Lesotho, the world's most rugged place. Kind of like Switzerland. Really strong negative relationship with GDP. But in Africa, the relationship goes in the other direction. Removing outliers doesn't remove the difference between the continents. So what's going on?" width="80%" />
<p class="caption">There's a feature of the terrain which is ruggedness, which is bad becasuse it makes it hard to move things. On the right is normalised. 0 is perfectly flat, 1 is Lesotho, the world's most rugged place. Kind of like Switzerland. Really strong negative relationship with GDP. But in Africa, the relationship goes in the other direction. Removing outliers doesn't remove the difference between the continents. So what's going on?</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L09/17.png" alt="We want to develop priors that constrain pre-data the outcomes to the possible outcome space. We've scaled the outcome between 0 and 1. Then I've taken log GDP, and scaled it in proportion to the average. 1.5 is 50% more. Think about doubling the economy - that would be a huge effect. The dashed lines are the world's GDPs. We've centered at 1 for the average GDP. We simulate priors and we get chaos. At least on the right you can stay within the world's possible economies." width="80%" />
<p class="caption">We want to develop priors that constrain pre-data the outcomes to the possible outcome space. We've scaled the outcome between 0 and 1. Then I've taken log GDP, and scaled it in proportion to the average. 1.5 is 50% more. Think about doubling the economy - that would be a huge effect. The dashed lines are the world's GDPs. We've centered at 1 for the average GDP. We simulate priors and we get chaos. At least on the right you can stay within the world's possible economies.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L09/18.png" alt="These two plots come from splitting the data. This is cheating, because now you have no statistical criterion on which to evaluate the split. Need to estimate both of the lines in the same model. DOn't split it yourself - let the model split it and tell you how compelling it is." width="80%" />
<p class="caption">These two plots come from splitting the data. This is cheating, because now you have no statistical criterion on which to evaluate the split. Need to estimate both of the lines in the same model. DOn't split it yourself - let the model split it and tell you how compelling it is.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L09/19.png" alt="Using an index variable that is continent ID. 1 means Africa, 2 means not Africa. Can do it for each continent. Different $\alpha$ for each continent. Now you can assign the same prior to all of the continents. We run the model and get the graphs on the right. The intercepts now have changed, and African countries are depressed relative to non-African countries." width="80%" />
<p class="caption">Using an index variable that is continent ID. 1 means Africa, 2 means not Africa. Can do it for each continent. Different $\alpha$ for each continent. Now you can assign the same prior to all of the continents. We run the model and get the graphs on the right. The intercepts now have changed, and African countries are depressed relative to non-African countries.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L09/20.png" alt="Just add the index variable to the slope. Now we have a separete slope for ecah continent. Centered the GDP so that the intercept makes sense. " width="80%" />
<p class="caption">Just add the index variable to the slope. Now we have a separete slope for ecah continent. Centered the GDP so that the intercept makes sense. </p>
</div>

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L09/21.png" width="80%" />

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L09/22.png" alt="Here are the marginal posterior distributions. Index of 1 means Africa, 2 means not Africa. Average GDP is lower. At the mean ruggedness, in the world, an African country has 90% of the average GDP in the sample. How does GDP change? It's postivie for AFrican countries `b[1]`, and `b[2]` is negative. Basically the same magnitude." width="80%" />
<p class="caption">Here are the marginal posterior distributions. Index of 1 means Africa, 2 means not Africa. Average GDP is lower. At the mean ruggedness, in the world, an African country has 90% of the average GDP in the sample. How does GDP change? It's postivie for AFrican countries `b[1]`, and `b[2]` is negative. Basically the same magnitude.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L09/23.png" alt="Now they're from the same model. Looks the same. The slope on the left is less certain. Compatibility bowtie is bigger because there are fewer African countries. " width="80%" />
<p class="caption">Now they're from the same model. Looks the same. The slope on the left is less certain. Compatibility bowtie is bigger because there are fewer African countries. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L09/24.png" alt="Here we're just looking at two categories, but it can get confusing quickly, especially if you don't center the variables. Need to plot to understand. **Whenever you have an interaction, the impact of a change in one predictor depends on more that one parameter.** So you can't look at a single row and guess what the effect is of changing things. You need them all. This is why plotting is so essential." width="80%" />
<p class="caption">Here we're just looking at two categories, but it can get confusing quickly, especially if you don't center the variables. Need to plot to understand. **Whenever you have an interaction, the impact of a change in one predictor depends on more that one parameter.** So you can't look at a single row and guess what the effect is of changing things. You need them all. This is why plotting is so essential.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L09/25.png" alt="There's a causal symmetry to them. You can't tell the difference. Only way is to use your scientific knowledge. You're bringing in your extra knowledge with the first interpretation. In the statstical model, the second is the same, but it doesn't make sense because a country can't switch continents." width="80%" />
<p class="caption">There's a causal symmetry to them. You can't tell the difference. Only way is to use your scientific knowledge. You're bringing in your extra knowledge with the first interpretation. In the statstical model, the second is the same, but it doesn't make sense because a country can't switch continents.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L09/26.png" alt="Now this is trying to predict the effect of moving a country to a different continent. y-axis is expected improvement if we move the nation to Africa. At low ruggedness you expect it to hurt the economy, but at high ruggedness you expect it to help it. We can see that this interpretation is causally ridiculous. But the model doesn't see them as different things. The reason this is confusing is because there is causal information in your head. You want to interpret the variables in certain ways." width="80%" />
<p class="caption">Now this is trying to predict the effect of moving a country to a different continent. y-axis is expected improvement if we move the nation to Africa. At low ruggedness you expect it to hurt the economy, but at high ruggedness you expect it to help it. We can see that this interpretation is causally ridiculous. But the model doesn't see them as different things. The reason this is confusing is because there is causal information in your head. You want to interpret the variables in certain ways.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L09/27.png" alt="Now here both predictors are continuous. Basically works the same way, but much harder to think about. Experimental example but works the same in observationals. 3 variables of interest plus the experimental block which you want to control for. We're going to leave out `block` and add that in later. Three levels of water and shade, with the outcome bloom area. " width="80%" />
<p class="caption">Now here both predictors are continuous. Basically works the same way, but much harder to think about. Experimental example but works the same in observationals. 3 variables of interest plus the experimental block which you want to control for. We're going to leave out `block` and add that in later. Three levels of water and shade, with the outcome bloom area. </p>
</div>
<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L09/28.png" alt="They're categorical, but in principle they're continuous. This is the conventional form of the interaction. When you add an interaction of continous variables, you multiply the predictors and add a third coefficient. First is to understand why this happens. " width="80%" />
<p class="caption">They're categorical, but in principle they're continuous. This is the conventional form of the interaction. When you add an interaction of continous variables, you multiply the predictors and add a third coefficient. First is to understand why this happens. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L09/29.png" alt="Here is the conventional form on top. " width="80%" />
<p class="caption">Here is the conventional form on top. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L09/30.png" alt="It means we replace one of these slopes with another linear model. Now $W$ will be the centered version, as with $S$ for shade. We've replaced the $\beta$ coefficient in front of water level with $\gamma$, and $\gamma$ isn't a parameter but a linear model. Another one. We can have as many as we want. And this linear model now tells us the slope. And the slope has two parameters in it. One is the ordinary slope, $\beta_W$, and the other $\beta_{WS}$, is the interaction. That parameter measures the marginal effect of changing shade on the impact of water. So we're directly assuming that the effect of water depends on shade. And we make the submodel, which is linear because we're still in geocentric world. " width="80%" />
<p class="caption">It means we replace one of these slopes with another linear model. Now $W$ will be the centered version, as with $S$ for shade. We've replaced the $\beta$ coefficient in front of water level with $\gamma$, and $\gamma$ isn't a parameter but a linear model. Another one. We can have as many as we want. And this linear model now tells us the slope. And the slope has two parameters in it. One is the ordinary slope, $\beta_W$, and the other $\beta_{WS}$, is the interaction. That parameter measures the marginal effect of changing shade on the impact of water. So we're directly assuming that the effect of water depends on shade. And we make the submodel, which is linear because we're still in geocentric world. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L09/31.png" alt="It doesnt' matter which one you pick, you get the same equation. Basically, this is where it comes from - assuming I want the association of each with the outcome to be dependent on the other's value, so let's make a linear model of that. Liek a regression within a regression. " width="80%" />
<p class="caption">It doesnt' matter which one you pick, you get the same equation. Basically, this is where it comes from - assuming I want the association of each with the outcome to be dependent on the other's value, so let's make a linear model of that. Liek a regression within a regression. </p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L09/32.png" alt="Let's fit this. Contrasting one with and without an interaction. Main effect of water, main effect of shade. With priors. But we've already got the problem of how to visualise this." width="80%" />
<p class="caption">Let's fit this. Contrasting one with and without an interaction. Main effect of water, main effect of shade. With priors. But we've already got the problem of how to visualise this.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L09/33.png" alt="Related frames that tell a bigger story. Going to have graphs in triptych form. Nothing binding you to only three, but that's the minimum. You can do 20 if you think that's necessary." width="80%" />
<p class="caption">Related frames that tell a bigger story. Going to have graphs in triptych form. Nothing binding you to only three, but that's the minimum. You can do 20 if you think that's necessary.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L09/34.png" alt="Here's the triptych for the prior predictions Just showing you that the outcomes are staying within the legal range. Don't want to predict negative outcomes. I'd make them even tighter. The black lines come from the same sample from the prior distribution. The slope is always the same, because there's no interaction." width="80%" />
<p class="caption">Here's the triptych for the prior predictions Just showing you that the outcomes are staying within the legal range. Don't want to predict negative outcomes. I'd make them even tighter. The black lines come from the same sample from the prior distribution. The slope is always the same, because there's no interaction.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L09/35.png" alt="The posterior predictions are plotted as these lines. Same arrangement as the tritpych. Notice that we're missing the data in each case here. Why? Because the slope is the same in each graph. It's doing a pretty bad job a prediction. Water has no effect if you have no light, and vice versa. There's necessarily an interaction." width="80%" />
<p class="caption">The posterior predictions are plotted as these lines. Same arrangement as the tritpych. Notice that we're missing the data in each case here. Why? Because the slope is the same in each graph. It's doing a pretty bad job a prediction. Water has no effect if you have no light, and vice versa. There's necessarily an interaction.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L09/36.png" alt="Now we've added the interaction term. You can't look at just `bws` because it depends on other parameters now, so you have to push things out through the predictions. Need to look at its behaviour." width="80%" />
<p class="caption">Now we've added the interaction term. You can't look at just `bws` because it depends on other parameters now, so you have to push things out through the predictions. Need to look at its behaviour.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L09/37.png" alt="Now the slope changes across shade levels. Allows interactions." width="80%" />
<p class="caption">Now the slope changes across shade levels. Allows interactions.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L09/38.png" alt="On the left, shade is low, meaning there's a lot of light. Which means a big effect for water, because as you add water, you get a lot of growth. On the right the plant can't do much because it doesn't get much light." width="80%" />
<p class="caption">On the left, shade is low, meaning there's a lot of light. Which means a big effect for water, because as you add water, you get a lot of growth. On the right the plant can't do much because it doesn't get much light.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L09/39.png" alt="In this data, we've cut all backdoors between shade and water because it's an experiment. This isn't the real knowledge we want to know how real plants grow. What's the difference? Shade influences water level because it reduces evaporation. So shady flowers can grow better because they retain more moisture. That's the backdoor path. Need to think about this when you're considering intervening. You can't just cut down the trees to give the flowers more light and let them dehydrate. Need to think carefully about these things." width="80%" />
<p class="caption">In this data, we've cut all backdoors between shade and water because it's an experiment. This isn't the real knowledge we want to know how real plants grow. What's the difference? Shade influences water level because it reduces evaporation. So shady flowers can grow better because they retain more moisture. That's the backdoor path. Need to think about this when you're considering intervening. You can't just cut down the trees to give the flowers more light and let them dehydrate. Need to think carefully about these things.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L09/40.png" alt="You can find the function, but you'd expect a non-linear effect." width="80%" />
<p class="caption">You can find the function, but you'd expect a non-linear effect.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L09/41.png" alt="There may be good scientific reasons to go beyond to further interactions. Slope times each predictor, then three two-way interactions, because they're all possible. Then there's a 3-way where the extent to which the first depends on the second depends on the third." width="80%" />
<p class="caption">There may be good scientific reasons to go beyond to further interactions. Slope times each predictor, then three two-way interactions, because they're all possible. Then there's a 3-way where the extent to which the first depends on the second depends on the third.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L09/42.png" alt="These things are really hard to understand. Tend to be small effects." width="80%" />
<p class="caption">These things are really hard to understand. Tend to be small effects.</p>
</div>

<div class="figure">
<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L09/43.png" alt="Some will know about a famous wine judgment. New Jersey now grows a lot of good wine. In 2012 they arrranged a similar judgment and did very well. French judges can't tell the difference between good French and New Jersey wines. The outcome variable is the score. All these predictors can interact with each other." width="80%" />
<p class="caption">Some will know about a famous wine judgment. New Jersey now grows a lot of good wine. In 2012 they arrranged a similar judgment and did very well. French judges can't tell the difference between good French and New Jersey wines. The outcome variable is the score. All these predictors can interact with each other.</p>
</div>

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L09/44.png" width="80%" />

<img src="/Users/brettell/Documents/Repositories/statistical_rethinking/docs/slides/L09/45.png" width="80%" />

