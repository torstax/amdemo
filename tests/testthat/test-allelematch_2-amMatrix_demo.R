test_that("Demo minComparableLoci for amMatrix() on loci with two alleles each", {


  expect_snapshot({
    "The new parameter minComparableLoci is demonstrated in the tests below.";
    " ";
    "minComparableLoci is here passed to the function amMatrix().";
    " ";
    "amMatrix() calculates dissimilarities between pairs of multilocus genotypes.";
    " ";
    "minComparableLoci raises the dissimilarity to 100% for pairs of genotypes ";
    "that don't have enough comparable loci.";
    " ";
    "A loci is incomparable if all alleles in it have NA data for any of the two";
    "compared genotypes.";
    " ";
    library(allelematch)})


  # Create mini sample with 3 genotype rows and 3 loci with 2 alleles each:
  # The genotype C2, BAD, will not be comparable with the others:
  #
  miniColnames  = c("IND","META","L1a","L1b","L2a","L2b","L3a","L3b")
  sample = t(data.frame(
      c("F1","Focal",-99,-99,"X","Y","X","Y"), # One incomparable locus
      c("C1","Good", -99,-99,"X","Y","X","Y"), # Same incomparable locus => no effect
      c("C2","Bad",  "X","Y",-99,-99,"X","Y")  # Another incomparable locus => incomparable genotypes
  ))
  colnames(sample) <- miniColnames
  expect_snapshot({
    "We first create a minimal data set with three genotype rows (F1, C1 and C2)";
    "and 6 allele columns.";
    " ";
    "The alleles are grouped pairwise in three loci (L1, L2 and L3).";
    " ";
    "Both genotypes F1 and C1 have one incomparable locus: L1. This is because ";
    "both alleles L1a and L1b have NA data (coded as -99).";
    " ";
    "Genotype C2 also has one incomparable locus: L2";
    " ";
    "When doing pairwise comparisons of the genotype rows, we can then see that";
    "comparing F1 and C1 give one incomparable (and two comparable) loci";
    "Whilst comparing F1 and C2 give two incomparable (and one comparable) loci";
    " ";
    print.amDataset(
    ds <- amDataset(sample,indexColumn = 1, metaDataColumn = 2))})

  expect_snapshot({
    "Here minComparableLoci = 3 => No genotypes are comparable.";
    "This means that all genotype gets 100% dissimilarity towards all others:";
    " ";
    print(
    mx_3 <- amMatrix(ds, minComparableLoci = 3))})

  expect_snapshot({
    "Here minComparableLoci = 0 => Backwards compatible with allelematch 2.5.4."
    " ";
    "Here all genotypes are comparable with each other:"
    " ";
    print(
    mx_0 <- amMatrix(ds, minComparableLoci = 0)
  )})

  expect_snapshot({
    "Here minComparableLoci = 2 => genotype C2 is incomparable towards the other genotypes"
    "(dissimilarity == 1 == 100%)"
    " ";
    "Note that the the dissimilarities between the other genotypes remain the same";
    "compared to the abowe run where minComparableLoci = 0:";
    " ";
    print(
    mx_2 <- amMatrix(ds, minComparableLoci = 2))})

})

test_that("Demo minComparableLoci for amMatrix() with one sigle-allele locus", {

  # Create mini sample with 3 genotype rows and 3 loci where the first only has 1 allele:
  # The genotype C2, BAD, will not be comparable with the others:
  #
  miniColnames  = c("IND","META","L1g","L2a","L2b","L3a","L3b")
  sample = t(data.frame(
    c("F1","Focal",-99,"X","Y","X","Y"), # One incomparable locus
    c("C1","Good", -99,"X","Y","X","Y"), # Same incomparable locus => no effect
    c("C2","Bad",  "Y",-99,-99,"X","Y")  # Another incomparable locus => incomparable genotypes
  ))
  colnames(sample) <- miniColnames
  expect_snapshot({
    "Create a minimal data set with 3 loci where the first only has one allele.";
    " ";
    "Note the new parameter multilocusMap to amDataset:";
    " ";
    print.amDataset(
      ds <- amDataset(sample,indexColumn = 1, metaDataColumn = 2, multilocusMap = c(1,2,2,3,3)))})


  expect_snapshot({
    "Here minComparableLoci = 3 => No genotypes are comparable.";
    "This means that all genotype gets 100% dissimilarity towards all others:";
    " ";
    print(
      mx_3 <- amMatrix(ds, minComparableLoci = 3))})


  expect_snapshot({
    "Here minComparableLoci = 0 => Backwards compatible with allelematch 2.5.4"
    "and all genotypes are comparable with each other:"
    " ";
    print(
      mx_0 <- amMatrix(ds, minComparableLoci = 0)
    )})


  expect_snapshot({
    "Here minComparableLoci = 2 => C2 is incomparable towards the other genotypes"
    "(dissimilarity == 1 == 100%)"
    " ";
    "Note that the the dissimilarities between the other genotypes remain the same";
    "compared to the abowe run:";
    " ";
    print(
      mx_2 <- amMatrix(ds, minComparableLoci = 2))})

})
