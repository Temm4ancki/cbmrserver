class Color
{
	Color() { r = 0; g = 0; b = 0; }
	Color(int cr, int cg, int cb) { r = cr; g = cg; b = cb; }
	string GetFormat() { return "&colr[" + R() + " " + G() + " " + B() + "]"; }
	int R() { return r; }
	int G() { return g; }
	int B() { return b; }
	int r, g, b;
}

float DistanceSquared(vector3 v1, vector3 v2)
{
	vector3 b = v1 - v2;
	return b.x * b.x + b.y * b.y + b.z * b.z;
}

string ConvertIntToTime(int time, bool full = true)
{
	int minutes = int(min(time / 60, 59));
	int seconds = int(min(time % 60, 59));
	
	string sminutes = ((minutes < 10 && full) ? "0" : "") + minutes;
	string sseconds = (seconds < 10 ? "0" : "") + seconds;
	
	return sminutes + ":" + sseconds;
}

int CountSplitString(string s, string c)
{
	array<string>@ values = s.split(c);
	if(@values != null) return values.size();
	return 0;
}

string SplitString(string s, string c, int id)
{
	array<string>@ values = s.split(c);
	if(@values != null && id < values.size()) return values[id];
	return "";
}

int IPToDecimal(string ip)
{
	return (parseInt(SplitString(ip, ".", 0)) << 24) 
	+ (parseInt(SplitString(ip, ".", 1)) << 16) 
	+ (parseInt(SplitString(ip, ".", 2)) << 8) 
	+ (parseInt(SplitString(ip, ".", 3)));
}

string DottedIP(int ip)
{
	return "" + ((ip >> 24) & 255) + "." + ((ip >> 16) & 255) + "." + ((ip >> 8) & 255) + "." + (ip & 255);
}

void TFormRoom(Room r, float x, float y, float z, float &out ox, float &out oy, float &out oz)
{
	if(r == NULL) return;
	TFormPoint(x, y, z, r.GetEntity(), NULL);
	ox = TFormedX(); 
	oy = TFormedY(); 
	oz = TFormedZ();
}