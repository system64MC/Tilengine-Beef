using TLN.Enums;
using System;

namespace TLN.Animations
{
	[CRepr]
	public struct SequenceFrame // Data used to define each frame of an animation for Sequence objects
	{
		public int32 Index; // Tile/Sprite index
		public int32 Delay; // Time delay for next frame

		public this(int32 index, int32 delay)
		{
			Index = index;
			Delay = delay;
		}
	}
}
