#include "include/uerm.as"

const uint64 DEFAULT_ADMIN = 76561198175577305;

// Admin panel For Breach Mode
namespace AdminPanel
{
	class Admin
	{
		Admin() { }
		Admin(uint64 id, int l) 
		{ 
			steamid = id; 
			level = l;
		}
		uint64 steamid;
		int level;
	}
	
	Admin[] Admins;
	filesystem@ FileSystem = filesystem();
	
	void Register()
	{
		FileSystem.makeDir("admins");
		FileSystem.changeCurrentPath("admins");
		
		RegisterCallback(PlayerKeyAction_c, OnPlayerKeyAction);
		RegisterCallback(PlayerConnect_c, OnPlayerConnect);
		RegisterCallback(PlayerPressPlayer_c, OnPlayerPressPlayer);
		RegisterCallback(ServerConsole_c, OnConsole);
		Load();
	}
	
	void Load()
	{
		Admins.clear();

		array<string>@ files = FileSystem.getFiles();
		for(int i = 0; i < files.size(); i++) {
			file f;

			if(f.open("admins/" + files[i], "r") >= 0)
			{
				while(!f.isEndOfFile()) {
					string line = f.readLine();
					
					array<string>@ values = line.split(":");
					if(values.size() >= 2) {
						if(values[0].trim().lower() == "level") {
							SetAdmin(parseInt(files[i]), parseInt(values[1].trim()));
						}
					}
				}
				
				f.close();
				
				if(files[i].findFirst(".txt") == -1) FileSystem.move(files[i], files[i] + ".txt");
			}
		}
		
		if(Admins.size() == 0) {
			print("[ADMIN PANEL]: No admins found. Loading default admin.");
			SetAdmin(DEFAULT_ADMIN, 5, true);
		}
		
		for(int i = 0; i <= MAX_PLAYERS; i++) {
			Player p = GetPlayer(i);
			if(p != NULL) {
				if(!IsAdmin(p)) p.SetAdmin(false);
				else p.SetAdmin(true);
			}
		}
	}
	
	bool SetAdmin(uint64 steamid, int level, bool save = false)
	{
		bool found = false;
		for(int i = 0; i < Admins.size(); i++)
		{
			if(Admins[i].steamid == steamid)
			{
				Admins[i].level = level;
				print("[ADMIN PANEL]: Updated " + steamid + " to " + level + " level");

				if(level == 0) Admins.removeAt(i);
				
				found = true;
				break;
			}
		}
		
		if(!found) {
			if(level == 0) return false;
			print("[ADMIN PANEL]: Created " + steamid + " with " + level + " level");
			Admins.push_back(Admin(steamid, level));
		}
		
		if(save)
		{
			if(level == 0) FileSystem.deleteFile(steamid + ".txt");
			else {
				file f;
				if(f.open("admins/" + steamid + ".txt", "w") >= 0)
				{
					f.writeString("Level: " + level);
					f.close();
				}
			}
		}	
		
		return true;
	}
	
	bool IsAdmin(Player p)
	{
		if(p.IsAdmin()) return true;
		
		uint64 steamid = parseInt(p.GetSteamID());
		for(int i = 0; i < Admins.size(); i++) {
			if(Admins[i].steamid == steamid && Admins[i].level > 0) return true;
		}
		return false;
	}
	
	int GetAdminLevel(Player p)
	{
		uint64 steamid = parseInt(p.GetSteamID());
		for(int i = 0; i < Admins.size(); i++) {
			if(Admins[i].steamid == steamid) return Admins[i].level;
		}
		return 0;
	}
	
	bool OnConsole(string command)
	{
		if(command == "reloadadmins") {
			Load();
			print("Reloaded admins");
			return false;
		}
		return true;
	}
	
	void OnPlayerConnect(Player p)
	{
		if(p != NULL) {
			if(IsAdmin(p)) {
				p.SetAdmin(true);
				chat.SendPlayer(p, "You are logged in as an administrator (" + GetAdminLevel(p) + "). &colr[255 127 100]Use F2 or /panel");
			}
		}
	}
	
	void OnPlayerKeyAction(Player p, int n, int o) 
	{
		if(IsKeyPressed(KEY_F2, n, o)) 
		{
			Show(p);
		}
	}
	
