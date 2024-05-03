using TLN.Enums;
using System;
using TLN.Color;

namespace TLN.Color
{
	public struct Color
	{
		public uint8 a, b, g, r;

		public this(uint8 r, uint8 g, uint8 b, uint8 a = 255)
		{
			this.a = a;
			this.b = b;
			this.g = g;
			this.r = r;
		}

		public static Color operator +(Color col1, Color col2)
		{
			return Color(
				(uint8)Math.Min((uint16)col1.a + (uint16)col2.a, 255),
				(uint8)Math.Min((uint16)col1.b + (uint16)col2.b, 255),
				(uint8)Math.Min((uint16)col1.g + (uint16)col2.g, 255),
				(uint8)Math.Min((uint16)col1.r + (uint16)col2.r, 255)
				);
		}

		public void operator +=(Color col1) mut
		{
			this.a = (uint8)Math.Min((uint16)this.a + (uint16)col1.a, 255);
			this.b = (uint8)Math.Min((uint16)this.b + (uint16)col1.b, 255);
			this.g = (uint8)Math.Min((uint16)this.g + (uint16)col1.g, 255);
			this.r = (uint8)Math.Min((uint16)this.r + (uint16)col1.r, 255);
		}

		public void operator ++() mut
		{
			this.a = (uint8)Math.Min((uint16)this.a << 1, 255);
			this.b = (uint8)Math.Min((uint16)this.b << 1, 255);
			this.g = (uint8)Math.Min((uint16)this.g << 1, 255);
			this.r = (uint8)Math.Min((uint16)this.r << 1, 255);
		}

		public static Color operator -(Color col1, Color col2)
		{
			return Color(
				(uint8)Math.Max((int16)col1.a - (int16)col2.a, 255),
				(uint8)Math.Max((int16)col1.b - (int16)col2.b, 255),
				(uint8)Math.Max((int16)col1.g - (int16)col2.g, 255),
				(uint8)Math.Max((int16)col1.r - (int16)col2.r, 255)
				);
		}

		public void operator -=(Color col1) mut
		{
			this.a = (uint8)Math.Min((int16)this.a - (int16)col1.a, 255);
			this.b = (uint8)Math.Min((int16)this.b - (int16)col1.b, 255);
			this.g = (uint8)Math.Min((int16)this.g - (int16)col1.g, 255);
			this.r = (uint8)Math.Min((int16)this.r - (int16)col1.r, 255);
		}

		public static Color operator *(Color col1, Color col2)
		{
			return Color(
				(uint8)((uint16)col1.a * (uint16)col2.a / 255),
				(uint8)((uint16)col1.b * (uint16)col2.b / 255),
				(uint8)((uint16)col1.g * (uint16)col2.g / 255),
				(uint8)((uint16)col1.r * (uint16)col2.r / 255)
				);
		}

		public void operator *=(Color col1) mut
		{
			this.a = (uint8)((uint16)this.a * (uint16)col1.a / 255);
			this.b = (uint8)((uint16)this.b * (uint16)col1.b / 255);
			this.g = (uint8)((uint16)this.g * (uint16)col1.g / 255);
			this.r = (uint8)((uint16)this.r * (uint16)col1.r / 255);
		}

		public void sqr() mut
		{
			this.a = (uint8)((uint16)this.a * (uint16)this.a / 255);
			this.b = (uint8)((uint16)this.b * (uint16)this.b / 255);
			this.g = (uint8)((uint16)this.g * (uint16)this.g / 255);
			this.r = (uint8)((uint16)this.r * (uint16)this.r / 255);
		}

		public static Color operator *(Color col1, float scale)
		{
			return Color(
				(uint8)Math.Min((float)col1.a * scale, 255),
				(uint8)Math.Min((float)col1.b * scale, 255),
				(uint8)Math.Min((float)col1.g * scale, 255),
				(uint8)Math.Min((float)col1.r * scale, 255)
				);
		}

		public void operator *=(float scale) mut
		{
			this.a = (uint8)Math.Min((float)this.a * scale, 255);
			this.b = (uint8)Math.Min((float)this.b * scale, 255);
			this.g = (uint8)Math.Min((float)this.g * scale, 255);
			this.r = (uint8)Math.Min((float)this.r * scale, 255);
		}
	}
}

namespace TLN.Palettes
{
	[CRepr]
	public struct Palette
	{
		Palette* Palette;

