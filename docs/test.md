---
title: "Notes for Statistical Rethinking 2nd ed. by Richard McElreath"
date: '2021-05-12'
output:
  bookdown::tufte_html_book:
    toc: yes
    css: toc.css
    pandoc_args: --lua-filter=color-text.lua
    highlight: pygments
    link-citations: yes
---

# Preface {-}

Consolidated slides, notes, homework, code and output from the *Statistical Rethinking* book and course by Richard McElreath.

Repo with slides and homework here: <https://github.com/rmcelreath/stat_rethinking_2020>

Buy the book here: <https://xcelab.net/rm/statistical-rethinking/>

McElreath's GitHub here: <https://github.com/rmcelreath>

Slides downloaded manually via links on GitHub page and split into separate directories.

## Install packages


```r
renv::init()
devtools::install_github("stan-dev/cmdstanr")
cmdstanr::install_cmdstan()
install.packages(c("coda","mvtnorm","devtools","loo","dagitty"))
devtools::install_github("rmcelreath/rethinking")

set_ulam_cmdstan(TRUE)
```

## Split and convert slides


```r
n_lectures = 20

lectures = 1:n_lectures
dir_name = ifelse(lectures < 10,
                  paste("0", lectures, sep = ""),
                  as.character(lectures))

lapply(dir_name, function(LECTURE){
  
  slides_dir = here::here("docs/slides", paste("L", LECTURE, sep = ""))

  slides = magick::image_read_pdf(file.path(slides_dir, paste("L", LECTURE, ".pdf", sep = "")))
  
  slides_list = as.list(slides)
  
  lapply(seq_along(slides_list), function(i){
    out = image_convert(slides_list[[i]], format = "png")
    # set name
    out_name = ifelse(i < 10,
                      paste("0", i, sep = ""),
                      as.character(i))
    magick::image_write(out, path = file.path(slides_dir, paste(out_name, ".png", sep = "")))
  })

})
```

## Create markdown code to incorporate slides


```r
slides_dir = here::here("docs/slides/L07")
slides = list.files(slides_dir) %>% str_remove(".png") %>% .[!grepl(".pdf", .)]

lapply(slides, function(x){
   out = paste("```{r, echo = F, out.width='60%'}\nknitr::include_graphics(file.path(slides_dir, '", x, ".png'))\n```\n\n\n", sep = "")
   write(out, "tmp.txt", append = T)
})

# Delete tmp file
file.remove("tmp.txt")
```

