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

		public this(uint16 id, uint16 gID, uint16 flags, int32 x, int32 y, int32 width, int32 height)
		{
			ID = id;
			GID = gID;
			Flags = flags;
			X = x;
			Y = y;
			Width = width;
			Height = height;
		}

		public this()
		{
			ID = 0;
			GID = 0;
			Flags = 0;
			X = 0;
			Y = 0;
			Width = 0;
			Height = 0;
		}
	}
}
