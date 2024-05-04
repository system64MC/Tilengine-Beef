using TLN.Enums;
using System;
using TLN.Maps;

namespace TLN.TileImage
{
	[CRepr]
	public struct TileImage // Image Tile items for TLN_CreateImageTileset()
	{
		public Bitmap Bitmap;
		public uint16 Id;
		public uint8 Type;

		public this(Bitmap bitmap = default, uint16 id = 0, uint8 type = 0)
		{
			Bitmap = bitmap;
			Id = (uint16)id;
			Type = (uint8)type;
		}
	}
}
