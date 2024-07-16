require("luasnip.session.snippet_collection").clear_snippets("r")

local luasnip = require("luasnip")

local s = luasnip.snippet
local t = luasnip.text_node
local i = luasnip.insert_node

luasnip.add_snippets("r", {
  s("temptable", {
    i(1),
    t(" <- list(set_iso_lvl = glue::glue('SET TRANSACTION ISOLATION LEVEL READ UNCOMMITED;'), "),
    i(2),
    t(' = glue::glue("'),
    i(3),
    t('"),))'),
  }),
})
