#' Run CINFER to infer mis-segregation rates.
#'
#' @description
#' Top level controller script to run CINFER. Handles input data, fetches prior data from CINFERbase, and runs approximate Bayesian computation inference of mis-segregation rates.
#' @export
cinfer <- function(){

## Options ----------------------------------------------------------------
# --steps
# --rate
# --pressure
# --steps

## Input -------------------------------------------------------------------
### Load input -------------------------------------------------------------
### Normalize chromosomes --------------------------------------------------
### Calculate summary statistics -------------------------------------------

## Prior -------------------------------------------------------------------
CINFERprior <- fetchPrior()

## ABC ---------------------------------------------------------------------

### Select summary statistics ----------------------------------------------
### Run ABC ----------------------------------------------------------------

## Output ------------------------------------------------------------------
### Generate tables --------------------------------------------------------
### Generate plots ---------------------------------------------------------
}
