local status, neoscrolls = pcall(require, "neoscroll")
if not status then
    vim.notify("neoscrolls: is not installed! ", vim.log.levels.WARN)
    return
end

neoscrolls.setup({
    easing_function = "quadratic", -- Default easing function
})
local keymap = {
  ["<C-u>"] = function() neoscrolls.ctrl_u({ duration = 250 }) end;
  ["<C-d>"] = function() neoscrolls.ctrl_d({ duration = 250 }) end;
  ["<C-b>"] = function() neoscrolls.ctrl_b({ duration = 450 }) end;
  ["<C-f>"] = function() neoscrolls.ctrl_f({ duration = 450 }) end;
  ["<C-y>"] = function() neoscrolls.scroll(-0.1, { move_cursor=false; duration = 100 }) end;
  ["<C-e>"] = function() neoscrolls.scroll(0.1, { move_cursor=false; duration = 100 }) end;
  ["zt"]    = function() neoscrolls.zt({ half_win_duration = 250 }) end;
  ["zz"]    = function() neoscrolls.zz({ half_win_duration = 250 }) end;
  ["zb"]    = function() neoscrolls.zb({ half_win_duration = 250 }) end;
}
local modes = { 'n', 'v', 'x' }
for key, func in pairs(keymap) do
  vim.keymap.set(modes, key, func)
end

