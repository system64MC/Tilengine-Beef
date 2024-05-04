using TLN.Enums;
using System;

namespace TLN.Maps
{
	[CRepr]
	public struct TileAttributes // Tileset attributes for constructor
	{
		public uint8 Type; // Tile type
		public bool	Priority; // Priority flag set

		public this(uint8 type = 0, bool priority = false)
		{
			Type = type;
			Priority = priority;
		}
	}
}
