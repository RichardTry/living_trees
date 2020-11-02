living_trees = {plants = {}}

--[[ L-strings:
	Apple tree: 	TTT[^Q[+W-E&R][-W+E&R] ][&Q[+W-E^R][-W+E^R] ]Q[^W&E^R][&W^E&R][+W-E+R][-W+E-R]
	Pine: 
]]

local modpath = minetest.get_modpath("living_trees")
dofile(modpath.."/breaking.lua")
dofile(modpath.."/branches.lua")

minetest.register_node("living_trees:roots", {
	description = "Roots",
	tiles = {"default_dirt.png^living_trees_roots.png"},
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("lstring", "TTTTT^[QW[+E-R][-E+R]ER]+[QW[+E-R][-E+R]ER]+[QW[+E-R][-E+R]ER]+[QW[+E-R][-E+R]ER]&Q^[WE[+R][-R]R]+[WE[+R][-R]R]+[WE[+R][-R]R]+[WE[+R][-R]R]&W^[ER]+[ER]+[ER]+[ER]&E^[R]+[R]+[R]+[R]&R")
	end,
	groups = {crumbly = 2, choppy = 1}
})

function opposite_dir(dir)
	if dir % 2 == 0 then
		return dir + 1
	else
		return dir - 1
	end
end

function wallmounted_to_facedir(dir)
	if dir == 0 then
		return 0
	elseif dir == 1 then
		return 5
	elseif dir == 2 then
		return 3
	elseif dir == 3 then
		return 4
	elseif dir == 4 then
		return 1
	elseif dir == 5 then
		return 2
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
					if name == "air" or name == "default:leaves" then
						minetest.set_node(curpos, {name="living_trees:branch_3_4", param2 = opposite_dir(currot.dir)})
						skipbranch = skipbranch + 1 
					elseif name == "living_trees:branch_3_4" then
						minetest.set_node(curpos, {name="living_trees:branch_2_3", param2 = opposite_dir(currot.dir)})
					elseif name == "living_trees:branch_2_3" then
						minetest.set_node(curpos, {name="living_trees:branch_1_2", param2 = opposite_dir(currot.dir)})
					elseif name == "living_trees:branch_1_2" then
						minetest.set_node(curpos, {name="living_trees:branch_T_1", param2 = opposite_dir(currot.dir)})
					elseif name == "living_trees:branch_T_1" then
						minetest.set_node(curpos, {name="default:tree", param2 = wallmounted_to_facedir(currot.dir) * 4})
					elseif name ~= "default:tree" then
						skipbranch = skipbranch + 1
					end
				elseif c == "Q" then
					add_dir_to_pos(curpos, currot.dir)
					local name = minetest.get_node(curpos).name
					if name == "air" or name == "default:leaves" then
						minetest.set_node(curpos, {name="living_trees:branch_3_4", param2 = opposite_dir(currot.dir)})
						skipbranch = skipbranch + 1
					elseif name == "living_trees:branch_3_4" then
						minetest.set_node(curpos, {name="living_trees:branch_2_3", param2 = opposite_dir(currot.dir)})
					elseif name == "living_trees:branch_2_3" then
						minetest.set_node(curpos, {name="living_trees:branch_1_2", param2 = opposite_dir(currot.dir)})
					elseif name == "living_trees:branch_1_2" then
						minetest.set_node(curpos, {name="living_trees:branch_T_1", param2 = opposite_dir(currot.dir)})
					elseif name ~= "living_trees:branch_T_1" then
						skipbranch = skipbranch + 1
					end
				elseif c == "W" then
					add_dir_to_pos(curpos, currot.dir)
					local name = minetest.get_node(curpos).name
					if name == "air" or name == "default:leaves" then
						minetest.set_node(curpos, {name="living_trees:branch_3_4", param2 = opposite_dir(currot.dir)})
						skipbranch = skipbranch + 1
					elseif name == "living_trees:branch_3_4" then
						minetest.set_node(curpos, {name="living_trees:branch_2_3", param2 = opposite_dir(currot.dir)})
					elseif name == "living_trees:branch_2_3" then
						minetest.set_node(curpos, {name="living_trees:branch_1_2", param2 = opposite_dir(currot.dir)})
					elseif name ~= "living_trees:branch_1_2" then
						skipbranch = skipbranch + 1
					end
				elseif c == "E" then
					add_dir_to_pos(curpos, currot.dir)
					local name = minetest.get_node(curpos).name
					if name == "air" or name == "default:leaves" then
						minetest.set_node(curpos, {name="living_trees:branch_3_4", param2 = opposite_dir(currot.dir)})
						skipbranch = skipbranch + 1
					elseif name == "living_trees:branch_3_4" then
						minetest.set_node(curpos, {name="living_trees:branch_2_3", param2 = opposite_dir(currot.dir)})
					elseif name ~= "living_trees:branch_2_3" then
						skipbranch = skipbranch + 1
					end
				elseif c == "R" then
					add_dir_to_pos(curpos, currot.dir)
					local name = minetest.get_node(curpos).name
					if name == "air" or name == "default:leaves" then
						minetest.set_node(curpos, {name="living_trees:branch_3_4", param2 = opposite_dir(currot.dir)})
						skipbranch = skipbranch + 1
					elseif name ~= "living_trees:branch_3_4" then
						skipbranch = skipbranch + 1
					end
				elseif c == "1" then
					add_dir_to_pos(curpos, currot.dir)
					local name = minetest.get_node(curpos).name
					if name == "air" or name == "default:leaves" then
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
					if name == "air" or name == "default:leaves" then
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
					if name == "air" or name == "default:leaves" then
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
					if name == "air" or name == "default:leaves" then
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
--[[
minetest.register_abm({
    nodenames = {"living_trees:branch_3_4", "living_trees:branch_4"},
    interval = 1.0, -- Run every 10 seconds
    chance = 1, -- Select every 1 in 50 nodes
    action = function(pos, node, active_object_count, active_object_count_wider)
	for x = -1,1 do
		for y = -1,1 do
			for z = -1,1 do
				local curpos = {x = x, y = y, z = z}
				curpos = vector.add(pos, curpos)
				if minetest.get_node(curpos).name == "air" and (y == 0 or x == 0 or z == 0) then
					minetest.set_node(curpos, {name = "default:leaves"})
				end
			end
		end
	end
    end
})
]]

living_trees.register_tree({name = "tree", roots = {"living_trees:roots"} })
