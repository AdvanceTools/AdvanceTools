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
	// CORE VARIABLES
	// =========================
	public static var instance:Main;
	public var started:Bool = false;

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
	// INITIALIZATION
	// =========================
	function init(?e:Event):Void
	{
		removeEventListener(Event.ADDED_TO_STAGE, init);

		trace("AdvanceTools Engine Initializing...");

		setupStage();
		setupSystems();

		started = true;

		addEventListener(Event.ENTER_FRAME, update);
	}

	// =========================
	// STAGE CONFIG
	// =========================
	function setupStage():Void
	{
		stage.frameRate = 60;

		#if html5
		Browser.document.title = "AdvanceTools";
		trace("Running on HTML5");
		#end
	}

	// =========================
	// SYSTEM INITIALIZATION
	// =========================
	function setupSystems():Void
	{
		#if ENABLE_AI_MODULE
		trace("AI Module Enabled");
		#end

		#if ENABLE_UTILS
		trace("Utils Module Enabled");
		#end

		// Aqui você pode inicializar:
		// - AI Manager
		// - Input System
		// - Camera System
		// - Modchart System
	}

	// =========================
	// UPDATE LOOP
	// =========================
	function update(e:Event):Void
	{
		if (!started) return;

		// Game loop principal
		engineUpdate();
	}

	// =========================
	// ENGINE UPDATE
	// =========================
	function engineUpdate():Void
	{
		// Aqui roda tudo por frame

		// Exemplo:
		// AIManager.update();
		// Input.update();
		// Camera.update();
	}

	// =========================
	// STATIC ENTRY POINT
	// =========================
	public static function main():Void
	{
		Lib.current.addChild(new Main());
	}
}
