#' Coerce phyloseq object
#'
#' @param object
#'
#' @return An object of class MicrobiomeExperiment
#' @export
#' @examples
#' if (requireNamespace("phyloseq")) {
#'     data(GlobalPatterns, package="phyloseq")
#'     as(GlobalPatterns, "MicrobiomeExperiment")
#'     data(enterotype, package="phyloseq")
#'     as(enterotype, "MicrobiomeExperiment")
#'     data(esophagus, package="phyloseq")
#'     as(esophagus, "MicrobiomeExperiment")
#' }
makeMicrobiomeExperimentFromphyloseq <- function(object) {
    otu <- object@otu_table@.Data
    taxa <- object@tax_table@.Data
    if(is.null(taxa)){
        taxa <- matrix(nrow=nrow(otu), ncol=0)
        rownames(taxa) <- rownames(otu)
    }
    if(!is.null(object@phy_tree)){
        tree <- object@phy_tree
    }else{
        tree <- NULL
    }
    mf <- MicrobiomeFeatures(taxa=taxa, tree=tree)
    if (!is.null(object@refseq)) {
        mf@refDbSeq <- object@refseq
    }
output <- MicrobiomeExperiment(
        assays = SimpleList(counts = object@otu_table@.Data),
        rowData = mf
    )
    if(!is.null(object@sam_data)){
        colData(output) <- DataFrame(data.frame(object@sam_data))
    }
    return(output)
}

setAs("phyloseq", "MicrobiomeExperiment", function(from)
{
    makeMicrobiomeExperimentFromphyloseq(from)
})
