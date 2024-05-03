using TLN.Enums;
using System;

namespace TLN.Maps
{
	[CRepr]
	public struct TileInfo // Data returned by Layer.GetTile about a given tile inside a background layer
	{
		public uint16 Index; // Tile index
		public uint16 Flags; // Attributes (FlipX, FlipY, Rotate, Priority)
		public int32 Row; // Row number in the Tilemap
		public int32 Col; // Col number in the Tilemap
		public int32 Xoffset; // Horizontal position inside the title
		public int32 Yoffset; // Vertical position inside the title
		public uint8 Color; // Color index at collision point
		public uint8 Type; // Tile type
		public bool Empty; // Cell is empty

	}
}
