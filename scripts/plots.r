#!/usr/bin/Rscript

##
# Plot the data with ggplot. 
#
# For each plot their are two facets - the average of the _gsi_ being 
# being summarised for each data and proportion of the runs for each
# paramater that have a significant (P < 0.05) result. There is probably
# some clever way to do this in one go with `viewports` and the like. 
# I'm not clever enough, so just made two plots for each and pasted them
# together in Inkscape...
#
##

library(reshape)
library(ggplot2)


stat_sum_single <- function(fun=mean, geom="point", ...) {
       stat_summary(fun=fun, colour="black", geom=geom)
}

plot_div <- function(){
    gsi_sims <- read.csv("data/gsi_2v4.csv")
    molten_sims <- melt(gsi_sims, id.var=c("comp", "t_div"))

    p <- ggplot(molten_sims, aes(t_div, value, colour=factor(comp)))
    
    svg("figures/divergence_pval.svg", width=8.5, height=4)
    print(p + stat_sum_single(fun=function(x) mean(x < 0.05)) + 
        facet_grid(variable~.))
    dev.off()

    svg("figures/divergence_gsi.svg", width=8.5, height=4)
    print(
        p +  stat_summary() + facet_grid(variable~.)
    )
    dev.off()
}

if(!interactive()){
    plot_div()
#    plot_mig()
}
