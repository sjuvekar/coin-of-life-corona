-----------------------------------------------------------------------------------------
--
-- level1.lua
--
-----------------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

-- include Corona's "widget" library
local widget = require "widget"

-- include Corona's "physics" library
local physics = require "physics"
physics.start(); physics.pause()

-- Include util
local util = require( "util" )

--------------------------------------------

-- forward declarations and other locals
local screenW, screenH, halfW = display.contentWidth, display.contentHeight, display.contentWidth*0.5

-----------------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
-- 
-- NOTE: Code outside of listener functions (below) will only be executed once,
--		 unless storyboard.removeScene() is called.
-- 
-----------------------------------------------------------------------------------------
-- Buttons
local playBtn, undoBtn, resetBtn

-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view

	local num_cells = util.num_cells
	local cell_width = util.cell_width
	local cell_height = util.cell_height
	local arena_width = util.arena_width
	local arena_height = util.arena_height
	
	
	for i = 1,num_cells do
		-- Horizontal lines
		local sh = display.newRect(cell_width, cell_height * i, arena_width, cell_height)
		sh:setFillColor(0, 0, 0)
		sh:setStrokeColor(255, 255, 255)
		sh.strokeWidth = 3
	end
	
	for i = 1,num_cells do
		-- Vertical lines
		local sv = display.newRect(cell_width * i, cell_height, cell_width, arena_height)
		sv:setFillColor(0, 0, 0)
		sv:setStrokeColor(255, 255, 255)
		sv.strokeWidth = 3
		sv.alpha = 0.5
	end
	
	-- Draw button
	playBtn = widget.newButton{
		label="Play",
		defaultFile=util.button_image,
		overFile=util.active_button_image,
		width=256, height=64,
		onRelease = onPlayBtnRelease	-- event listener function
	}
	playBtn.x = arena_width + 2 * cell_width + 128
	playBtn.y = 1.5 * cell_height
	
	undoBtn = widget.newButton{
		label="Undo",
		defaultFile=util.button_image,
		overFile=util.active_button_image,
		width=256, height=64,
		onRelease = onPlayBtnRelease	-- event listener function
	}
	undoBtn.x = playBtn.x
	undoBtn.y = playBtn.y + 2 * cell_height
	
	resetBtn = widget.newButton{
		label="Reset",
		defaultFile=util.button_image,
		overFile=util.active_button_image,
		width=256, height=64,
		onRelease = onPlayBtnRelease	-- event listener function
	}
	resetBtn.x = playBtn.x
	resetBtn.y = playBtn.y + 4 * cell_height
	
	-- Draw Time bar
	local timeText = display.newText("Time", 0, 0, native.systemFont, 32)
	timeText.x = playBtn.x
	timeText.y = playBtn.y + 12 * cell_height
	
	-- Draw Rect
	local timeRect = display.newRect(2 * cell_width + arena_width, timeText.y + cell_height, 256, 20)
	timeRect:setFillColor(153, 101, 21)
end

-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view
	
	physics.start()
	
end

-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view
	
	physics.stop()
	
end

-- If scene's view is removed, scene:destroyScene() will be called just prior to:
function scene:destroyScene( event )
	local group = self.view
	
	package.loaded[physics] = nil
	physics = nil
end

-----------------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
-----------------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "exitScene" event is dispatched whenever before next scene's transition begins
scene:addEventListener( "exitScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )

-----------------------------------------------------------------------------------------

return scene
