#' Coercion methods
#'
#' Coerce from \code{\link[MetagenomeSeq]{MRexperiment}}
#'
#' @param obj obj of \code{\link[MetagenomeSeq]{MRexperiment}}
#'
#' @export
#' @examples
#' if(requireNameSpace("metagenomeSeq")) {
#'   data("mouseData")
#'   as(mouseData, "MicrobiomeExperiment")
#' }
makeMicrobiomeExperimentFromMRexperiment <- function(obj) {
    counts <- MRcounts(obj)
    sample_data <- pData(obj)
    feature_data <- fData(obj)

    MicrobiomeExperiment(assays=list(counts=counts), colData=sample_data,
                         rowData=MicrobiomeFeatures(taxa=feature_data))
}

setAs(from="MRexperiment", to="MicrobiomeExperiment", function(from) {
    makeMicrobiomeExperimentFromMRexperiment(from)
})
