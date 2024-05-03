using TLN.Enums;
using System;
using TLN.Color;
using TLN.Maps;
using TLN.Palettes;
using TLN.Layer;
using TLN.Sprites;

namespace TLN.Engine
{
	// public function void VideoCallback(int scanline);
	public typealias RasterCallback = function void(void* userData, int32 scanline);
	internal typealias _vcb = function void(int32 scanline);
	public typealias FrameCallback = function void(void* userData, int32 frame);
	// public typealias VideoDelegate = delegate void(int scanline);
	public typealias BlendFunction = function uint8(uint8 src, uint8 dst);

	internal class _globals
	{
		public static RasterCallback _rCallback;
		public static FrameCallback _fCallback;
		public static void* _rasterUserData;
		public static void* _frameUserData;

		public static void rCB(int32 scanline)
		{
			if (_rCallback != null)
			{
				_rCallback(_rasterUserData, scanline);
			}
		}

		public static void fCB(int32 frame)
		{
			if (_fCallback != null)
				_fCallback(_frameUserData, frame);
		}
	}

	public struct _Palettes
	{
		[LinkName("TLN_SetGlobalPalette")]
		private static extern bool setGlobalPalette(int32 index, Palette palette);
		[LinkName("TLN_GetGlobalPalette")]
		private static extern Palette getGlobalPalette(int32 index);

		public Palette this[int index]
		{
			set => setGlobalPalette((int32)index, value);
			get => getGlobalPalette((int32)index);
		}
	}

	public struct _Layers
	{
		public Layer this[int index]
		{
			get => Layer((int32)index);
		}
	}

	public struct _Sprites
	{
		public Sprite this[int index]
		{
			get => Sprite((int32)index);
		}
	}

	[CRepr]
	public struct Engine
	{
		Engine* Engine;

		// ------------------------------------------------------------------------------------
		// - Setup
		// -	Basic setup and management
		// ------------------------------------------------------------------------------------

		// // Initializes the graphic engine in 32 bpp pixel format.
		// // Creates the Viewport with the specified dimensions and allocates the number of Layers, Sprites and Animation slots.
		[LinkName("TLN_Init")]
		private static extern Engine init(int32 hres, int32 vres, int32 numlayers, int32 numsprites, int32 numanimations);
		// // Deinitializes current engine context and frees used resources.
		[LinkName("TLN_Deinit")]
		public static extern void Deinit();
		// // Deletes explicit context.
		[LinkName("TLN_DeleteContext")]
		private static extern bool deleteContext(Engine context);
		// // Sets current engine context.
		[LinkName("TLN_SetContext")]
		private static extern bool setContext(Engine context);
		// // Returns the current engine context.
		[LinkName("TLN_GetContext")]
		private static extern Engine getContext();
		[LinkName("TLN_SetTargetFps")]
		private static extern void setTargetFPS(int32 fps);
		[LinkName("TLN_GetTargetFps")]
		private static extern int getTargetFPS();
		// // Returns the Width in pixels of the framebuffer.
		[LinkName("TLN_GetWidth")]
		private static extern int32 getWidth();
		// // Returns the Height in pixels of the framebuffer.
		[LinkName("TLN_GetHeight")]
		private static extern int32 getHeight();
		// // Returns the pixel format of the framebuffer.
		[LinkName("TLN_GetBPP")]
		private static extern int32 getBPP();
		// // Returns the number of Objects(The total amount of Tilesets, Tilemaps, Spritesets, Palettes or Sequences combined) used by the engine so far.
		[LinkName("TLN_GetNumObjects")]
		private static extern uint32 getNumObjects();
		// // Returns the total amount of memory used by the Objects.
		[LinkName("TLN_GetUsedMemory")]
		private static extern uint32 getUsedMemory();
		// // Retrieves Tilengine DLL version.
		[LinkName("TLN_GetVersion")]
		private static extern uint32 getVersion();
		// // Returns the number of layers specified during initialization.
		[LinkName("TLN_GetNumLayers")]
		private static extern int getNumLayers();
		// // Returns the number of sprites specified during initialization.
		[LinkName("TLN_GetNumSprites")]
		private static extern int getNumSprites();
		// // Sets the background color; the color of the pixel when there isn't any layer or sprite at that position.
		// // This function can be called during a raster callback to create gradient backgrounds
		[LinkName("TLN_SetBGColor")]
		public static extern void SetBGColor(uint8 r, uint8 g, uint8 b);

		// // Disables background color rendering.
		// // If you know that the last background layer will always cover the entire screen, you can disable it to gain some performance.
		[LinkName("TLN_DisableBGColor")]
		public static extern void DisableBGColor();
		// // Sets a static Bitmap as background.
		// // Sets an optional Bitmap instead of a solid color where there is no Layer or Sprite. Unlike Tilemaps or Sprites, this Bitmap cannot be moved and has no transparency
		[LinkName("TLN_SetBGBitmap")]
		private static extern bool setBGBitmap(Bitmap bitmap);
		// // Changes the Palette for the background Bitmap.
		[LinkName("TLN_SetBGPalette")]
		private static extern bool setBGPalette(Palette palette);
		// // Set RasterCallback for Raster Effects
		[LinkName("TLN_SetRasterCallback")]
		public static extern void setRasterCallback(Engine._vcb cb);

