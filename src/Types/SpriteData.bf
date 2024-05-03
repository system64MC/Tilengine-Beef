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
	}
}
