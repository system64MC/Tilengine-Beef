using TLN.Enums;
using System;
using TLN.Objects;
using TLN.Tilesets;
using TLN.Palettes;
using TLN.Affine;
using TLN.PixelMap;
using TLN.Color;
using TLN.Maps;

namespace TLN.Layer
{
	[CRepr]
	public struct Layer
	{
		int32 layer;

		public this(int32 layer)
		{
			this.layer = layer;
		}

		// ------------------------------------------------------------------------------------
		// - Layers
		// -	Background layers management.
		// ------------------------------------------------------------------------------------
		// // Configures a background layer with the specified tileset and tilemap.
		// // This function doesn't modify the current position nor the blend mode, but assigns the palette of the specified tileset.
		[LinkName("TLN_SetLayer")]
		private static extern bool setLayer(int32 nlayer, Tileset tileset, Tilemap tilemap);
		// // Configures a background layer with the specified full bitmap.
		// // This function doesn't modify the current position nor the blend mode, but assigns the palette of the specified bitmap.
		[LinkName("TLN_SetLayerBitmap")]
		private static extern bool setLayerBitmap(int32 nlayer, Bitmap bitmap);
		// // Configures a background layer with the specified full tilemap.
		// // This function doesn't modify the current position nor the blend mode, but assigns the palette of the specified tilemap.
		[LinkName("TLN_SetLayerTilemap")]
		private static extern bool setLayerTilemap(int32 nlayer, Tilemap tilemap);
		// // Sets the color palette to the layer.
		// // When a layer is assigned with a tileset with the function TLN_SetLayer(), it automatically sets the palette of the assigned tileset to the layer.
		// // Use this function to override it and set another palette
		// // Call this function inside a raster callback to change the palette in the middle of the frame to get raster effect colors, like and "underwater" palette below the water line in a partially submerged background, or a gradient palette in an area at the top of the screen to simulate a "depth fog effect" in a pseudo 3d background
		[LinkName("TLN_SetLayerPalette")]
		private static extern bool setLayerPalette(int32 nlayer, Palette palette);
		// // Sets the position of the tileset that corresponds to the upper left corner.
		// // The tileset usually spans an area much bigger than the viewport. Use this function to move the viewport insde the tileset. Change this value progressively for each frame to get a scrolling effect.
		// // Call this function inside a raster callback to get a raster scrolling effect. Use this to create horizontal strips of the same layer that move at different speeds to simulate depth. The extreme case of this effect, where the position is changed in each scanline, is called "line scroll" and was the technique used by games such as Street Fighter II to simualte a pseudo 3d floor, or many racing games to simulate a 3D road.
		[LinkName("TLN_SetLayerPosition")]
		private static extern bool setLayerPosition(int32 nlayer, int32 hstart, int32 vstart);
		// // Sets simple scaling.
		// // By default the scaling factor of a given layer is 1.0f, 1.0f, which means no scaling. Use values below 1.0 to downscale (shrink) and above 1.0 to upscale (enlarge). Call TLN_ResetLayerMode() to disable scaling.
		[LinkName("TLN_SetLayerScaling")]
		private static extern bool setLayerScaling(int32 nlayer, float xfactor, float yfactor);
		// // Sets affine transform matrix to enable rotating and scaling of this layer.
		// // Enable the transformation matrix to give the layer the capabilities of the famous Super Nintendo / Famicom Mode 7. Beware that the rendering of a transformed layer uses more CPU than a regular layer. Unlike the original Mode 7, that could only transform the single layer available, Tilengine can transform all the layers at the same time. The only limitation is the available CPU power.
		// // Call this function inside a raster callback to set the transformation matrix in the middle of the frame. Setting it for each scanline is the trick used by many Super Nintendo games to fake a 3D perspective projection.
		[LinkName("TLN_SetLayerAffineTransform")]
		private static extern bool setLayerAffineTransform(int32 nlayer, in Affine affine);
		// private static extern bool setLayerAffineTransform(int32 nlayer, Affine* affine);
		// // Sets affine transform matrix to enable rotating and scaling of this layer.
		// // This function is a simple wrapper to TLN_SetLayerAffineTransform() without using the TLN_Affine struct
		[LinkName("TLN_SetLayerTransform")]
		private static extern bool setLayerTransform(int32 layer, float angle, float dx, float dy, float sx, float sy);
		// Sets the table for pixel mapping render mode.
		[LinkName("TLN_SetLayerPixelMapping")]
		private static extern bool setLayerPixelMapping(int32 nlayer, PixelMap* table);
		// // Sets the blending mode (transparency effect).
		[LinkName("TLN_SetLayerBlendMode")]
		private static extern bool setLayerBlendMode(int32 nlayer, Blend mode, uint8 factor);
		// // Enables column offset mode for this layer.
		// // Column offset is a value that is added or substracted (depeinding on the sign) to the vertical position for that layer (see TLN_SetLayerPosition) for each column in the tilemap assigned to that layer.
		// // This feature is tipically used to simulate vertical strips moving at different speeds, or combined with a line scroll effect, to fake rotations where the angle is small. The Sega Genesis games Puggsy and Chuck Rock II used this trick to simulate partially rotating backgrounds
		[LinkName("TLN_SetLayerColumnOffset")]
		private static extern bool setLayerColumnOffset(int32 nlayer, int32* offset);
		// // Enables clipping rectangle on selected layer.
		[LinkName("TLN_SetLayerClip")]
		private static extern bool setLayerClip(int32 nlayer, int32 x1, int32 y1, int32 x2, int32 y2);
		// // Disables clipping rectangle on selected layer.
		[LinkName("TLN_DisableLayerClip")]
		private static extern bool disableLayerClip(int32 nlayer);

