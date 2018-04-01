#' Alias for mgFeatures class from metagenomeFeatures package
#'
#' @importClassesFrom metagenomeFeatures mgFeatures
#'
.MicrobiomeFeatures <- setClass("MicrobiomeFeatures",
    contains = "mgFeatures")

MicrobiomeFeatures <- function() {
    .MicrobiomeFeatures()
}
