using System;
namespace TLN.Enums
{
	[AllowDuplicates]
	public enum LayerType : uint32 // Layer types.
	{ // Must set one of these; choice is mutually exclusive:
		None,
		Tile,
		Object,
		Bitmap,
	}
}
