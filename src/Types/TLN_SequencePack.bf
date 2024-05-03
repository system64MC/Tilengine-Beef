using TLN.Enums;
using System;
namespace TLN.Animations
{
	[CRepr]
	public struct SequencePack
	{
		SequencePack* SequencePack;

		// ------------------------------------------------------------------------------------
		// - SequencePacks
		// -	Sequence pack manager for grouping and finding sequences.
		// ------------------------------------------------------------------------------------
		// // Creates a new collection of Sequences.
		[LinkName("TLN_CreateSequencePack")]
		private static extern SequencePack createSequencePack();
		// // Loads a .sqx file containing one or more Sequences.
		// // A SQX file can contain many sequences. This function loads all of them inside a single SequencePack(). Individual Sequences can be later queried with TLN_FindSequence()
		[LinkName("TLN_LoadSequencePack")]
		private static extern SequencePack loadSequencePack(char8* filename);
		// // Returns the nth Sequence inside a Sequence Pack.
		[LinkName("TLN_GetSequence")]
		private static extern Sequence getSequence(SequencePack sp, int32 index);
		// // Finds a Sequence inside a Sequence Pack.
		[LinkName("TLN_FindSequence")]
		private static extern Sequence findSequence(SequencePack sp, char8* name);
		// // Returns the number of Sequences inside a Sequence Pack.
		[LinkName("TLN_GetSequencePackCount")]
		private static extern int getSequencePackCount(SequencePack sp);
		// // Adds a Sequence to a Sequence Pack.
		[LinkName("TLN_AddSequenceToPack")]
		private static extern bool addSequenceToPack(SequencePack sp, Sequence sequence);
		// // Deletes the specified Sequence Pack and frees memory.
		[LinkName("TLN_DeleteSequencePack")]
		private static extern bool deleteSequencePack(SequencePack sp);

		public this()
		{
			this.SequencePack = createSequencePack().SequencePack;
		}

		public this(String filename)
		{
			this.SequencePack = loadSequencePack(filename).SequencePack;
		}

		public Sequence this[int index]
		{
			get => getSequence(this, (int32)index);
		}

		public Sequence this[String name]
		{
			get => findSequence(this, name);
		}

		public int Count
		{
			get => getSequencePackCount(this);
		}

		public bool Add(Sequence sequence)
		{
			return addSequenceToPack(this, sequence);
		}

		public bool Delete() mut
		{
			let res = deleteSequencePack(this);
			if (res)
				this.SequencePack = null;
			return res;
		}

		public bool IsNull
		{
			get => this.SequencePack == null;
		}
	} // Opaque Sequence Pack reference
}