		// ------------------------------------------------------------------------------------
		// - Palette
		// -	Color palette resources management for sprites and background layers.
		// ------------------------------------------------------------------------------------
		// // Creates a new color table.
		[LinkName("TLN_CreatePalette")]
		private static extern Palette createPalette(int32 entries);
		// // Loads a palette from a standard .act file.
		[LinkName("TLN_LoadPalette")]
		private static extern Palette loadPalette(char8* filename);
		// // Creates a duplicate of the specified palette.
		[LinkName("TLN_ClonePalette")]
		private static extern Palette clonePalette(Palette src);
		// // Sets the RGB color value of a palette entry.
		[LinkName("TLN_SetPaletteColor")]
		private static extern bool setPaletteColor(Palette palette, int color, uint8 r, uint8 g, uint8 b);
		// // Mixes two palettes to create a third one.
		[LinkName("TLN_MixPalettes")]
		private static extern bool mixPalettes(Palette src1, Palette src2, Palette dst, uint8 factor);
		// // Modifies a range of colors by adding the provided color value to the selected range. The result is always a brighter color.
		[LinkName("TLN_AddPaletteColor")]
		private static extern bool addPaletteColor(Palette palette, uint8 r, uint8 g, uint8 b, uint8 start, uint8 num);
		// Modifies a range of colors by subtracting the provided color value to the selected range. The result is always a darker color.
		[LinkName("TLN_SubPaletteColor")]
		private static extern bool subPaletteColor(Palette palette, uint8 r, uint8 g, uint8 b, uint8 start, uint8 num);
		// // Modifies a range of colors by modulating (normalized product) the provided color value to the selected range. The result is always a darker color.
		[LinkName("TLN_ModPaletteColor")]
		private static extern bool modPaletteColor(Palette palette, uint8 r, uint8 g, uint8 b, uint8 start, uint8 num);
		// // Returns the color value of a palette entry.
		[LinkName("TLN_GetPaletteData")]
		private static extern uint8* getPaletteData(Palette palette, int32 index);
		// // Returns the number of entries of a palette.
		[LinkName("TLN_GetPaletteNumColors")]
		private static extern int32 getPaletteNumColors(Palette palette);
		// // Deletes the specified palette and frees memory.
		[LinkName("TLN_DeletePalette")]
		private static extern bool deletePalette(Palette palette);

		public this(int entries)
		{
			this.Palette = createPalette((int32)entries).Palette;
		}

		public this(String filename)
		{
			this.Palette = loadPalette(filename).Palette;
		}

		public Palette clone()
		{
			return clonePalette(this);
		}

		public Color this[int index]
		{
			get
			{
				return ((Color*)getPaletteData(this, (int32)index))[index];
			}

			set
			{
				setPaletteColor(this, index, value.r, value.g, value.b);
			}
		}

		public Palette Mix(Palette pal2, int resEntries, uint8 factor)
		{
			var pal = Palette(resEntries);
			Runtime.Assert(mixPalettes(this, pal2, pal, factor));
			return pal;
		}

		public bool Add(Color color, uint8 start, uint8 numEntries)
		{
			return addPaletteColor(this, color.r, color.g, color.b, start, numEntries);
		}

		public static Palette operator +(Palette pal1, Palette pal2)
		{
			var palOut = createPalette((int32)Math.Max(pal1.Entries, pal2.Entries));
			var data1 = (Color*)getPaletteData(pal1, 0);
			var data2 = (Color*)getPaletteData(pal2, 0);
			var dataE = (Color*)getPaletteData(palOut, 0);
			for (int i in 0 ..< Math.Min(pal1.Entries, pal2.Entries))
			{
				dataE[i].a = (uint8)Math.Min((uint16)data1[i].a + (uint16)data2[i].a, 255);
				dataE[i].b = (uint8)Math.Min((uint16)data1[i].b + (uint16)data2[i].b, 255);
				dataE[i].g = (uint8)Math.Min((uint16)data1[i].g + (uint16)data2[i].g, 255);
				dataE[i].r = (uint8)Math.Min((uint16)data1[i].r + (uint16)data2[i].r, 255);
			}
			return palOut;
		}

		public void operator +=(Palette pal1) mut
		{
			var data1 = (Color*)getPaletteData(this, 0);
			var data2 = (Color*)getPaletteData(pal1, 0);
			for (int i in 0 ..< Math.Min(this.Entries, pal1.Entries))
			{
				data1[i].a = (uint8)Math.Min((uint16)data1[i].a + (uint16)data2[i].a, 255);
				data1[i].b = (uint8)Math.Min((uint16)data1[i].b + (uint16)data2[i].b, 255);
				data1[i].g = (uint8)Math.Min((uint16)data1[i].g + (uint16)data2[i].g, 255);
				data1[i].r = (uint8)Math.Min((uint16)data1[i].r + (uint16)data2[i].r, 255);
			}
		}

