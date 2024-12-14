-- Reset highlighting.
vim.cmd.highlight("clear")
if vim.fn.exists("syntax_on") then
  vim.cmd.syntax("reset")
end
vim.o.termguicolors = true
vim.g.colors_name = "miss-dracula"

local colors = {
  bg = "#212223",
  black = "#000000",
  bright_blue = "#93A3B5",
  bright_cyan = "#b1bec4",
  bright_green = "#2E5935",
  bright_clay = "#bf7256",
  muted_red = "#815c59",
  bright_white = "#FFFFFF",
  bright_yellow = "#BFBA75",
  comment = "#b8bfbf",
  blue = "#89a4bc",
  fg = "#F2E7C4",
  violet = "#754c5d",
  green = "#425b43",
  grey = "#b8bfbf",
  gutter_fg = "#4B5263",
  lavender = "#6272A4",
  lilac = "#3D3C59",
  menu = "#222126",
  the_sky = "#AAB7BF",
  nontext = "#3B4048",
  orange = "#a4715f",
  sand = "#9E916F",
  clay = "#BC6454",
  barnyard_red = "#8C5858",
  selection = "#70645C",
  transparent_black = "#1E1F29",
  transparent_earth = "#1c2a1f",
  transparent_green = "#22372c",
  transparent_red = "#342231",
  transparent_yellow = "#202624",
  visual = "#565161",
  white = "#e0dfd0",
  yellow = "#a7a766",
}

-- Terminal colors.
vim.g.terminal_color_0 = colors.transparent_black
vim.g.terminal_color_1 = colors.barnyard_red
vim.g.terminal_color_2 = colors.green
vim.g.terminal_color_3 = colors.yellow
vim.g.terminal_color_4 = colors.clay
vim.g.terminal_color_5 = colors.sand
vim.g.terminal_color_6 = colors.blue
vim.g.terminal_color_7 = colors.white
vim.g.terminal_color_8 = colors.selection
vim.g.terminal_color_9 = colors.muted_red
vim.g.terminal_color_10 = colors.bright_green
vim.g.terminal_color_11 = colors.bright_yellow
vim.g.terminal_color_12 = colors.bright_blue
vim.g.terminal_color_13 = colors.bright_clay
vim.g.terminal_color_14 = colors.bright_cyan
vim.g.terminal_color_15 = colors.bright_white
vim.g.terminal_color_background = colors.bg
vim.g.terminal_color_foreground = colors.fg

-- Groups used for my statusline.
---@type table<string, vim.api.keyset.highlight>
local statusline_groups = {}
for mode, color in pairs({
  Normal = "purple",
  Pending = "pink",
  Visual = "yellow",
  Insert = "green",
  Command = "cyan",
  Other = "orange",
}) do
  statusline_groups["StatuslineMode" .. mode] = { fg = colors.transparent_black, bg = colors[color] }
  statusline_groups["StatuslineModeSeparator" .. mode] = { fg = colors[color], bg = colors.transparent_black }
end
statusline_groups = vim.tbl_extend("error", statusline_groups, {
  StatuslineItalic = { fg = colors.grey, bg = colors.transparent_black, italic = true },
  StatuslineSpinner = { fg = colors.bright_green, bg = colors.transparent_black, bold = true },
  StatuslineTitle = { fg = colors.bright_white, bg = colors.transparent_black, bold = true },
})

