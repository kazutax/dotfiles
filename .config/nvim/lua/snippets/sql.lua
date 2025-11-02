local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

return {
  s("create_date_func", fmt([[
create temporary function _start_date() as (date('{year}-{month}-{day}'));
create temporary function _end_date() as (date('{year}-{month}-{day}'));
  ]], {
    year = f(function()
      return os.date("%Y")
    end),
    month = f(function()
      return os.date("%m")
    end),
    day = f(function()
      return os.date("%d")
    end),
  })),

  s("select_base", fmt([[
select {cols}
from `{table}`
where {cond};
  ]], {
    cols = i(1, "*"),
    table = i(2, "your_table"),
    cond = i(3, "_partitiondate between _start_date() and _end_date()"),
  })),
}