	void OnPlayerPressPlayer(Player src, Player dest)
	{
		if(IsAdmin(src) && GetAdminLevel(src) >= 2)
		{
			ShowPlayer(src, dest);
		}
	}
	
	void Show(Player p)
	{
		if(IsAdmin(p)) {
			if(FileSystem.getSize(p.GetSteamID() + ".txt") == -1) {
				p.SetAdmin(false);
				return;
			}
			
			int level = GetAdminLevel(p);
			string access;
			if(level >= 1) access += "Round control (1)\n";
			if(level >= 2) access += "Players control (2)\n";
			if(level >= 3) access += "Server control (3)\n";
			if(level >= 4) access += "Admin control (4)\n";
			
			p.ShowDialog(DIALOG_TYPE_LIST, Dialog::Panel, "Admin panel", access, "Select", "Cancel");
		}
	}
	
	void ShowPlayer(Player src, Player dest = NULL)
	{
		if(dest != NULL) src.SetDialogData(dest.GetName() + "\n" + dest.GetIndex() + "\n" + dest.GetSteamID() + "\n" + dest.GetIP());
		src.ShowDialog(DIALOG_TYPE_LIST, Dialog::PlayerPanel, "Player control", "Ban\nKick\nGive role\nGive item\nTeleport to\nTeleport to me\nSet speed\nSet model\nSet texture\nSet size" + (GetAdminLevel(src) >= 4 ? "\nSet admin access" : ""), "Select", "Cancel");
	}
	
	namespace Dialog
	{
		void Panel(Player p, bool result, string input, int item)
		{
			if(result)
			{
				switch(item)
				{
					case 0:
					{
						RoundControlDialog::ShowControl(p);
						break;
					}
					case 1:
					{
						PlayersControlDialog::ShowControl(p);
						break;
					}
					case 2:
					{
						ServerControlDialog::ShowControl(p);
						break;
					}
					case 3:
					{
						AdminControlDialog::ShowControl(p);
						break;
					}
				}
			}
		}
		
