#' MicrobiomeExperiment-class
#'
#' SummarizedExperiment-like class for microbiome data. rowData is a
#' MicrobiomeFeatures object LINK so it includes: a taxonomy table (DataFrame),
#' optional phylogentic tree (phylo object), and a sequence database.
#'
#' It supports (most) of the interface to phyloseq objects
#'
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
#' #mgf <- as(mock_mgF, "MetagenomicFeatures")
#' mgf <- mock_mgF
#' MicrobiomeExperiment(assays=SimpleList(counts=counts),
#' rowData=mgf,
#' colData=pd
#' )
#'
#setClass("MicrobiomeExperiment",
#         contains="SummarizedExperiment",
#         representation(rowData="MicrobiomeFeatures"))