		public static Palette operator +(Palette pal1, Color col)
		{
			var palOut = clonePalette(pal1);
			var dataE = (Color*)getPaletteData(palOut, 0);
			for (int i in 0 ..< pal1.Entries)
			{
				dataE[i].a = (uint8)Math.Min((uint16)dataE[i].a + (uint16)col.a, 255);
				dataE[i].b = (uint8)Math.Min((uint16)dataE[i].b + (uint16)col.b, 255);
				dataE[i].g = (uint8)Math.Min((uint16)dataE[i].g + (uint16)col.g, 255);
				dataE[i].r = (uint8)Math.Min((uint16)dataE[i].r + (uint16)col.r, 255);
			}
			return palOut;
		}

		public void operator +=(Color col) mut
		{
			var dataE = (Color*)getPaletteData(this, 0);
			for (int i in 0 ..< this.Entries)
			{
				dataE[i].a = (uint8)Math.Min((uint16)dataE[i].a + (uint16)col.a, 255);
				dataE[i].b = (uint8)Math.Min((uint16)dataE[i].b + (uint16)col.b, 255);
				dataE[i].g = (uint8)Math.Min((uint16)dataE[i].g + (uint16)col.g, 255);
				dataE[i].r = (uint8)Math.Min((uint16)dataE[i].r + (uint16)col.r, 255);
			}
		}

		public void operator ++() mut
		{
			var dataE = (Color*)getPaletteData(this, 0);
			for (int i in 0 ..< this.Entries)
			{
				dataE[i].a = (uint8)Math.Min((uint16)dataE[i].a << 1, 255);
				dataE[i].b = (uint8)Math.Min((uint16)dataE[i].b << 1, 255);
				dataE[i].g = (uint8)Math.Min((uint16)dataE[i].g << 1, 255);
				dataE[i].r = (uint8)Math.Min((uint16)dataE[i].r << 1, 255);
			}
		}

		public static Palette operator -(Palette pal1, Palette pal2)
		{
			var palOut = createPalette((int32)Math.Max(pal1.Entries, pal2.Entries));
			var data1 = (Color*)getPaletteData(pal1, 0);
			var data2 = (Color*)getPaletteData(pal2, 0);
			var dataE = (Color*)getPaletteData(palOut, 0);
			for (int i in 0 ..< Math.Min(pal1.Entries, pal2.Entries))
			{
				dataE[i].a = (uint8)Math.Max((int16)data1[i].a - (int16)data2[i].a, 0);
				dataE[i].b = (uint8)Math.Max((int16)data1[i].b - (int16)data2[i].b, 0);
				dataE[i].g = (uint8)Math.Max((int16)data1[i].g - (int16)data2[i].g, 0);
				dataE[i].r = (uint8)Math.Max((int16)data1[i].r - (int16)data2[i].r, 0);
			}
			return palOut;
		}

		public void operator -=(Palette pal1) mut
		{
			var data1 = (Color*)getPaletteData(this, 0);
			var data2 = (Color*)getPaletteData(pal1, 0);
			for (int i in 0 ..< Math.Min(this.Entries, pal1.Entries))
			{
				data1[i].a = (uint8)Math.Max((int16)data1[i].a - (int16)data2[i].a, 0);
				data1[i].b = (uint8)Math.Max((int16)data1[i].b - (int16)data2[i].b, 0);
				data1[i].g = (uint8)Math.Max((int16)data1[i].g - (int16)data2[i].g, 0);
				data1[i].r = (uint8)Math.Max((int16)data1[i].r - (int16)data2[i].r, 0);
			}
		}

		public static Palette operator -(Palette pal1, Color col)
		{
			var palOut = createPalette((int32)pal1.Entries);
			var data1 = (Color*)getPaletteData(pal1, 0);
			var dataE = (Color*)getPaletteData(palOut, 0);
			for (int i in 0 ..< pal1.Entries)
			{
				dataE[i].a = (uint8)Math.Max((int16)data1[i].a - (int16)col.a, 0);
				dataE[i].b = (uint8)Math.Max((int16)data1[i].b - (int16)col.b, 0);
				dataE[i].g = (uint8)Math.Max((int16)data1[i].g - (int16)col.g, 0);
				dataE[i].r = (uint8)Math.Max((int16)data1[i].r - (int16)col.r, 0);
			}
			return palOut;
		}

		public void operator -=(Color col) mut
		{
			var dataE = (Color*)getPaletteData(this, 0);
			for (int i in 0 ..< this.Entries)
			{
				dataE[i].a = (uint8)Math.Max((int16)dataE[i].a - (int16)col.a, 0);
				dataE[i].b = (uint8)Math.Max((int16)dataE[i].b - (int16)col.b, 0);
				dataE[i].g = (uint8)Math.Max((int16)dataE[i].g - (int16)col.g, 0);
				dataE[i].r = (uint8)Math.Max((int16)dataE[i].r - (int16)col.r, 0);
			}
		}



