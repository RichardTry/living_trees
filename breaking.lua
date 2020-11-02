function break_childs(pos)
	local curpos = vector.add(pos, {x = -1, y = 0, z = 0})
	local node = minetest.get_node(curpos)
	if node.name:sub(0, 13) == "living_trees:" and node.param2 == 2 then
		minetest.dig_node(curpos)
	end
	curpos = vector.add(pos, {x = 1, y = 0, z = 0})
	node = minetest.get_node(curpos)
	if node.name:sub(0, 13) == "living_trees:" and node.param2 == 3 then
		minetest.dig_node(curpos)
	end
	curpos = vector.add(pos, {x = 0, y = -1, z = 0})
	node = minetest.get_node(curpos)
	if node.name:sub(0, 13) == "living_trees:" and node.param2 == 0 then
		minetest.dig_node(curpos)
	end
	curpos = vector.add(pos, {x = 0, y = 1, z = 0})
	node = minetest.get_node(curpos)
	if node.name:sub(0, 13) == "living_trees:" and node.param2 == 1 then
		minetest.dig_node(curpos)
	end
	curpos = vector.add(pos, {x = 0, y = 0, z = -1})
	node = minetest.get_node(curpos)
	if node.name:sub(0, 13) == "living_trees:" and node.param2 == 4 then
		minetest.dig_node(curpos)
	end
	curpos = vector.add(pos, {x = 0, y = 0, z = 1})
	node = minetest.get_node(curpos)
	if node.name:sub(0, 13) == "living_trees:" and node.param2 == 5 then
		minetest.dig_node(curpos)
	end
end
