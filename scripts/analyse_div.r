#!/usr/bin/Rscript

library(stringr)
library(genealogicalSorting)

gsi_a <- function(tr, imap, nperm=1000){
    grp <- as.factor("A")
    assigns <- imap[tr$tip.label,2]
    gsi_val <- gsi(tr, grp, assigns)
    p_val <- permutationTest(tr, grp, assigns, nperm)
    return(c(gsi=gsi_val, P=p_val))
}


per_tree <- function(tr, imap, nperm=1000){
    dropped_tr <- drop.tip(tr, as.character(21:40))
    res_2 <- gsi_a(dropped_tr, imap=imap)
    res_4 <- gsi_a(tr, imap=imap)
    final <- c(res_2, res_4)
    names(final) <- c("gsi_2", "P_2", "gsi_4", "P_4")
    return(final)
}

is_gsi <- function(fname) {
    str_split(fname, "_")[[1]][1] == "gsi"
}

tfiles <- paste("trees/", Filter(is_gsi, list.files("trees/")), sep="")
div_time <- as.numeric(sapply(tfiles, str_extract,  "\\d\\.\\d+"))
cat(paste("loading data from", length(tfiles), "tree files...\n"))
all_trees <- do.call("c", lapply(tfiles, read.tree))
sp_map <- read.table("sample.imap")
print ("calcuating gsi...\n")
res <- sapply(all_trees, per_tree, sp_map)

#because they'll all be "//"
colnames(res) <- NULL
print("writing data... \n")
df0 <- data.frame(res, t_div <- rep(div_time, each=500))
write.csv(df0, "data/gsi_2v4.csv")


