using TLN.Enums;
using System;
using TLN.Palettes;

namespace TLN.Maps
{
	[CRepr]
	public struct Bitmap
	{
		Bitmap* Bitmap;

		// ------------------------------------------------------------------------------------
		// - Bitmap
		// -	Bitmap management.
		// ------------------------------------------------------------------------------------
		// // Creates a memory Bitmap.
		[LinkName("TLN_CreateBitmap")]
		private static extern Bitmap createBitmap(int32 width, int32 height, int32 bpp);
		// // Load image file (8-bit BMP or PNG)
		[LinkName("TLN_LoadBitmap")]
		private static extern Bitmap loadBitmap(char8* filename);
		// // Creates a copy of a Bitmap.
		[LinkName("TLN_CloneBitmap")]
		private static extern Bitmap cloneBitmap(Bitmap src);
		// // Gets memory access for direct pixel manipulation.
		[LinkName("TLN_GetBitmapPtr")]
		private static extern uint8* getBitmapPtr(Bitmap bitmap, int x, int y);
		// // Returns the Width in pixels.
		[LinkName("TLN_GetBitmapWidth")]
		private static extern int getBitmapWidth(Bitmap bitmap);
		// // Returns the Height in pixels.
		[LinkName("TLN_GetBitmapHeight")]
		private static extern int getBitmapHeight(Bitmap bitmap);
		// // Returns the bits per pixel.
		[LinkName("TLN_GetBitmapDepth")]
		private static extern int getBitmapDepth(Bitmap bitmap);
		// // Returns the number of bytes per scanline (also known a stride)
		[LinkName("TLN_GetBitmapPitch")]
		private static extern int getBitmapPitch(Bitmap bitmap);
		// // Gets the associated Palette of a bitmap.
		[LinkName("TLN_GetBitmapPalette")]
		private static extern Palette getBitmapPalette(Bitmap bitmap);
		// // Assigns a new Palette to the bitmap.
		[LinkName("TLN_SetBitmapPalette")]
		private static extern bool setBitmapPalette(Bitmap bitmap, Palette palette);
		// // Deletes bitmap and frees resources.
		[LinkName("TLN_DeleteBitmap")]
		private static extern bool deleteBitmap(Bitmap bitmap);

		public this(int width, int height, int bpp = 8)
		{
			this.Bitmap = createBitmap((int32)width, (int32)height, (int32)bpp).Bitmap;
		}

		public this(String filename)
		{
			this.Bitmap = loadBitmap(filename).Bitmap;
		}

		public Bitmap Clone()
		{
			return cloneBitmap(this);
		}

		public bool Delete() mut
		{
			let res = deleteBitmap(this);
			if (res)
				this.Bitmap = null;
			return res;
		}

		public bool IsNull
		{
			get => this.Bitmap == null;
		}

		public Span<uint8> GetData(int x = 0, int y = 0)
		{
			return .(getBitmapPtr(this, (int32)x, (int32)y), (getBitmapWidth(this) * getBitmapHeight(this)) - (y * getBitmapWidth(this) + x));
		}

		public Span<uint8> Data
		{
			get => .(getBitmapPtr(this, 0, 0), (getBitmapWidth(this) * getBitmapHeight(this)));
			set
			{
				let max = Math.Min(value.Length, (getBitmapWidth(this) * getBitmapHeight(this)));
				var ptr = getBitmapPtr(this, 0, 0);
				for (int i in 0 ..< max)
				{
					ptr[i] = value[i];
				}
			}
		}

		public uint8 this[int x, int y]
		{
			get => getBitmapPtr(this, (int32)x, (int32)y)[0];
			set => getBitmapPtr(this, (int32)x, (int32)y)[0] = value;
		}

		public int Width
		{
			get => getBitmapWidth(this);
		}

		public int Height
		{
			get => getBitmapHeight(this);
		}

		public int Depth
		{
			get => getBitmapDepth(this);
		}

		public int Pitch
		{
			get => getBitmapPitch(this);
		}

		public Palette Palette
		{
			get => getBitmapPalette(this);
			set => setBitmapPalette(this, value);
		}
	} // Opaque Bitmap reference
}