		void PlayerPanel(Player p, bool result, string input, int item)
		{
			if(result)
			{
				switch(item)
				{
					case 0:
					{
						if(GetAdminLevel(GetPanelPlayer(p)) >= GetAdminLevel(p) && GetPanelPlayer(p) != p) {
							chat.SendPlayer(p, "Ты не можешь использовать это на игроке.");
							return;
						}
						string name = SplitString(p.GetDialogData(), "\n", 0);
						string steamid = SplitString(p.GetDialogData(), "\n", 2);
						string ip = SplitString(p.GetDialogData(), "\n", 3);
						p.ShowDialog(DIALOG_TYPE_INPUT, PlayerPanelControl::ContinueBan, "Ban player confirmation", "Player: " + name + "\nSteam ID: " + steamid + "\nIP Address: " + ip +"\nEnter ban reason:", "Continue", "Cancel", false);
						break;
					}
					case 1:
					{
						if(GetAdminLevel(GetPanelPlayer(p)) >= GetAdminLevel(p) && GetPanelPlayer(p) != p) {
							chat.SendPlayer(p, "Ты не можешь использовать это на игроке.");
							return;
						}
						p.ShowDialog(DIALOG_TYPE_MESSAGE, PlayerPanelControl::ConfirmKick, "Kick player?", "Are you sure to kick " + SplitString(p.GetDialogData(), "\n", 0) + "?", "Ban", "Cancel");
						break;
					}
					case 2:
					{
						if(GetAdminLevel(GetPanelPlayer(p)) >= GetAdminLevel(p) && GetPanelPlayer(p) != p) {
							chat.SendPlayer(p, "Ты не можешь использовать это на игроке.");
							return;
						}
						PlayerPanelControl::ShowRoleSelection(p);
						break;
					}
					case 3:
					{
						p.ShowDialog(DIALOG_TYPE_INPUT, PlayerPanelControl::GiveItem, "Give item", "Enter item name:", "Enter", "Cancel");
						break;
					}
					case 4:
					{
						p.ShowDialog(DIALOG_TYPE_MESSAGE, PlayerPanelControl::TeleportTo, "Teleport to", "Are you sure to teleport to this player?", "Yes", "Cancel");
						break;
					}
					case 5:
					{
						if(GetAdminLevel(GetPanelPlayer(p)) >= GetAdminLevel(p) && GetPanelPlayer(p) != p) {
							chat.SendPlayer(p, "Ты не можешь использовать это на игроке.");
							return;
						}
						p.ShowDialog(DIALOG_TYPE_MESSAGE, PlayerPanelControl::TeleportMe, "Teleport me", "Are you sure to teleport this player?", "Yes", "Cancel");
						break;
					}
					case 6:
					{
						if(GetAdminLevel(GetPanelPlayer(p)) >= GetAdminLevel(p) && GetPanelPlayer(p) != p) {
							chat.SendPlayer(p, "Ты не можешь использовать это на игроке.");
							return;
						}
						p.ShowDialog(DIALOG_TYPE_INPUT, PlayerPanelControl::SetSpeed, "Set speed", "Enter speed (0.0 is default)", "Enter", "Cancel");
						break;
					}
					case 7:
					{
						if(GetAdminLevel(GetPanelPlayer(p)) >= GetAdminLevel(p) && GetPanelPlayer(p) != p) {
							chat.SendPlayer(p, "Ты не можешь использовать это на игроке.");
							return;
						}
						p.ShowDialog(DIALOG_TYPE_INPUT, PlayerPanelControl::SetModel, "Set model", "Enter model ID (1-16)", "Enter", "Cancel");
						break;
					}
					case 8:
					{
						if(GetAdminLevel(GetPanelPlayer(p)) >= GetAdminLevel(p) && GetPanelPlayer(p) != p) {
							chat.SendPlayer(p, "Ты не можешь использовать это на игроке.");
							return;
						}
						p.ShowDialog(DIALOG_TYPE_INPUT, PlayerPanelControl::SetTexture, "Set texture", "Enter texture ID (1-30)", "Enter", "Cancel");
						break;
					}
					case 9:
					{
						if(GetAdminLevel(GetPanelPlayer(p)) >= GetAdminLevel(p) && GetPanelPlayer(p) != p) {
							chat.SendPlayer(p, "Ты не можешь использовать это на игроке.");
							return;
						}
						p.ShowDialog(DIALOG_TYPE_INPUT, PlayerPanelControl::SetSize, "Set size", "Enter size (0.0 is default)", "Enter", "Cancel");
						break;
					}
					case 10:
					{
						if(GetAdminLevel(GetPanelPlayer(p)) >= GetAdminLevel(p)) {
							chat.SendPlayer(p, "Ты не можешь использовать это на игроке.");
							return;
						}
						p.ShowDialog(DIALOG_TYPE_INPUT, PlayerPanelControl::GiveAdmin, "Set admin access", "Enter admin level access (0 - remove)", "Enter", "Cancel");
						break;
					}
				}
			}
		}
		
		Player GetPanelPlayer(Player p)
		{
			int index = parseInt(SplitString(p.GetDialogData(), "\n", 1));
			
			if(GetPlayer(index) != NULL && GetPlayer(index).GetSteamID() == SplitString(p.GetDialogData(), "\n", 2))
			{
				return GetPlayer(index);
			}
			return NULL;
		}
			
		namespace PlayerPanelControl
		{
			void ShowRoleSelection(Player p)
			{
				string roleList = "";
				int roleCount = 0;
				
				for(int i = 0; ; i++) {
					Role@ role = Roles::GetRole(i);
					if(@role == null) break;
					
					if(roleCount > 0) roleList += "\n";
					roleList += role.GetFormatColor() + role.name;
					roleCount++;
				}
				
				if(roleCount > 0) {
					p.ShowDialog(DIALOG_TYPE_LIST, GiveRole, "Выберите роль", roleList, "Выдать роль", "Отмена");
				} else {
					chat.SendPlayer(p, "Нет доступных ролей!");
					ShowPlayer(p);
				}
			}
			
