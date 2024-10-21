function include_if_html(args, kwargs)
  -- Check if the output format is HTML
  if quarto.doc.is_format("html") then
    -- Read the contents of latex-commands.txt
    local file = io.open("latex-commands.txt", "r")
    if file then
      local content = file:read("*all")
      file:close()
      return pandoc.RawBlock('html', content)
    else
      -- Handle the case where the file is not found
      return pandoc.RawBlock('html', "<!-- latex-commands.txt not found -->")
    end
  end
  -- If not HTML, return nothing
  return ""
end