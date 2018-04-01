#' Coerce phyloseq object
#'
#' @param object
#'
#' @return An object of class MicrobiomeExperiment
#' @export
#' @examples
#' if (requireNamespace("phyloseq")) {
#'     data(GlobalPatterns)
#'     as(GlobalPatterns, "MicrobiomeExperiment")
#'     data(enterotype)
#'     as(enterotype, "MicrobiomeExperiment")
#' }
makeMicrobiomeExperimentFromphyloseq <- function(object) {
    mf <- MicrobiomeFeatures(taxa = object@tax_table@.Data)
    if(!is.null(object@phy_tree)){
        mf@refDbTree <- object@phy_tree
    }
    if (!is.null(object@refseq)) {
        mf@refDbSeq <- object@refseq
    }
    MicrobiomeExperiment(
        assays = SimpleList(counts = object@otu_table@.Data),
        colData = data.frame(object@sam_data),
        rowData = mf
    )
}

setAs("phyloseq", "MicrobiomeExperiment", function(from)
{
    makeMicrobiomeExperimentFromphyloseq(from)
})
