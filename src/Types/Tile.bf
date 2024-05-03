using TLN.Enums;
using System;

namespace TLN.Maps
{
	[CRepr /*, Union*/]
	public struct Tile // Tile item for Tilemap access methods
	{
		// private uint32 value;
		public uint16 index; // Tile index
		public uint16 flags; // Attributes (FLAG_FLIPX, FLAG_FLIPY, FLAG_PRIORITY)

		public this(uint16 index, uint16 flags)
		{
			this.index = index;
			this.flags = flags;
		}
	}
}
