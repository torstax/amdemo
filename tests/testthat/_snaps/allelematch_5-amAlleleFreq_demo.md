# Demo minComparableLoci for amAlleleFreq()

    Code
      # The new parameter minComparableLoci has no effect on amAlleleFreq().
      #  
      # There is therefore not really need for any demonstration. But you'll get a short one anyway.
      #  
      # amAlleleFreq() determines the allele frequencies for each locus in a
      # multilocus genetic dataset by first removing missing observations.
      #  
      library(allelematch)

---

    Code
      # Get the six first columns and 10 first rows from an allelematch example:
      # Here of 4 data columns consisting of 2 loci with 2 alleles each
      #  
      sample <- amExample1[1:10, 1:6]
      ds <- amDataset(sample, indexColumn = 1, metaDataColumn = 2, lociMap = TRUE)
      print(ds, verbose = TRUE)
    Output
      allelematch
      amDataset object
         MissingCode: -99
         lociMap    : (1, 1, 2, 2)
              LOC1a LOC1b LOC2a LOC2b
      1   AAA   103   108   201   201
      2   AAA   103   108   201   201
      3   AAB   104   120   201   208
      4   AAB   104   120   201   208
      5   AAC   103   109   201   209
      6   AAC   103   109   201   209
      7   AAD   108   109   201   208
      8   AAE   104   110   207   208
      9   AAF   109   120   208   208
      10  AAF   109   120   208   208

---

    Code
      # Calculate the allele frequencies for these 2 loci:
      #  
      # Note that we have the lociMap in the amDataset 'ds'.
      #  
      print(f <- amAlleleFreq(ds))
    Output
      allelematch
      amAlleleFreq object
      Frequencies calculated after removal of missing data
      
      LOC1a-LOC1b (6 alleles)
      	Allele	 109 	 0.25 
      	Allele	 103 	 0.2 
      	Allele	 120 	 0.2 
      	Allele	 104 	 0.15 
      	Allele	 108 	 0.15 
      	Allele	 110 	 0.05 
      
      LOC2a-LOC2b (4 alleles)
      	Allele	 201 	 0.45 
      	Allele	 208 	 0.4 
      	Allele	 209 	 0.1 
      	Allele	 207 	 0.05 

