start_server <- function() {
    pr <- plumber::pr()
    pr$mount("/vpa", plumber::pr("R/vpa.R"))

    spec <- pr$getApiSpec()
    jsonlite::write_json(spec, "../../schema/openapi.json", pretty = TRUE)

    port <- Sys.getenv("PLUMBER_PORT")
    pr$run(port = port)
}
