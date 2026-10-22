# Custom output hook: not currently used by any chapter (no chunk sets
# `results: "inlist"`), kept as a template in case a chapter wants a
# data-frame result rendered as an indented markdown table in the future.

# Step 1: Store the original output hook
original_output_hook <- knitr::knit_hooks$get("output")

# Step 2: Define the custom output hook
knitr::knit_hooks$set(output = function(x, options) {

  # Check if the results option is "inlist"
  if (options$results == "inlist") {
    # Try to evaluate the output to check if it returns a data frame
    result <- try(eval(parse(text = x)), silent = TRUE)

    # If the result is a data frame, use knitr::kable to print it
    if (inherits(result, "data.frame")) {
      kable_output <- knitr::kable(result, format = "markdown")
      options$results <- "asis"
      return(original_output_hook(kable_output, options))
    } else {
      # If it's not a data frame but "inlist" is specified, return as-is
      options$results <- "asis"
      options$highlight <- FALSE  # Disable syntax highlighting
      options$indent <- ""        # Clear indentation
      return(original_output_hook(x, options))
    }
  }

  # Fallback to the original output hook behavior
  return(original_output_hook(x, options))
})
