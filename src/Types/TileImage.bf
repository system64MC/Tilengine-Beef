using TLN.Enums;
using System;
using TLN.Maps;

namespace TLN.TileImage
{
	[CRepr]
	public struct TileImage // Image Tile items for TLN_CreateImageTileset()
	{
		public Bitmap bitmap;
		public uint16 id;
		public uint8	type;
	}
}
