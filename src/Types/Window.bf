using System;
using TLN.Enums;

namespace TLN.Window
{
	[CRepr]
	public struct Window
	{
		// [Union]
		// public struct SDL_Event;
		public typealias SDLCallback = function void(in uint32 sdlEvent);
		// public delegate void SDLCallback(in uint32 sdlEvent);
		// ------------------------------------------------------------------------------------
		// - Windowing
		// -	Built-in window and input management.
		// ------------------------------------------------------------------------------------
		// // Creates a window for rendering.
		// // Using this feature is optional, Tilengine is designed to output its rendering to a user-provided surface so it can be used as a backend renderer of an already existing framework.
		// // But it is provided for convenience, so it isn't needed to provide external components to run the examples or do engine tests.
		[LinkName("TLN_CreateWindow")]
		private static extern bool createWindow(char8* overlay, WindowFlags flags);
		// // Creates a Multithreaded Window for rendering.
		// // Unlike TLN_CreateWindow, This Window runs in its own thread.
		[LinkName("TLN_CreateWindowThread")]
		private static extern bool createWindowThread(char8* overlay, WindowFlags flags);
		// // Sets Window Title.
		[LinkName("TLN_SetWindowTitle")]
		private static extern void setWindowTitle(char8* title);
		// // Does basic Window housekeeping in single-threaded Window.
		[LinkName("TLN_ProcessWindow")]
		private static extern bool processWindow();
		// // Checks Window state.
		[LinkName("TLN_IsWindowActive")]
		private static extern bool isWindowActive();
		// // Returns the state of a given player controlled Input.
		[LinkName("TLN_GetInput")]
		public static extern bool getInput(Input id);
		// // Enables or disables Input for specified Player.
		[LinkName("TLN_EnableInput")]
		private static extern void enableInput(Player player, bool enable);
		// // Assigns a Joystick index to the specified Player.
		[LinkName("TLN_AssignInputJoystick")]
		private static extern void assignInputJoystick(Player player, int32 index);
		// // Assigns a Keyboard Input to a Player.
		[LinkName("LN_DefineInputKey")]
		private static extern void defineInputKey(Player player, Input input, uint32 keycode);
		// // Assigns a button Joystick Input to a Player.
		[LinkName("TLN_DefineInputButton")]
		private static extern void defineInputButton(Player player, Input input, uint8 joybutton);
		// // Draws a frame to the Window.
		[LinkName("TLN_DrawFrame")]
		private static extern void drawFrame(int32 time);
		// // Thread synchronization for multi-threaded Window. Waits until the current frame has ended rendering.
		[LinkName("TLN_WaitRedraw")]
		private static extern void waitRedraw();
		// // Deletes the Window previously created with TLN_CreateWindow() or TLN_CreateWindowThread()
		[LinkName("TLN_DeleteWindow")]
		private static extern void deleteWindow();
		// // Removed in release 1.12, use TLN_EnableCRTEffect() instead.
		[LinkName("TLN_EnableBlur")]
		private static extern void enableBlur(bool mode);
		[LinkName("TLN_ConfigCRTEffect")]
		private static extern void configCrtEffect(CRT type, bool blur);
		// // Enables CRT simulation post-processing effect to give true retro appearance.
		[LinkName("TLN_EnableCRTEffect")]
		private static extern void enableCRTEffect(Overlay overlay, uint8 overlay_factor, uint8 threshold, uint8 v0, uint8 v1, uint8 v2, uint8 v3, bool blur, uint8 glow_factor);
		// // Disables the CRT post-processing effect.
		[LinkName("TLN_DisableCRTEffect")]
		private static extern void disableCRTEffect();
		// // Registers a user-defined callback to capture internal SDL2 events.
		[LinkName("TLN_SetSDLCallback")]
		private static extern void setSDLCallback(SDLCallback callback); // This might not work... We shall see hopefully.
		// // Suspends execution for a fixed time.
		[LinkName("TLN_Delay")]
		private static extern void delay(uint32 msecs);
		// // Returns the number of milliseconds since application start.
		[LinkName("TLN_GetTicks")]
		private static extern uint32 getTicks();
		// // Returns the average FPS.
		[LinkName("TLN_GetAverageFps")]
		private static extern uint32 getAverageFps();
		// // Returns Horizontal dimension of Window after scaling.
		[LinkName("TLN_GetWindowWidth")]
		private static extern int32 getWindowWidth();
		// // Returns Vertical dimension of Window after scaling.
		[LinkName("TLN_GetWindowHeight")]
		private static extern int32 getWindowHeight();

		[LinkName("TLN_GetWindowScaleFactor")]
		private static extern int32 getWindowScaleFactor();

		[LinkName("TLN_SetWindowScaleFactor")]
		private static extern void setWindowScaleFactor(int32 value);

		public static bool Create(String overlay, WindowFlags flags)
		{
			return createWindow(overlay, flags);
		}

		public static bool CreateThreaded(String overlay, WindowFlags flags)
		{
			return createWindowThread(overlay, flags);
		}

		public static void Draw(int frame = 0)
		{
			drawFrame((int32)frame);
		}

		public static void Delete()
		{
			deleteWindow();
		}

		public static void WaitRedraw()
		{
			waitRedraw();
		}

		public static void Delay(int time)
		{
			delay((uint32)time);
		}

		public static String Title
		{
			set => setWindowTitle(value);
		}

		public static bool Processing
		{
			get => processWindow();
		}

		public static bool Active
		{
			get => isWindowActive();
		}

		public static int Ticks
		{
			get => getTicks();
		}

		public static int Width
		{
			get => getWindowWidth();
		}

		public static int Height
		{
			get => getWindowHeight();
		}

		public static SDLCallback Callback
		{
			set => setSDLCallback(value);
		}

		public static bool Blur
		{
			set => enableBlur(value);
		}

		public static int ScaleFactor
		{
			get => (int)getWindowScaleFactor();
			set => setWindowScaleFactor((int32)value);
		}

		public static int AvgFPS
		{
			get => (int)getAverageFps();
		}

		public static void ConfigCRT(CRT type, bool blur)
		{
			configCrtEffect(type, blur);
		}

		public static void EnableCRT(Overlay overlay, uint8 overlay_factor, uint8 threshold, uint8 v0, uint8 v1, uint8 v2, uint8 v3, bool blur, uint8 glow_factor)
		{
			enableCRTEffect(overlay, overlay_factor, threshold, v0, v1, v2, v3, blur, glow_factor);
		}

		public static void DisableCRT()
		{
			disableCRTEffect();
		}

		public static void DefineInputButton(Player player, Input input, uint8 joybutton)
		{
			defineInputButton(player, input, joybutton);
		}

		public static void DefineInputKey(Player player, Input input, uint32 keycode)
		{
			defineInputKey(player, input, keycode);
		}

		public static void AssignInputJoystick(Player player, int32 index)
		{
			assignInputJoystick(player, index);
		}

		public static void EnableInput(Player player, bool enable)
		{
			enableInput(player, enable);
		}

		public static bool Input(Input id)
		{
			return getInput(id);
		}
	}
}