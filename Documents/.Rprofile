transformers <- styler::tidyverse_style()
transformers$token$fix_quotes <- NULL
options(styler.cache_root = "styler-perm")

# Disable completion from the language server
# options(
#   languageserver.server_capabilities =
#     list(completionProvider = FALSE, completionItemResolve = FALSE)
# )
options(download.file.method = "auto", download.file.extra = "--ssl-revoke-best-effort")
options(repos = c(CRAN = "https://repo.miserver.it.umich.edu/cran/"))
