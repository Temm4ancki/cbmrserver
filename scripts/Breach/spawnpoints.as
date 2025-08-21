class Spawnpoint
{
	Spawnpoint() { }
	Spawnpoint(vector3 offset, float pt, float yw, Room r)
	{ 
		if(r != NULL) TFormRoom(r, offset.x, offset.y, offset.z, x, y, z);
		pitch = pt; 
		yaw = yw; 
		room = r;
	}
	~Spawnpoint()
	{
		
	}
	float x, y, z;
	float pitch, yaw;
	Room room;
}