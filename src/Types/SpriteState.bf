using TLN.Enums;
using TLN.Palettes;
using System;

namespace TLN.Sprites
{
	[CRepr]
	public struct SpriteState // State of Sprite
	{
		public int32 X; // Screen Position X
		public int32 Y; // Screen Position Y
		public int32 W; // Actual width in screen (after scaling)
		public int32 H; // Actual height in screen (after scaling)
		public TileFlags Flags; // Flags
		public Palette Palette; // Assigned Palette
		public Spriteset Spriteset; // Assigned Spriteset
		public int32 Index; // Graphic index inside Spriteset
		public bool Enabled; // Enabled or not
		public bool Collision; // Per-Pixel Collision detection enabled or not

		public this(int32 x = 0, int32 y = 0, int32 width = 0, int32 height = 0, TileFlags flags = 0, Palette palette = default, Spriteset spriteset = default, int32 index = 0, bool enabled = false, bool collision = false)
		{
			X = (int32)x;
			Y = (int32)y;
			W = (int32)width;
			H = (int32)height;
			Flags = flags;
			Palette = palette;
			Spriteset = spriteset;
			Index = (int32)index;
			Enabled = enabled;
			Collision = collision;
		}
	}
}