			void ContinueBan(Player p, bool result, string input, int item)
			{
				if(!result || input.findFirst(":::") >= 0) { ShowPlayer(p); return; }
				
				p.SetDialogData(p.GetDialogData() + "\n" + input);
				
				string name = SplitString(p.GetDialogData(), "\n", 0);
				string steamid = SplitString(p.GetDialogData(), "\n", 2);
				string ip = SplitString(p.GetDialogData(), "\n", 3);
				p.ShowDialog(DIALOG_TYPE_INPUT, PlayerPanelControl::ConfirmBan, "Подтверждение бана игрока", "Игрок: " + name + "\nSteam ID: " + steamid + "\nIP Адрес: " + ip +"\nВведите время бана в минутах (0 - перманент):", "Забанить", "Отмена", false);
			}
			
			void ConfirmBan(Player p, bool result, string input, int item)
			{
				if(!result) { ShowPlayer(p); return; }
				
				int minutes = parseInt(input);
				
				string reason = SplitString(p.GetDialogData(), "\n", CountSplitString(p.GetDialogData(), "\n") - 1);
				
				string IP = SplitString(p.GetDialogData(), "\n", 3);
				GlobalBans.Push(SplitString(p.GetDialogData(), "\n", 2), IP, reason, minutes != 0 ? datetime().time + (60 * minutes) : 0);
				GlobalBans.Save();
				chat.Send("&colr[200 0 0]Администратор &r[]" + p.GetName() + "&r[] забанил " + SplitString(p.GetDialogData(), "\n", 0) + " на " + minutes + " минут. Причина: " + reason);

				for(int i = connPlayers.size() - 1; i >= 0; i--) {
					if(connPlayers[i].GetIP() == IP) { 
						connPlayers[i].Kick(CODE_BANNED);
					}
				}
			}
			
			void ConfirmKick(Player p, bool result, string input, int item)
			{
				if(!result) { ShowPlayer(p); return; }
				int index = parseInt(SplitString(p.GetDialogData(), "\n", 2));
				if(GetPanelPlayer(p) != NULL)
				{
					GetPanelPlayer(p).Kick(CODE_KICKED);
					chat.SendPlayer(p, "Успешно!");
				}
			}
			
			void GiveRole(Player p, bool result, string input, int item)
			{
				if(!result) { ShowPlayer(p); return; }
				if(GetPanelPlayer(p) != NULL) {
					Role@ role = Roles::GetRole(item);
					if(@role != null) {
						SetPlayerRole(GetPanelPlayer(p), role);
						chat.SendPlayer(p, role.name + " был выдан игроку " + GetPanelPlayer(p).GetName());
					}
					else chat.SendPlayer(p, "Роли не существует!");
				}
				ShowPlayer(p);
			}
			
			void GiveItem(Player p, bool result, string input, int item)
			{
				if(!result) { ShowPlayer(p); return; }
				if(GetPanelPlayer(p) != NULL) {
					Items it = world.CreateItem(input);
					if(it != NULL) {
						it.SetPicker(GetPanelPlayer(p));
						chat.SendPlayer(p, it.GetTemplateName() + " был выдан игроку " + GetPanelPlayer(p).GetName());
					}
					else chat.SendPlayer(p, "Предмета не существует!");
				}
				ShowPlayer(p);
			}
			
			void TeleportTo(Player p, bool result, string input, int item)
			{
				if(!result) { ShowPlayer(p); return; }
				if(GetPanelPlayer(p) != NULL) {
					Entity destEnt = GetPanelPlayer(p).GetEntity();
					p.SetPosition(destEnt.PositionX(), destEnt.PositionY(), destEnt.PositionZ(), GetPanelPlayer(p).GetRoom());
					chat.SendPlayer(p, "Успешно!");
				}
			}
			
			void TeleportMe(Player p, bool result, string input, int item)
			{
				if(!result) { ShowPlayer(p); return; }
				if(GetPanelPlayer(p) != NULL) {
					Entity destEnt = p.GetEntity();
					GetPanelPlayer(p).SetPosition(destEnt.PositionX(), destEnt.PositionY(), destEnt.PositionZ(), p.GetRoom());
					chat.SendPlayer(p, "Успешно!");
				}
			}
			
			void SetSpeed(Player p, bool result, string input, int item)
			{
				if(!result) { ShowPlayer(p); return; }
				if(input.length() > 0 && GetPanelPlayer(p) != NULL) {
					GetPanelPlayer(p).SetSpeedMultiplier(parseFloat(input));
					chat.SendPlayer(p, "Успешно!");
					ShowPlayer(p);
				}
			}
			
