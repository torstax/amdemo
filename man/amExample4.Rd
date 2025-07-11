% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/demo_data.R
\docType{data}
\name{amExample4}
\alias{amExample4}
\title{Example 4 Low quality data set}
\format{
Data frame with samples in rows, and alleles in columns. Missing data is represented as "-99".
}
\description{
This is sample data copied from \link[allelematch:amExampleData]{allelematch::amExampleData} in version 5.2.1
of package \link{allelematch}. We use this data to test allelematch backwards compatibility.
}
\details{
For this example we have simulated a low quality data set where uncertainty created
by genotyping error and missing data, combined with a lack of information in the form
of allelic diversity across loci will result in a low confidence assessment of the unique
genotypes. At each locus a random 6\% of heterozygotes lost their second allele to
simulate an allele dropout, and a random 20\% of samples at each locus had alleles set
to missing.
}
\references{
\url{https://github.com/cran/allelematch}
}
\keyword{data}
