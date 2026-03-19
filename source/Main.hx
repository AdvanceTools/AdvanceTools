package;

import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.DeactivateEvent;
import openfl.Lib;

#if html5
import js.Browser;
#end

#if android
import openfl.events.FocusEvent;
#end

class Main extends Sprite
{
	// =========================
	// CORE
	// =========================
	public static var instance:Main;

	public var started:Bool = false;
	public var paused:Bool = false;

	// =========================
	// CONSTRUCTOR
	// =========================
	public function new()
	{
		super();
		instance = this;

		if (stage != null)
			init();
		else
			addEventListener(Event.ADDED_TO_STAGE, init);
	}

	// =========================
	// INIT
	// =========================
	function init(?e:Event):Void
	{
		removeEventListener(Event.ADDED_TO_STAGE, init);

		trace("AdvanceTools Engine Starting...");

		setupStage();
		setupPlatform();
		setupSystems();

		started = true;

		addEventListener(Event.ENTER_FRAME, update);

		// Lifecycle (mobile + geral)
		stage.addEventListener(Event.DEACTIVATE, onPause);
		stage.addEventListener(Event.ACTIVATE, onResume);
	}

	// =========================
	// STAGE
	// =========================
	function setupStage():Void
	{
		stage.frameRate = 60;
	}

	// =========================
	// PLATFORM DETECTION
	// =========================
	function setupPlatform():Void
	{
		#if html5
		Browser.document.title = "AdvanceTools";
		trace("Platform: HTML5");
		#end

		#if android
		trace("Platform: Android");
		#end

		#if desktop
		trace("Platform: Desktop");
		#end
	}

	// =========================
	// SYSTEMS
	// =========================
	function setupSystems():Void
	{
		#if ENABLE_AI_MODULE
		trace("AI Module Loaded");
		#end

		#if ENABLE_UTILS
		trace("Utils Module Loaded");
		#end

		// Futuro:
		// AIManager.init();
		// InputSystem.init();
		// CameraSystem.init();
	}

	// =========================
	// UPDATE LOOP
	// =========================
	function update(e:Event):Void
	{
		if (!started || paused) return;

		engineUpdate();
	}

	// =========================
	// ENGINE UPDATE
	// =========================
	function engineUpdate():Void
	{
		// Loop principal

		// Exemplo futuro:
		// AIManager.update();
		// Input.update();
	}

	// =========================
	// PAUSE / RESUME
	// =========================
	function onPause(e:Event):Void
	{
		paused = true;
		trace("Game Paused");
	}

	function onResume(e:Event):Void
	{
		paused = false;
		trace("Game Resumed");
	}

	// =========================
	// ENTRY POINT
	// =========================
	public static function main():Void
	{
		Lib.current.addChild(new Main());
	}
}