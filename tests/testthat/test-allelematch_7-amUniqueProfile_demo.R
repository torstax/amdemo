## Internal utility function to store a plot as a .bmp file
## under tests/testthat/_snaps
plot_amUniqueProfile <- function(res, ds, ...) {

  argstr = helpArgToString(...)
  cmdstr = paste0(res, " <- amUniqueProfile(", ds, ", ", argstr, ")", collapse="")
  expect_snapshot({
    "About to make the following call to generate a plot"
    "under ./_snaps/allelematch_7-amUniqueProfile_demo/*.png"
    cmdstr })

  amds = get(ds, envir = parent.frame()) ; stopifnot(inherits(amds, "amDataset"))

  # Store the resulting plot as a file:
  tmp <- tempfile(fileext = ".png")
  png(tmp)
  result <- amUniqueProfile(amds, ...)  # generates the plot
  dev.off()

  expect_snapshot_file(tmp, name=paste0("allelematch_7-amUniqueProfile_demo_",res,".png"))

  return(result)
}

# Internal utility function.
# Print most columns of a data.frame:
printMost <- function(df) {
  withr::local_options(width=200) # Allow longer lines for the summaries:

  # Drop some unnecessary columns (alleMatch is enough):
  df[c("matchThreshold", "cutHeight")] <- list(NULL)

  # # Format 'Psib' and 'score' with 2 decimal places (as character columns)
  # df$Psib  <- format(round(df$Psib, 2), nsmall = 2)
  # df$score <- format(round(df$score, 2), nsmall = 2)

  # ... and print:
  cat("\n")
  print(df, row.names=FALSE)
}


test_that("Demo minComparableLoci for amUniqueProfile() when plotting from amExample5 data", {

  expect_snapshot({
    "The new parameter minComparableLoci is demonstrated in the tests below."
    " "
    "minComparableLoci is here passed to the function amUniqueProfile()."
    " "
    "amUniqueProfile() automatically runs amUnique() at a sequence of parameter values"
    "to determine an optimal setting, and optionally plot the result."
    " "
    "minComparableLoci raises the dissimilarity to 100% for pairs of genotypes "
    "that don't have enough comparable loci."
    " "
    "A loci is incomparable if all alleles in it have NA data for any of the two"
    "compared genotypes."
    " "
    library(allelematch)})

  withr::local_options(width=200) # Allow longer lines for the summaries:

  # Load amExample5 (wild life dataset) into an amDataset. Note that the first
  # locus is a single-allele gender locus. So, we get 21 alleles over 11 loci.
  amDataExemple5 = amDataset(amExample5, indexColumn="sampleId", metaDataColumn="samplingData",
                              lociMap = c(1, rep(2:11, each=2)))

  e5_0 <- plot_amUniqueProfile("e5_0", "amDataExemple5", doPlot=TRUE, verbose=FALSE)
  expect_snapshot({
    "Generate a backwards compatible plot (i.e. minComparableLoci=0) of amExemple5."
    ""
    "Interpret 'e5_0' like this: 'e5' for dataset from 'amExample5' and '0' for 'minComparableLoci=0'."
    "'amExample5' is the allelematch built-in wild-life example with low data quality."
    " "
    "The function 'printMost()' below prints all columns in the data.frame"
    "that is returned by amUniqueProfile(), excep for columns 'matchThreshold'"
    "and 'cutHeight'. These are deamed unnecessary when we have column 'alleleMatch'."
    ""
    printMost(e5_0) })

  e5_8 <- plot_amUniqueProfile("e5_8","amDataExemple5", minComparableLoci = 8, doPlot=TRUE, verbose=FALSE)
  expect_snapshot({
    "Generate a plot where 8 of the 11 loci must be comparable (i.e. minComparableLoci=8)."
    ""
    "Note that the resulting plot is still quite similar to that of the"
    "backwards compatible, 'e5_0' above."
    ""
    printMost(e5_8) })

  e5_9 <- plot_amUniqueProfile("e5_9","amDataExemple5", minComparableLoci = 9, doPlot=TRUE, verbose=FALSE)
  expect_snapshot({
    "Generate a plot where 9 of the 11 loci must be comparable (i.e. minComparableLoci=9)."
    ""
    printMost(e5_9) })

  e5_10 <- plot_amUniqueProfile("e5_10","amDataExemple5", minComparableLoci = 10, doPlot=TRUE, verbose=FALSE)
  expect_snapshot({
    "Generate a plot where 10 of the 11 loci must be comparable (i.e. minComparableLoci=10)."
    ""
    printMost(e5_10) })

  e5_11 <- plot_amUniqueProfile("e5_11", "amDataExemple5", minComparableLoci = 11, doPlot=TRUE, verbose=FALSE)
  expect_snapshot({
    "Finally generate a plot where all 11 loci must be comparable (i.e. minComparableLoci=11)"
    ""
    printMost(e5_11) })

})


test_that("Demo minComparableLoci for amUniqueProfile() on loci with two alleles each", {

  # Create the same mini sample that was used with the amUnique() demo.
  #
  miniColnames  = c("IND","META","L1a","L1b","L2a","L2b","L3a","L3b")
  sample = t(data.frame(
    c("F1","Focal",-99,-99,"X","Y","X","z"), # One incomparable locus
    c("C1","Good", -99,-99,"X","Y","X","Y"), # Same incomparable locus => no effect
    c("C2","Bad",  "X","Y",-99,-99,"X","Y")  # Another incomparable locus => incomparable genotypes
  ))
  colnames(sample) <- miniColnames

  expect_snapshot({
    "We first create the same mini sample that was used with the amUnique() demo."
    " "
    "With amUnique we could see some effect of minComparableLoci,"
    "but here not so much. We leave it in anyway for reference."
    " "
    print.amDataset(
      ds <- amDataset(sample,indexColumn = 1, metaDataColumn = 2, lociMap = TRUE), verbose=TRUE)})

  expect_snapshot({
    "Here minComparableLoci = 3 => No genotypes are comparable."
    "This means that all genotype gets 100% dissimilarity towards all others:"
    " "
    "The function 'printMost() below prints all columns in the data.frame"
    "that is returned by amUniqueProfile(), excep for columns 'matchThreshold'"
    "and 'cutHeight'. These are deamed unnecessary when we have column 'alleleMatch'."
    " "
    printMost(
      u_3 <- amUniqueProfile(ds,
                             minComparableLoci = 3,
                             doPlot=FALSE,
                             verbose = FALSE)
    )})

  expect_snapshot({
    "Here minComparableLoci = 0 => Backwards compatible with allelematch 2.5.4."
    " "
    "Here all genotypes are comparable with each other:"
    " "
    printMost(
      u_0 <- amUniqueProfile(ds,
                             minComparableLoci = 0,
                             doPlot=FALSE,
                             verbose = FALSE)
    )})

  expect_snapshot({
    "Here minComparableLoci = 2 => genotype C2 is incomparable towards the other genotypes"
    "(dissimilarity == 1 == 100%)"
    " "
    "Note that the the dissimilarities between the other genotypes remain the same"
    "compared to the abowe run where minComparableLoci = 0:"
    " "
    printMost(
      u_2 <- amUniqueProfile(ds, minComparableLoci = 2, doPlot = FALSE, verbose = FALSE)
    )})

})
