# Demo minComparableLoci for amCluster() on loci with two alleles each

    Code
      # The new parameter minComparableLoci is demonstrated in the tests below.
      #  
      # minComparableLoci is here passed to the function amCluster().
      #  
      # amCluster() performs a pairwise matching analysis of a focal 
      # multilocus genotype dataset. For each genotype in the focal dataset 
      # all genotypes in the comparison genotype are returned that match at or above 
      # a threshold matching score.
      #  
      # minComparableLoci lowers the matching score to 0 for pairs of genotypes 
      # that don't have enough comparable loci.
      #  
      # A loci is incomparable if all alleles in it have NA data for any of the two
      # compared genotypes.
      #  
      library(allelematch)

---

    Code
      # We first create a minimal focal data set with ?? genotype rows (F1, C1, C2)
      # and 6 allele columns.
      #  
      # The alleles are grouped pairwise in three loci (L1, L2 and L3).
      #  
      # The focal genotype F1 has one incomparable locus: L1. This is because 
      # both alleles L1a and L1b have NA data (coded as -99).
      #  
      # Note that we request the default multilocusMap which will be c(1,1,2,2,3,3)
      #  
      print.amDataset(ds <- amDataset(sample, indexColumn = 1, metaDataColumn = 2,
        multilocusMap = TRUE))
    Output
      allelematch
      amDataset object
                L1a L1b L2a L2b L3a L3b
      F1  Focal -99 -99   X   Y   X   z
      C1  Good  -99 -99   X   Y   X   Y
      C2  Bad     X   Y -99 -99   X   Y

---

    Code
      # Here minComparableLoci = 3 => No genotypes are comparable.
      # This means that all genotype gets 100% dissimilarity towards all others.
      # Therefore we don't find any matches:
      #  
      summary.amCluster(clu_3 <- amCluster(ds, minComparableLoci = 3))
    Output
      allelematch
      amCluster object
      
      Focal dataset N=3
      Unique genotypes (total): 3
      Unique genotypes (by cluster consensus): 0
      Unique genotypes (singletons): 3
      
      Missing data represented by: -99
      Missing data matching method: 2
      Clustered genotypes consensus method: 1
      Hierarchical clustering method: complete
      Dynamic tree cutting height (cutHeight): 0.3
      
      Run until only singletons: TRUE
      Runs: 1
      
      Score flags:
      *101 Allele does not match
      +101 Allele is missing
      [101] Allele is interpolated in consensus from non-missing cluster members (consensusMethod = 2, 4 only)
      
      (Singleton 1 of 3)
                            L1a  L1b L2a L2b L3a L3b score
      SINGLETON  F1  Focal +-99 +-99   X   Y   X   z      
      CLOSEST    F1  Focal +-99 +-99   X   Y   X   z     0
      
      
      (Singleton 2 of 3)
                            L1a  L1b L2a L2b L3a L3b score
      SINGLETON  C1  Good  +-99 +-99   X   Y   X   Y      
      CLOSEST    F1  Focal +-99 +-99   X   Y   X  *z     0
      
      
      (Singleton 3 of 3)
                            L1a  L1b  L2a  L2b L3a L3b score
      SINGLETON  C2  Bad      X    Y +-99 +-99   X   Y      
      CLOSEST    F1  Focal +-99 +-99   +X   +Y   X  *z     0
      
      
      (Singletons END)
      
      
      (Unique genotypes)
                           L1a L1b L2a L2b L3a L3b
      SINGLETON  C1  Good  -99 -99   X   Y   X   Y
      SINGLETON  C2  Bad     X   Y -99 -99   X   Y
      SINGLETON  F1  Focal -99 -99   X   Y   X   z

