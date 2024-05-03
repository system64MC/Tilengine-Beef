using TLN.Enums;
using System;

namespace TLN.Animations
{
	[CRepr]
	public struct SequenceInfo // Sequence info returned by Sequence.GetInfo
	{
		public char8[32] Name; // Sequence Name
		public int32 NumFrames; // Number of Frames

		public this(String name, int32 numFrames)
		{
			Name = .();
			for (int i in 0 ..< Math.Min(32, name.Length))
			{
				Name[i] = name[i];
			}
			NumFrames = numFrames;
		}

		public this()
		{
			Name = .();
			NumFrames = 0;
		}
	}
}
