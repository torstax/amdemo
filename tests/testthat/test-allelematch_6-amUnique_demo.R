# Internal utility function.
# Use amCSV.amUnique to convert from amUnique object to simple data.frame:
printViaCsv <- function(x) {
  withr::local_options(width=200) # Allow longer lines for the summaries:

  # Write the result of amUnique to a .csv file:
  tmp = tempfile("tmp_amUnique_demo", fileext=".csv")
  amCSV.amUnique(x, csvFile=tmp)

  # Read it back to get it into a manageable data.frame format:
  df <- read.csv(tmp)
  file.remove(tmp)

  # Drop some unnecessary columns:
  df[c("matchThreshold", "alleleMismatch", "cutHeight")] <- list(NULL)

  # Format 'Psib' and 'score' with 2 decimal places (as character columns)
  df$Psib  <- format(round(df$Psib, 2), nsmall = 2)
  df$score <- format(round(df$score, 2), nsmall = 2)

  # ... and print:
  cat("\n", sep="")
  print(df, row.names=FALSE)
}


test_that("Demo minComparableLoci for amUnique() on loci with two alleles each", {
  withr::local_options(width=200) # Allow longer lines for the summaries:

  expect_snapshot({
    "The new parameter minComparableLoci is demonstrated in the tests below."
    " "
    "minComparableLoci is here passed to the function amUnique()."
    " "
    "amUnique() identifies unique genotypes. Samples are clustered and matched"
    "based on their dissimilarity score (see amMatrix)."
    "Psib, probability that two samples are siblings, is also calculated."
    " ";
    "minComparableLoci causes both Psib and score to become NA ";
    "for pairs of genotypes that don't have enough comparable loci."
    " "
    "A loci is incomparable if all alleles in it have NA data for any of the two";
    "compared genotypes."
    " ";
    library(allelematch)})


  # Create mini sample with 3 genotype rows and 3 loci with 2 alleles each:
  # The genotype C2, BAD, will not be comparable with the others
  # if minComparableLoci goes above 1.
  #
  miniColnames  = c("IND","META","L1a","L1b","L2a","L2b","L3a","L3b")
  sample = t(data.frame(
      c("F1","Focal",-99,-99,"X","Y","X","z"), # One incomparable locus
      c("C1","Good", -99,-99,"X","Y","X","Y"), # Same incomparable locus => no effect
      c("C2","Bad",  "X","Y",-99,-99,"X","Y")  # Another incomparable locus => incomparable genotypes
  ))
  colnames(sample) <- miniColnames
  expect_snapshot({
    "We first create a minimal data set with three genotype rows (F1, C1 and C2)"
    "and 6 allele columns."
    " "
    "The alleles are grouped pairwise in three loci (L1, L2 and L3)."
    " "
    "Both genotypes F1 and C1 have one incomparable locus: L1. This is because "
    "both alleles L1a and L1b have NA data (coded as -99)."
    " "
    "Genotype C2 also has one incomparable locus: L2"
    " "
    "When doing pairwise comparisons of the genotype rows, we can see that"
    "comparing F1 and C1 give one incomparable (and two comparable) loci"
    "Whilst comparing F1 and C2 give two incomparable (and one comparable) loci"
    " ";
    print.amDataset(
    ds <- amDataset(sample,indexColumn = 1, metaDataColumn = 2, lociMap = TRUE))})


  expect_snapshot({
    "Here minComparableLoci = 3 => No genotypes are comparable."
    "This means that all genotype gets 100% dissimilarity towards all others:"
    " ";
    printViaCsv(
    u_3 <- amUnique(ds, cutHeight = 0.3, minComparableLoci = 3, verbose = FALSE))})


  expect_snapshot({
    "Here minComparableLoci = 0 => Backwards compatible with allelematch 2.5.4."
    " "
    "Here all genotypes are comparable with each other:"
    " ";
    printViaCsv(
    u_0 <- amUnique(ds, cutHeight = 0.3, minComparableLoci = 0, verbose = FALSE)
  )})

  expect_snapshot({
    "Here minComparableLoci = 2 => genotype C2 is incomparable towards the other genotypes"
    "(dissimilarity == 1 == 100%), but still comparable towards itself."
    " "
    "Note that the the dissimilarities between the other genotypes remain the same"
    "compared to the abowe run where minComparableLoci = 0:"
    " ";
    printViaCsv(
    u_2 <- amUnique(ds, cutHeight = 0.3, minComparableLoci = 2, verbose = FALSE))})

})

test_that("Demo minComparableLoci for amUnique() with one sigle-allele locus", {
  withr::local_options(width=200) # Allow longer lines for the summaries:

  # Create mini sample with 3 genotype rows and 3 loci where the first only has 1 allele:
  # The genotype C2, BAD, will not be comparable with the others:
  #
  miniColnames  = c("IND","META","L1g","L2a","L2b","L3a","L3b")
  sample = t(data.frame(
    c("F1","Focal",-99,"X","Y","X","z"), # One incomparable locus
    c("C1","Good", -99,"X","Y","X","Y"), # Same incomparable locus => no effect
    c("C2","Bad",  "Y",-99,-99,"X","Y")  # Another incomparable locus => incomparable genotypes
  ))
  colnames(sample) <- miniColnames
  expect_snapshot({
    "Create a minimal data set with 3 loci where the first only has one allele.";
    " ";
    "Note the new parameter lociMap to amDataset:";
    " ";
    print.amDataset(
      ds <- amDataset(sample,indexColumn = 1, metaDataColumn = 2, lociMap = c(1,2,2,3,3)))})


  expect_snapshot({
    "Here minComparableLoci = 3 => No genotypes are comparable.";
    "This means that all genotype gets 100% dissimilarity towards all others:";
    " ";
    printViaCsv(
      u_3 <- amUnique(ds, cutHeight = 0.3, minComparableLoci = 3, verbose = FALSE))})


  expect_snapshot({
    "Here minComparableLoci = 0 => Backwards compatible with allelematch 2.5.4"
    "and all genotypes are comparable with each other:"
    " ";
    printViaCsv(
      u_0 <- amUnique(ds, cutHeight = 0.3, minComparableLoci = 0, verbose = FALSE)
    )})


  expect_snapshot({
    "Here minComparableLoci = 2 => C2 is incomparable towards the other genotypes"
    "(dissimilarity == 1 == 100%), but still comparable towards itself."
    " ";
    "Note that the the dissimilarities between the other genotypes remain the same";
    "compared to the abowe run:";
    " ";
    printViaCsv(
      u_2 <- amUnique(ds, cutHeight = 0.3, minComparableLoci = 2, verbose = FALSE))})

})
