using TLN.Enums;
using System;
using TLN.Palettes;
using TLN.Animations;
using TLN.Maps;
using TLN.TileImage;

namespace TLN.Tilesets
{
	[CRepr]
	public struct Tileset
	{
		Tileset* Tileset;

		// ------------------------------------------------------------------------------------
		// - Tileset
		// -	Resources management for background layers.
		// ------------------------------------------------------------------------------------
		// // Creates a tile-based Tileset.
		[LinkName("TLN_CreateTileset")]
		public static extern Tileset createTileset(int32 numtiles, int32 width, int32 height, Palette palette, SequencePack sp, TileAttributes* attributes);
		// // Creates a multiple image-based Tileset.
		[LinkName("TLN_CreateImageTileset")]
		public static extern Tileset createImageTileset(int32 numtiles, TileImage* images);
		// // Loads a tileset from a Tiled .tsx file.
		[LinkName("TLN_LoadTileset")]
		public static extern Tileset loadTileset(char8* filename);
		// // Creates a duplicate of the specified Tileset and its associated palette.
		[LinkName("TLN_CloneTileset")]
		public static extern Tileset cloneTileset(Tileset src);
		// // Sets pixel data for a tile in a Tileset.
		[LinkName("TLN_SetTilesetPixels")]
		public static extern bool setTilesetPixels(Tileset tileset, int32 entry, uint8* srcdata, int32 srcpitch);
		// // Returns the width in pixels of each individual Tile in the tileset.
		[LinkName("TLN_GetTileWidth")]
		public static extern int32 getTileWidth(Tileset tileset);
		// // Returns the height in pixels of each individual tile in the tileset.
		[LinkName("TLN_GetTileHeight")]
		public static extern int32 getTileHeight(Tileset tileset);
		// // Returns the number of different tiles in tileset.
		[LinkName("TLN_GetTilesetNumTiles")]
		public static extern int32 getTilesetNumTiles(Tileset tileset);
		// // Returns a reference to the Palette associated to the specified tileset.
		[LinkName("TLN_GetTilesetPalette")]
		public static extern Palette getTilesetPalette(Tileset tileset);
		// // Returns a reference to the optional sequence pack associated to the specified tileset.
		[LinkName("TLN_GetTilesetSequencePack")]
		public static extern SequencePack getTilesetSequencePack(Tileset tileset);
		// // Deletes the specified tileset and frees memory.
		[LinkName("TLN_DeleteTileset")]
		public static extern bool deleteTileset(Tileset tileset);

		public this(int numTiles, int width, int height, Palette palette, SequencePack sp, TileAttributes[] attributes)
		{
			this.Tileset = createTileset((int32)numTiles, (int32)width, (int32)height, palette, sp, attributes.CArray()).Tileset;
		}

		public this(TileImage[] images)
		{
			this.Tileset = createImageTileset((int32)images.Count, images.CArray()).Tileset;
		}

		public this(String filename)
		{
			this.Tileset = loadTileset(filename).Tileset;
		}

		public Tileset Clone()
		{
			return cloneTileset(this);
		}

		public bool SetPixels(int entry, uint8[] data, int srcPitch)
		{
			return setTilesetPixels(this, (int32)entry, data.CArray(), (int32)srcPitch);
		}

		public int TileWidth
		{
			get
			{
				return getTileWidth(this);
			}
		}

		public int TileHeight
		{
			get
			{
				return getTileHeight(this);
			}
		}

		public int NumTiles
		{
			get
			{
				return getTilesetNumTiles(this);
			}
		}

		public Palette Palette
		{
			get
			{
				return getTilesetPalette(this);
			}
		}

		public SequencePack SequencePack
		{
			get
			{
				return getTilesetSequencePack(this);
			}
		}

		public bool Delete() mut
		{
			var res = deleteTileset(this);
			if (res)
				this.Tileset = null;
			return res;
		}

		public bool IsNull
		{
			get => this.Tileset == null;
		}
	} // Opaque Tileset reference
}