---

    Code
      # Here minComparableLoci = 0 => Backwards compatible with allelematch 2.5.4.
      #  
      # Here all genotypes are comparable with each other and we get backward
      # compatible number of matches:
      #  
      summary.amCluster(clu_0 <- amCluster(ds, minComparableLoci = 0))
    Output
      allelematch
      amCluster object
      
      Focal dataset N=3
      Unique genotypes (total): 2
      Unique genotypes (by cluster consensus): 0
      Unique genotypes (singletons): 2
      
      Missing data represented by: -99
      Missing data matching method: 2
      Clustered genotypes consensus method: 1
      Hierarchical clustering method: complete
      Dynamic tree cutting height (cutHeight): 0.3
      
      Run until only singletons: TRUE
      Runs: 2
      
      Score flags:
      *101 Allele does not match
      +101 Allele is missing
      [101] Allele is interpolated in consensus from non-missing cluster members (consensusMethod = 2, 4 only)
      
      (Singleton 1 of 2)
                            L1a  L1b  L2a  L2b L3a L3b score
      SINGLETON  C2  Bad      X    Y +-99 +-99   X   Y      
      CLOSEST    F1  Focal +-99 +-99   +X   +Y   X  *z   0.5
      
      
      (Singleton 2 of 2)
                            L1a  L1b  L2a  L2b L3a L3b score
      SINGLETON  F1  Focal +-99 +-99    X    Y   X   z      
      CLOSEST    C2  Bad     +X   +Y +-99 +-99   X  *Y   0.5
      
      
      (Singletons END)
      
      
      (Unique genotypes)
                           L1a L1b L2a L2b L3a L3b
      SINGLETON  C2  Bad     X   Y -99 -99   X   Y
      SINGLETON  F1  Focal -99 -99   X   Y   X   z

---

    Code
      # Here minComparableLoci = 2 => genotype C2 is incomparable towards F1 (and C2),
      # => 100% dissimilarity => C2 is removed from the list of matches.
      #  
      # Note that the the the comparable genotypes (C1) still get the same matching score
      # compared to the abowe backwards compatible run where minComparableLoci = 0:
      #  
      summary.amCluster(clu_2 <- amCluster(ds, minComparableLoci = 2))
    Output
      allelematch
      amCluster object
      
      Focal dataset N=3
      Unique genotypes (total): 2
      Unique genotypes (by cluster consensus): 0
      Unique genotypes (singletons): 2
      
      Missing data represented by: -99
      Missing data matching method: 2
      Clustered genotypes consensus method: 1
      Hierarchical clustering method: complete
      Dynamic tree cutting height (cutHeight): 0.3
      
      Run until only singletons: TRUE
      Runs: 2
      
      Score flags:
      *101 Allele does not match
      +101 Allele is missing
      [101] Allele is interpolated in consensus from non-missing cluster members (consensusMethod = 2, 4 only)
      
      (Singleton 1 of 2)
                         L1a L1b  L2a  L2b L3a L3b score
      SINGLETON  C2  Bad   X   Y +-99 +-99   X   Y      
      CLOSEST    C2  Bad   X   Y +-99 +-99   X   Y     0
      
      
      (Singleton 2 of 2)
                            L1a  L1b  L2a  L2b L3a L3b score
      SINGLETON  F1  Focal +-99 +-99    X    Y   X   z      
      CLOSEST    C2  Bad     +X   +Y +-99 +-99   X  *Y     0
      
      
      (Singletons END)
      
      
      (Unique genotypes)
                           L1a L1b L2a L2b L3a L3b
      SINGLETON  C2  Bad     X   Y -99 -99   X   Y
      SINGLETON  F1  Focal -99 -99   X   Y   X   z

# Demo minComparableLoci for amCluster() with first locus sigle-allele

    Code
      # Create mini sample with 3 genotype rows and 3 loci where
      # the first locus only has 1 allele, L1g (g for Gender):
      #  
      # Locus L1 is incomparable because its only allele L1g has NA data 
      # (coded as -99).
      #  
      # Note the new parameter multilocusMap to amDataset():
      #  
      print.amDataset(focal <- amDataset(sample, indexColumn = 1, metaDataColumn = 2,
        multilocusMap = c(1, 2, 2, 3, 3)))
    Output
      allelematch
      amDataset object
                L1g L2a L2b L3a L3b
      F1  Focal -99   X   Y   X   z

---

    Code
      # Create mini sample with 3 genotype rows and 3 loci where
      # the first locus L1 only has 1 allele, L1g (g for Gender):
      #  
      # Locus L1 is incomparable because its only allele L1g has NA data 
      # (coded as -99).
      #  
      # Genotypes C1 and C2 both have one incomparable locus: L1. But this is the same
      # locus as for the focal genotype F1, so it will not decrease the number of
      # comparable loci when comparing with F1.
      #  
      # Genotypes C3 to C7 have other incomparable loci than L1. This will decrease
      # the number of comparable loci when comparing with F1.
      #  
      # Note the new parameter 'multilocusMap' to amDataset():
      #  
      print.amDataset(ds <- amDataset(sample, indexColumn = 1, metaDataColumn = 2,
        multilocusMap = c(1, 2, 2, 3, 3)))
    Output
      allelematch
      amDataset object
                L1g L2a L2b L3a L3b
      F1  Focal -99   X   Y   X   z
      C1  Good  -99   X   Y   X   Y
      C2  Good  -99   X -99   X -99
      C3  Bad     Y -99 -99   X   Y
      C4  Bad     Y   X   Y -99 -99
      C5  Bad     Y -99 -99 -99   Y
      C6  Bad     Y -99 -99 -99 -99
      C7  Bad   -99 -99 -99 -99 -99