			void SetSize(Player p, bool result, string input, int item)
			{
				if(!result) { ShowPlayer(p); return; }
				if(input.length() > 0 && GetPanelPlayer(p) != NULL) {
					GetPanelPlayer(p).SetModelSize(parseFloat(input));
					chat.SendPlayer(p, "Успешно!");
					ShowPlayer(p);
				}
			}
			
			void SetModel(Player p, bool result, string input, int item)
			{
				if(!result) { ShowPlayer(p); return; }
				if(input.length() > 0 && GetPanelPlayer(p) != NULL) {
					GetPanelPlayer(p).SetModel(parseInt(input));
					chat.SendPlayer(p, "Успешно!");
					ShowPlayer(p);
				}
			}
			
			void SetTexture(Player p, bool result, string input, int item)
			{
				if(!result) { ShowPlayer(p); return; }
				if(input.length() > 0 && GetPanelPlayer(p) != NULL) {
					GetPanelPlayer(p).SetModelTexture(parseInt(input));
					chat.SendPlayer(p, "Успешно!");
					ShowPlayer(p);
				}
			}
			
			void GiveAdmin(Player p, bool result, string input, int item)
			{
				if(!result) { ShowPlayer(p); return; }
				if(input.length() > 0 && GetPanelPlayer(p) != NULL) {
					if(GetAdminLevel(p) <= parseInt(input)) {
						chat.SendPlayer(p, "Ты не можешь выставить этот уровень.");
						return;
					}
						
					SetAdmin(parseInt(GetPanelPlayer(p).GetSteamID()), parseInt(input), true);
					chat.SendPlayer(p, "Ты выставил уровень администратора " + parseInt(input) + " игроку " + GetPanelPlayer(p).GetName());
				}
			}
		}
		
		namespace PlayersControlDialog
		{
			void ShowControl(Player p)
			{
				p.ShowDialog(DIALOG_TYPE_LIST, PlayersControl, "Панель игроков", "Телепортировать всех к себе\nТелепортировать игрока к другому\nРазбанить игрока\nИспользовать список игроков (P)" , "Выбрать", "Назад");
			}
			
			void PlayersControl(Player p, bool result, string input, int item)
			{
				if(!result) { Show(p); return; }
				
				switch(item) {
					case 0: 
						p.ShowDialog(DIALOG_TYPE_MESSAGE, TeleportEveryone, "Teleport everyone", "Are you really sure to teleport everyone?", "Yes", "Cancel");
						break;
					case 1:
						p.ShowDialog(DIALOG_TYPE_INPUT, TeleportPTOP, "Teleport player to player", "Enter player index and player index. Example [1 2]", "Enter", "Cancel");
						break;
					case 2:
						p.ShowDialog(DIALOG_TYPE_INPUT, Unban, "Unban player", "Enter IP or SteamID", "Unban", "Cancel");
						break;
				}
			}
		
			void TeleportEveryone(Player p, bool result, string input, int item)
			{
				if(!result) { ShowControl(p); return; }
				for(int i = 0; i < connPlayers.size(); i++) {
					Entity destEnt = p.GetEntity();
					connPlayers[i].SetPosition(destEnt.PositionX(), destEnt.PositionY(), destEnt.PositionZ(), p.GetRoom());
				}
				chat.SendPlayer(p, "Успешно!");
			}
			
			void TeleportPTOP(Player p, bool result, string input, int item)
			{
				if(!result) { ShowControl(p); return; }
				array<string>@ values = input.split(" ");
				if(values.size() >= 2) {
					int playerid = parseInt(values[0]);
					if(playerid <= MAX_PLAYERS) {
						Player dest = GetPlayer(playerid);
						if(dest != NULL) {
							int playerid2 = parseInt(values[1]);
							if(playerid2 <= MAX_PLAYERS) {
								Player dest2 = GetPlayer(playerid2);
								if(dest2 != NULL) {
									Entity destEnt = dest2.GetEntity();
									dest.SetPosition(destEnt.PositionX(), destEnt.PositionY(), destEnt.PositionZ(), dest2.GetRoom());
						
									chat.SendPlayer(p, dest.GetName() + " был успешно телепортирован к " + dest2.GetName());
									ShowControl(p);
								}
							}
							return;
						}
					}
				}
				
				ShowControl(p);
				chat.SendPlayer(p, "Невозможно найти игрока или роль.");
			}
			
