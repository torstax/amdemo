# Demo minComparableLoci for amUniqueProfile() when plotting from amExample5 data

    Code
      # The new parameter minComparableLoci is demonstrated in the tests below.
      #  
      # minComparableLoci is here passed to the function amUniqueProfile().
      #  
      # amUniqueProfile() automatically runs amUnique() at a sequence of parameter values
      # to determine an optimal setting, and optionally plot the result.
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
      # About to make the following call to generate a plot
      # under ./_snaps/allelematch_7-amUniqueProfile_demo/*.png
      cmdstr
    Output
      [1] "e5_0 <- amUniqueProfile(amDataExemple5, doPlot=TRUE, verbose=FALSE)"

---

    Code
      # Generate a backwards compatible plot (i.e. minComparableLoci=0) of amExemple5.
      # 
      # Interpret 'e5_0' like this: 'e5' for dataset from 'amExample5' and '0' for 'minComparableLoci=0'.
      # 'amExample5' is the allelematch built-in wild-life example with low data quality.
      #  
      # The function 'printMost()' below prints all columns in the data.frame
      # that is returned by amUniqueProfile(), excep for columns 'matchThreshold'
      # and 'cutHeight'. These are deamed unnecessary when we have column 'alleleMatch'.
      # 
      printMost(e5_0)
    Output
      
       alleleMismatch samples unique unclassified multipleMatch guessOptimum missingDataLoad allelicDiversity      guessMorphology
                    0     335    265            0             0        FALSE           0.095              6.1 NonZeroSecondMinimum
                    1     335    240            0            79        FALSE           0.095              6.1 NonZeroSecondMinimum
                    2     335    195            1            57        FALSE           0.095              6.1 NonZeroSecondMinimum
                    3     335    171            3            11         TRUE           0.095              6.1 NonZeroSecondMinimum
                    4     335    155            1            41        FALSE           0.095              6.1 NonZeroSecondMinimum
                    5     335    141            1            62        FALSE           0.095              6.1 NonZeroSecondMinimum
                    6     335    115            2           123        FALSE           0.095              6.1 NonZeroSecondMinimum
                    7     335     84           17            70        FALSE           0.095              6.1 NonZeroSecondMinimum
                    8     335     45           26           176        FALSE           0.095              6.1 NonZeroSecondMinimum

---

    Code
      # About to make the following call to generate a plot
      # under ./_snaps/allelematch_7-amUniqueProfile_demo/*.png
      cmdstr
    Output
      [1] "e5_8 <- amUniqueProfile(amDataExemple5, minComparableLoci=8, doPlot=TRUE, verbose=FALSE)"

---

    Code
      # Generate a plot where 8 of the 11 loci must be comparable (i.e. minComparableLoci=8).
      # 
      # Note that the resulting plot is still quite similar to that of the
      # backwards compatible, 'e5_0' above.
      # 
      printMost(e5_8)
    Output
      
       alleleMismatch samples unique unclassified multipleMatch guessOptimum missingDataLoad allelicDiversity      guessMorphology
                    0     335    265            0             0        FALSE           0.095              6.2 NonZeroSecondMinimum
                    1     335    240            0            79        FALSE           0.095              6.2 NonZeroSecondMinimum
                    2     335    195            1            55        FALSE           0.095              6.2 NonZeroSecondMinimum
                    3     335    172            3            11         TRUE           0.095              6.2 NonZeroSecondMinimum
                    4     335    158            5            22        FALSE           0.095              6.2 NonZeroSecondMinimum
                    5     335    153            1            75        FALSE           0.095              6.2 NonZeroSecondMinimum
                    6     335    127            2           126        FALSE           0.095              6.2 NonZeroSecondMinimum
                    7     335     92           13            72        FALSE           0.095              6.2 NonZeroSecondMinimum
                    8     335     54           21           187        FALSE           0.095              6.2 NonZeroSecondMinimum

---

    Code
      # About to make the following call to generate a plot
      # under ./_snaps/allelematch_7-amUniqueProfile_demo/*.png
      cmdstr
    Output
      [1] "e5_9 <- amUniqueProfile(amDataExemple5, minComparableLoci=9, doPlot=TRUE, verbose=FALSE)"

---

    Code
      # Generate a plot where 9 of the 11 loci must be comparable (i.e. minComparableLoci=9).
      # 
      printMost(e5_9)
    Output
      
       alleleMismatch samples unique unclassified multipleMatch guessOptimum missingDataLoad allelicDiversity      guessMorphology
                    0     335    266            0             1        FALSE           0.095              6.4 NonZeroSecondMinimum
                    1     335    243            0            64        FALSE           0.095              6.4 NonZeroSecondMinimum
                    2     335    203            1             8         TRUE           0.095              6.4 NonZeroSecondMinimum
                    3     335    200            2             9        FALSE           0.095              6.4 NonZeroSecondMinimum
                    4     335    192            4            17        FALSE           0.095              6.4 NonZeroSecondMinimum
                    5     335    177            7            26        FALSE           0.095              6.4 NonZeroSecondMinimum
                    6     335    160            5            82        FALSE           0.095              6.4 NonZeroSecondMinimum
                    7     335    134           11            57        FALSE           0.095              6.4 NonZeroSecondMinimum
                    8     335     96           29           148        FALSE           0.095              6.4 NonZeroSecondMinimum

---

    Code
      # About to make the following call to generate a plot
      # under ./_snaps/allelematch_7-amUniqueProfile_demo/*.png
      cmdstr
    Output
      [1] "e5_10 <- amUniqueProfile(amDataExemple5, minComparableLoci=10, doPlot=TRUE, verbose=FALSE)"

