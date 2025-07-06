# Demo minComparableLoci for amUnique() on loci with two alleles each

    Code
      # The new parameter minComparableLoci is demonstrated in the tests below.
      #  
      # minComparableLoci is here passed to the function amUnique().
      #  
      # amUnique() identifies unique genotypes. Samples are clustered and matched
      # based on their dissimilarity score (see amMatrix).
      # Psib, probability that two samples are siblings, is also calculated.
      #  
      # minComparableLoci raises the dissimilarity to 100% for pairs of genotypes 
      # that don't have enough comparable loci.
      #  
      # A loci is incomparable if all alleles in it have NA data for any of the two
      # compared genotypes.
      #  
      library(allelematch)

---

    Code
      # We first create a minimal data set with three genotype rows (F1, C1 and C2)
      # and 6 allele columns.
      #  
      # The alleles are grouped pairwise in three loci (L1, L2 and L3).
      #  
      # Both genotypes F1 and C1 have one incomparable locus: L1. This is because 
      # both alleles L1a and L1b have NA data (coded as -99).
      #  
      # Genotype C2 also has one incomparable locus: L2
      #  
      # When doing pairwise comparisons of the genotype rows, we can see that
      # comparing F1 and C1 give one incomparable (and two comparable) loci
      # Whilst comparing F1 and C2 give two incomparable (and one comparable) loci
      #  
      print.amDataset(ds <- amDataset(sample, indexColumn = 1, metaDataColumn = 2,
        lociMap = TRUE))
    Output
      allelematch
      amDataset object
                L1a L1b L2a L2b L3a L3b
      F1  Focal -99 -99   X   Y   X   Y
      C1  Good  -99 -99   X   Y   X   Y
      C2  Bad     X   Y -99 -99   X   Y

---

    Code
      # Here minComparableLoci = 3 => No genotypes are comparable.
      # This means that all genotype gets 100% dissimilarity towards all others:
      #  
      printViaCsv(u_3 <- amUnique(ds, cutHeight = 0.3, minComparableLoci = 3,
        verbose = FALSE))
    Output
      
       uniqueGroup        rowType uniqueIndex matchIndex nUniqueGroup Psib score metaData L1a L1b L2a L2b L3a L3b
                 1   CHECK_UNIQUE          C1         C1            1   NA    NA     Good -99 -99   X   Y   X   Y
                 1 MULTIPLE_MATCH          C1       None            1   NA    NA                                 
                 2   CHECK_UNIQUE          C2         C2            1   NA    NA      Bad   X   Y -99 -99   X   Y
                 2 MULTIPLE_MATCH          C2       None            1   NA    NA                                 
                 3   CHECK_UNIQUE          F1         F1            1   NA    NA    Focal -99 -99   X   Y   X   Y
                 3 MULTIPLE_MATCH          F1       None            1   NA    NA                                 

---

    Code
      # Here minComparableLoci = 0 => Backwards compatible with allelematch 2.5.4.
      #  
      # Here all genotypes are comparable with each other:
      #  
      printViaCsv(u_0 <- amUnique(ds, cutHeight = 0.3, minComparableLoci = 0,
        verbose = FALSE))
    Output
      
       uniqueGroup rowType uniqueIndex matchIndex nUniqueGroup     Psib score metaData L1a L1b L2a L2b L3a L3b
                 1  UNIQUE          C2         C2            1 0.390625    NA      Bad   X   Y -99 -99   X   Y
                 2  UNIQUE          F1         F1            2 0.390625    NA    Focal -99 -99   X   Y   X   Y
                 2   MATCH          F1         C1            2 0.390625     1     Good -99 -99   X   Y   X   Y

---

    Code
      # Here minComparableLoci = 2 => genotype C2 is incomparable towards the other genotypes
      # (dissimilarity == 1 == 100%)
      #  
      # Note that the the dissimilarities between the other genotypes remain the same
      # compared to the abowe run where minComparableLoci = 0:
      #  
      printViaCsv(u_2 <- amUnique(ds, cutHeight = 0.3, minComparableLoci = 2,
        verbose = FALSE))
    Output
      
       uniqueGroup rowType uniqueIndex matchIndex nUniqueGroup     Psib score metaData L1a L1b L2a L2b L3a L3b
                 1  UNIQUE          C2         C2            1 0.390625    NA      Bad   X   Y -99 -99   X   Y
                 2  UNIQUE          F1         F1            2 0.390625    NA    Focal -99 -99   X   Y   X   Y
                 2   MATCH          F1         C1            2 0.390625     1     Good -99 -99   X   Y   X   Y

