## Add methods:
#counts accessor (MEcounts)
#taxTable accessor

#' Counts accessor for MicrobiomeExperiment class
#'
#' ~description~
#'
#' @name MEcounts
#' @param x an object of class MicrobiomeExperiment
#'
setMethod("counts", "MicrobiomeExperiment", function(object, ...){
    countMat <- assays(object)[["counts"]]
    return(countMat)
} )
# MEcounts <- function(x){
#     countMat <- x@assays[["counts"]]
#     return(countMat)
# }
