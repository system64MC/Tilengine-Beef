using TLN.Enums;
using System;

namespace TLN.Sprites
{
	[CRepr]
	public struct SpriteData // Data used to create Spriteset objects
	{
		public char8[64] Name; // Entry name
		public int32 X; // Horizontal Position
		public int32 Y; // Vertical Position
		public int32 W; // Width
		public int32 H; // Height

		public this(String name = "", int32 x = 0, int32 y = 0, int32 width = 0, int32 height = 0)
		{
			Name = .();
			for (int i in 0 ..< Math.Min(name.Length, 64))
			{
				Name[i] = name[i];
			}
			X = (int32)x;
			Y = (int32)y;
			W = (int32)width;
			H = (int32)height;
		}
	}
}