		[LinkName("TLN_SetLayerWindow")]
		private static extern bool setLayerWindow(int32 nlayer, int32 x1, int32 y1, int32 x2, int32 y2, bool invert);

		[LinkName("TLN_SetLayerWindowColor")]
		private static extern bool setLayerWindowColor(int32 nlayer, uint8 r, uint8 g, uint8 b, Blend blend);

		[LinkName("TLN_DisableLayerWindow")]
		private static extern bool disableLayerWindow(int32 nlayer);

		[LinkName("TLN_DisableLayerWindowColor")]
		private static extern bool disableLayerWindowColor(int32 nlayer);

		// // Enables mosaic effect (pixelation) for selected layer.
		[LinkName("TLN_SetLayerMosaic")]
		private static extern bool setLayerMosaic(int32 nlayer, int32 width, int32 height);
		// // Disables mosaic effect for selected layer.
		[LinkName("TLN_DisableLayerMosaic")]
		private static extern bool disableLayerMosaic(int32 nlayer);
		// // Disables scaling or affine transform for the layer.
		[LinkName("TLN_ResetLayerMode")]
		private static extern bool resetLayerMode(int32 nlayer);
		// // Configures a background layer with a object list and an image-based tileset.
		[LinkName("TLN_SetLayerObjects")]
		private static extern bool setLayerObjects(int32 nlayer, ObjectList objects, Tileset tileset);
		// // Sets full Layer priority, appearing in front of Sprites.
		[LinkName("TLN_SetLayerPriority")]
		private static extern bool setLayerPriority(int32 nlayer, bool enable);
		// // Sets parent Layer index to scroll in sync.
		// // A layer with a parent gets scroll position from its parent, so they scroll together
		[LinkName("TLN_SetLayerParent")]
		private static extern bool setLayerParent(int32 nlayer, int32 parent);
		// // Disables Layer parent.
		[LinkName("TLN_DisableLayerParent")]
		private static extern bool disableLayerParent(int32 nlayer);
		// // Disables the specified Layer so it is not drawn.
		[LinkName("TLN_DisableLayer")]
		private static extern bool disableLayer(int32 nlayer);

		[LinkName("TLN_EnableLayer")]
		private static extern bool enableLayer(int32 nlayer);

		[LinkName("TLN_GetLayerType")]
		private static extern LayerType getLayerType(int32 nlayer);

		// // Gets the attached Palette of a Layer.
		[LinkName("TLN_GetLayerPalette")]
		private static extern Palette getLayerPalette(int32 nlayer);

		[LinkName("TLN_GetLayerTileset")]
		private static extern Tileset getLayerTileset(int32 nlayer);

		[LinkName("TLN_GetLayerTilemap")]
		private static extern Tilemap getLayerTilemap(int32 nlayer);

		[LinkName("TLN_GetLayerBitmap")]
		private static extern Bitmap getLayerBitmap(int32 nlayer);

		[LinkName("TLN_GetLayerObjects")]
		private static extern ObjectList getLayerObjects(int32 nlayer);
		// // Gets info about the tile located in Tilemap space.
		// // Use this function to implement collision detection between sprites and the main background layer.
		[LinkName("TLN_GetLayerTile")]
		public static extern bool getLayerTile(int32 nlayer, int32 x, int32 y, TileInfo* info);
		// Returns the Layer Width in pixels.
		[LinkName("TLN_GetLayerWidth")]
		private static extern int  getLayerWidth(int32 nlayer);
		// // Returns the Layer Height in pixels.
		[LinkName("TLN_GetLayerHeight")]
		private static extern int  getLayerHeight(int32 nlayer);

		[LinkName("TLN_GetLayerX")]
		private static extern int32 getLayerX(int32 nlayer);