			void Unban(Player p, bool result, string input, int item)
			{
				if(!result) { ShowControl(p); return; }
				if(input.findFirst(".") >= 0 ? GlobalBans.Remove("", input) : GlobalBans.Remove(input, "")) {
					chat.SendPlayer(p, "Игрок успешно разбанен.");
					GlobalBans.Save();
				}
				else chat.SendPlayer(p, "Невозможно найти забанненого игрока.");
				ShowControl(p);
			}
			
			// Новые функции для улучшенной телепортации игрок к игроку
			void ShowPlayerListForTeleport(Player p, bool selectingFirst)
			{
				string playerList = "";
				string playerData = "";
				int playerCount = 0;
				
				// Создаем список всех подключенных игроков
				for(int i = 0; i < connPlayers.size(); i++) {
					Player player = connPlayers[i];
					if(player != NULL) {
						if(playerCount > 0) {
							playerList += "\n";
							playerData += "|";
						}
						playerList += "[" + player.GetIndex() + "] " + player.GetName();
						playerData += player.GetIndex() + ":" + player.GetName() + ":" + player.GetSteamID();
						playerCount++;
					}
				}
				
				if(playerCount > 0) {
					// Сохраняем данные игроков и флаг выбора в DialogData
					p.SetDialogData((selectingFirst ? "FIRST" : "SECOND") + ":::" + playerData);
					
					string title = selectingFirst ? "Выберите телепортирующегося игрока" : "Выберите конечного игрока";
					p.ShowDialog(DIALOG_TYPE_LIST, SelectPlayerForTeleport, title, playerList, "Выбрать", "Отмена");
				} else {
					chat.SendPlayer(p, "На сервере нет игроков!");
					ShowControl(p);
				}
			}
			
			void SelectPlayerForTeleport(Player p, bool result, string input, int item)
			{
				if(!result) { ShowControl(p); return; }
				
				string dialogData = p.GetDialogData();
				array<string>@ mainParts = dialogData.split(":::");
				if(mainParts.size() < 2) {
					ShowControl(p);
					return;
				}
				
				bool selectingFirst = (mainParts[0] == "FIRST");
				array<string>@ playerDataArray = mainParts[1].split("|");
				
				if(item >= 0 && item < playerDataArray.size()) {
					array<string>@ selectedPlayerData = playerDataArray[item].split(":");
					if(selectedPlayerData.size() >= 3) {
						int selectedIndex = parseInt(selectedPlayerData[0]);
						string selectedName = selectedPlayerData[1];
						string selectedSteamID = selectedPlayerData[2];
						
						if(selectingFirst) {
							// Сохраняем данные первого игрока и показываем список для второго
							p.SetDialogData("SELECTED_FIRST:::" + selectedIndex + ":" + selectedName + ":" + selectedSteamID);
							ShowPlayerListForTeleport(p, false);
						} else {
							// У нас есть оба игрока, выполняем телепортацию
							string firstPlayerData = p.GetDialogData();
							array<string>@ firstParts = firstPlayerData.split(":::");
							if(firstParts.size() >= 2) {
								array<string>@ firstPlayerInfo = firstParts[1].split(":");
								if(firstPlayerInfo.size() >= 3) {
									int firstIndex = parseInt(firstPlayerInfo[0]);
									string firstName = firstPlayerInfo[1];
									
									Player firstPlayer = GetPlayer(firstIndex);
									Player secondPlayer = GetPlayer(selectedIndex);
									
									if(firstPlayer != NULL && secondPlayer != NULL) {
										// Проверяем, что SteamID совпадают (для безопасности)
										if(firstPlayer.GetSteamID() == firstPlayerInfo[2] && 
										   secondPlayer.GetSteamID() == selectedSteamID) {
											
											Entity destEnt = secondPlayer.GetEntity();
											firstPlayer.SetPosition(destEnt.PositionX(), destEnt.PositionY(), destEnt.PositionZ(), secondPlayer.GetRoom());
											
											chat.SendPlayer(p, firstName + " был успешно телепортирован к " + selectedName);
										} else {
											chat.SendPlayer(p, "Информация о игроке не совпадает! Попробуйте ещё раз.");
										}
									} else {
										chat.SendPlayer(p, "Одного или обеих игроков больше нет на сервере!");
									}
								}
							}
							ShowControl(p);
						}
					}
				}
			}
		}
		
