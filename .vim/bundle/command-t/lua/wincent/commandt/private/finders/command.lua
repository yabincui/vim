-- SPDX-FileCopyrightText: Copyright 2022-present Greg Hurrell and contributors.
-- SPDX-License-Identifier: BSD-2-Clause

local ffi = require('ffi')

return function(directory, command, options)
  local lib = require('wincent.commandt.private.lib')
  local drop = 0
  if type(command) == 'function' then
    command, drop = command(directory, options)
  end
  local finder = {}
  finder.scanner = require('wincent.commandt.private.scanners.command').scanner(command, drop)
  finder.matcher = lib.matcher_new(finder.scanner, options)
  finder.run = function(query)
    local results = lib.matcher_run(finder.matcher, query)
    local strings = {}
    for i = 0, results.count - 1 do
      local str = results.matches[i]
      table.insert(strings, ffi.string(str.contents, str.length))
    end
    return strings
  end
  finder.open = options.open
  return finder
end
