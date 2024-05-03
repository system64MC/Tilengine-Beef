using TLN.Enums;
using System;

namespace TLN.Objects
{
	[CRepr]
	public struct ObjectList
	{
		ObjectList* ObjectList;

		// ------------------------------------------------------------------------------------
		// - Objects
		// -	ObjectList resources management.
		// ------------------------------------------------------------------------------------
		// // Creates a ObjectList The list is created empty, it must be populated with TLN_AddSpriteToList() and assigned to a layer with TLN_SetLayerObjects()
		[LinkName("TLN_CreateObjectList")]
		private static extern ObjectList createObjectList();
		// // Adds an image-based Tileset item to given ObjectList.
		[LinkName("TLN_AddTileObjectToList")]
		private static extern bool addTileObjectToList(ObjectList list, uint16 id, uint16 gid, uint16 flags, int32 x, int32 y);
		// // Loads an Object List from a Tiled Object Layer.
		[LinkName("TLN_LoadObjectList")]
		private static extern ObjectList loadObjectList(char8* filename, char8* layername);
		// // Creates a duplicate of a given ObjectList Object.
		[LinkName("TLN_CloneObjectList")]
		private static extern ObjectList cloneObjectList(ObjectList src);
		// // Returns number of items in ObjectList.
		[LinkName("TLN_GetListNumObjects")]
		private static extern int32 getListNumObjects(ObjectList list);
		// // Iterates over elements in a ObjectList.
		[LinkName("TLN_GetListObject")]
		private static extern bool getListObject(ObjectList list, ObjectInfo* info);
		// // Deletes Object List.
		[LinkName("TLN_DeleteObjectList")]
		private static extern bool deleteObjectList(ObjectList list);

		public this()
		{
			this.ObjectList = createObjectList().ObjectList;
		}

		public this(String filename, String layername)
		{
			this.ObjectList = loadObjectList(filename, layername).ObjectList;
		}

		public bool Add(int id, int gid, uint16 flags, int x, int y)
		{
			return addTileObjectToList(this, (uint16)id, (uint16)gid, (uint16)flags, (int32)x, (int32)y);
		}

		public ObjectList Clone()
		{
			return cloneObjectList(this);
		}

		public bool GetObject(ref ObjectInfo infos)
		{
			return getListObject(this, &infos);
		}

		public bool Delete() mut
		{
			let res = deleteObjectList(this);
			if (res)
				this.ObjectList = null;
			return res;
		}

		public int NumObjects
		{
			get => getListNumObjects(this);
		}
	} // Opaque Object List reference
}