		namespace RoundControlDialog
		{
			void ShowControl(Player p)
			{
				p.ShowDialog(DIALOG_TYPE_LIST, RoundControl, "Round control", "Start round\nRestart round\nSet lobby timer\nSet round timer\nSpawn wave\nAnnounce" , "Select", "Back");
			}
			
			void RoundControl(Player p, bool result, string input, int item)
			{
				if(!result) { Show(p); return; }
				switch(item) 
				{
					case 0:
						p.ShowDialog(DIALOG_TYPE_MESSAGE, StartRound, "Start?", "Are you really sure to start the round?", "Enter", "Cancel");
						break;
					case 1:
						p.ShowDialog(DIALOG_TYPE_MESSAGE, RestartRound, "Restart round", "Are you really sure to restart the round?", "Yes", "Cancel");
						break;
					case 2:
						p.ShowDialog(DIALOG_TYPE_INPUT, SetLobbyTimer, "Set lobby timer", "Enter lobby seconds.", "Enter", "Cancel");
						break;
					case 3:
						p.ShowDialog(DIALOG_TYPE_INPUT, SetRoundTimer, "Set round timer", "Enter round seconds", "Enter", "Cancel");
						break;
					case 4:
						Round::SpawnWave();
						break;
					case 5:
						p.ShowDialog(DIALOG_TYPE_INPUT, Announce, "Announce", "Enter message for announce:", "Enter", "Cancel");
						break;
				}
			}
			
			void StartRound(Player p, bool result, string input, int item)
			{
				if(!result) { ShowControl(p); return; }
				Round::Start();
			}
			
			void RestartRound(Player p, bool result, string input, int item)
			{
				if(!result) { ShowControl(p); return; }
				Round::Reload();
			}
			
			void SetLobbyTimer(Player p, bool result, string input, int item)
			{
				if(!result) { ShowControl(p); return; }
				if(input.length() > 0) {
					Lobby::SetTimer(parseInt(input));
					chat.SendPlayer(p, "Успешно!");
				}
			}
			
			void SetRoundTimer(Player p, bool result, string input, int item)
			{
				if(!result || input == "") { ShowControl(p); return; }
				Round::SetTimer(parseUInt(input));
			}
			
			void Announce(Player p, bool result, string input, int item)
			{
				if(!result || input == "") { ShowControl(p); return; }
				audio.PlaySound("SFX\\Character\\MTF\\StartAnnounc.ogg");
				chat.Send("[Server]: " + input);
			}
		}
		
		namespace ServerControlDialog
		{
			void ShowControl(Player p)
			{
				p.ShowDialog(DIALOG_TYPE_LIST, ServerControl, "Server control", "Restart server\n" , "Select", "Back");
			}
			
			void ServerControl(Player p, bool result, string input, int item)
			{
				if(!result) { Show(p); return; }
				if(item == 0) {
					p.ShowDialog(DIALOG_TYPE_MESSAGE, RestartServer, "Restart server", "Are you really sure to restart the server?", "Yes", "Cancel");
				}
			}
			
			void RestartServer(Player p, bool result, string input, int item)
			{
				if(!result) { ShowControl(p); return; }
				Round::End();
			}
		}
		
		namespace AdminControlDialog
		{
			void ShowControl(Player p)
			{
				p.ShowDialog(DIALOG_TYPE_LIST, AdminControl, "Admin control", "Set admin access", "OK");
			}
			
			void AdminControl(Player p, bool result, string input, int item)
			{
				if(result) p.ShowDialog(DIALOG_TYPE_MESSAGE, 0, "Notification", "Double click on player in players list to set admin access.", "Ok");
				else Show(p);
			}
		}
	}
}