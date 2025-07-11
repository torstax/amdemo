######################################
### Helper functions for the tests ###
######################################

# We load the allelematch package dynamically to avoid reload deadlocks
# at rebuilds. These deadlocks are caused by static 'import' statements:
library(allelematch)

# Turns `...` into a string of <name>=<value> pairs:
helpArgToString <- function(...) {
  # form the `...` arguments into a string on the form "<name1>=<value1>, <name2>=<value2> ..."
  v = character(...length()) # Reserve space for a vector of strings

  # Paste together <name>=<value> pairs.
  # the <name> comes from `...names()[n]`. The <value> comes from `...elt(n)`
  # for(n in 1:...length()) v[n] = paste(...names()[n], format(...elt(n)), sep="=")
  for(n in 1:...length()) v[n] = paste(...names()[n], deparse(...elt(n)), sep="=")

  # Remove spurious empty pairs from the vector:
  v = v[! v == "=NULL"]

  # Return a string were the pairs are ", " -separated:
  ret = paste(v, collapse=", ")

  return(ret)
}

