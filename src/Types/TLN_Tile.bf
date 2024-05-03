using TLN.Enums;
using System;

namespace TLN.Maps
{
	[CRepr, Union]
	public struct TilePtr
	{
		Tile* Tile;
	} // Tile reference
}
