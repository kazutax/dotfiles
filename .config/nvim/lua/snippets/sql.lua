local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

return {
  -- WITH 句テンプレ
  s("withq", fmt([[
with {name} as (
    select
        {cols}
    from
        `{project}.{dataset}.{table}`
    {where}
)

select
    *
from
    {name}
{limit};
]]
    , {
        name = i(1, "src"),
        cols = i(2, "*"),
        project = i(3, "my-proj"),
        dataset = i(4, "analytics"),
        table = i(5, "events_*"),
        where = i(6, "-- where _partitiondate \"20250101\" AND \"20250131\""),
        limit = i(7, "limit 1000"),
  })
  ),

  -- SAFE_CAST
  s("scast", fmt([[SAFE_CAST({expr} AS {type})]], {
    expr = i(1, "value"),
    type = i(2, "INT64"),
  })),

  -- 窓関数・パーティション
  s("rown", fmt([[row_number() over (partition by {p} order by {o})]], {
    p = i(1, "user_id"),
    o = i(2, "event_timestamp"),
  })),
}
 
