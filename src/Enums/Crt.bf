namespace TLN.Enums
{
	public enum CRT : uint32 // List of possible exception Error codes
	{
		Slot, // Slot mask without scanlines, similar to legacy effect
		Aperture, // Aperture grille with scanlines (matrix-like dot arrangement)
		Shadow, // Shadow mask with scanlines, diagonal subpixel arrangement)
	}
}
