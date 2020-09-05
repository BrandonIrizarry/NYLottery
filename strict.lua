--[[
	Usage:
	<introduce globals here>
	require "strict"
		-- no more globals after this point
		-- handy for avoiding typos that introduce nil-valued global variables
]]

setmetatable(_ENV, {
	__index = function (_, nonexistent)
		error(string.format("nonexistent global '%s'", nonexistent), 2)
	end,

	__newindex = function (_, prohibited)
		error(string.format("cannot write to new global '%s'", prohibited), 2)
	end
})

