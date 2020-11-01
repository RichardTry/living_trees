living_trees = {plants = {}}

local modpath = minetest.get_modpath("living_trees")
dofile(modpath.."/branches.lua")

minetest.register_node("living_trees:roots", {
	description = "Roots",
	tiles = {"default_dirt.png^living_trees_roots.png"},
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("lstring", "TTT[&12^34][^12&34]TT[+12-34][-12+34]")
	end,
	groups = {choppy = 3}
})

function opposite_dir(dir)
	if dir % 2 == 0 then
		return dir + 1
	else
		return dir - 1
	end
end

function add_dir_to_pos(pos, dir)
	if dir == 0 then
		pos.y = pos.y + 1
	elseif dir == 1 then
		pos.y = pos.y - 1
	elseif dir == 2 then
		pos.x = pos.x + 1
	elseif dir == 3 then
		pos.x = pos.x - 1
	elseif dir == 4 then
		pos.z = pos.z + 1
	elseif dir == 5 then
		pos.z = pos.z - 1
	end
	return pos
end

function living_trees.register_tree(tree)
	minetest.register_abm({
		nodenames = tree.roots,
		interval = 1.0, -- Run every n seconds
		chance = 1, -- Select every 1 in n nodes
		action = function(pos, node, active_object_count, active_object_count_wider)
			local curpos = pos
			local currot = {dir = 0, up = 3, left = 4}		-- In wallmounted numbers
			local meta = minetest.get_meta(pos)
			local lstr = meta:get_string("lstring")
			local stack = {}
			local skipbranch = 0
			for i = 1, #lstr do

				local c = lstr:sub(i,i)
				
				if c == "]" then
					if skipbranch > 1 then
						skipbranch = skipbranch - 1
					else
						skipbranch = 0
						currot = table.remove(stack)
						curpos = table.remove(stack)
					end
				elseif c == "[" then
					if skipbranch > 0 then
						skipbranch = skipbranch + 1
					else
						local savedpos = {}
						for k,v in pairs(curpos) do
							savedpos[k] = v
						end
						local savedrot = {}
						for k,v in pairs(currot) do
							savedrot[k] = v
						end
						table.insert(stack, savedpos)
						table.insert(stack, savedrot)
					end
				elseif skipbranch > 0 then
				elseif c == "T" then
					add_dir_to_pos(curpos, currot.dir)
					local name = minetest.get_node(curpos).name
					if name == "air" then
						minetest.set_node(curpos, {name="living_trees:branch_4", param2 = opposite_dir(currot.dir)})
						skipbranch = skipbranch + 1 
					elseif name == "living_trees:branch_4" then
						minetest.set_node(curpos, {name="living_trees:branch_3", param2 = opposite_dir(currot.dir)})
					elseif name == "living_trees:branch_3" then
						minetest.set_node(curpos, {name="living_trees:branch_2", param2 = opposite_dir(currot.dir)})
					elseif name == "living_trees:branch_2" then
						minetest.set_node(curpos, {name="living_trees:branch_1", param2 = opposite_dir(currot.dir)})
					elseif name == "living_trees:branch_1" then
						minetest.set_node(curpos, {name="default:tree", param2 = opposite_dir(currot.dir)})
					elseif name ~= "default:tree" then
						skipbranch = skipbranch + 1
					end
				elseif c == "1" then
					add_dir_to_pos(curpos, currot.dir)
					local name = minetest.get_node(curpos).name
					if name == "air" then
						minetest.set_node(curpos, {name="living_trees:branch_4", param2 = opposite_dir(currot.dir)})
						skipbranch = skipbranch + 1
					elseif name == "living_trees:branch_4" then
						minetest.set_node(curpos, {name="living_trees:branch_3", param2 = opposite_dir(currot.dir)})
					elseif name == "living_trees:branch_3" then
						minetest.set_node(curpos, {name="living_trees:branch_2", param2 = opposite_dir(currot.dir)})
					elseif name == "living_trees:branch_2" then
						minetest.set_node(curpos, {name="living_trees:branch_1", param2 = opposite_dir(currot.dir)})
					elseif name ~= "living_trees:branch_1" then
						skipbranch = skipbranch + 1
					end
				elseif c == "2" then
					add_dir_to_pos(curpos, currot.dir)
					local name = minetest.get_node(curpos).name
					if name == "air" then
						minetest.set_node(curpos, {name="living_trees:branch_4", param2 = opposite_dir(currot.dir)})
						skipbranch = skipbranch + 1
					elseif name == "living_trees:branch_4" then
						minetest.set_node(curpos, {name="living_trees:branch_3", param2 = opposite_dir(currot.dir)})
					elseif name == "living_trees:branch_3" then
						minetest.set_node(curpos, {name="living_trees:branch_2", param2 = opposite_dir(currot.dir)})
					elseif name ~= "living_trees:branch_2" then
						skipbranch = skipbranch + 1
					end
				elseif c == "3" then
					add_dir_to_pos(curpos, currot.dir)
					local name = minetest.get_node(curpos).name
					if name == "air" then
						minetest.set_node(curpos, {name="living_trees:branch_4", param2 = opposite_dir(currot.dir)})
						skipbranch = skipbranch + 1
					elseif name == "living_trees:branch_4" then
						minetest.set_node(curpos, {name="living_trees:branch_3", param2 = opposite_dir(currot.dir)})
					elseif name ~= "living_trees:branch_3" then
						skipbranch = skipbranch + 1
					end
				elseif c == "4" then
					add_dir_to_pos(curpos, currot.dir)
					local name = minetest.get_node(curpos).name
					if name == "air" then
						minetest.set_node(curpos, {name="living_trees:branch_4", param2 = opposite_dir(currot.dir)})
						skipbranch = skipbranch + 1
					elseif name ~= "living_trees:branch_4" then
						skipbranch = skipbranch + 1
					end
				elseif c == "^" then
					local temp = opposite_dir(currot.dir)
					currot.dir = currot.up
					currot.up = temp
				elseif c == "&" then
					local temp = opposite_dir(currot.up)
					currot.up = currot.dir
					currot.dir = temp
				elseif c == "+" then
					local temp = opposite_dir(currot.left)
					currot.left = currot.dir
					currot.dir = temp
				elseif c == "-" then
					local temp = opposite_dir(currot.dir)
					currot.dir = currot.left
					currot.left = temp
				elseif c == "/" then
					local temp = opposite_dir(currot.left)
					currot.left = currot.up
					currot.up = temp
				elseif c == "*" then
					local temp = opposite_dir(currot.up)
					currot.up = currot.left
					currot.left = temp
				end
			end
		end
	})
end

living_trees.register_tree({name = "dub", roots = {"living_trees:roots"} })
