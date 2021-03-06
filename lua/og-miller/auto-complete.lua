local cmp = require "cmp"

cmp.setup {
 mapping = {
    ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
    ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-e>"] = cmp.mapping.abort(),

     sources = {
    { name = "gh_issues" },

    -- Youtube: Could enable this only for lua, but nvim_lua handles that already.
    { name = "nvim_lua" },

    { name = "nvim_lsp" },
    { name = "path" },
 -- { name = "luasnip" }, don't have a snippet plugin yet
    { name = "buffer", keyword_length = 5 },
  },

}

}
