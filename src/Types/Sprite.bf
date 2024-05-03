using TLN.Enums;
using System;
using TLN.Palettes;
using TLN.Animations;

namespace TLN.Sprites
{
	[CRepr]
	public struct Sprite // errors
	{
		int32 sprite;

		public this(int32 sprite)
		{
			this.sprite = sprite;
		}

		// ------------------------------------------------------------------------------------
		// - Sprites
		// -	Sprites management.
		// ------------------------------------------------------------------------------------
		// // Configures a Sprite, setting Spriteset and flags at once
		[LinkName("TLN_ConfigSprite")]
		private static extern bool configSprite(int nsprite, Spriteset spriteset, TileFlags flags);
		// // Assigns the spriteset and its palette to a given sprite.
		[LinkName("TLN_SetSpriteSet")]
		private static extern bool setSpriteSet(int nsprite, Spriteset spriteset);
		// // Sets flags for a given sprite.
		[LinkName("TLN_SetSpriteFlags")]
		private static extern bool setSpriteFlags(int nsprite, TileFlags flags);

		[LinkName("TLN_EnableSpriteFlag")]
		private static extern bool enableSpriteFlag(int nsprite, TileFlags flag, bool enable);

		[LinkName("TLN_SetSpritePivot")]
		private static extern bool setSpritePivot(int nsprite, float px, float py);
		// // Sets the sprite position inside the viewport.
		// // Call this function inside a raster callback to so some vertical distortion effects (fake scaling) or sprite multiplexing (reusing a single sprite at different screen heights). This technique was used by some 8 bit games, with very few hardware sprites, to draw much more sprites in the screen, as long as they don't overlap vertically.
		[LinkName("TLN_SetSpritePosition")]
		private static extern bool setSpritePosition(int32 nsprite, int32 x, int32 y);
		// // Sets the actual graphic to the sprite.
		[LinkName("TLN_SetSpritePicture")]
		private static extern bool setSpritePicture(int32 nsprite, int32 entry);
		// // Assigns a palette to a sprite.
		[LinkName("TLN_SetSpritePalette")]
		private static extern bool setSpritePalette(int32 nsprite, Palette palette);
		// // Sets the blending mode (transparency effect).
		[LinkName("TLN_SetSpriteBlendMode")]
		private static extern bool setSpriteBlendMode(int32 nsprite, Blend mode, uint8 factor);
		// // Sets the scaling factor of the sprite.
		[LinkName("TLN_SetSpriteScaling")]
		private static extern bool setSpriteScaling(int32 nsprite, float sx, float sy);
		// // Disables scaling for a given sprite.
		[LinkName("TLN_ResetSpriteScaling")]
		private static extern bool resetSpriteScaling(int32 nsprite);
		/*// // Rotate Sprite
		[LinkName("TLN_SetSpriteRotation")]
		public static extern bool SetSpriteRotation (int nsprite, float angle);
		// // Reset	Sprite Rotation
		[LinkName("TLN_ResetSpriteRotation")]
		public static extern bool ResetSpriteRotation (int nsprite);*/
		// // Returns the index of the assigned picture from the Spriteset.
		[LinkName("TLN_GetSpritePicture")]
		private static extern int32 getSpritePicture(int32 nsprite);

		[LinkName("TLN_GetSpriteX")]
		private static extern int32 getSpriteX(int32 nsprite);
		[LinkName("TLN_GetSpriteY")]
		private static extern int32 getSpriteY(int32 nsprite);

		// // Finds an available (unused) Sprite.
		[LinkName("TLN_GetAvailableSprite")]
		private static extern int32 getAvailableSprite();
		// // Enable sprite collision checking at pixel level.
		// // Only sprites that have collision enabled are checked between them, so to detect a collision between two sprites, both of them must have collision detection enabled. Processing collision detection sprites take more a bit more CPU time compared to non-colliding sprites, so by default it is disabled on all sprites.
		[LinkName("TLN_EnableSpriteCollision")]
		private static extern bool enableSpriteCollision(int32 nsprite, bool enable);
		// // Gets the collision status of a given sprite. Collision detection must be enabled for the sprite to get checked
		[LinkName("TLN_GetSpriteCollision")]
		private static extern bool getSpriteCollision(int32 nsprite);
		// // Returns runtime info about a given sprite.
		// // Info may not be accurate if SpriteState.enabled member is returned as false
		[LinkName("TLN_GetSpriteState")]
		private static extern bool getSpriteState(int32 nsprite, SpriteState* state);
		// // Sets the first sprite drawn (beginning of list)
		[LinkName("TLN_SetFirstSprite")]
		private static extern bool setFirstSprite(int32 nsprite);
		// // Sets the next sprite to draw for a given sprite, builds list.
		[LinkName("TLN_SetNextSprite")]
		private static extern bool setNextSprite(int32 nsprite, int32 next);
		// // Enables or disables masking for this sprite, if enabled it won't be drawn inside the region set up with TLN_SetSpritesMaskRegion()
		[LinkName("TLN_EnableSpriteMasking")]
		private static extern bool enableSpriteMasking(int32 nsprite, bool enable);
		// // Defines a sprite masking region between the two scanlines. Sprites masked with TLN_EnableSpriteMasking() won't be drawn inside this region.
		[LinkName("TLN_SetSpritesMaskRegion")]
		private static extern void setSpritesMaskRegion(int32 top_line, int32 bottom_line);

