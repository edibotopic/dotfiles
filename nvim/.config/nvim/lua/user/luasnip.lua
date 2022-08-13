local ls = require "luasnip"

local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node

-- custom snippets
ls.add_snippets("markdown", {
    s("qnote", {
        c(1, {
            t(":::{.callout-note}"),
            t(":::{.callout-warning}")
        }),
        t("\t"),
        i(2),
        t("\t"),
        t(":::"),
        i(0),
    }) }
)
