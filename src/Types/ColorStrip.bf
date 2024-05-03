using TLN.Enums;
using System;

namespace TLN.Animations
{
	[CRepr]
	public struct ColorStrip // Data used to define each frame of a color cycle for Sequence objects
	{
		public int32 Delay; // Time delay between frames
		public uint8 First; // Index of first color to cycle
		public uint8 Count; // Number of colors in the cycle
		public uint8 Dir; // Direction: 0 = Descending, 1 = Ascending

		public this(int32 delay, uint8 first, uint8 count, uint8 dir)
		{
			Delay = delay;
			First = first;
			Count = count;
			Dir = dir;
		}
	}
}
