# not currently using this, but leaving in case want a template for the future...


# Step 1: Store the original output hook
original_output_hook <- knitr::knit_hooks$get("output")

# Step 2: Define the custom output hook
knitr::knit_hooks$set(output = function(x, options) {

  chunk_number <- as.numeric(gsub("unnamed-chunk-", "", options$label))
  print(paste("chunk number: ", chunk_number))
  print(options$label)
  print("brant")
  if (chunk_number == 71) {
    cat("Debug Info for Chunk 71:\n")
    print(x)
    print(options)
  }

  # Check if the results option is "inlist"
  if (options$results == "inlist") {
    # Try to evaluate the output to check if it returns a data frame
    result <- try(eval(parse(text = x)), silent = TRUE)
    
    # If the result is a data frame, use knitr::kable to print it with indentation
    if (inherits(result, "data.frame")) {
      kable_output <- knitr::kable(result, format = "markdown")
      # Add indentation to the kable output
      # indented_output <- paste0("    ", gsub("\n", "\n    ", kable_output))
      options$results <- "asis"
      return(original_output_hook(kable_output, options))
    } else {
      # If it's not a data frame but "inlist" is specified, return the output as-is
      # return(knitr::asis_output(x))
      # print(options)
      # print("*********")
      # print(x)
      options$results <- "asis"
      options$highlight <- FALSE  # Disable syntax highlighting
      options$indent <- ""        # Clear indentation
      print(x)
      print(options)
      return(original_output_hook(x, options))
    }
  }

  # Fallback to the original output hook behavior
  return(original_output_hook(x, options))
})
