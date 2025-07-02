# Demo minComparableLoci for amPairwise() on loci with two alleles each

    Code
      # The new parameter minComparableLoci is demonstrated in the tests below.
      #  
      # minComparableLoci is here passed to the function amPairwise().
      #  
      # amPairwise() performs a pairwise matching analysis of a focal 
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
      # We first create a minimal focal data set with one genotype row (F1)
      # and 6 allele columns.
      #  
      # The alleles are grouped pairwise in three loci (L1, L2 and L3).
      #  
      # The focal genotype F1 has one incomparable locus: L1. This is because 
      # both alleles L1a and L1b have NA data (coded as -99).
      #  
      print.amDataset(focal <- amDataset(sample, indexColumn = 1, metaDataColumn = 2))
    Output
      allelematch
      amDataset object
                L1a L1b L2a L2b L3a L3b
      F1  Focal -99 -99   X   Y   X   z

---

    Code
      # We then create another minimal data set for the comparison genotypes.
      #  
      # Genotypes C1 has the one incomparable locus: L1. This is the sama as for
      # the focal genotype F1.
      #  
      # Genotype C2 also has one incomparable locus: L2
      #  
      # When doing pairwise comparisons of the genotype rows, we can then see that
      # comparing F1 and C1 give one incomparable (and two comparable) loci
      # Whilst comparing F1 and C2 give two incomparable (and one comparable) loci
      #  
      print.amDataset(comparison <- amDataset(sample, indexColumn = 1,
        metaDataColumn = 2))
    Output
      allelematch
      amDataset object
               L1a L1b L2a L2b L3a L3b
      C1  Good -99 -99   X   Y   X   Y
      C2  Bad    X   Y -99 -99   X   Y

---

    Code
      # Here minComparableLoci = 3 => No genotypes are comparable.
      # This means that all genotype gets 0 matching score towards all others.
      # Therefore we don't find any matches:
      #  
      summary.amPairwise(pw_3 <- amPairwise(focal, comparison, matchThreshold = 0.5,
        minComparableLoci = 3))
    Output
      allelematch
      pairwise analysis
      
      focal dataset N=1
      comparison dataset N=2
      missing data represented by: -99
      missing data matching method: 2
      minComparableLoci (required for a match): 3
      alleleMismatch (m-hat; maximum number of mismatching alleles): 3
      matchThreshold (s-hat; lowest matching score returned): 0.5
      
      score flags:
      *101 allele does not match
      +101 allele is missing
      
      (1 of 1)
                          L1a  L1b L2a L2b L3a L3b score
      FOCAL  F1    Focal +-99 +-99   X   Y   X   z      
      MATCH  None                                       
      0 perfect matches found.  0 partial matches found.
      
      

---

    Code
      # Here minComparableLoci = 0 => Backwards compatible with allelematch 2.5.4.
      #  
      # Here all genotypes are comparable with each other and we get backward
      # compatible number of matches:
      #  
      summary.amPairwise(pw_0 <- amPairwise(focal, comparison, matchThreshold = 0.5,
        minComparableLoci = 0))
    Output
      allelematch
      pairwise analysis
      
      focal dataset N=1
      comparison dataset N=2
      missing data represented by: -99
      missing data matching method: 2
      alleleMismatch (m-hat; maximum number of mismatching alleles): 3
      matchThreshold (s-hat; lowest matching score returned): 0.5
      
      score flags:
      *101 allele does not match
      +101 allele is missing
      
      (1 of 1)
                        L1a  L1b  L2a  L2b L3a L3b score
      FOCAL  F1  Focal +-99 +-99    X    Y   X   z      
      MATCH  C1  Good  +-99 +-99    X    Y   X  *Y  0.83
      MATCH  C2  Bad     +X   +Y +-99 +-99   X  *Y   0.5
      0 perfect matches found.  2 partial matches found.
      
      

---

    Code
      # Here minComparableLoci = 2 => genotype C2 is incomparable towards F1 (and C2),
      # => 0 matching score => C2 is removed from the list of matches.
      #  
      # Note that the the the comparable genotypes (C1) still get the same matching score
      # compared to the abowe backwards compatible run where minComparableLoci = 0:
      #  
      summary.amPairwise(pw_2 <- amPairwise(focal, comparison, matchThreshold = 0.5,
        minComparableLoci = 2))
    Output
      allelematch
      pairwise analysis
      
      focal dataset N=1
      comparison dataset N=2
      missing data represented by: -99
      missing data matching method: 2
      minComparableLoci (required for a match): 2
      alleleMismatch (m-hat; maximum number of mismatching alleles): 3
      matchThreshold (s-hat; lowest matching score returned): 0.5
      
      score flags:
      *101 allele does not match
      +101 allele is missing
      
      (1 of 1)
                        L1a  L1b L2a L2b L3a L3b score
      FOCAL  F1  Focal +-99 +-99   X   Y   X   z      
      MATCH  C1  Good  +-99 +-99   X   Y   X  *Y  0.83
      0 perfect matches found.  1 partial matches found.
      
      

