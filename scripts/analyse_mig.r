#!/usr/bin/Rscript

library(stringr)
library(genealogicalSorting)

permute_gsi <- function(observed_value, tr, assignments, nperm=1000){
    one_rep <- function(){
       #Namespaces in R mean we aren't overwritng here
      tr$tip.label <- sample(tr$tip.label)
      return(mean(gsi(tr, 0, assignments)$gsi))
    }
    distr <- replicate(nperm, one_rep())
    return(mean(distr > observed_value))
}

pwgsi <- function(tr, imap, nperm=1000){
    assigns <- imap[tr$tip.label,2]
    pw_gsi <- mean(gsi(tr, 0, assigns)$gsi)
    p_val <- permute_gsi(pw_gsi, tr, assigns,nperm)
    return(c(pwgsi=pw_gsi, P=p_val))
}


per_tree <- function(tr, imap, nperm=1000){
    dropped_tr <- drop.tip(tr, as.character(1:10))
    res <- gsi_a(dropped_tr, imap=imap)
    return(final)
}

is_mig <- function(fname) {
    str_split(fname, "_")[[1]][1] == "migration"
}

tfiles <- paste("trees/", Filter(is_mig, list.files("trees/")), sep="")
m_rate <- as.numeric(sapply(tfiles, str_extract,  "\\d+(\\.\\d{1,2})?"))
                     

cat(paste("loading data from", length(tfiles), "tree files...\n"))
all_trees <- do.call("c", lapply(tfiles, read.tree))
sp_map <- read.table("sample.imap")
cat("calcuating gsi...\n")
res <- sapply(all_trees, per_tree, sp_map)

#because they'll all be "//"
colnames(res) <- NULL
print("writing data... \n")
df0 <- data.frame(res,  m = rep(m_rate_time, each=500))
write.csv(df0, "data/gsi_migration.csv")