		[LinkName("TLN_SetSpriteAnimation")]
		private static extern bool setSpriteAnimation(int32 nsprite, Sequence sequence, int32 loop);

		[LinkName("TLN_DisableSpriteAnimation")]
		private static extern bool disableSpriteAnimation(int32 nsprite);

		[LinkName("TLN_PauseSpriteAnimation")]
		private static extern bool pauseSpriteAnimation(int32 index);

		[LinkName("TLN_ResumeSpriteAnimation")]
		private static extern bool resumeSpriteAnimation(int32 index);

		[LinkName("TLN_DisableAnimation")]
		private static extern bool disableAnimation(int32 index);
		// // Disables the sprite so it is not drawn.
		// // A sprite is also automatically disabled when assigned with an invalid spriteste or palette. Disabled sprites are returned by the function TLN_GetAvailableSprite as available
		[LinkName("TLN_DisableSprite")]
		private static extern bool disableSprite(int32 nsprite);
		// // Gets the palette assigned to a given Sprite.
		[LinkName("TLN_GetSpritePalette")]
		private static extern Palette getSpritePalette(int32 nsprite);

		public bool Config(Spriteset spriteset, TileFlags flags)
		{
			return configSprite(this.sprite, spriteset, flags);
		}

		public bool EnableFlag(TileFlags flag, bool enable)
		{
			return enableSpriteFlag(this.sprite, flag, enable);
		}

		public bool SetPivot(float px, float py)
		{
			return setSpritePivot(sprite, px, py);
		}

		public bool SetPosition(int x, int y)
		{
			return setSpritePosition(sprite, (int32)x, (int32)y);
		}

		public bool SetBlendMode(Blend mode, uint8 factor)
		{
			return setSpriteBlendMode(sprite, mode, factor);
		}

		public bool SetScaling(float sx, float sy)
		{
			return setSpriteScaling(sprite, sx, sy);
		}

		public bool ResetScaling()
		{
			return resetSpriteScaling(sprite);
		}

		public bool GetState(ref SpriteState state)
		{
			return getSpriteState(sprite, &state);
		}

		public bool SetFirst()
		{
			return setFirstSprite(sprite);
		}

		public static void SetMaskRegion(int topLine, int bottomLine)
		{
			setSpritesMaskRegion((int32)topLine, (int32)bottomLine);
		}

		public bool SetAnimation(Sequence sequence, int loop)
		{
			return setSpriteAnimation(sprite, sequence, (int32)loop);
		}

		public bool Disable()
		{
			return disableSprite(sprite);
		}

		public AnimationMode Animate
		{
			set
			{
				switch (value)
				{
				case AnimationMode.Disable:
					pauseSpriteAnimation(sprite);
				case .Pause:
					pauseSpriteAnimation(sprite);
				case .Resume:
					resumeSpriteAnimation(sprite);
				}
			}
		}

		public SpriteState State
		{
			get
			{
				SpriteState state = .();
				getSpriteState(sprite, &state);
				return state;
			}
		}

		public static Sprite First
		{
			set => setFirstSprite(value.sprite);
		}

		public Sprite Next
		{
			set => setNextSprite(sprite, value.sprite);
		}

		public bool Masking
		{
			set => enableSpriteMasking(sprite, value);
		}

		public float Scaling
		{
			set => setSpriteScaling(sprite, value, value);
		}

		public Spriteset Spriteset
		{
			set => setSpriteSet(this.sprite, value);
		}

		public TileFlags Flags
		{
			set => setSpriteFlags(this.sprite, value);
		}

		public bool FlipX
		{
			set => enableSpriteFlag(this.sprite, TileFlags.FlipX, value);
		}

		public bool FlipY
		{
			set => enableSpriteFlag(this.sprite, TileFlags.FlipY, value);
		}

		public bool Priority
		{
			set => enableSpriteFlag(this.sprite, TileFlags.Priority, value);
		}

		public bool Rotate
		{
			set => enableSpriteFlag(this.sprite, TileFlags.Rotate, value);
		}

		public int Picture
		{
			set => setSpritePicture(sprite, (int32)value);
			get => getSpritePicture(sprite);
		}

		public Palette Palette
		{
			set => setSpritePalette(sprite, value);
			get => getSpritePalette(sprite);
		}

		public int X
		{
			get => getSpriteX(sprite);
			set => setSpritePosition(sprite, (int32)value, getSpriteY(sprite));
		}

		public int Y
		{
			get => getSpriteY(sprite);
			set => setSpritePosition(sprite, getSpriteX(sprite), (int32)value);
		}

		public static Sprite Availlable
		{
			get => Sprite(getAvailableSprite());
		}

		public bool EnableCollision
		{
			set => enableSpriteCollision(sprite, value);
		}

		public bool Collision
		{
			get => getSpriteCollision(sprite);
		}
	}
}
