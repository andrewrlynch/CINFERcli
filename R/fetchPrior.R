#' Fetch prior data
#'
#' @description
#' Fetches prior data set from CINFERbase given default or user-specified parameters. Downloads the latest CINFERbase release if not present.
#'
#' @param steps The range of time steps to include in the prior data. Defaults to "all".
#' @param rate The range of mis-segregation rates to include in the prior data. Defaults to "all".
#' @param pressure The range of selection pressure magnitudes to include in the prior data. Defaults to "all".
#' @param forceDownload Force download the specified CINFERbase version.
#' @param version The version of CINFERbase to download and/or use. Defaults to "latest".
#' @importFrom data.table fread
#' @importFrom piggyback pb_download
#' @export
fetchPrior <- function(
    steps = "all",
    rate = "all",
    pressure = "all",
    forceDownload = FALSE,
    version = "latest"
    ){
  ## Check file exists or download
  fileList = list.files()
  Cb = fileList[grepl("CINFERbase", fileList)]
  fileExists = ifelse(length(Cb) == 0, 0, 1)
  downloadFlag = 0

  if(fileExists == T){
    print("CINFERbase located on disk.")
  } else {
    print(paste("CINFERbase not found. Downloading", version, "CINFERbase release from GitHub repo."))
    piggyback::pb_download(repo="andrewrlynch/CINFERcli", tag=version, dest=".", overwrite = TRUE)
    downloadFlag = 1
  }

  if((fileExists == FALSE | forceDownload == TRUE) & downloadFlag == 0){
    print(paste("Downloading", version, "CINFERbase release from GitHub repo."))
    piggyback::pb_download(repo="andrewrlynch/CINFERcli", tag=version, dest=".", overwrite = TRUE)
  }

  ## Load prior data
  fileList = list.files()
  Cb = fileList[grepl("CINFERbase", fileList)]

  print(paste0("Loading... (", Cb, ")"))
  CINFERprior = data.table::fread(Cb, header = T)

  if(any(steps == "all")){
    print("Using all time steps.")
    } else {
      print(paste0("Using time steps: ", rate[1], "-", rate[2]))
      CINFERprior = CINFERprior[CINFERprior$Step >= steps[1] & CINFERprior$Step <= steps[2],]
    }

  if(any(rate == "all")){
    print("Using all rate values.")
  } else {
    print(paste0("Using pressure: ", rate[1], "-", rate[2]))
    CINFERprior = CINFERprior[CINFERprior$Step >= rate[1] & CINFERprior$Step <= rate[2],]
  }

  if(any(pressure == "all")){
    print("Using all pressure values.")
  } else {
    print(paste0("Using pressure: ", pressure[1], "-", pressure[2]))
    CINFERprior = CINFERprior[CINFERprior$Step >= pressure[1] & CINFERprior$Step <= pressure[2],]
  }

  return(CINFERprior)
}
