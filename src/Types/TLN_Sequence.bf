using TLN.Enums;
using System;
using TLN.Sprites;

namespace TLN.Animations
{
	[CRepr]
	public struct Sequence
	{
		Sequence* Sequence;

		// ------------------------------------------------------------------------------------
		// - Sequences
		// -	Resources management for Layer, Sprite and Palette animations.
		// ------------------------------------------------------------------------------------
		// // Creates a new Sequence for the animation engine.
		// // Use this function to create Tileset or Sprite animations
		[LinkName("TLN_CreateSequence")]
		private static extern Sequence createSequence(char8* name, int32 target, int32 num_frames, SequenceFrame* frames);
		// // Creates a Color Cycle Sequence for Palette animation.
		// // Use this function to create advanced Palette animation effects.
		[LinkName("TLN_CreateCycle")]
		private static extern Sequence createCycle(char8* name, int32 num_strips, ColorStrip* strips);
		// // Creates a name based Sprite Sequence.
		[LinkName("TLN_CreateSpriteSequence")]
		private static extern Sequence createSpriteSequence(char8* name, Spriteset spriteset, char8* basename, int32 delay);
		// // Creates a duplicate of the specified Sequence.
		[LinkName("TLN_CloneSequence")]
		private static extern Sequence cloneSequence(Sequence src);
		// // Returns runtime info about a given Sequence.
		[LinkName("TLN_GetSequenceInfo")]
		public static extern bool getSequenceInfo(Sequence sequence, SequenceInfo* info);
		// // Deletes the sequence and frees resources.
		[LinkName("TLN_DeleteSequence")]
		public static extern bool deleteSequence(Sequence sequence);

		public this(String name, int target, Span<SequenceFrame> frames)
		{
			this.Sequence = createSequence(name, (int32)target, (int32)frames.Length, &frames[0]).Sequence;
		}

		public this(String name, Span<ColorStrip> strips)
		{
			this.Sequence = createCycle(name, (int32)strips.Length, &strips[0]).Sequence;
		}

		public this(String name, Spriteset spriteset, String baseName, int delay)
		{
			this.Sequence = createSpriteSequence(name, spriteset, baseName, (int32)delay).Sequence;
		}

		public Sequence Clone()
		{
			return cloneSequence(this);
		}

		public bool GetInfos(ref SequenceInfo infos)
		{
			return getSequenceInfo(this, &infos);
		}

		public SequenceInfo Infos
		{
			get
			{
				SequenceInfo infos = .();
				Runtime.Assert(getSequenceInfo(this, &infos));
				return infos;
			}
		}

		public bool Delete() mut
		{
			let res = deleteSequence(this);
			if (res)
				this.Sequence = null;
			return res;
		}

		public bool IsNull
		{
			get => this.Sequence == null;
		}
	} // Opaque Sequence reference
}
