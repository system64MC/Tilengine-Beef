using TLN.Enums;
using System;

namespace TLN.Objects
{
	[CRepr]
	public struct ObjectInfo // Object item info returned by TLN_GetObjectInfo()
	{
		public uint16 ID; // Unique ID
		public uint16 GID; // Graphic ID (tile index)
		public uint16 Flags; // Attributes (FlipX, FlipY, Priority)
		public int32 X; // Horizontal position
		public int32 Y; // Vertical position
		public int32 Width; // Horizontal size
		public int32 Height; // Vertical size

		public this(uint16 id = 0, uint16 gID = 0, uint16 flags = 0, int32 x = 0, int32 y = 0, int32 width = 0, int32 height = 0)
		{
			ID = id;
			GID = gID;
			Flags = flags;
			X = x;
			Y = y;
			Width = width;
			Height = height;
		}
	}
}
