
test_that("Demo minComparableLoci for amAlleleFreq()", {


  expect_snapshot({
    "The new parameter minComparableLoci has no effect on amAlleleFreq()."
    " "
    "There is therefore not really need for any demonstration. But you'll get a short one anyway."
    " "
    "amAlleleFreq() determines the allele frequencies for each locus in a"
    "multilocus genetic dataset by first removing missing observations."
    " ";
    library(allelematch)})

  expect_snapshot({
    "Get the six first columns and 10 first rows from an allelematch example:"
    "Here of 4 data columns consisting of 2 loci with 2 alleles each"
    " "
    sample <- amExample1[1:10 , 1:6]
    ds <- amDataset(sample, indexColumn = 1, metaDataColumn = 2, lociMap = TRUE)
    print(ds, verbose=TRUE)
  })

  expect_snapshot({
    "Calculate the allele frequencies for these 2 loci:"
    " "
    "Note that we have the lociMap in the amDataset 'ds'."
    " "
    print(
      f <- amAlleleFreq(ds) )
  })

})
