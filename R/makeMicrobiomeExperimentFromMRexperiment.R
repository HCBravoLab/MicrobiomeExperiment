#' Coerce from \code{\link[metagenomeSeq]{MRexperiment}} to \code{\link[MicrobiomeExperiment]{MicrobiomeExperiment}}
#'
#' @param obj object of type \code{\link[eetagenomeSeq]{MRexperiment}}
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
