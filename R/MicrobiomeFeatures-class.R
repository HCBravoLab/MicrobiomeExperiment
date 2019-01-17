## Class constructor
setOldClass("phylo")
setClassUnion("phyloOrNULL", c("phylo", "NULL"))
setClassUnion("DNAStringSetOrNULL", c("DNAStringSet", "NULL"))

.MicrobiomeFeatures <- setClass("MicrobiomeFeatures",
    contains = c("TreeIndex"),
    slots = list(phyloTree = "phyloOrNULL",
                 seq = "DNAStringSetOrNULL",
                 metadata = "list"
    )
)

#' Alias for mgFeatures class from metagenomeFeatures package
#'
#' @importClassesFrom metagenomeFeatures mgFeatures
#'
#' @aliases MicrobiomeFeatures-class
#' @import TreeSummarizedExperiment
#' @import Biostrings
#' @import ape
#' @export
MicrobiomeFeatures <- function(taxa = DataFrame(), phyloTree=NULL,
    seq=NULL, metadata=list()) {
    mgF <- TreeSummarizedExperiment::TreeIndex(taxa)
    .MicrobiomeFeatures(mgF, phyloTree = phyloTree, seq = seq, metadata = metadata)
}

setAs("DataFrame", "MicrobiomeFeatures", function(from) {
    ## TO-DO: add coercion method for DataFrame to MicrobiomeFeatures
    as.data.frame(from)
})
