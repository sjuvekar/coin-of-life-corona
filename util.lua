-- Define all parameters required for scenes
local params = { }

-- Images
params["button_image"] = "button.png"
params["active_button_image"] = "active_button.png"
params["logo_image"] = "logo.png"
params["coin_image"] = "coin.png"
params["gem_image"] = "gem.png"
params["diamond_image"] = "diamond.png"
params["rock_image"] = "rock.png"

-- Number of cells in a row/columns
params["num_cells"] = 14

-- Board dimensions
params["cell_height"] = display.contentHeight / (params["num_cells"] + 2)
params["cell_width"] = params["cell_height"]
params["arena_height"] = params["cell_height"] * params["num_cells"]
params["arena_width"] = params["cell_width"] * params["num_cells"]


return params
