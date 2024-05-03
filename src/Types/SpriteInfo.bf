using TLN.Enums;
using System;

namespace TLN.Sprites
{
	[CRepr]
	public struct SpriteInfo // Data returned by Spriteset.GetSpriteInfo with dimensions of the requested sprite
	{
		public int32 W; // Width of Sprite
		public int32 H; // Height of Sprite
	}
}
