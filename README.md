#Analysis for Winter et al (in review) The GSI...

## Requirements

To run these analyses you need

* ms (for simulating gene trees, [avaliable here](http://home.uchicago.edu/rhudson1/source/mksamples.html))
* Python
* R
** R libraries 
** genealogicalSorting ([avaliable here](http://www.genealogicalsorting.org/))
** plyr
** stringr
** littler
** (For plots)
** ggplot2
** reshape


## Check evertyhing works / reproduce our results

Run everything from the root directory for the project. These commands will write 2 trees for each combination of paramaters, them run the appropriate analyses. 

```shell
$./scripts/make_samples 2 both
$./scripts/analyse_mig.r
$./scripts/analyse_div.r
```
To reproduce everything from our paper run the analyses on 500 simulated trees for each paramater combination (these scripts don't set a seed, so you won't get
_exactly_ the same results):

```
$./scripts/make_samples 500 both
$./scripts/analyse_mig.r
$./scripts/analyse_div.r
```

## Take it further 

The idea of putting these analyses up on github is to let anyone interested in extending these analyses to different scenarios or different paramater values. The R scripts are written in such a way that the functions can be imported into an interactive R session without setting off the any of the analsyes. The paramter values are set using the ```make_samples.py``` script, which produces commandline agruments for ```ms```. 

All of scripts have some documentation, but feel free to contact me (david.winter@gmail.com) if something is not clear. 


