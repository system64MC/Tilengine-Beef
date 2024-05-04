using TLN.Enums;
using System;
namespace TLN.Errors
{
	[CRepr]
	public struct Errors // errors
	{
		private const String[?] errorNames =
			String[](
			"No error",
			"Not enough memory",
			"Layer index out of range",
			"Sprite index out of range",
			"Animation index out of range",
			"Picture or tile index out of range",
			"Invalid Tileset reference",
			"Invalid Tilemap reference",
			"Invalid Spriteset reference",
			"Invalid Palette reference",
			"Invalid SequencePack reference",
			"Invalid Sequence reference",
			"Invalid Bitmap reference",
			"Null pointer as required argument",
			"Resource file not found",
			"Resource file has invalid format",
			"A width or height parameter is invalid",
			"Unsupported function",
			"Invalid ObjectList reference"
			);
		// ------------------------------------------------------------------------------------
		// - Errors
		// -	Basic setup and management
		// ------------------------------------------------------------------------------------
		// // Sets the global error code of Tilengine. Useful for custom loaders that need to set the error state.
		[LinkName("TLN_SetLastError")]
		private static extern void setLastError(Error error);
		// // Returns the last error after an invalid operation.
		[LinkName("TLN_GetLastError")]
		private static extern Error getLastError();
		// // Returns the string description of the specified error code.
		[LinkName("TLN_GetErrorString")]
		private static extern char8* getErrorString(Error error);

		public static Error LastError
		{
			get => getLastError();
			set => setLastError(value);
		}

		public static String LastErrMessage
		{
			get => errorNames[(uint32)getLastError()];
		}

		public static String GetString(Error error)
		{
			return errorNames[(uint32)error];
		}
	}
}
