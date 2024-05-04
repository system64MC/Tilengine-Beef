using TLN.Enums;
using System;
namespace TLN.Affine
{
	[CRepr]
	public struct Affine // Affine transformation parameters
	{
		public float Angle; // Rotation in degrees
		public float DX; // Horizontal translation
		public float DY; // Vertical translation
		public float SX; // Horizontal scaling
		public float SY; // Vertical scaling

		public this(float angle = 0, float dx = 0, float dy = 0, float sx = 0, float sy = 0)
		{
			Angle = angle;
			DX = dx;
			DY = dy;
			SX = sx;
			SY = sy;
		}
	}
}
