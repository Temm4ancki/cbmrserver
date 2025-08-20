class BanValue
{
	BanValue() { }
	BanValue(uint64 steamid, int ip, string reason = "", uint64 time = 0)
	{
		bSteamID = steamid;
		bIP = ip;
		bReason = reason;
		bTime = time;
	}
	
	uint64 bSteamID;
	int bIP;
	string bReason;
	uint64 bTime;
}

class BanList
{
	BanList()
	{

	}
	
	BanList(string file)
	{
		filename = file;
		file f;
		if(f.open(filename, "r") >= 0)
		{
			while(!f.isEndOfFile()) {
				string line = f.readLine();
				
				array<string>@ values = line.split(":::");
				if(@values != null && values.size() >= 3) Push(parseUInt(values[0]), parseInt(values[1]), values[2], values.size() < 4 ? 0 : parseInt(values[3]));
			}
			
			f.close();
		}
	}
	
	array<BanValue> bans;
	string filename;
	
	void Push(uint64 steamid, int ip, string reason = "", uint64 time = 0) {
		bans.push_back(BanValue(steamid, ip, reason, time));
	}
	
	void Push(string steamid, string ip, string reason = "", uint64 time = 0) {
		Push(parseUInt(steamid), IPToDecimal(ip), reason, time);
	}
	
	bool Remove(uint64 steamid = 0, int ip = 0) {
		uint size = bans.size();
		for(int i = size - 1; i >= 0; i--) {
			if(bans[i].bIP == ip || bans[i].bSteamID == steamid)
			{
				bans.removeAt(i);
			}
		}
		
		return bans.size() != size;
	}
	
	bool Remove(string steamid = "", string ip = "") {
		return Remove(parseUInt(steamid), IPToDecimal(ip));
	}
	
	bool Save()
	{
		file f;
		if(f.open(filename, "w") >= 0)
		{
			uint size = bans.size();
			for(int i = 0; i < size; i++) {
				f.writeString(formatUInt(bans[i].bSteamID) + ":::" + formatInt(bans[i].bIP) + ":::" + bans[i].bReason + ":::" + bans[i].bTime + "\n");
			}
			f.close();
			return true;
		}
		return false;
	}
	
	int Contains(uint64 steamid = 0, int ip = 0)
	{
		uint size = bans.size();
		for(int i = size - 1; i >= 0; i--) {
			if(bans[i].bIP == ip || bans[i].bSteamID == steamid) {
				if(bans[i].bTime > 0 && bans[i].bTime < datetime().time)
				{
					bans.removeAt(i);
					continue;
				}
				return i;
			}
		}
		return -1;
	}
}