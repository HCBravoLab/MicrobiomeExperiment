#' load biom file into a \code{\link[MicrobiomeExperiment]{MicrobiomeExperiment}}
#'
#' @param file biom file location
#'
#' @importMethodsFrom biomformat read_biom
#' @return An object of class \code{\link[MicrobiomeExperiment]{MicrobiomeExperiment}}
#'
#' @export
#' @examples
#' if(requireNameSpace("biomformat")) {
#'   rich_dense_file  = system.file("extdata", "rich_dense_otu_table.biom", package = "biomformat")
#'   loadFromBiom(rich_dense_file)
#' }
loadFromBiom <- function(file) {
    biom <- read_biom(file)
    as(biom, "MicrobiomeExperiment")
}

#' coerce \code{\link[biomformat]{biom}} into a \code{\link[MicrobiomeExperiment]{MicrobiomeExperiment}}
#'
#' @param obj object of type \code{\link[biomformat]{biom}}
#'
#' @import biomformat
#' @return An object of class \code{\link[MicrobiomeExperiment]{MicrobiomeExperiment}}
#'
#' @export
#' @examples
#' if(requireNameSpace("biomformat")) {
#'   rich_dense_file  = system.file("extdata", "rich_dense_otu_table.biom", package = "biomformat")
#'   x1 <- read_biom(rich_dense_file)
#'   as(x1, "MicrobiomeExperiment")
#' }
makeMicrobiomeExperimentFromBiom <- function(obj) {
    counts <- as(biom_data(obj), "matrix")
    sample_data <- sample_metadata(obj)
    feature_data <- observation_metadata(obj)

    MicrobiomeExperiment(assays=list(counts=counts), colData=sample_data,
                         rowData=MicrobiomeFeatures(taxa=feature_data))
}


setAs(from="biom", to="MicrobiomeExperiment", function(from) {
    makeMicrobiomeExperimentFromBiom(from)
})
