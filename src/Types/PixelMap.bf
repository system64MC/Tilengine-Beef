using TLN.Enums;
using System;

namespace TLN.PixelMap
{
	[CRepr]
	public struct PixelMap // Pixel mapping for Layer.SetPixelMapping
	{
		public int16 DX; // Horizontal Pixel Displacement
		public int16 DY; // Vertical Pixel Displacement

		public this(int16 dx, int16 dy)
		{
			DX = dx;
			DY = dy;
		}
	}
}
