using TLN.Enums;
using System;
using TLN.Palettes;
using TLN.Sprites;
using TLN.Animations;

namespace TLN.Animations
{
	public enum AnimationMode
	{
		Disable,
		Pause,
		Resume,
	}
	[CRepr]
	public struct Animation // errors
	{
		int32 animation;

		public this(int32 animation)
		{
			this.animation = animation;
		}

		// ------------------------------------------------------------------------------------
		// - Animations
		// -	Animation engine manager.
		// ------------------------------------------------------------------------------------
		// // Starts a Palette animation.
		[LinkName("TLN_SetPaletteAnimation")]
		public static extern bool setPaletteAnimation(int32 index, Palette palette, Sequence sequence, bool blend);
		// // Sets the source Palette of a Color Cycle animation.
		// // Use this function to change the palette assigned to a color cycle animation running. This is useful to combine color cycling and palette interpolation at the same time.
		[LinkName("TLN_SetPaletteAnimationSource")]
		public static extern bool setPaletteAnimationSource(int32 index, Palette palette);
		// // Checks the state of the specified animation.
		[LinkName("TLN_GetAnimationState")]
		public static extern bool getAnimationState(int32 index);
		// // Deprecated, each frame has its own delay.
		[LinkName("TLN_SetAnimationDelay")]
		public static extern bool setAnimationDelay(int32 index, int32 frame, int32 delay);
		// // Finds an available (unused) animation.
		[LinkName("TLN_GetAvailableAnimation")]
		public static extern int32 getAvailableAnimation();
		// // Disables the animation so it stops playing and returns it to the list of available animations.
		[LinkName("TLN_DisablePaletteAnimation")]
		public static extern bool disablePaletteAnimation(int32 index);

		public bool SetPalette(Palette palette, Sequence sequence, bool blend)
		{
			return setPaletteAnimation(animation, palette, sequence, blend);
		}

		public bool SetDelay(int frame, int delay)
		{
			return setAnimationDelay(animation, (int32)frame, (int32)delay);
		}

		public Palette Source
		{
			set => setPaletteAnimationSource(animation, value);
		}

		public bool Playing
		{
			get => getAnimationState(animation);
		}

		public static Animation Availlable
		{
			get => Animation(getAvailableAnimation());
		}

	}
}
