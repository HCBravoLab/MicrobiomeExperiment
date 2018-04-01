#' Alias for mgFeatures class from metagenomeFeatures package
#'
#' @importClassesFrom metagenomeFeatures mgFeatures
#'
.MicrobiomeFeatures <- setClass("MicrobiomeFeatures",
    contains = "mgFeatures")

MicrobiomeFeatures <- function() {
    .MicrobiomeFeatures()
}

MicrobiomeFeatures <- function(taxa, tree=NULL, seq=NULL, metadata=list()) {
    metagenomeFeatures::mgFeatures(taxa, tree, seq, metadata)
}