---

    Code
      # Here minComparableLoci = 3 => No genotypes are comparable.
      # This means that all genotype gets 100% dissimilarity towards all others.
      # Therefore we don't find any matches:
      #  
      summary.amCluster(clu_3 <- amCluster(ds, minComparableLoci = 3))
    Output
      allelematch
      amCluster object
      
      Focal dataset N=8
      Unique genotypes (total): 8
      Unique genotypes (by cluster consensus): 0
      Unique genotypes (singletons): 8
      
      Missing data represented by: -99
      Missing data matching method: 2
      Clustered genotypes consensus method: 1
      Hierarchical clustering method: complete
      Dynamic tree cutting height (cutHeight): 0.3
      
      Run until only singletons: TRUE
      Runs: 1
      
      Score flags:
      *101 Allele does not match
      +101 Allele is missing
      [101] Allele is interpolated in consensus from non-missing cluster members (consensusMethod = 2, 4 only)
      
      (Singleton 1 of 8)
                            L1g L2a L2b L3a L3b score
      SINGLETON  F1  Focal +-99   X   Y   X   z      
      CLOSEST    F1  Focal +-99   X   Y   X   z     0
      
      
      (Singleton 2 of 8)
                            L1g L2a L2b L3a L3b score
      SINGLETON  C1  Good  +-99   X   Y   X   Y      
      CLOSEST    F1  Focal +-99   X   Y   X  *z     0
      
      
      (Singleton 3 of 8)
                            L1g L2a  L2b L3a  L3b score
      SINGLETON  C2  Good  +-99   X +-99   X +-99      
      CLOSEST    F1  Focal +-99   X   +Y   X   +z     0
      
      
      (Singleton 4 of 8)
                            L1g  L2a  L2b L3a L3b score
      SINGLETON  C3  Bad      Y +-99 +-99   X   Y      
      CLOSEST    F1  Focal +-99   +X   +Y   X  *z     0
      
      
      (Singleton 5 of 8)
                            L1g L2a L2b  L3a  L3b score
      SINGLETON  C4  Bad      Y   X   Y +-99 +-99      
      CLOSEST    F1  Focal +-99   X   Y   +X   +z     0
      
      
      (Singleton 6 of 8)
                            L1g  L2a  L2b  L3a L3b score
      SINGLETON  C5  Bad      Y +-99 +-99 +-99   Y      
      CLOSEST    F1  Focal +-99   +X   +Y   +X  *z     0
      
      
      (Singleton 7 of 8)
                            L1g  L2a  L2b  L3a  L3b score
      SINGLETON  C6  Bad      Y +-99 +-99 +-99 +-99      
      CLOSEST    F1  Focal +-99   +X   +Y   +X   +z     0
      
      
      (Singleton 8 of 8)
                            L1g  L2a  L2b  L3a  L3b score
      SINGLETON  C7  Bad   +-99 +-99 +-99 +-99 +-99      
      CLOSEST    F1  Focal +-99   +X   +Y   +X   +z     0
      
      
      (Singletons END)
      
      
      (Unique genotypes)
                           L1g L2a L2b L3a L3b
      SINGLETON  C1  Good  -99   X   Y   X   Y
      SINGLETON  C2  Good  -99   X -99   X -99
      SINGLETON  C3  Bad     Y -99 -99   X   Y
      SINGLETON  C4  Bad     Y   X   Y -99 -99
      SINGLETON  C5  Bad     Y -99 -99 -99   Y
      SINGLETON  C6  Bad     Y -99 -99 -99 -99
      SINGLETON  C7  Bad   -99 -99 -99 -99 -99
      SINGLETON  F1  Focal -99   X   Y   X   z

