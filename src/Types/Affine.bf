using TLN.Enums;
using TLN.Types;
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

		public this(float angle, float dx, float dy, float sx, float sy)
		{
			Angle = angle;
			DX = dx;
			DY = dy;
			SX = sx;
			SY = sy;
		}
	}
}