---@type table<string, vim.api.keyset.highlight>
local groups = vim.tbl_extend("error", statusline_groups, {
  -- Builtins.
  Boolean = { fg = colors.blue },
  Character = { fg = colors.green },
  ColorColumn = { bg = colors.selection },
  Comment = { fg = colors.comment, italic = true },
  Conceal = { fg = colors.comment },
  Conditional = { fg = colors.sand },
  Constant = { fg = colors.yellow },
  CurSearch = { fg = colors.black, bg = colors.fuchsia },
  Cursor = { fg = colors.black, bg = colors.white },
  CursorColumn = { bg = colors.transparent_black },
  CursorLine = { bg = colors.selection },
  CursorLineNr = { fg = colors.lilac, bold = true },
  Define = { fg = colors.clay },
  Directory = { fg = colors.blue },
  EndOfBuffer = { fg = colors.bg },
  Error = { fg = colors.muted_red },
  ErrorMsg = { fg = colors.muted_red },
  FoldColumn = {},
  Folded = { bg = colors.transparent_black },
  Function = { fg = colors.bright_green },
  Identifier = { fg = colors.blue },
  IncSearch = { link = "CurSearch" },
  Include = { fg = colors.clay },
  Keyword = { fg = colors.blue },
  Label = { fg = colors.blue },
  LineNr = { fg = colors.lilac },
  Macro = { fg = colors.clay },
  MatchParen = { sp = colors.fg, underline = true },
  NonText = { fg = colors.nontext },
  Normal = { fg = colors.fg, bg = colors.bg },
  NormalFloat = { fg = colors.fg, bg = colors.bg },
  Number = { fg = colors.orange },
  Pmenu = { fg = colors.white, bg = colors.transparent_earth },
  PmenuSbar = { bg = colors.transparent_earth },
  PmenuSel = { fg = colors.blue, bg = colors.selection },
  PmenuThumb = { bg = colors.selection },
  PreCondit = { fg = colors.blue },
  PreProc = { fg = colors.yellow },
  Question = { fg = colors.clay },
  Repeat = { fg = colors.sand },
  Search = { fg = colors.bg, bg = colors.orange },
  SignColumn = { bg = colors.bg },
  Special = { fg = colors.green, italic = true },
  SpecialComment = { fg = colors.comment, italic = true },
  SpecialKey = { fg = colors.nontext },
  SpellBad = { sp = colors.muted_red, underline = true },
  SpellCap = { sp = colors.yellow, underline = true },
  SpellLocal = { sp = colors.yellow, underline = true },
  SpellRare = { sp = colors.yellow, underline = true },
  Statement = { fg = colors.clay },
  StatusLine = { fg = colors.white, bg = colors.transparent_black },
  StorageClass = { fg = colors.sand },
  Structure = { fg = colors.yellow },
  Substitute = { fg = colors.fuchsia, bg = colors.orange, bold = true },
  Title = { fg = colors.blue },
  Todo = { fg = colors.clay, bold = true, italic = true },
  Type = { fg = colors.blue },
  TypeDef = { fg = colors.yellow },
  Underlined = { fg = colors.blue, underline = true },
  VertSplit = { fg = colors.white },
  Visual = { bg = colors.visual },
  VisualNOS = { fg = colors.visual },
  WarningMsg = { fg = colors.yellow },
  WildMenu = { fg = colors.transparent_black, bg = colors.white },

  -- Treesitter.
  ["@annotation"] = { fg = colors.yellow },
  ["@attribute"] = { fg = colors.blue },
  ["@boolean"] = { fg = colors.clay },
  ["@character"] = { fg = colors.green },
  ["@constant"] = { fg = colors.clay },
  ["@constant.builtin"] = { fg = colors.clay },
  ["@constant.macro"] = { fg = colors.blue },
  ["@constructor"] = { fg = colors.blue },
  ["@error"] = { fg = colors.muted_red },
  ["@function"] = { fg = colors.bright_green },
  ["@function.builtin"] = { fg = colors.blue },
  ["@function.macro"] = { fg = colors.bright_green },
  ["@function.method"] = { fg = colors.bright_green },
  ["@keyword"] = { fg = colors.sand },
  ["@keyword.conditional"] = { fg = colors.sand },
  ["@keyword.exception"] = { fg = colors.clay },
  ["@keyword.function"] = { fg = colors.blue },
  ["@keyword.function.ruby"] = { fg = colors.sand },
  ["@keyword.include"] = { fg = colors.sand },
  ["@keyword.operator"] = { fg = colors.sand },
  ["@keyword.repeat"] = { fg = colors.sand },
  ["@label"] = { fg = colors.blue },
  ["@markup"] = { fg = colors.orange },
  ["@markup.emphasis"] = { fg = colors.yellow, italic = true },
  ["@markup.heading"] = { fg = colors.sand, bold = true },
  ["@markup.link"] = { fg = colors.orange, bold = true },
  ["@markup.link.uri"] = { fg = colors.yellow, italic = true },
  ["@markup.list"] = { fg = colors.blue },
  ["@markup.raw"] = { fg = colors.yellow },
  ["@markup.strong"] = { fg = colors.orange, bold = true },
  ["@markup.underline"] = { fg = colors.orange },
  ["@module"] = { fg = colors.orange },
  ["@number"] = { fg = colors.clay },
  ["@number.float"] = { fg = colors.green },
  ["@operator"] = { fg = colors.sand },
  ["@parameter.reference"] = { fg = colors.orange },
  ["@property"] = { fg = colors.bright_blue },
  ["@punctuation.bracket"] = { fg = colors.fg },
  ["@punctuation.delimiter"] = { fg = colors.fg },
  ["@string"] = { fg = colors.bright_yellow },
  ["@string.escape"] = { fg = colors.blue },
  ["@string.regexp"] = { fg = colors.muted_red },
  ["@string.special.symbol"] = { fg = colors.clay },
  ["@structure"] = { fg = colors.clay },
  ["@tag"] = { fg = colors.blue },
  ["@tag.attribute"] = { fg = colors.green },
  ["@tag.delimiter"] = { fg = colors.blue },
  ["@type"] = { fg = colors.bright_cyan },
  ["@type.builtin"] = { fg = colors.blue, italic = true },
  ["@type.qualifier"] = { fg = colors.sand },
  ["@variable"] = { fg = colors.fg },
  ["@variable.builtin"] = { fg = colors.clay },
  ["@variable.member"] = { fg = colors.orange },
  ["@variable.parameter"] = { fg = colors.orange },

  -- Semantic tokens.
  ["@class"] = { fg = colors.blue },
  ["@decorator"] = { fg = colors.blue },
  ["@enum"] = { fg = colors.blue },
  ["@enumMember"] = { fg = colors.clay },
  ["@event"] = { fg = colors.blue },
  ["@interface"] = { fg = colors.blue },
  ["@lsp.type.class"] = { fg = colors.blue },
  ["@lsp.type.decorator"] = { fg = colors.green },
  ["@lsp.type.enum"] = { fg = colors.blue },
  ["@lsp.type.enumMember"] = { fg = colors.clay },
  ["@lsp.type.function"] = { fg = colors.green },
  ["@lsp.type.interface"] = { fg = colors.blue },
  ["@lsp.type.macro"] = { fg = colors.blue },
  ["@lsp.type.method"] = { fg = colors.bright_green },
  ["@lsp.type.namespace"] = { fg = colors.orange },
  ["@lsp.type.parameter"] = { fg = colors.orange },
  ["@lsp.type.property"] = { fg = colors.lavender },
  ["@lsp.type.struct"] = { fg = colors.blue },
  ["@lsp.type.type"] = { fg = colors.bright_cyan },
  ["@lsp.type.variable"] = { fg = colors.fg },
  ["@modifier"] = { fg = colors.blue },
  ["@regexp"] = { fg = colors.yellow },
  ["@struct"] = { fg = colors.blue },
  ["@typeParameter"] = { fg = colors.blue },

  -- Package manager.
  LazyDimmed = { fg = colors.grey },

  -- LSP.
  DiagnosticDeprecated = { strikethrough = true, fg = colors.fg },
  DiagnosticError = { fg = colors.barnyard_red },
  DiagnosticFloatingError = { fg = colors.barnyard_red },
  DiagnosticFloatingHint = { fg = colors.blue },
  DiagnosticFloatingInfo = { fg = colors.blue },
  DiagnosticFloatingWarn = { fg = colors.yellow },
  DiagnosticHint = { fg = colors.blue },
  DiagnosticInfo = { fg = colors.blue },
  DiagnosticUnderlineError = { undercurl = true, sp = colors.barnyard_red },
  DiagnosticUnderlineHint = { undercurl = true, sp = colors.blue },
  DiagnosticUnderlineInfo = { undercurl = true, sp = colors.blue },
  DiagnosticUnderlineWarn = { undercurl = true, sp = colors.yellow },
  DiagnosticUnnecessary = { fg = colors.grey, italic = true },
  DiagnosticVirtualTextError = { fg = colors.barnyard_red, bg = colors.transparent_red },
  DiagnosticVirtualTextHint = { fg = colors.blue, bg = colors.transparent_earth },
  DiagnosticVirtualTextInfo = { fg = colors.blue, bg = colors.transparent_earth },
  DiagnosticVirtualTextWarn = { fg = colors.yellow, bg = colors.transparent_yellow },
  DiagnosticWarn = { fg = colors.yellow },
  LspCodeLens = { fg = colors.blue },
  LspFloatWinBorder = { fg = colors.comment },
  LspInlayHint = { fg = colors.lavender, italic = true },
  LspReferenceRead = { bg = colors.transparent_earth },
  LspReferenceText = {},
  LspReferenceWrite = { bg = colors.transparent_red },
  LspSignatureActiveParameter = { bold = true, underline = true, sp = colors.fg },

  -- Completions.
  CmpItemAbbrDeprecated = { link = "DiagnosticDeprecated" },
  CmpItemAbbrMatch = { fg = colors.blue, bg = "NONE" },
  CmpItemKind = { bg = "NONE" },
  CmpItemKindClass = { link = "@type" },
  CmpItemKindColor = { link = "DevIconCss" },
  CmpItemKindConstant = { link = "@constant" },
  CmpItemKindConstructor = { link = "@type" },
  CmpItemKindEnum = { link = "@variable.member" },
  CmpItemKindEnumMember = { link = "@variable.member" },
  CmpItemKindEvent = { link = "@constant" },
  CmpItemKindField = { link = "@variable.member" },
  CmpItemKindFile = { link = "Directory" },
  CmpItemKindFolder = { link = "Directory" },
  CmpItemKindFunction = { link = "@function" },
  CmpItemKindInterface = { link = "@type" },
  CmpItemKindKeyword = { link = "@keyword" },
  CmpItemKindMethod = { link = "@function.method" },
  CmpItemKindModule = { link = "@module" },
  CmpItemKindOperator = { link = "@operator" },
  CmpItemKindProperty = { link = "@property" },
  CmpItemKindReference = { link = "@parameter.reference" },
  CmpItemKindSnippet = { link = "@markup" },
  CmpItemKindStruct = { link = "@structure" },
  CmpItemKindText = { link = "@markup" },
  CmpItemKindTypeParameter = { link = "@variable.parameter" },
  CmpItemKindUnit = { link = "@variable.member" },
  CmpItemKindValue = { link = "@variable.member" },
  CmpItemKindVariable = { link = "@variable" },
  CmpItemMenu = { fg = colors.grey },

  -- Dap UI.
  DapStoppedLine = { default = true, link = "Visual" },
  DapUIBreakpointsCurrentLine = { fg = colors.bright_green, bold = true },
  DapUIBreakpointsInfo = { fg = colors.bright_green },
  DapUIBreakpointsPath = { fg = colors.bright_cyan },
  DapUIDecoration = { fg = colors.bright_cyan },
  DapUIFloatBorder = { fg = colors.bright_cyan },
  DapUILineNumber = { fg = colors.bright_cyan },
  DapUIModifiedValue = { fg = colors.bright_cyan, bold = true },
  DapUIPlayPause = { fg = colors.bright_green },
  DapUIRestart = { fg = colors.green },
  DapUIScope = { fg = colors.bright_cyan },
  DapUISource = { fg = colors.bright_blue },
  DapUIStepBack = { fg = colors.blue },
  DapUIStepInto = { fg = colors.blue },
  DapUIStepOut = { fg = colors.blue },
  DapUIStepOver = { fg = colors.blue },
  DapUIStop = { fg = colors.barnyard_red },
  DapUIStoppedThread = { fg = colors.bright_cyan },
  DapUIThread = { fg = colors.bright_green },
  DapUIType = { fg = colors.bright_blue },
  DapUIWatchesEmpty = { fg = colors.sand },
  DapUIWatchesError = { fg = colors.sand },
  DapUIWatchesValue = { fg = colors.bright_green },
  DapUIWinSelect = { fg = colors.bright_cyan, bold = true },
  NvimDapVirtualText = { fg = colors.lavender, underline = true },

  -- Diffs.
  DiffAdd = { fg = colors.green, bg = colors.transparent_green },
  DiffChange = { fg = colors.yellow, bg = colors.transparent_yellow },
  DiffDelete = { fg = colors.barnyard_red, bg = colors.transparent_red },
  DiffText = { fg = colors.bright_white, bg = colors.transparent_black },
  diffAdded = { fg = colors.bright_green, bold = true },
  diffChanged = { fg = colors.bright_yellow, bold = true },
  diffRemoved = { fg = colors.muted_red, bold = true },

  -- Command line.
  MoreMsg = { fg = colors.bright_white, bold = true },
  MsgArea = { fg = colors.blue },
  MsgSeparator = { fg = colors.lilac },

  -- Winbar styling.
  WinBar = { fg = colors.fg, bg = colors.transparent_black },
  WinBarNC = { bg = colors.transparent_black },
  WinBarDir = { fg = colors.bright_clay, bg = colors.transparent_black, italic = true },
  WinBarSeparator = { fg = colors.green, bg = colors.transparent_black },

  -- Quickfix window.
  QuickFixLine = { italic = true, bg = colors.transparent_red },

  -- Gitsigns.
  GitSignsAdd = { fg = colors.bright_green },
  GitSignsChange = { fg = colors.blue },
  GitSignsDelete = { fg = colors.muted_red },
  GitSignsStagedAdd = { fg = colors.orange },
  GitSignsStagedChange = { fg = colors.orange },
  GitSignsStagedDelete = { fg = colors.orange },

  -- Bufferline.
  BufferLineBufferSelected = { bg = colors.bg, underline = true, sp = colors.clay },
  BufferLineFill = { bg = colors.bg },
  TabLine = { fg = colors.comment, bg = colors.bg },
  TabLineFill = { bg = colors.bg },
  TabLineSel = { bg = colors.clay },

  -- When triggering flash, use a white font and make everything in the backdrop italic.
  FlashBackdrop = { italic = true },
  FlashPrompt = { link = "Normal" },

  -- Make these titles more visible.
  MiniClueTitle = { bold = true, fg = colors.blue },
  MiniFilesTitleFocused = { bold = true, fg = colors.blue },

  -- Nicer yanky highlights.
  YankyPut = { link = "Visual" },
  YankyYanked = { link = "Visual" },

  -- Highlight for the Treesitter sticky context.
  TreesitterContextBottom = { underline = true, sp = colors.lilac },

  -- Fzf overrides.
  FzfLuaBorder = { fg = colors.comment },
  FzfLuaHeaderBind = { fg = colors.lavender },
  FzfLuaHeaderText = { fg = colors.sand },
  FzfLuaLiveSym = { fg = colors.fuchsia },
  FzfLuaPreviewTitle = { fg = colors.fg },
  FzfLuaSearch = { bg = colors.transparent_red },

  -- TODOs and notes.
  MiniHipatternsHack = { fg = colors.bg, bg = colors.orange, bold = true },
  MiniHipatternsNote = { fg = colors.bg, bg = colors.bright_green, bold = true },
  MiniHipatternsTodo = { fg = colors.bg, bg = colors.blue, bold = true },

  -- Overseeer.
  OverseerComponent = { link = "@keyword" },

  -- Links.
  HighlightUrl = { underline = true, fg = colors.the_sky, sp = colors.the_sky },
})

for group, opts in pairs(groups) do
  vim.api.nvim_set_hl(0, group, opts)
end