---

    Code
      # Here minComparableLoci = 0 => Backwards compatible with allelematch 2.5.4.
      #  
      # Here all genotypes are comparable with each other and we get backward
      # compatible number of matches:
      #  
      # Note that C7 with all NA/-99 data scores pretty high:
      #  
      summary.amCluster(clu_0 <- amCluster(ds, minComparableLoci = 0))
    Output
      allelematch
      amCluster object
      
      Focal dataset N=8
      Unique genotypes (total): 3
      Unique genotypes (by cluster consensus): 0
      Unique genotypes (singletons): 3
      
      Missing data represented by: -99
      Missing data matching method: 2
      Clustered genotypes consensus method: 1
      Hierarchical clustering method: complete
      Dynamic tree cutting height (cutHeight): 0.3
      
      Run until only singletons: TRUE
      Runs: 3
      
      Score flags:
      *101 Allele does not match
      +101 Allele is missing
      [101] Allele is interpolated in consensus from non-missing cluster members (consensusMethod = 2, 4 only)
      
      (Singleton 1 of 3)
                            L1g L2a L2b  L3a  L3b score
      SINGLETON  C4  Bad      Y   X   Y +-99 +-99      
      CLOSEST    F1  Focal +-99   X   Y   +X   +z   0.7
      
      
      (Singleton 2 of 3)
                            L1g L2a L2b  L3a  L3b score
      SINGLETON  F1  Focal +-99   X   Y    X    z      
      CLOSEST    C4  Bad     +Y   X   Y +-99 +-99   0.7
      
      
      (Singleton 3 of 3)
                         L1g  L2a  L2b  L3a  L3b score
      SINGLETON  C3  Bad   Y +-99 +-99    X    Y      
      CLOSEST    C4  Bad   Y   +X   +Y +-99 +-99   0.6
      
      
      (Singletons END)
      
      
      (Unique genotypes)
                           L1g L2a L2b L3a L3b
      SINGLETON  C3  Bad     Y -99 -99   X   Y
      SINGLETON  C4  Bad     Y   X   Y -99 -99
      SINGLETON  F1  Focal -99   X   Y   X   z

---

    Code
      # Here minComparableLoci = 2 => genotype C3 to c7 are incomparable towards F1,
      # => 100% dissimilarity => C3 to C7 are removed from the list of matches.
      #  
      # Note that the comparable genotypes (C1 and C2, tagged 'Good') still
      # get the same matching score compared to the abowe backwards compatible run 
      # where minComparableLoci = 0:
      #  
      summary.amCluster(clu_2 <- amCluster(ds, minComparableLoci = 2))
    Output
      allelematch
      amCluster object
      
      Focal dataset N=8
      Unique genotypes (total): 5
      Unique genotypes (by cluster consensus): 0
      Unique genotypes (singletons): 5
      
      Missing data represented by: -99
      Missing data matching method: 2
      Clustered genotypes consensus method: 1
      Hierarchical clustering method: complete
      Dynamic tree cutting height (cutHeight): 0.3
      
      Run until only singletons: TRUE
      Runs: 2
      
      Score flags:
      *101 Allele does not match
      +101 Allele is missing
      [101] Allele is interpolated in consensus from non-missing cluster members (consensusMethod = 2, 4 only)
      
      (Singleton 1 of 5)
                         L1g  L2a  L2b L3a L3b score
      SINGLETON  C3  Bad   Y +-99 +-99   X   Y      
      CLOSEST    C3  Bad   Y +-99 +-99   X   Y     0
      
      
      (Singleton 2 of 5)
                         L1g  L2a  L2b  L3a  L3b score
      SINGLETON  C4  Bad   Y    X    Y +-99 +-99      
      CLOSEST    C3  Bad   Y +-99 +-99   +X   +Y     0
      
      
      (Singleton 3 of 5)
                         L1g  L2a  L2b  L3a  L3b score
      SINGLETON  C6  Bad   Y +-99 +-99 +-99 +-99      
      CLOSEST    C3  Bad   Y +-99 +-99   +X   +Y     0
      
      
      (Singleton 4 of 5)
                          L1g  L2a  L2b  L3a  L3b score
      SINGLETON  C7  Bad +-99 +-99 +-99 +-99 +-99      
      CLOSEST    C3  Bad   +Y +-99 +-99   +X   +Y     0
      
      
      (Singleton 5 of 5)
                            L1g  L2a  L2b L3a L3b score
      SINGLETON  F1  Focal +-99    X    Y   X   z      
      CLOSEST    C3  Bad     +Y +-99 +-99   X  *Y     0
      
      
      (Singletons END)
      
      
      (Unique genotypes)
                           L1g L2a L2b L3a L3b
      SINGLETON  C3  Bad     Y -99 -99   X   Y
      SINGLETON  C4  Bad     Y   X   Y -99 -99
      SINGLETON  C6  Bad     Y -99 -99 -99 -99
      SINGLETON  C7  Bad   -99 -99 -99 -99 -99
      SINGLETON  F1  Focal -99   X   Y   X   z

