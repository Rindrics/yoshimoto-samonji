start_server <- function() {
    pr <- plumber::pr()
    pr$mount("/vpa", plumber::pr("R/vpa.R"))
    
    port <- Sys.getenv("PLUMBER_PORT")
    pr$run(port = port)
}
