local lsa = "TTT[^Q[+W-E&R][-W+E&R]][&Q[+W-E^R][-W+E^R]]Q[^W&E^R][&W^E&R][+W-E+R][-W+E-R]"
local lsp = "TTTT^[QW[+E-R][-E+R]ER]+[QW[+E-R][-E+R]ER]+[QW[+E-R][-E+R]ER]+[QW[+E-R][-E+R]ER]&Q^[WE[+R][-R]R]+[WE[+R][-R]R]+[WE[+R][-R]R]+[WE[+R][-R]R]&1W^[ER]+[ER]+[ER]+[ER]&2E^[R]+[R]+[R]+[R]&3R"

living_trees.register_tree({ name = "Apple", lstring = lsa, growthInterval = 5, texture = "default_tree.png", trunk = "default:tree", leaves = "default:leaves" })
living_trees.register_tree({ name = "Pine", lstring = lsp, growthInterval = 1, texture = "default_pine_tree.png", trunk = "default:pine_tree", leaves = "default:pine_needles" })