---

    Code
      # Generate a plot where 10 of the 11 loci must be comparable (i.e. minComparableLoci=10).
      # 
      printMost(e5_10)
    Output
      
       alleleMismatch samples unique unclassified multipleMatch guessOptimum missingDataLoad allelicDiversity      guessMorphology
                    0     335    281            0             1        FALSE           0.095              6.8 NonZeroSecondMinimum
                    1     335    262            2             3        FALSE           0.095              6.8 NonZeroSecondMinimum
                    2     335    258            0             2        FALSE           0.095              6.8 NonZeroSecondMinimum
                    3     335    256            2             1         TRUE           0.095              6.8 NonZeroSecondMinimum
                    4     335    250            2             5        FALSE           0.095              6.8 NonZeroSecondMinimum
                    5     335    243            1             9        FALSE           0.095              6.8 NonZeroSecondMinimum
                    6     335    227            2            26        FALSE           0.095              6.8 NonZeroSecondMinimum
                    7     335    219            2            26        FALSE           0.095              6.8 NonZeroSecondMinimum
                    8     335    179           14            45        FALSE           0.095              6.8 NonZeroSecondMinimum

---

    Code
      # About to make the following call to generate a plot
      # under ./_snaps/allelematch_7-amUniqueProfile_demo/*.png
      cmdstr
    Output
      [1] "e5_11 <- amUniqueProfile(amDataExemple5, minComparableLoci=11, doPlot=TRUE, verbose=FALSE)"

---

    Code
      # Finally generate a plot where all 11 loci must be comparable (i.e. minComparableLoci=11)
      # 
      printMost(e5_11)
    Output
      
       alleleMismatch samples unique unclassified multipleMatch guessOptimum missingDataLoad allelicDiversity guessMorphology
                    0     335    319            0             1        FALSE           0.095              6.8 NoSecondMinimum
                    1     335    318            0             1        FALSE           0.095              6.8 NoSecondMinimum
                    2     335    317            0             1         TRUE           0.095              6.8 NoSecondMinimum
                    3     335    317            0             1        FALSE           0.095              6.8 NoSecondMinimum
                    4     335    316            0             1        FALSE           0.095              6.8 NoSecondMinimum
                    5     335    316            0             1        FALSE           0.095              6.8 NoSecondMinimum
                    6     335    313            0             1        FALSE           0.095              6.8 NoSecondMinimum
                    7     335    313            0             1        FALSE           0.095              6.8 NoSecondMinimum
                    8     335    299            1            11        FALSE           0.095              6.8 NoSecondMinimum

# Demo minComparableLoci for amUniqueProfile() on loci with two alleles each

    Code
      # We first create the same mini sample that was used with the amUnique() demo.
      #  
      # With amUnique we could see some effect of minComparableLoci,
      # but here not so much. We leave it in anyway for reference.
      #  
      print.amDataset(ds <- amDataset(sample, indexColumn = 1, metaDataColumn = 2,
        lociMap = TRUE), verbose = TRUE)
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
      # Here minComparableLoci = 3 => No genotypes are comparable.
      # This means that all genotype gets 100% dissimilarity towards all others:
      #  
      # The function 'printMost() below prints all columns in the data.frame
      # that is returned by amUniqueProfile(), excep for columns 'matchThreshold'
      # and 'cutHeight'. These are deamed unnecessary when we have column 'alleleMatch'.
      #  
      printMost(u_3 <- amUniqueProfile(ds, minComparableLoci = 3, doPlot = FALSE,
        verbose = FALSE))
    Output
      
       alleleMismatch samples unique unclassified multipleMatch guessOptimum missingDataLoad allelicDiversity guessMorphology
                    0       3      3            0             1        FALSE           0.333              2.3 NoSecondMinimum
                    1       3      3            0             1         TRUE           0.333              2.3 NoSecondMinimum
                    2       3      3            0             1        FALSE           0.333              2.3 NoSecondMinimum

---

    Code
      # Here minComparableLoci = 0 => Backwards compatible with allelematch 2.5.4.
      #  
      # Here all genotypes are comparable with each other:
      #  
      printMost(u_0 <- amUniqueProfile(ds, minComparableLoci = 0, doPlot = FALSE,
        verbose = FALSE))
    Output
      
       alleleMismatch samples unique unclassified multipleMatch guessOptimum missingDataLoad allelicDiversity   guessMorphology
                    0       3      3            0             0        FALSE           0.333              2.3 ZeroSecondMinimum
                    1       3      3            0             2        FALSE           0.333              2.3 ZeroSecondMinimum
                    2       3      2            0             0         TRUE           0.333              2.3 ZeroSecondMinimum

---

    Code
      # Here minComparableLoci = 2 => genotype C2 is incomparable towards the other genotypes
      # (dissimilarity == 1 == 100%)
      #  
      # Note that the the dissimilarities between the other genotypes remain the same
      # compared to the abowe run where minComparableLoci = 0:
      #  
      printMost(u_2 <- amUniqueProfile(ds, minComparableLoci = 2, doPlot = FALSE,
        verbose = FALSE))
    Output
      
       alleleMismatch samples unique unclassified multipleMatch guessOptimum missingDataLoad allelicDiversity   guessMorphology
                    0       3      3            0             0        FALSE           0.333              2.3 ZeroSecondMinimum
                    1       3      3            0             2        FALSE           0.333              2.3 ZeroSecondMinimum
                    2       3      2            0             0         TRUE           0.333              2.3 ZeroSecondMinimum