# Demo minComparableLoci for amUnique() with one sigle-allele locus

    Code
      # Create a minimal data set with 3 loci where the first only has one allele.
      #  
      # Note the new parameter lociMap to amDataset:
      #  
      print.amDataset(ds <- amDataset(sample, indexColumn = 1, metaDataColumn = 2,
        lociMap = c(1, 2, 2, 3, 3)))
    Output
      allelematch
      amDataset object
                L1g L2a L2b L3a L3b
      F1  Focal -99   X   Y   X   Y
      C1  Good  -99   X   Y   X   Y
      C2  Bad     Y -99 -99   X   Y

---

    Code
      # Here minComparableLoci = 3 => No genotypes are comparable.
      # This means that all genotype gets 100% dissimilarity towards all others:
      #  
      printViaCsv(u_3 <- amUnique(ds, cutHeight = 0.3, minComparableLoci = 3,
        verbose = FALSE))
    Output
      
       uniqueGroup        rowType uniqueIndex matchIndex nUniqueGroup Psib score metaData L1g L2a L2b L3a L3b
                 1   CHECK_UNIQUE          C1         C1            1   NA    NA     Good -99   X   Y   X   Y
                 1 MULTIPLE_MATCH          C1       None            1   NA    NA                             
                 2   CHECK_UNIQUE          C2         C2            1   NA    NA      Bad   Y -99 -99   X   Y
                 2 MULTIPLE_MATCH          C2       None            1   NA    NA                             
                 3   CHECK_UNIQUE          F1         F1            1   NA    NA    Focal -99   X   Y   X   Y
                 3 MULTIPLE_MATCH          F1       None            1   NA    NA                             

---

    Code
      # Here minComparableLoci = 0 => Backwards compatible with allelematch 2.5.4
      # and all genotypes are comparable with each other:
      #  
      printViaCsv(u_0 <- amUnique(ds, cutHeight = 0.3, minComparableLoci = 0,
        verbose = FALSE))
    Output
      
       uniqueGroup        rowType uniqueIndex matchIndex nUniqueGroup     Psib score metaData L1g L2a L2b L3a L3b
                 1   CHECK_UNIQUE          C2         C2            3 0.625000    NA      Bad   Y -99 -99   X   Y
                 1 MULTIPLE_MATCH          C2         F1            3 0.625000   0.7    Focal -99   X   Y   X   Y
                 1 MULTIPLE_MATCH          C2         C1            3 0.625000   0.7     Good -99   X   Y   X   Y
                 2   CHECK_UNIQUE          F1         F1            3 0.390625    NA    Focal -99   X   Y   X   Y
                 2 MULTIPLE_MATCH          F1         C1            3 0.390625   1.0     Good -99   X   Y   X   Y
                 2 MULTIPLE_MATCH          F1         C2            3 0.625000   0.7      Bad   Y -99 -99   X   Y

---

    Code
      # Here minComparableLoci = 2 => C2 is incomparable towards the other genotypes
      # (dissimilarity == 1 == 100%)
      #  
      # Note that the the dissimilarities between the other genotypes remain the same
      # compared to the abowe run:
      #  
      printViaCsv(u_2 <- amUnique(ds, cutHeight = 0.3, minComparableLoci = 2,
        verbose = FALSE))
    Output
      
       uniqueGroup rowType uniqueIndex matchIndex nUniqueGroup     Psib score metaData L1g L2a L2b L3a L3b
                 1  UNIQUE          C2         C2            1 0.625000    NA      Bad   Y -99 -99   X   Y
                 2  UNIQUE          F1         F1            2 0.390625    NA    Focal -99   X   Y   X   Y
                 2   MATCH          F1         C1            2 0.390625     1     Good -99   X   Y   X   Y

