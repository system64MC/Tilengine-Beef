using TLN.Enums;
using System;

namespace TLN.Maps
{
	[CRepr]
	public struct TileAttributes // Tileset attributes for constructor
	{
		public uint8 type; // Tile type
		public bool	priority; // Priority flag set
	}
}
