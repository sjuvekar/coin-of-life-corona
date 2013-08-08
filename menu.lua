-----------------------------------------------------------------------------------------
--
-- menu.lua
--
-----------------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

-- include Corona's "widget" library
local widget = require "widget"

--------------------------------------------

-- forward declarations and other locals
local playBtn
local tutBtn

-- 'onRelease' event listener for playBtn
local function onPlayBtnRelease()
	
	-- go to level1.lua scene
	storyboard.gotoScene( "level1", "fade", 500 )
	
	return true	-- indicates successful touch
end

-----------------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
-- 
-- NOTE: Code outside of listener functions (below) will only be executed once,
--		 unless storyboard.removeScene() is called.
-- 
-----------------------------------------------------------------------------------------

-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view

	
	-- create/position logo/title image on upper-half of the screen
	local titleLogo = display.newImageRect( "logo.png", 384, 384 )
	titleLogo:setReferencePoint( display.CenterReferencePoint )
	titleLogo.x = display.contentWidth * 0.5
	titleLogo.y = 256
	
	-- create a widget button (which will loads level1.lua on release)
	playBtn = widget.newButton{
		label="Play",
		defaultFile="button.png",
		overFile="active_button.png",
		width=192, height=64,
		onRelease = onPlayBtnRelease	-- event listener function
	}
	playBtn:setReferencePoint( display.CenterReferencePoint )
	playBtn.x = display.contentWidth*0.5 - 100
	playBtn.y = display.contentHeight - 125
	
	-- Create a button for tutorial
	tutBtn = widget.newButton{
		label="Tutorial",
		defaultFile="button.png",
		overFile="active_button.png",
		width=192, height=64,
		onRelease = onPlayBtnRelease	-- event listener function
	}
	tutBtn:setReferencePoint( display.CenterReferencePoint )
	tutBtn.x = display.contentWidth*0.5 + 100
	tutBtn.y = display.contentHeight - 125
	
	local titleText = display.newText("The most addictive coin game ever!", 0, 0, native.systemFont, 32)
	titleText:setTextColor(183, 154, 0)
	titleText:setReferencePoint( display.CenterReferencePoint )
	titleText.x = display.contentWidth*0.5
	titleText.y = display.contentHeight - 250
	
	
	local punchText = display.newText("Place coins on board, watch them evolve, earn gems, diamonds and rocks!", 0, 0, native.systemFont, 20)
	punchText:setTextColor(255, 255, 255)
	punchText:setReferencePoint( display.CenterReferencePoint )
	punchText.x = display.contentWidth*0.5
	punchText.y = display.contentHeight - 200
	
	
	-- all display objects must be inserted into group
	-- group:insert( background )
	group:insert( titleLogo )	
	group:insert( playBtn )
	group:insert( tutBtn )
	group:insert( titleText )
	group:insert( punchText )
	
end

-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view
	
	-- INSERT code here (e.g. start timers, load audio, start listeners, etc.)
	
end

-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view
	
	-- INSERT code here (e.g. stop timers, remove listenets, unload sounds, etc.)
	
end

-- If scene's view is removed, scene:destroyScene() will be called just prior to:
function scene:destroyScene( event )
	local group = self.view
	
	if playBtn then
		playBtn:removeSelf()	-- widgets must be manually removed
		playBtn = nil
	end
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