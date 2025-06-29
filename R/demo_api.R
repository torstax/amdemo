###############################################################################
### allelematch test engine ###
###############################################################################

#### demoVersion ####
#' Returns package version
#'
#' @description
#' Displays version of this package ([amdemo]) and of [allelematch],
#' together with build timestamps.\cr
#' \cr
#' The version is specified in the file DESCRIPTION, tag "Version: ".\cr
#' \cr
#' Note that installing a package from source (like e.g. [allelematch]
#' it will show a build timestamp from the installation, not from when
#' it was published.
#'
#' @description
#' Returns version of this package ([amdemo]).\cr
#' \cr
#' The version is specified in the file DESCRIPTION, tag "Version: ".
#'
#' @param verbose logical. If TRUE (the default), prints additional info to stdout, including version of [allelematch-package]
#'
#' @return The installed version of this package ([amdemo-package]) in a character vector of length one
#'
#' @examples
#' # See what version of packages 'allelematch' and 'amdemo'
#' # are currently installed:
#' demoVersion()
#'
#' # List the available demo tests:
#' demoList()
#' \donttest{
#' # Run all the demo tests:
#' # demoRun()  # Takes several minutes
#'
#' # Run the first of the available demo testss:
#' demoRun(filter="allelematch_1-amDataset$")
#' }
#'
#'
#' @seealso [demoList], [demoRun] and [amdemo]
#' @export
demoVersion <- function(packages = c("amdemo", "amregtest", "allelematch"), verbose=TRUE) {
    stopifnot(is.logical(verbose))

    library(allelematch) # Loaded here rather than in the "Imports:" section of DESCRIPTION file

    for (pkg in packages) {
        getPackageVersion(pkg)
    }
    return(invisible(toString(utils::packageVersion("amdemo"))))
}

# Trivial internal utility to retrieve and format the currently loaded version of
# a package as a string
getPackageVersion <- function(packageName) {
    loadedVersion = toString(utils::packageVersion(packageName))

    cat(sprintf("\n    Version of package %-12s is: %-10s %s",
                packageName,
                loadedVersion,
                builtAt(packageName)))
    return(invisible(loadedVersion))
}


# Internal utility function to print the build time for a package:
builtAt <- function(pkg) {

    if (!is.null(built <- packageDescription(pkg)$Built)) {
        # Extract the timestamp string (third semicolon-separated field)
        fields <- strsplit(built, ";")[[1]]
        if (length(fields) < 3) return("(??Bad Build date??)")

        action <- "(Built "
        timestamp_str <- trimws(fields[3])
    }

    # Convert to POSIXct, assuming string is UTC unless otherwise specified
    ctBuildTime <- as.POSIXct(timestamp_str, tz = "UTC")

    # Was the build made today?
    form <- ifelse(as.Date(ctBuildTime, tz = Sys.timezone()) == Sys.Date(),
                   "%H:%M",  # Was build today. Use timestamp.
                   "%Y-%m-%d")  # Was built some othre day. Use date

    # Convert to local time zone, time or date:
    paste(action, format(ctBuildTime, format=form, tz = Sys.timezone()),")", sep="")
}