# Demo minComparableLoci for amPairwise() with first locus sigle-allele

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
      # We then create another minimal data set for the comparison genotypes.
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
      print.amDataset(comparison <- amDataset(sample, indexColumn = 1,
        metaDataColumn = 2, multilocusMap = c(1, 2, 2, 3, 3)))
    Output
      allelematch
      amDataset object
               L1g L2a L2b L3a L3b
      C1  Good -99   X   Y   X   Y
      C2  Good -99   X -99   X -99
      C3  Bad    Y -99 -99   X   Y
      C4  Bad    Y   X   Y -99 -99
      C5  Bad    Y -99 -99 -99   Y
      C6  Bad    Y -99 -99 -99 -99
      C7  Bad  -99 -99 -99 -99 -99

---

    Code
      # Here minComparableLoci = 3 => No genotypes are comparable.
      # This means that all genotype gets 0 matching score towards all others.
      # Therefore we don't find any matches:
      #  
      summary.amPairwise(pw_3 <- amPairwise(focal, comparison, matchThreshold = 0.5,
        minComparableLoci = 3))
    Output
      allelematch
      pairwise analysis
      
      focal dataset N=1
      comparison dataset N=7
      missing data represented by: -99
      missing data matching method: 2
      minComparableLoci (required for a match): 3
      alleleMismatch (m-hat; maximum number of mismatching alleles): 2.5
      matchThreshold (s-hat; lowest matching score returned): 0.5
      
      score flags:
      *101 allele does not match
      +101 allele is missing
      
      (1 of 1)
                          L1g L2a L2b L3a L3b score
      FOCAL  F1    Focal +-99   X   Y   X   z      
      MATCH  None                                  
      0 perfect matches found.  0 partial matches found.
      
      

---

    Code
      # Here minComparableLoci = 0 => Backwards compatible with allelematch 2.5.4.
      #  
      # Here all genotypes are comparable with each other and we get backward
      # compatible number of matches:
      #  
      # Note that C7 with all NA/-99 data scores pretty high:
      #  
      summary.amPairwise(pw_0 <- amPairwise(focal, comparison, matchThreshold = 0.5,
        minComparableLoci = 0))
    Output
      allelematch
      pairwise analysis
      
      focal dataset N=1
      comparison dataset N=7
      missing data represented by: -99
      missing data matching method: 2
      alleleMismatch (m-hat; maximum number of mismatching alleles): 2.5
      matchThreshold (s-hat; lowest matching score returned): 0.5
      
      score flags:
      *101 allele does not match
      +101 allele is missing
      
      (1 of 1)
                        L1g  L2a  L2b  L3a  L3b score
      FOCAL  F1  Focal +-99    X    Y    X    z      
      MATCH  C1  Good  +-99    X    Y    X   *Y   0.8
      MATCH  C2  Good  +-99    X +-99    X +-99   0.8
      MATCH  C4  Bad     +Y    X    Y +-99 +-99   0.7
      MATCH  C7  Bad   +-99 +-99 +-99 +-99 +-99   0.6
      MATCH  C3  Bad     +Y +-99 +-99    X   *Y   0.5
      MATCH  C6  Bad     +Y +-99 +-99 +-99 +-99   0.5
      0 perfect matches found.  6 partial matches found.
      
      

---

    Code
      # Here minComparableLoci = 2 => genotype C3 to C7 are incomparable towards F1,
      # => 0 matching score => C3 to C7 are removed from the list of matches.
      #  
      # Note that the comparable genotypes (C1 and C2, tagged 'Good') still
      # get the same matching score compared to the abowe backwards compatible run 
      # where minComparableLoci = 0:
      #  
      summary.amPairwise(pw_2 <- amPairwise(focal, comparison, matchThreshold = 0.5,
        minComparableLoci = 2))
    Output
      allelematch
      pairwise analysis
      
      focal dataset N=1
      comparison dataset N=7
      missing data represented by: -99
      missing data matching method: 2
      minComparableLoci (required for a match): 2
      alleleMismatch (m-hat; maximum number of mismatching alleles): 2.5
      matchThreshold (s-hat; lowest matching score returned): 0.5
      
      score flags:
      *101 allele does not match
      +101 allele is missing
      
      (1 of 1)
                        L1g L2a  L2b L3a  L3b score
      FOCAL  F1  Focal +-99   X    Y   X    z      
      MATCH  C1  Good  +-99   X    Y   X   *Y   0.8
      MATCH  C2  Good  +-99   X +-99   X +-99   0.8
      0 perfect matches found.  2 partial matches found.
      
      

