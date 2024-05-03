using TLN.Enums;
using System;
using TLN.Tilesets;

namespace TLN.Maps
{
	// ------------------------------------------------------------------------------------
	// - Tilemap
	// -	Resources management for Tilemap background layers.
	// ------------------------------------------------------------------------------------
	[CRepr]
	public struct Tilemap
	{
		Tilemap* Tilemap;

		// // Returns the optional associated tileset to the specified tilemap.
		[LinkName("TLN_GetTilemapTileset")]
		private static extern Tileset getTilemapTileset(Tilemap tilemap);

		// // Sets the associated tileset to the specified tilemap.
		[LinkName("TLN_SetTilemapTileset")]
		private static extern bool setTilemapTileset(Tilemap tilemap, Tileset tileset);

		[LinkName("TLN_GetTilemapTileset2")]
		private static extern Tileset getTilemapTileset2(Tilemap tilemap, int index);

		// // Sets the associated tileset to the specified tilemap.
		[LinkName("TLN_SetTilemapTileset2")]
		private static extern bool setTilemapTileset2(Tilemap tilemap, Tileset tileset, int index);

		// // Returns the number of vertical tiles in the tilemap.
		[LinkName("TLN_GetTilemapRows")]
		private static extern int32 getTilemapRows(Tilemap tilemap);

		// // Returns the number of horizontal tiles in the tilemap.
		[LinkName("TLN_GetTilemapCols")]
		private static extern int32 getTilemapCols(Tilemap tilemap);

		// // Sets the background color from a Tilemap defined color.
		[LinkName("TLN_SetBGColorFromTilemap")]
		private static extern bool setBGColorFromTilemap(Tilemap tilemap);

		public bool SetBgColor()
		{
			return setBGColorFromTilemap(this);
		}

		public int Rows
		{
			get { return getTilemapRows(this); }
		}

		public int Cols
		{
			get { return getTilemapCols(this); }
		}

		public Tileset Tileset
		{
			get { return getTilemapTileset(this); }
			set { setTilemapTileset(this, value); }
		}

		public Tileset GetTileset(int index)
		{
			return getTilemapTileset2(this, index);
		}

		public bool SetTileset(Tileset tileset, int index)
		{
			return setTilemapTileset2(this, tileset, index);
		}

		[LinkName("TLN_LoadTilemap")]
		private static extern Tilemap loadTilemap(char8* filename, char8* layername);
		// // Loads a tilemap layer from a Tiled .tmx file.
		public static Tilemap Load(String filename, String layername = null)
		{
			return loadTilemap(filename, layername);
		}

		[LinkName("TLN_CreateTilemap")]
		private static extern Tilemap createTilemap(int rows, int cols, Tile* tiles, uint32 bgcolor, Tileset tileset);
		// // Creates a new tilemap. Make sure that the tiles[] array is has at least rows*cols items or application may crash

		public this(int rows, int cols, Tile[] tiles, Tileset tileset, uint32 bgcolor = 0)
		{
			this.Tilemap = createTilemap(rows, cols, tiles.CArray(), bgcolor, tileset).Tilemap;
		}

		public this(String filename, String layername = null)
		{
			var tmap = loadTilemap(filename, layername);
			this.Tilemap = tmap.Tilemap;
		}

		[LinkName("TLN_CloneTilemap")]
		private static extern Tilemap cloneTilemap(Tilemap src);
		// // Creates a duplicate of the specified tilemap.
		public Tilemap Clone()
		{
			return cloneTilemap(this);
		}

		[LinkName("TLN_DeleteTilemap")]
		private static extern bool deleteTilemap(Tilemap tilemap);
		// // Deletes the specified tilemap and frees memory.
		public bool Delete() mut
		{
			bool res = deleteTilemap(this);
			if (res)
				this.Tilemap = null;
			return res;
		}

		[LinkName("TLN_GetTilemapTile")]
		private static extern bool getTilemapTile(Tilemap tilemap, int row, int col, Tile* tile);
		// // Gets data of a single tile inside a tilemap.
		public Tile GetTile(int row, int col)
		{
			return this.GetTiles(row, col)[0];
		}

		[LinkName("TLN_GetTilemapTiles")]
		private static extern Tile* getTilemapTiles(Tilemap tilemap, int row, int col);
		// // Gets data of a single tile inside a tilemap.
		public Tile* GetTiles(int row, int col)
		{
			return getTilemapTiles(this, row, col);
		}

		[LinkName("TLN_SetTilemapTile")]
		private static extern bool setTilemapTile(Tilemap tilemap, int row, int col, Tile* tile);
		// // Sets a tile of a tilemap.
		public bool SetTile(int row, int col, Tile tile)
		{
			if (row < 0 || row >= this.Rows || col < 0 || col >= this.Cols) return false;
			GetTiles(0, 0)[0] = tile;
			return true;
		}

		[LinkName("TLN_CopyTiles")]
		private static extern bool copyTiles(Tilemap src, int srcrow, int srccol, int rows, int cols, Tilemap dst, int dstrow, int dstcol);
		// // Copies blocks of tiles between two tilemaps.
		public bool CopyTiles(int srcrow, int srccol, int rows, int cols, Tilemap dst, int dstrow, int dstcol)
		{
			return copyTiles(this, srcrow, srccol, rows, cols, dst, dstrow, dstcol);
		}

		public bool IsNull
		{
			get => this.Tilemap == null;
		}

		public static bool operator ==(Tilemap a, Tilemap b)
		{
			return a.Tilemap == b.Tilemap;
		}
	} // Opaque Tilemap reference
}
