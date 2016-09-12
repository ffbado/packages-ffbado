local cbi = require "luci.cbi"
local i18n = require "luci.i18n"
local uci = luci.model.uci.cursor()

local M = {}

function M.section(form)
  local text = i18n.translate('If you want to Aktivate wifi button')

  local s = form:section(cbi.SimpleSection, nil, text)
  local o = s:option(cbi.Flag, "_rfkill_enabled", i18n.translate("If you want to Aktivate wifi button... bla bla"))
  o.default = uci:get_bool("rfkill", "rfkill", "enabled") and o.enabled or o.disabled
  o.rmempty = false
end

function M.handle(data)
  uci:set("rfkill", "rfkill", "enabled", data._rfkill_enabled)
  uci:save("rfkill")
  uci:commit("rfkill")
end

return M
