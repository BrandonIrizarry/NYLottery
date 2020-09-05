#!/usr/bin/env lua
--[[
	Tool meant to simplify each line into the form

date midday evening
date midday evening
...

Ideally, each line should be multi-column, to save space.

Also, I should only need to go back as far as the last three months.
]]

require "strict"

local filename = arg[1] -- should be a csv file
assert(filename)

local extension = filename:sub(-4)
assert(extension == ".csv")

local file = io.open(filename)

local function entries (file, limit) -- '06/30/2020', first non-applicable date
	local next_line = file:lines()

	next_line() -- throw out the first line

	return function ()
		local line = next_line()

		local date, midday, evening = line:match("^(.-),(.-),.-,(.-),")

		if date == limit then return nil end

		return date, midday, evening
	end
end

for d, m, e in entries(file, "05/31/2020") do
	local chunk = string.format("%s %s %s", d, m, e)
	print(chunk)
end
