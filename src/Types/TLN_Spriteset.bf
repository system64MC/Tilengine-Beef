using TLN.Enums;
using System;
using TLN.Maps;
using TLN.Palettes;

namespace TLN.Sprites
{
	[CRepr]
	public struct Spriteset
	{
		Spriteset* Spriteset;

		// ------------------------------------------------------------------------------------
		// - Spriteset
		// -	Resources management for sprites.
		// ------------------------------------------------------------------------------------
		// // Creates a new Spriteset.
		[LinkName("TLN_CreateSpriteset")]
		private static extern Spriteset createSpriteset(Bitmap bitmap, SpriteData* data, int num_entries);
		// // Loads a Spriteset from an image png and its associated atlas descriptor.
		// // The Spriteset comes in a pair of files: an image file (bmp or png) and a standardized atlas descriptor (json, csv or txt) The supported json format is the array.
		[LinkName("TLN_LoadSpriteset")]
		private static extern Spriteset loadSpriteset(char8* name);
		// // Creates a duplicate of the specified Spriteset and its associated Palette.
		[LinkName("TLN_CloneSpriteset")]
		private static extern Spriteset cloneSpriteset(Spriteset src);
		// // Query the details about the specified Sprite inside a Spriteset.
		[LinkName("TLN_GetSpriteInfo")]
		private static extern bool getSpriteInfo(Spriteset spriteset, int32 entry, SpriteInfo* info);
		// // Returns a reference to the Palette associated to the specified Spriteset.
		[LinkName("TLN_GetSpritesetPalette")]
		private static extern Palette getSpritesetPalette(Spriteset spriteset);
		// // Returns a reference to the Palette associated to the specified Spriteset.
		[LinkName("TLN_FindSpritesetSprite")]
		private static extern int32 findSpritesetSprite(Spriteset spriteset, char8* name);
		// // Sets attributes and pixels of a given Sprite inside a Spriteset.
		[LinkName("TLN_SetSpritesetData")]
		private static extern bool setSpritesetData(Spriteset spriteset, int32 entry, SpriteData* data, void* pixels, int32 pitch);
		// // Deletes the specified Spriteset and frees memory.
		[LinkName("TLN_DeleteSpriteset")]
		private static extern bool deleteSpriteset(Spriteset Spriteset);

		public this(Bitmap bitmap, SpriteData[] data)
		{
			this.Spriteset = createSpriteset(bitmap, &data[0], data.Count).Spriteset;
		}

		public this(String name)
		{
			this.Spriteset = loadSpriteset(name).Spriteset;
		}

		public static Spriteset Load(String name)
		{
			return loadSpriteset(name);
		}

		public Spriteset Clone()
		{
			return cloneSpriteset(this);
		}

		public bool Delete() mut
		{
			let res = deleteSpriteset(this);
			if (res)
				this.Spriteset = null;
			return res;
		}

		public bool IsNull
		{
			get => this.Spriteset == null;
		}

		public SpriteInfo GetSpriteInfos(int entry)
		{
			SpriteInfo infos = .();
			Runtime.Assert(getSpriteInfo(this, (int32)entry, &infos));
			return infos;
		}

		public bool GetSpriteInfos(int entry, ref SpriteInfo infos)
		{
			return getSpriteInfo(this, (int32)entry, &infos);
		}

		public Palette Palette
		{
			get => getSpritesetPalette(this);
		}

		public Sprite this[String name]
		{
			get => Sprite(findSpritesetSprite(this, name));
		}

		public Sprite FindSprite(String name)
		{
			return Sprite(findSpritesetSprite(this, name));
		}

		public bool SetData(int entry, SpriteData[] data, uint8[] pixels, int pitch)
		{
			return setSpritesetData(this, (int32)entry, &data[0], &pixels[0], (int32)pitch);
		}
	} // Opaque Spriteset reference
}
