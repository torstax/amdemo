# Demo amDataset() support for new param minComparableLoci

    Code
      # Please continue to allelematch_2-amMatrix_demo.md to see minComparableLoci
      # properly demonstrated.
      #  
      # The new support for parameter minComparableLoci in amDataset()
      # is indirect.
      #  
      # The main new feature of amDataset() is the new parameter lociMap.
      #  
      # But support for cloning an existing amDataset object has also been added.
      #  
      # These two new features are demonstrated below.
      #  
      library(allelematch)

---

    Code
      # We first create a backwards compatible minimal data set with 3 genotype rows (F1, C1, C2)
      # and 6 allele columns.
      #  
      # The alleles are grouped pairwise in three loci (L1, L2 and L3).
      #  
      # The genotypes F1 and C1 both have one incomparable locus: L1. This is because 
      # both alleles L1a and L1b have NA data (coded as -99). 
      #  
      # C2 also has an incomparable locus: L2.
      #  
      print.amDataset(dsTrad <- amDataset(sample, indexColumn = 1, metaDataColumn = 2),
      verbose = TRUE)
    Output
      allelematch
      amDataset object
         MissingCode: -99
         lociMap    : (NULL)
                L1a L1b L2a L2b L3a L3b
      F1  Focal -99 -99   X   Y   X   z
      C1  Good  -99 -99   X   Y   X   Y
      C2  Bad     X   Y -99 -99   X   Y

---

    Code
      # We then create an identical data set with with a default lociMap.
      #  
      # We do this by passing 'lociMap = TRUE' to amDataset().
      #  
      # This will only work for a default data set were each locus holds exactly
      # two alleles, which is the normal case.
      #  
      # The focal genotype F1 has one incomparable locus: L1. This is because 
      # both alleles L1a and L1b have NA data (coded as -99).
      #  
      print.amDataset(dsDefaultMap <- amDataset(sample, indexColumn = 1,
        metaDataColumn = 2, lociMap = TRUE), verbose = TRUE)
    Output
      allelematch
      amDataset object
         MissingCode: -99
         lociMap    : (1, 1, 2, 2, 3, 3)
                L1a L1b L2a L2b L3a L3b
      F1  Focal -99 -99   X   Y   X   z
      C1  Good  -99 -99   X   Y   X   Y
      C2  Bad     X   Y -99 -99   X   Y

---

    Code
      # Here we clone the traditional amDataset (without ading a lociMap):
      #  
      print.amDataset(dsCloned1 <- amDataset(dsTrad), verbose = TRUE)
    Output
      allelematch
      amDataset object
         MissingCode: -99
         lociMap    : (NULL)
                L1a L1b L2a L2b L3a L3b
      F1  Focal -99 -99   X   Y   X   z
      C1  Good  -99 -99   X   Y   X   Y
      C2  Bad     X   Y -99 -99   X   Y

---

    Code
      # Here we clone and add a default lociMap in the same call:
      #  
      print.amDataset(dsClonedMap <- amDataset(dsTrad, lociMap = TRUE), verbose = TRUE)
    Output
      allelematch
      amDataset object
         MissingCode: -99
         lociMap    : (1, 1, 2, 2, 3, 3)
                L1a L1b L2a L2b L3a L3b
      F1  Focal -99 -99   X   Y   X   z
      C1  Good  -99 -99   X   Y   X   Y
      C2  Bad     X   Y -99 -99   X   Y

---

    Code
      # Here we clone and add a numeric lociMap in the same call:
      #  
      print.amDataset(dsNumMap <- amDataset(dsTrad, lociMap = c(1, 1, 2, 2, 3, 3)),
      verbose = TRUE)
    Output
      allelematch
      amDataset object
         MissingCode: -99
         lociMap    : (1, 1, 2, 2, 3, 3)
                L1a L1b L2a L2b L3a L3b
      F1  Focal -99 -99   X   Y   X   z
      C1  Good  -99 -99   X   Y   X   Y
      C2  Bad     X   Y -99 -99   X   Y

---

    Code
      # Here we clone and add a string lociMap in the same call:
      #  
      # Note that the lociMap strings are converted to numerics,
      # making dsStrMap and dsNumMap identical.
      #  
      print.amDataset(dsStrMap <- amDataset(dsTrad, lociMap = c("L1", "L1", "L2",
        "L2", "L3", "L3")), verbose = TRUE)
    Output
      allelematch
      amDataset object
         MissingCode: -99
         lociMap    : (1, 1, 2, 2, 3, 3)
                L1a L1b L2a L2b L3a L3b
      F1  Focal -99 -99   X   Y   X   z
      C1  Good  -99 -99   X   Y   X   Y
      C2  Bad     X   Y -99 -99   X   Y

# Demo minComparableLoci for amCluster() with first locus sigle-allele

    Code
      # Create mini sample with 3 genotype rows and 3 loci where
      # the first locus only has 1 allele, L1g (g for Gender):
      #  
      # Locus L1 is incomparable because its only allele L1g has NA data 
      # (coded as -99).
      #  
      # Note the new parameter lociMap to amDataset():
      #  
      print.amDataset(focal <- amDataset(sample, indexColumn = 1, metaDataColumn = 2,
        lociMap = c(1, 2, 2, 3, 3)), verbose = TRUE)
    Output
      allelematch
      amDataset object
         MissingCode: -99
         lociMap    : (1, 2, 2, 3, 3)
                L1g L2a L2b L3a L3b
      F1  Focal -99   X   Y   X   z