		[LinkName("TLN_GetLayerY")]
		private static extern int32 getLayerY(int32 nlayer);

		public bool Setup(Tileset tileset, Tilemap tilemap)
		{
			return setLayer(this.layer, tileset, tilemap);
		}

		public bool SetPosition(int x, int y)
		{
			return setLayerPosition(layer, (int32)x, (int32)y);
		}

		public bool SetScaling(float xFactor, float yFactor)
		{
			return setLayerScaling(layer, xFactor, yFactor);
		}

		public bool SetTransform(float angle, float dx, float dy, float sx, float sy)
		{
			return setLayerTransform(layer, angle, dx, dy, sx, sy);
		}

		public bool SetBlendMode(Blend mode, uint8 factor)
		{
			return setLayerBlendMode(layer, mode, factor);
		}

		public bool SetClip(int x1, int y1, int x2, int y2)
		{
			return setLayerClip(layer, (int32)x1, (int32)y1, (int32)x2, (int32)y2);
		}

		public bool DisableClip()
		{
			return disableLayerClip(layer);
		}

		public bool SetWindow(int x1, int y1, int x2, int y2, bool invert)
		{
			return setLayerWindow(layer, (int32)x1, (int32)y1, (int32)x2, (int32)y2, (bool)invert);
		}

		public bool SetWindowColor(uint8 r, uint8 g, uint8 b, Blend blend)
		{
			return setLayerWindowColor(layer, r, g, b, blend);
		}

		public bool SetWindowColor(Color color, Blend blend)
		{
			return setLayerWindowColor(layer, color.r, color.g, color.b, blend);
		}

		public bool DisableWindow()
		{
			return disableLayerWindow(layer);
		}

		public bool DisableWindowColor()
		{
			return disableLayerWindowColor(layer);
		}

		public bool SetMosaic(int width, int height)
		{
			return setLayerMosaic(layer, (int32)width, (int32)height);
		}

		public bool DisableMosaic()
		{
			return disableLayerMosaic(layer);
		}

		public bool ResetMode()
		{
			return resetLayerMode(layer);
		}

		public bool SetObjects(ObjectList objects, Tileset tileset)
		{
			return setLayerObjects(layer, objects, tileset);
		}

		public bool DisableParent()
		{
			return disableLayerParent(layer);
		}

		public int Mosaic
		{
			set
			{
				if (value != 0)
					setLayerMosaic(layer, (int32)value, (int32)value);
				else
					disableLayerMosaic(layer);
			}
		}

		public Bitmap Bitmap
		{
			get => getLayerBitmap(layer);
			set => setLayerBitmap(layer, value);
		}

		public Tilemap Tilemap
		{
			get => getLayerTilemap(layer);
			set => setLayerTilemap(layer, value);
		}

		public Tileset Tileset
		{
			get => getLayerTileset(layer);
			set => setLayer(layer, value, getLayerTilemap(layer));
		}

		public Palette Palette
		{
			get => getLayerPalette(layer);
			set => setLayerPalette(layer, value);
		}

		public Affine Affine
		{
			set => setLayerAffineTransform(layer, value);
		}

		public PixelMap[] PixelMapping
		{
			set => setLayerPixelMapping(layer, &value[0]);
		}

		public int32[] ColumnOffsets
		{
			set => setLayerColumnOffset(layer, &value[0]);
		}

		public bool Priority
		{
			set => setLayerPriority(layer, value);
		}

		public Layer Parent
		{
			set
			{
				if (value.layer >= 0)
				{
					setLayerParent(layer, value.layer);
				}
				else
					disableLayerParent(layer);
			}
		}

		public bool Enable
		{
			set
			{
				if (value)
					enableLayer(layer);
				else
					disableLayer(layer);
			}
		}

		public LayerType Type
		{
			get => getLayerType(layer);
		}

		public ObjectList Objects
		{
			get => getLayerObjects(layer);
		}

		public TileInfo this[int x, int y]
		{
			get
			{
				var infos = TileInfo();
				Runtime.Assert(getLayerTile(layer, (int32)x, (int32)y, &infos));
				return infos;
			}
		}

		public void GetTile(int x, int y, ref TileInfo infos)
		{
			getLayerTile(layer, (int32)x, (int32)y, &infos);
		}

		public int Width
		{
			get => getLayerWidth(layer);
		}

		public int Height
		{
			get => getLayerHeight(layer);
		}

		public int X
		{
			get => getLayerX(layer);
			set => setLayerPosition(layer, (int32)value, getLayerY(layer));
		}

		public int Y
		{
			get => getLayerX(layer);
			set => setLayerPosition(layer, getLayerX(layer), (int32)value);
		}
	}
}
