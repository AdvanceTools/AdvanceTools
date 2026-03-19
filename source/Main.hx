package;

import openfl.display.Sprite;
import openfl.events.Event;
import openfl.Lib;

#if html5
import js.Browser;
#end

class Main extends Sprite
{
	// =========================
	// SINGLETON
	// =========================
	public static var instance:Main;

	// =========================
	// ENGINE STATE
	// =========================
	public var started:Bool = false;
	public var paused:Bool = false;

	// Delta time (profissional)
	public var lastTime:Float = 0;
	public var deltaTime:Float = 0;

	// FPS control
	public var targetFPS:Int = 60;

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

		trace("=== AdvanceTools Engine Boot ===");

		setupStage();
		setupPlatform();
		setupSystems();

		lastTime = Lib.getTimer();

		started = true;

		addEventListener(Event.ENTER_FRAME, update);

		// Lifecycle
		stage.addEventListener(Event.DEACTIVATE, onPause);
		stage.addEventListener(Event.ACTIVATE, onResume);
	}

	// =========================
	// STAGE SETUP
	// =========================
	function setupStage():Void
	{
		stage.frameRate = targetFPS;
	}

	// =========================
	// PLATFORM
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
	// SYSTEM INIT
	// =========================
	function setupSystems():Void
	{
		trace("Initializing Systems...");

		#if ENABLE_AI_MODULE
		trace("> AI Module Enabled");
		#end

		#if ENABLE_UTILS
		trace("> Utils Module Enabled");
		#end

		// FUTURO:
		// AIManager.init();
		// InputSystem.init();
		// CameraSystem.init();
		// ModchartSystem.init();
	}

	// =========================
	// UPDATE LOOP
	// =========================
	function update(e:Event):Void
	{
		if (!started || paused) return;

		// Delta time calculation
		var currentTime = Lib.getTimer();
		deltaTime = (currentTime - lastTime) / 1000;
		lastTime = currentTime;

		engineUpdate(deltaTime);
	}

	// =========================
	// ENGINE UPDATE
	// =========================
	function engineUpdate(dt:Float):Void
	{
		// Aqui roda tudo por frame

		// Exemplo futuro:
		// AIManager.update(dt);
		// Input.update(dt);
		// Camera.update(dt);

		#if debug
		debugInfo(dt);
		#end
	}

	// =========================
	// DEBUG SYSTEM
	// =========================
	function debugInfo(dt:Float):Void
	{
		var fps = Std.int(1 / dt);
		trace("FPS: " + fps + " | DT: " + dt);
	}

	// =========================
	// PAUSE / RESUME
	// =========================
	function onPause(e:Event):Void
	{
		if (paused) return;

		paused = true;
		trace("Game Paused");

		// FUTURO:
		// Audio.pauseAll();
	}

	function onResume(e:Event):Void
	{
		if (!paused) return;

		paused = false;
		trace("Game Resumed");

		lastTime = Lib.getTimer(); // evita bug de delta gigante
	}

	// =========================
	// ENTRY POINT
	// =========================
	public static function main():Void
	{
		Lib.current.addChild(new Main());
	}
}