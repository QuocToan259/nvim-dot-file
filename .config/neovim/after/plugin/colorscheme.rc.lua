local status, n = pcall(require, 'solarized-osaka')

if (not status) then return end

n.setup({ 
        comment_italics = true,
        transpency = true
})


local colorbuddy = require 'colorbuddy.init'
local Color = colorbuddy.Color
local colors = colorbuddy.colors
local Group = colorbuddy.Group
local groups = colorbuddy.groups
local styles = colorbuddy.styles

Color.new('black', '#000000')
Group.new('CursorLine', colors.NONE, colors.base03, styles.NONE, colors.base1)
Group.new('CursorLineNr', colors.yellow, colors.black, styles.NONE, colors.base1)
Group.new('Visual', colors.NONE, colors.base1, styles.reverse)

local cError = groups.Error and groups.Error.fg or colors.red
local cInfo = groups.Information and groups.Info.fg or colors.blue
local cWarn = groups.Warning and groups.Warn.fg or colors.yellow
local cHint = groups.Hint and groups.Hint.fg or colors.green

Group.new('DiagnosticVirtualTextError', cError, cError:dark():dark():dark():dark(), styles.NONE)
Group.new('DiagnosticVirtualTextInfo', cInfo, cInfo:dark():dark():dark(), styles.NONE)
Group.new('DiagnosticVirtualTextWarn', cWarn, cWarn:dark():dark():dark(), styles.NONE)
Group.new('DiagnosticVirtualTextHint', cHint, cHint:dark():dark():dark(), styles.NONE)
Group.new('DiagnosticUnderlineError', colors.none, colors.none, styles.undercurl, cError)
Group.new('DiagnosticUnderlineInfo', colors.none, colors.none, styles.undercurl, cInfo)
Group.new('DiagnosticUnderlineWarn', colors.none, colors.none, styles.undercurl, cWarn)
Group.new('DiagnosticUnderlineHint', colors.none, colors.none, styles.undercurl, cHint)
