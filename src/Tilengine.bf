using System;

namespace Tilengine
{
	public class TLN
	{
		// Used by
		// DllImport to load the native library.
		public const char8* nativeLibName = "Tilengine";

		/* version */
		public const int TILENGINE_VER_MAJ = 2;
		public const int TILENGINE_VER_MIN = 8;
		public const int TILENGINE_VER_REV = 0;
		public const int TILENGINE_HEADER_VERSION = ((TILENGINE_VER_MAJ << 16) | (TILENGINE_VER_MIN << 8) | TILENGINE_VER_REV);

		/* callbacks */


	}
}
