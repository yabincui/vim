-- SPDX-FileCopyrightText: Copyright 2022-present Greg Hurrell and contributors.
-- SPDX-License-Identifier: BSD-2-Clause

local time = {}

time.cpu = function(callback)
  local start_cpu = os.clock()
  callback()
  return os.clock() - start_cpu
end

time.wall = function(callback)
  local lib = require('wincent.commandt.private.lib')
  local start_wall_s, start_wall_us = lib.epoch()
  callback()
  local end_wall_s, end_wall_us = lib.epoch()
  if end_wall_us >= start_wall_s then
    end_wall_us = end_wall_us + 1000000
    end_wall_s = end_wall_s - 1
  end
  return (end_wall_s - start_wall_s) + (end_wall_us - start_wall_us) / 1000000
end

return time