		public static Palette operator *(Palette pal1, Palette pal2)
		{
			var palOut = createPalette((int32)Math.Max(pal1.Entries, pal2.Entries));
			var data1 = (Color*)getPaletteData(pal1, 0);
			var data2 = (Color*)getPaletteData(pal2, 0);
			var dataE = (Color*)getPaletteData(palOut, 0);
			for (int i in 0 ..< Math.Min(pal1.Entries, pal2.Entries))
			{
				dataE[i].a = (uint8)((uint16)data1[i].a * (uint16)data2[i].a / 255);
				dataE[i].b = (uint8)((uint16)data1[i].b * (uint16)data2[i].b / 255);
				dataE[i].g = (uint8)((uint16)data1[i].g * (uint16)data2[i].g / 255);
				dataE[i].r = (uint8)((uint16)data1[i].r * (uint16)data2[i].r / 255);
			}
			return palOut;
		}

		public void operator *=(Palette pal1) mut
		{
			var data1 = (Color*)getPaletteData(this, 0);
			var data2 = (Color*)getPaletteData(pal1, 0);
			for (int i in 0 ..< Math.Min(this.Entries, pal1.Entries))
			{
				data1[i].a = (uint8)((uint16)data1[i].a * (uint16)data2[i].a / 255);
				data1[i].b = (uint8)((uint16)data1[i].b * (uint16)data2[i].b / 255);
				data1[i].g = (uint8)((uint16)data1[i].g * (uint16)data2[i].g / 255);
				data1[i].r = (uint8)((uint16)data1[i].r * (uint16)data2[i].r / 255);
			}
		}

		public static Palette operator *(Palette pal1, Color col)
		{
			var palOut = clonePalette(pal1);
			var dataE = (Color*)getPaletteData(palOut, 0);
			for (int i in 0 ..< pal1.Entries)
			{
				dataE[i].a = (uint8)((uint16)dataE[i].a * (uint16)col.a / 255);
				dataE[i].b = (uint8)((uint16)dataE[i].b * (uint16)col.b / 255);
				dataE[i].g = (uint8)((uint16)dataE[i].g * (uint16)col.g / 255);
				dataE[i].r = (uint8)((uint16)dataE[i].r * (uint16)col.r / 255);
			}
			return palOut;
		}

		public void operator *=(Color col) mut
		{
			var dataE = (Color*)getPaletteData(this, 0);
			for (int i in 0 ..< this.Entries)
			{
				dataE[i].a = (uint8)((uint16)dataE[i].a * (uint16)col.a / 255);
				dataE[i].b = (uint8)((uint16)dataE[i].b * (uint16)col.b / 255);
				dataE[i].g = (uint8)((uint16)dataE[i].g * (uint16)col.g / 255);
				dataE[i].r = (uint8)((uint16)dataE[i].r * (uint16)col.r / 255);
			}
		}

		public static Palette operator *(Palette pal1, float scale)
		{
			var palOut = clonePalette(pal1);
			var dataE = (Color*)getPaletteData(palOut, 0);
			for (int i in 0 ..< pal1.Entries)
			{
				dataE[i].a = (uint8)Math.Min((uint16)dataE[i].a * scale, 255);
				dataE[i].b = (uint8)Math.Min((uint16)dataE[i].b * scale, 255);
				dataE[i].g = (uint8)Math.Min((uint16)dataE[i].g * scale, 255);
				dataE[i].r = (uint8)Math.Min((uint16)dataE[i].r * scale, 255);
			}
			return palOut;
		}

		public void operator *=(float scale) mut
		{
			var dataE = (Color*)getPaletteData(this, 0);
			for (int i in 0 ..< this.Entries)
			{
				dataE[i].a = (uint8)Math.Min((float)dataE[i].a * scale, 255);
				dataE[i].b = (uint8)Math.Min((float)dataE[i].b * scale, 255);
				dataE[i].g = (uint8)Math.Min((float)dataE[i].g * scale, 255);
				dataE[i].r = (uint8)Math.Min((float)dataE[i].r * scale, 255);
			}
		}

		public bool Sub(Color color, uint8 start, uint8 numEntries)
		{
			return subPaletteColor(this, color.r, color.g, color.b, start, numEntries);
		}

		public bool Mod(Color color, uint8 start, uint8 numEntries)
		{
			return modPaletteColor(this, color.r, color.g, color.b, start, numEntries);
		}

		public int Entries
		{
			get
			{
				return (int)getPaletteNumColors(this);
			}
		}

		public Span<Color> Data
		{
			get => Span<Color>((Color*)getPaletteData(this, 0), getPaletteNumColors(this));
			set => Internal.MemCpy((Color*)getPaletteData(this, 0), &value[0], Math.Min(getPaletteNumColors(this), value.Length * sizeof(Color)));
		}

		public bool Delete() mut
		{
			var res = deletePalette(this);
			if (res)
				this.Palette = null;
			return res;
		}

		public bool IsNull
		{
			get => this.Palette == null;
		}
	} // Opaque Palette reference
}