		// [LinkName("TLN_SetRasterCallback")]
		// public static extern void SetRasterCallback(VideoDelegate callback);
		// // Set Frame Callback
		[LinkName("TLN_SetFrameCallback")]
		private static extern void setFrameCallback(Engine._vcb cb);
		// [LinkName("TLN_SetFrameCallback")]
		// public static extern void SetFrameCallback(VideoDelegate callback);
		// // Sets the output surface for rendering. The render target pixel format must be 32 bits RGBA
		[LinkName("TLN_SetRenderTarget")]
		private static extern void setRenderTarget(uint8* data, int32 pitch);
		// // Draws the frame to the previously specified render target.
		// // The time value is application defined, but its units must match the same used in the sequences xml file. It usually is the frame number or millisecond count
		[LinkName("TLN_UpdateFrame")]
		private static extern void updateFrame(int32 time);
		// // Sets base path for TLN_LoadXXX functions.
		[LinkName("TLN_SetLoadPath")]
		private static extern void SetLoadPath(char8* path);
		// // Sets custom blend function to use when Blend.Custom mode is selected.
		[LinkName("TLN_SetCustomBlendFunction")]
		private static extern void setCustomBlendFunction(BlendFunction callback);
		// // Sets logging level for current instance.
		[LinkName("TLN_SetLogLevel")]
		private static extern void setLogLevel(LogLevel log_level);
		// // Open the resource package with optional aes-128 key and binds it.
		[LinkName("TLN_OpenResourcePack")]
		private static extern bool openResourcePack(char8* filename, char8* key);
		// // Closes current resource package and unbinds it.
		[LinkName("TLN_CloseResourcePack")]
		public static extern void CloseResourcePack();

		public this(int hres, int vres, int numlayers = 4, int numsprites = 64, int numanimations = 64)
		{
			this.Engine = init((int32)hres, (int32)vres, (int32)numlayers, (int32)numsprites, (int32)numanimations).Engine;
			// setRasterCallback((scanline) => { _globals.fCB(scanline); });
			setRasterCallback( => _globals.rCB);
			setFrameCallback( => _globals.fCB);
		}

		public bool Delete() mut
		{
			var res = deleteContext(this);
			if (res)
				this.Engine = null;
			return res;
		}

		public bool IsNull
		{
			get => this.Engine == null;
		}

		public static void SetRasterCallback(void* userData, RasterCallback callback)
		{
			_globals._rCallback = callback;
			_globals._rasterUserData = userData;
		}

		public static void SetFrameCallback(void* userData, FrameCallback callback)
		{
			_globals._fCallback = callback;
			_globals._frameUserData = userData;
		}

		public static void SetRenderTarget(uint8[] data, int pitch)
		{
			setRenderTarget(&data[0], (int32)pitch);
		}

		public static void UpdateFrame(int time)
		{
			updateFrame((int32)time);
		}

		public static bool OpenResourcePack(String filename, String key)
		{
			return openResourcePack(filename, key);
		}

		public static String LoadPath
		{
			set => SetLoadPath(value);
		}

		public static Engine Context
		{
			get => getContext();
			set => setContext(value);
		}

		public static BlendFunction BlendFunction
		{
			set => setCustomBlendFunction(value);
		}

		public static LogLevel LogLevel
		{
			set => setLogLevel(value);
		}

		public static int Width
		{
			get => getWidth();
		}

		public static int Height
		{
			get => getHeight();
		}

		public static int BPP
		{
			get => getBPP();
		}

		public static int NumObjects
		{
			get => getNumObjects();
		}

		public static int UsedMemory
		{
			get => getUsedMemory();
		}

		public static int Version
		{
			get => getVersion();
		}

		public static int NumLayers
		{
			get => getNumLayers();
		}

		public static int NumSprites
		{
			get => getNumSprites();
		}

		public static Color BgColor
		{
			set => SetBGColor(value.r, value.g, value.b);
		}

		public static Bitmap BgBitmap
		{
			set => setBGBitmap(value);
		}

		public static Palette BgPalette
		{
			set => setBGPalette(value);
		}

		public static RasterCallback RasterCallback
		{
			set => _globals._rCallback = value;
		}

		public static void* RasterUserData
		{
			set => _globals._rasterUserData = value;
		}

		public static FrameCallback FrameCallback
		{
			set => _globals._fCallback = value;
		}

		public static void* FrameUserData
		{
			set => _globals._frameUserData = value;
		}

		public static int TargetFPS
		{
			get => getTargetFPS();
			set => setTargetFPS((int32)value);
		}

		public static _Palettes Palettes
		{
			get => _Palettes();
		}

		public static _Layers Layers
		{
			get => _Layers();
		}

		public static _Sprites Sprites
		{
			get => _Sprites();
		}

	} // Engine context
}
