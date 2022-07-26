minetest.register_node("living_trees:apple_roots", {
    description = "Apple roots",
    tiles = { "default_dirt.png^living_trees_roots.png" },
    on_construct = function(pos)
        local meta = minetest.get_meta(pos)
        meta:set_string("lstring", "TTT[^Q[+W-E&R][-W+E&R]][&Q[+W-E^R][-W+E^R]]Q[^W&E^R][&W^E&R][+W-E+R][-W+E-R]")
    end,
    groups = { crumbly = 2, choppy = 1 }
})

minetest.register_node("living_trees:pine_roots", {
    description = "Pine roots",
    tiles = { "default_dirt.png^living_trees_roots.png" },
    on_construct = function(pos)
        local meta = minetest.get_meta(pos)
        meta:set_string("lstring", "TTTT^[QW[+E-R][-E+R]ER]+[QW[+E-R][-E+R]ER]+[QW[+E-R][-E+R]ER]+[QW[+E-R][-E+R]ER]&Q^[WE[+R][-R]R]+[WE[+R][-R]R]+[WE[+R][-R]R]+[WE[+R][-R]R]&1W^[ER]+[ER]+[ER]+[ER]&2E^[R]+[R]+[R]+[R]&3R")
    end,
    groups = { crumbly = 2, choppy = 1 }
})

living_trees.register_tree({ name = "Apple", roots = { "living_trees:apple_roots" }, texture = "default_tree.png", trunk = "default:tree", leaves = "default:leaves" })
living_trees.register_tree({ name = "Pine", roots = { "living_trees:pine_roots" }, texture = "default_pine_tree.png", trunk = "default:pine_tree", leaves = "default:pine_needles" })
