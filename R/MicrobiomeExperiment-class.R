#' MicrobiomeExperiment-class
#'
#' SummarizedExperiment-like class for microbiome data. rowData is a
#' MicrobiomeFeatures object LINK so it includes: a taxonomy table (DataFrame),
#' optional phylogentic tree (phylo object), and a sequence database.
#'
#' It supports (most) of the interface to phyloseq objects
#'
#' @include MicrobiomeFeatures-class.R
#' @importClassesFrom metagenomeFeatures mgFeatures
#' @importClassesFrom SummarizedExperiment SummarizedExperiment
#'
#' @examples
#'
#' library(metagenomeFeatures)
#' data(mock_mgF)
#'
#' sampleNames <- letters[1:4]
#' pd <- DataFrame(a=letters[1:4], b=1:4)
#' numcounts <- nrow(mock_mgF) * 4
#' counts <- matrix(sample(1:1000,numcounts,replace=TRUE), nr=nrow(mock_mgF), nc=4)
#'
#' MicrobiomeExperiment(assays=SimpleList(counts=counts),
#' rowData=mock_mgF,
#' colData=pd
#' )
#'
.MicrobiomeExperiment <- setClass("MicrobiomeExperiment",
    contains="SummarizedExperiment",
    representation(
        rowData="MicrobiomeFeatures"
    )
)

MicrobiomeExperiment <- function(assays = SimpleList(),
    rowData = MicrobiomeFeatures(), colData = DataFrame(),
    metadata = list()) {

    SummarizedExperiment <-
        if (!is(assays, "SummarizedExperiment"))
            SummarizedExperiment(assays = assays, colData = colData,
                metadata = metadata)
        else
            assays

    .MicrobiomeExperiment(SummarizedExperiment, rowData = rowData)
}

########
# phyloseq legacy setters/getters

# get otu table
.get_otu_table <- function(obj) { assay(obj) }
setMethod("otu_table", signature=c("MicrobiomeExperiment"), .get_otu_table)

# set otu table
.set_otu_table <- function(obj, value) {
    assay(obj) <- value
}
setReplaceMethod("otu_table", signature=c("MicrobiomeExperiment", "matrix"),
                 .set_otu_table)

# get taxonomy table
.get_tax_table <- function(obj) { rowData(obj) }
setMethod("tax_table", signature=c("MicrobiomeExperiment"), .get_tax_table)

# set taxonomy table
.set_tax_table <- function(obj, value) {
    # TODO: harmonize new value with existing MicrobiomeFeatures value
    obj@elementMetadata <- MicrobiomeFeatures(value)
}