#### demoList ####
#' Lists available tests in `amdemo` without running them
#'
#' @description
#' Use the output to select a value for parameter `filter` to [demoRun].
#' Useful when debugging.
#'
#' @param verbose logical. If TRUE (the default), prints additional info to stdout
#'
#' @return A character vector containing the names of all the tests
#'
#' @examples
#' # See what version of packages 'allelematch' and 'amdemo'
#' # are currently installed:
#' demoVersion()
#'
#' # List the available tests:
#' demoList()
#' \donttest{
#' # Run all the tests:
#' # demoRun()  # Takes several minutes
#'
#' # Run the first of the available tests:
#' demoRun(filter="allelematch_1-amDataset$")
#' }
#'
#' @seealso [demoVersion] and [demoRun]
#'
#' @export
demoList <- function(verbose=TRUE) {
    stopifnot(is.logical(verbose))

    root = paste(system.file(package = "amdemo"), "tests/testthat/", sep="/")

    all = gsub("^test-(.+?)\\.R", "\\1", grep("^test-.+?\\.R", list.files(root), value=TRUE), perl=TRUE)

    if (verbose) {
        cat('\nTests in files under "', root, '":\n', sep="")

        cat("\nTests by functions in allelematch:\n")
        print(grep("^allelematch", all, value=TRUE, perl=TRUE), width=50)

        cat("\nReproduction of the examples in 'allelematchSuppDoc.pdf':\n")
        print(grep("^amExample", all, value=TRUE, perl=TRUE))

        cat("\nOther:\n")
        print(grep("^allelematch|^amExample", all, value=TRUE, invert=TRUE, perl=TRUE))
        cat("\n")
    }

    return(invisible(all))
}


#### demoRun ####
#' Runs the regression test
#'
#' @description
#' Runs regression tests on package [allelematch] to make sure it is backwards compatible.\cr
#' \cr
#' The full set of tests will take a couple of minutes. \cr
#' \cr
#' Call [demoList] to see the available tests with without running them.
#'
#' @return A list (invisibly) containing data about the test results as returned by [testthat::test_package]
#'
#' @details
#' If any of the test executed with [demoRun] should fail, then we want to be able
#' to run that specific test under the debugger.\cr
#' \cr
#' Set a breakpoint in `allelematch.R` and call `demoRun(filter="<the test that reproduces the problem>")`\cr
#' \cr
#' Note that it is the last installed version of `allelematch` that will be executed,
#' not the last edited. In RStudio, CTRL+SHIFT+B will build and install.
#'
#'
#' @param filter    If specified, only tests with names matching this perl regular
#'                  expression will be executed. Character vector of length 1. See also [demoList]
#' @param verbose   logical. If TRUE (the default), prints version of tested allelematch to stdout
#'
#' @examples
#' # See what version of packages 'allelematch' and 'amdemo'
#' # are currently installed:
#' demoVersion()
#'
#' # List the available tests:
#' demoList()
#' \donttest{
#' # Run all the tests:
#' # demoRun()  # Takes several minutes
#'
#' # Run the first of the available tests:
#' demoRun(filter="allelematch_1-amDataset$")
#' }
#'
#' @seealso [demoVersion] and [demoList]
#'
#' @export
demoRun <- function(filter="", verbose=TRUE) {
    stopifnot(is.character(filter) && length(filter)==1)
    stopifnot(is.logical(verbose))

    installedVersion = toString(utils::packageVersion("allelematch"))
    if (verbose) cat("    About to test installed version of allelematch:  <<<", installedVersion, ">>>\n", sep="")
    reporter <- ifelse(verbose, "Progress", testthat::check_reporter())
    result = list()
    if (filter != "^$") result = testthat::test_package("amdemo", reporter=reporter , filter=filter) # We can't start tests recursively, even for coverage tests
    if (verbose) cat("    Done testing installed version of allelematch:  <<<", installedVersion, ">>>\n", sep="")
    return(invisible(result))
}



#' Installs one of the official versions of 'allelematch' from CRAN.
#'
#' @description
#' TBD\cr
#' \cr
#' TBD
#'
#' @param version. Default "2.5.4".
#'
#' @return TBD
#'
#' @examples
#' # Install the default official version of 'allelematch' from CRAN:
#' ttInstallCranAllelematch()
#'
#' # Install another official version of 'allelematch' from CRAN:
#' ttInstallCranAllelematch("2.5.3")
#'
#'
#' @seealso [demoVersion] and [amamdemo]
#' @export
demoInstallCranAllelematch <- function(version = "2.5.4") {
    # install.packages("remotes") # Requires restarting R
    library(remotes)
    remotes::install_version("allelematch", version = version, repos = "http://cran.r-project.org")
}
