
test_that("Demo minComparableLoci for amCluster() on loci with two alleles each", {


  expect_snapshot({
    "The new support for parameter minComparableLoci in amDataset()"
    "is demonstrated in the tests below.";
    " ";
    "The main new feature of amDataset() is the new parameter lociMap.";
    " ";
    "But support for cloning an existing amDataset object has also been added.";
    " ";
    library(allelematch)})

  # Mini dataset sample:
  miniColnames  = c("IND","META","L1a","L1b","L2a","L2b","L3a","L3b")
  sample = t(data.frame(
    c("F1","Focal",-99,-99,"X","Y","X","z"), # The locus L1a--L1b is incomparable
    c("C1","Good", -99,-99,"X","Y","X","Y"), # Same incomparable locus => no effect
    c("C2","Bad",  "X","Y",-99,-99,"X","Y")  # Another incomparable locus => incomparable genotypes
  ))
  colnames(sample) <- miniColnames

  expect_snapshot({
    "We first create a backwards compatible minimal data set with 3 genotype rows (F1, C1, C2)"
    "and 6 allele columns."
    " "
    "The alleles are grouped pairwise in three loci (L1, L2 and L3)."
    " "
    "The genotypes F1 and C1 both have one incomparable locus: L1. This is because "
    "both alleles L1a and L1b have NA data (coded as -99). "
    " "
    "C2 also has an incomparable locus: L2."
    " ";
    print.amDataset(
      dsTrad <- amDataset(sample, indexColumn = 1, metaDataColumn = 2), verbose=TRUE)})

  expect_snapshot({
    "We then create an identical data set with with a default lociMap."
    " "
    "We do this by passing 'lociMap = TRUE' to amDataset()."
    " "
    "This will only work for a default data set were each locus holds exactly"
    "two alleles, which is the normal case."
    " ";
    "The focal genotype F1 has one incomparable locus: L1. This is because "
    "both alleles L1a and L1b have NA data (coded as -99)."
    " ";
    print.amDataset(
      dsDefaultMap <- amDataset(sample,indexColumn = 1, metaDataColumn = 2, lociMap = TRUE), verbose=TRUE)})

  expect_snapshot({
    "Here we clone the traditional amDataset (without ading a lociMap):"
    " ";
    print.amDataset(
      dsCloned1 <- amDataset(dsTrad), verbose=TRUE)})
  expect_identical(dsCloned1, dsTrad)

  expect_snapshot({
    "Here we clone and add a default lociMap in the same call:"
    " ";
    print.amDataset(
      dsClonedMap <- amDataset(dsTrad, lociMap = TRUE), verbose=TRUE)})

  expect_snapshot({
    "Here we clone and add a numeric lociMap in the same call:"
    " ";
    print.amDataset(
      dsNumMap <- amDataset(dsTrad, lociMap = c(1,1,2,2,3,3)), verbose=TRUE)})
  expect_identical(dsNumMap, dsClonedMap)

  expect_snapshot({
    "Here we clone and add a string lociMap in the same call:"
    " "
    "Note that the lociMap strings are converted to numerics,"
    "making dsStrMap and dsNumMap identical."
    " ";
    print.amDataset(
      dsStrMap <- amDataset(dsTrad, lociMap = c("L1","L1","L2","L2","L3","L3")), verbose=TRUE)})
  expect_identical(dsStrMap, dsNumMap)

})


test_that("Demo minComparableLoci for amCluster() with first locus sigle-allele", {


  miniColnames  = c("IND","META","L1g","L2a","L2b","L3a","L3b")
  sample = t(data.frame(
    c("F1","Focal",-99,"X","Y","X","z")  # The locus L1g is incomparable
  ))
  colnames(sample) <- miniColnames

  expect_snapshot({
    "Create mini sample with 3 genotype rows and 3 loci where"
    "the first locus only has 1 allele, L1g (g for Gender):"
    " "
    "Locus L1 is incomparable because its only allele L1g has NA data "
    "(coded as -99)."
    " "
    "Note the new parameter lociMap to amDataset():"
    " ";
    print.amDataset(
      focal <- amDataset(sample,indexColumn = 1, metaDataColumn = 2, lociMap = c(1,2,2,3,3)), verbose=TRUE)})


  # Comparison sample:
  miniColnames  = c("IND","META","L1g","L2a","L2b","L3a","L3b")
  sample = t(data.frame(
    c("F1","Focal",-99,"X","Y","X","z"), # The locus L1g is incomparable
    c("C1","Good", -99,"X","Y","X","Y"), # Same incomparable locus as for F1 => no effect
    c("C2","Good", -99,"X",-99,"X",-99), # Same incomparable locus as for F1 => no effect
    c("C3","Bad",  "Y",-99,-99,"X","Y"), # Another incomparable locus => incomparable genotypes
    c("C4","Bad",  "Y","X","Y",-99,-99), # Another incomparable locus => incomparable genotypes
    c("C5","Bad",  "Y",-99,-99,-99,"Y"), # Another incomparable locus => incomparable genotypes
    c("C6","Bad",  "Y",-99,-99,-99,-99), # Another incomparable locus => incomparable genotypes
    c("C7","Bad",  -99,-99,-99,-99,-99)  # Another incomparable locus => incomparable genotypes
  ))
  colnames(sample) <- miniColnames

})
