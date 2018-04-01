#' Coerce phyloseq object
#'
#' @param object
#'
#' @return An object of class MicrobiomeExperiment
#' @export
#' @example
#' if(requireNamespace("phyloseq")){
#'     data(GlobalPatterns)
#'     as(GlobalPatterns, "MicrobiomeExperiment")
#'     makeMicrobiomeExperimentFromphyloseq(GlobalPatterns)
#' }
makeMicrobiomeExperimentFromphyloseq <- function(object) {
    tree <- MicrobiomeFeatures(taxa = phyloseq::tax_table(object)@.Data,
                               tree = phyloseq::phy_tree(object))
    if (!is.null(object@refseq)) {
        tree@refDbSeq <- object@refseq
    }
    MicrobiomeExperiment(
        assays = SimpleList(counts = phyloseq::otu_table(object)@.Data),
        colData = data.frame(phyloseq::sample_data(object)),
        rowData = tree
    )
}

setAs("phyloseq", "MicrobiomeExperiment", function(from)
{
    makeMicrobiomeExperimentFromphyloseq(from)
})
