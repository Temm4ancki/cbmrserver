Entity CreatePivot(int parent = 0) /*! Create pivot. Can create sphere collision */;
Entity LinePick(float x, float y, float z, float dx, float dy, float dz, float radius = 0.0) /*! Pick entity in specified coordinates */;
Player GetPlayer(int index) /*! Get player by his index */;
float PeekFloat(int bank, int offset) /*! Take float from buffer */;
float PickedNX() /*! Get picked Normal X after pick function */;
float PickedNY() /*! Get picked Normal Y after pick function */;
float PickedNZ() /*! Get picked Normal Z after pick function */;
float PickedX() /*! Get picked X after pick function */;
float PickedY() /*! Get picked Y after pick function */;
float PickedZ() /*! Get picked Z after pick function */;
float TFormedX() /*! Get TFormX */;
float TFormedY() /*! Get TFormY */;
float TFormedZ() /*! Get TFormZ */;
float clamp(float val, float minimal, float maximum) /*! */;
float frand(float from, float to = 0.0) /*! Float random */;
float max(float val, float val2) /*! */;
float min(float val, float val2) /*! */;
int BankSize(int bank) /*! Get memory buffer size */;
int BankStringSize(string& in) /*! Get string size required for memory buffer */;
int CreateBank(int size) /*! Create memory buffer */;
int CreateTimer(ref& in callback, int time, bool repeat, int timerdata = 0) /*! Create timer. DEPRECATED! Use CreateTimerEx instead */;
int CreateTimer(string& in funcdecl, int time, bool repeat, int timerdata = 0) /*! Create timer. DEPRECATED! Use CreateTimerEx instead */;
int CreateTimerData() /*! Create timer arguments buffer. Will be deleted in CreateTimer function. DEPRECATED! Use CreateTimerEx instead */;
int CreateTimerEx(ref& in callback, int time, bool repeat, ?&in = null, ?&in = null, ?&in = null, ?&in = null, ?&in = null, ?&in = null, ?&in = null, ?&in = null) /*! Create timer with variadic arguments. Supports 8 arguments. */;
int CreateTimerEx(string& in funcdecl, int time, bool repeat, ?&in = null, ?&in = null, ?&in = null, ?&in = null, ?&in = null, ?&in = null, ?&in = null, ?&in = null) /*! Create timer with variadic arguments. Supports 8 arguments. */;
int GetActiveContext() /*! Get pointer of active context of AngelScript. Need for plugins */;
int GetPlayersCount() /*! Get players count */;
int GetProcAddress(int, string &in) /*! Get proc address of function from DLL */;
int LoadLibrary(string &in) /*! Load DLL */;
int PeekInt(int bank, int offset) /*! Take int from buffer */;
int rand(int from, int to = 0) /*! Random */;
int rndseed() /*! Get random seed */;
int round(bool val) /*! */;
int round(float val) /*! */;
int srand(int val) /*! Seed random */;
int16 PeekShort(int bank, int offset) /*! Take short from buffer */;
int8 PeekByte(int bank, int offset) /*! Take byte from buffer */;
string& PeekString(int bank, int offset) /*! Take string from buffer */;
void Collisions(int src_type, int dest_type, int method, int response) /*! Set collision methods */;
void FreeBank(int bank) /*! Delete memory buffer */;
void PokeByte(int bank, int offset, int value) /*! Set byte in buffer */;
void PokeFloat(int bank, int offset, float value) /*! Set float in buffer */;
void PokeInt(int bank, int offset, int value) /*! Set int in buffer */;
void PokeShort(int bank, int offset, int value) /*! Set short in buffer */;
void PokeString(int bank, int offset, string &in value) /*! Set string in buffer */;
void RegisterFuncdef(string &in declaration) /*! Register new funcdef for callbacks. This function does not create new funcdefs during runtime. Required for plugins */;
void RegisterLibraryFunction(string &in decl, int procaddress, int convtype) /*! Register new function from DLL. This function does not create new functions during runtime. Required for plugins */;
void RegisterLibraryMethod(string &in classname, string &in decl, int procaddress, int convtype) /*! Register new class function from DLL. This function does not create new functions during runtime. Required for plugins */;
void RegisterLibraryObject(string &in classname) /*! Register new class. Required for plugins. This function does not create new classes during runtime. */;
void RemoveTimer() /*! Remove current executed timer */;
void RemoveTimer(int timer) /*! Remove timer by handle */;
void RemoveTimer(ref& in callback) /*! Remove all timers with this function */;
void SetTimerBool(int timerdata, bool val) /*! Add timer bool. DEPRECATED! Use CreateTimerEx instead */;
void SetTimerFloat(int timerdata, float val) /*! Add timer float. DEPRECATED! Use CreateTimerEx instead */;
void SetTimerHandle(int timerdata, int handle) /*! Add timer handle. DEPRECATED! Use CreateTimerEx instead */;
void SetTimerInt(int timerdata, int val) /*! Add timer int. DEPRECATED! Use CreateTimerEx instead */;
void SetTimerString(int timerdata, string &in val) /*! Add timer string. DEPRECATED! Use CreateTimerEx instead */;
void TFormNormal(float x, float y, float z, Entity src, Entity dest) /*! Transforms between coordinate systems. */;
void TFormPoint(float x, float y, float z, Entity src, Entity dest) /*! Transforms between coordinate systems. */;
void TFormVector(float x, float y, float z, Entity src, Entity dest) /*! Transforms between coordinate systems. */;
void print(string &in message) /*! Print message to console and logger */;
void sleep(int milliseconds) /*! Sleep thread */;
class Audio
{
public:
	void Play3DSound(string& in filename, Player player, float range, float volume, bool norange = false) /*! Emit and attach sound to player. If norange = true, then the sound is sent to all players regardless of the distance. */;
	void Play3DSound(string& in filename, Entity entity, float range, float volume, bool norange = false) /*! Emit sound at entity, instead of position. If norange = true, then the sound is sent to all players regardless of the distance. */;
	void Play3DSound(string& in filename, float x, float y, float z, float range, float volume, bool norange = false) /*! Emit sound at position. If norange = true, then the sound is sent to all players regardless of the distance. */;
	void PlaySound(string& in filename) /*! Play global sound for all players */;
	void PlaySoundForPlayer(Player player, string& in filename) /*! Play global sound for one player */;
	void Play3DSoundForPlayer(Player player, string& in filename, Entity entity, float range, float volume, bool norange = false) /*! Emit sound at entity for one player. If norange = true, then the sound is sent to player regardless of the distance. */;
	void Play3DSoundForPlayer(Player player, string& in filename, float x, float y, float z, float range, float volume, bool norange = false) /*! Emit sound at position for one player. If norange = true, then the sound is sent to player regardless of the distance. */;
	void Play3DSoundForPlayer(Player player, string& in filename, Player player, float range, float volume, bool norange = false) /*! Emit and attach sound to player for one player. If norange = true, then the sound is sent to player regardless of the distance. */;
};
class Chat
{
public:
	void Send(string& in message) /*! Send global chat message */;
	void SendPlayer(Player player, string& in message) /*! Send message to player */;
};
class Config
{
public:
	bool Exist(string& in key, int index = 0) /*! Is config value exist */;
	string& Get(string& in key, int index = 0) /*! Get config value. Index is multi value */;
	void Remove() /*! Remove */;
};
class Corpse
{
public:
	Player GetPlayer() /*! Get player of corpse. Can be NULL */;
	Entity GetEntity() /*! Get corpse entity */;
	float GetTimeout() /*! Get corpse timeout */;
	void SetTimeout(float) /*! Set corpse timeout */;
	bool PushItem(Items) /*! Push item to corpse. */;
	bool ExploreItem(int slot) /*! Take item from corpse slot. */;
	Items GetItem(int slot) /*! Get corpse item from slot index */;
	int GetModel() /*! Get corpse player model id */;
	int GetItemsCount() /*! Get corpse items count */;
	bool IsExplored() /*! Is explored */;
	void SetExplore(bool explore) /*! Set explored state */;
	bool Explore() /*! Takes all items from corpse, like usual exploring. */;
	void SetData(string& in data) /*! Set data for scripting messaging */;
	string& GetData() /*! Get data */;
	void Remove() /*! Remove corpse */;
};
class Door
{
public:
	void Use() /*! Use door with sound */;
	void SetOpen(bool) /*! Set open state */;
	bool IsOpened() /*! Is opened */;
	void SetLockState(int) /*! Set door lock state. 2 - for wooden, office, fence doors */;
	int GetLockState() /*! Get door lock state.*/;
	float GetOpenState() /*! Get open state */;
	void Decompose() /*! Decompose door like from SCP-106 */;
	int GetDoorAccess() /*! Get door access type */;
	int GetDoorType() /*! Get door type */;
	void SetKeycard(int) /*! Set keycard type */;
	int GetKeycard() /*! Get keycard type */;
	Entity GetEntity() /*! Get door frame entity */;
};
class Entity
{
public:
	void SetPosition(float x, float y, float z, bool global = false) /*! Set entity position */;
	void SetRotation(float pitch, float yaw, float roll, bool global = false) /*! Set entity rotation */;
	void SetScale(float x, float y, float z, bool global = false) /*! Set entity scale */;
	float PositionX(bool global = false) /*! Get entity pos X */;
	float PositionY(bool global = false) /*! Get entity pos Y */;
	float PositionZ(bool global = false) /*! Get entity pos Z */;
	void Translate(float x, float y, float z, bool global = false) /*! Translate entity without rotation */;
	void Move(float x, float y, float z, bool global = false) /*! Translate entity including rotation */;
	float Pitch(bool global = false) /*! Get entity pitch */;
	float Yaw(bool global = false) /*! Get entity yaw */;
	float Roll(bool global = false) /*! Get entity roll */;
	float Turn(float pitch, float yaw, float roll, bool global = false) /*! Rotate entity with specified angles */;
	float ScaleX(bool global = false) /*! Scale X */;
	float ScaleY(bool global = false) /*! Scale Y*/;
	float ScaleZ(bool global = false) /*! Scale Z*/;
	void SetAnimTime(float time, int sequence = 0) /*! Set entity anim time */;
	float GetAnimTime() /*! Get entity anim time */;
	float Point(Entity target, float roll = 0.0) /*! Turn entity to specified entity */;
	Entity Pick(float distance) /*! Pick nearest entity by distance */;
	void SetPickMode(int pickmode, bool obscurer = false) /*! Set entity pick mode to use with Pick functions */;
	bool Visible(Entity target) /*! Do the entities see each other (Collisions) */;
	float Distance(Entity target) /*! Distance from specified entity */;
	float DistanceSquared(Entity target) /*! Squared distance from specified entity */;
	void SetParent(Entity target, bool retain = true) /*! Set entity parent */;
	Entity GetParent() /*! Get entity parent */;
	int CountChildren() /*! Count of entity children */;
	Entity GetChild(int) /*! Get entity child by index */;
	string& GetName() /*! Get entity name */;
	void SetName(string& in name) /*! Set entity name */;
	bool Collided(int colltype) /*! Is entity collide with colltype */;
	int CountCollisions() /*! Count of entity collisions */;
	float CollisionX(int index) /*! Collision X */;
	float CollisionY(int index) /*! Collision Y */;
	float CollisionZ(int index) /*! Collision Z */;
	float CollisionNX(int index) /*! Collision Normal X */;
	float CollisionNY(int index) /*! Collision Normal Y */;
	float CollisionNZ(int index) /*! Collision Normal Z */;
	void SetType(int colltype, bool recursive = false) /*! Set entity type collision */;
	void SetRadius(float x, float y = 0.0) /*! Set entity collision radius if collision type is sphere */;
	void Reset() /*! Reset entity collision */;
	bool InView(Entity target) /*! Can camera (target) see specified entity (Camera can be taken from Player::GetHead) */;
	void Remove() /*! Remove entity */;
};
class Event
{
public:
	Room GetRoom() /*! Get event room */;
	int GetIndex() /*! Get event index */;
	int GetIdentifier() /*! Get event identifier */;
	float GetState() /*! Get state */;
	float GetState2() /*! Get state */;
	float GetState3() /*! Get state */;
	float GetState4() /*! Get state */;
	float SetState(float state) /*! Set state */;
	float SetState2(float state) /*! Set state */;
	float SetState3(float state) /*! Set state */;
	float SetState4(float state) /*! Set state */;
	void Remove() /*! Remove event. */;
};
class GUIElement
{
public:
	void GetPosition(float& out x, float& out y) /*! Get element position */;
	void SetPosition(float x, float y) /*! Set element position */;
	void SetScale(float width, float height) /*! Set element scale */;
	void GetScale(float& out width, float& out height) /*! Get element scale */;
	void SetData(string& in data) /*! Set element data for scripting messaging */;
	void SetText(string& in text) /*! Set element text*/;
	void SetSelectable(bool selectable) /*! Set element selectability. If at least one element is visible and selectable, then the player get a mouse cursor. */;
	void SetShadow(bool shadowed) /*! Set element shadow. Only for Text */;
	void SetOpacity(float target, float lerp) /*! Set element opacity */;
	void SetColor(int r, int g, int b) /*! Set element color. If you want opacity, use SetOpacity */;
	Player GetPlayer() /*! Get GUI owner */;
	void SetAttach(Player player) /*! Attach GUI to player */;
	Player GetAttach() /*! Get attached player to GUI */;
	string& GetText() /*! Get text */;
	string& GetData() /*! Get data */;
	int IsSelectable() /*! Is selectable */;
	bool IsHidden() /*! Is hidden */;
	void SetCallback(string& in funcname) /*! Set AS function callback for selectable elements. if not specified, PlayerClickGui_c is call. Declaration must be: void MyCallback(Player p, GUIElement gui) */;
	void SetCallback(GUICALLBACK @gc) /*! Set AS function callback for selectable elements. if not specified, PlayerClickGui_c is call. Declaration must be: void MyCallback(Player p, GUIElement gui) */;
	void Hide() /*! Hide GUI element */;
	void Show() /*! Show GUI element */;
	void Remove() /*! Remove GUI element */;
};
class Graphics
{
public:
	GUIElement CreateOval(Player player, float x, float y, float width, float height, bool align = false) /*! Creates a graphic element (Oval). If the player is NULL, the graphic element is created for all players. x, y, width, height are normalized to 1.0. You can use Player::GetScreenSize to display the element correctly. */;
	GUIElement CreateRect(Player player, float x, float y, float width, float height, bool align = false) /*! Creates a graphic element (Rect). If the player is NULL, the graphic element is created for all players. x, y, width, height are normalized to 1.0. You can use Player::GetScreenSize to display the element correctly. */;
	GUIElement CreateProgressBar(Player player, float time, float x, float y, float width, float height, bool align = false) /*! Creates a graphic element (Progress bar). If the player is NULL, the graphic element is created for all players. x, y, width, height are normalized to 1.0. You can use Player::GetScreenSize to display the element correctly. */;
	GUIElement CreateProgressBar(Player player, float time, float x, float y, float width, float height, bool align, string &in callback) /*! Creates a graphic element (Progress bar). The specified callback will be triggered when the progress bar reaches the end. If the player is NULL, the graphic element is created for all players. x, y, width, height are normalized to 1.0. You can use Player::GetScreenSize to display the element correctly. */;
	GUIElement CreateProgressBar(Player player, float time, float x, float y, float width, float height, bool align, ref &in callback) /*! Creates a graphic element (Progress bar). The specified callback will be triggered when the progress bar reaches the end. If the player is NULL, the graphic element is created for all players. x, y, width, height are normalized to 1.0. You can use Player::GetScreenSize to display the element correctly. */;
	GUIElement CreateText(Player player, int fontid, string& in text, float x, float y, bool align = false) /*! Creates a graphic element (Text). If the player is NULL, the graphic element is created for all players. x, y are normalized to 1.0. You can use Player::GetScreenSize to display the element correctly. */;
	GUIElement CreateImage(Player player, string& in filename, float x, float y, float width, float height, bool align = false) /*! Creates a graphic element (Image). If the player is NULL, the graphic element is created for all players. x, y, width, height are normalized to 1.0. You can use Player::GetScreenSize to display the element correctly. */;
};
class Items
{
public:
	bool IsPicked() /*! Is picked */;
	Player GetPicker() /*! Get item picker */;
	bool SetPicker(Player player) /*! Set item picker */;
	Entity GetEntity() /*! Get item entity */;
	int GetIndex() /*! Get item index */;
	string& GetName() /*! Get item name */;
	string& GetTemplateName() /*! Get item template name */;
	int GetTemplateIndex() /*! Get item template index */;
	bool IsWeapon() /*! Is item weapon */;
	void SetState(float state) /*! Set item state */;
	void SetState2(float state) /*! Set item state */;
	void SetState3(float state) /*! Set item state */;
	float GetState() /*! Get item state */;
	float GetState2() /*! Get item state */;
	float GetState3() /*! Get item state */;
	Items Fine(int) /*! Improves the item as if SCP-914 had been used. The item can be deleted or remain, and returns a new item, or returns NULL if the new item isn't created. */;
	int GetSlots() /*! Get item slots if exist. */;
	Items GetParentItem() /*! Get parent item if item in any item slot. */;
	Items GetSlotItem(int) /*! Get item from slot. */;
	bool PushItem(Items) /*! Push item to item slot. If can't, returns false */;
	bool RemoveSlotItem(int) /*! Remove item from slot. Item drops. If can't, returns false */;
	void Remove() /*! Remove item */;
};
class ModelPreset
{
public:
	const string& headbone;
	const string& spinebone;
	const string& handbone;
	const string& forearmbone;
	int DEPRECATED;
	const int maximumspinepitch;
	const int maximumspinepitchdist;
	const int maximumheadpitch;
	const int fixedspinerotation;
	const bool usedefaultrolls;
	const float offsetyaw;
	const float offsety;
	const float collisionradius;
	const float scale;
	const string& stepsound;
	const float blobshadowsize;
	const float forearmholdingpitch;
	const float forearmholdingyaw;
	const float forearmholdingroll;
	const float holdingitemoffsetx;
	const float holdingitemoffsety;
	const float holdingitemoffsetz;
	const float holdingitemoffsetpitch;
	const float holdingitemoffsetyaw;
	const float holdingitemoffsetroll;
	const float hitboxwidth;
	const float hitboxheight;
	const float hitboxdepth;
	const float speed;
	const float stamina;
};
class NPC
{
public:
	Entity GetEntity() /*! Get entity */;
	Entity GetModel() /*! Get model */;
	void SetPickable(bool pickable) /*! Sets that the NPC can be shot at. Calls PlayerShootNPC_c on shoot */;
	void SetDead(bool state) /*! Set NPC dead state */;
	bool IsDead() /*! Is NPC dead */;
	void SetHealth(int health) /*! Get NPC HP */;
	int GetHealth() /*! Get NPC HP */;
	void SetState1(float state) /*! Set NPC state */;
	void SetState2(float state) /*! Set NPC state */;
	void SetState3(float state) /*! Set NPC state */;
	float GetState1() /*! Get NPC state */;
	float GetState2() /*! Get NPC state */;
	float GetState3() /*! Get NPC state */;
	void Remove() /*! Remove */;
};
class Object
{
public:
	void SetRoom(Room) /*! Set object room */;
	Room GetRoom() /*! Get object room */;
	Entity GetEntity() /*! Get object controller entity. Use pick mode 2 on this entity to enable bullets collision. */;
	Entity GetModel() /*! Get object model. Touching this not recommended */;
	void SetTexture(int textureid) /*! Set object texture from preloaded textures */;
	void SetTouchable(bool val) /*! Set touchable to activate PlayerClickObject */;
	void Remove() /*! Remove object */;
};
class Player
{
public:
	Entity GetHitbox() /*! Get hitbox entity */;
	Entity GetHead() /*! Get head entity */;
	Entity GetEntity() /*! Get main entity */;
	void GetScreenSize(int& out width, int& out height) /*! Get screen size */;
	string& GetLanguage() /*! Get language. (ru-RU, en-EN) */;
	string& GetIP() /*! Get IP */;
	string& GetSteamID() /*! Get SteamID */;
	string& GetHWID() /*! Get HWID */;
	string& GetName() /*! Get name */;
	void SetSteamID(string &in steamid64) /*! Set SteamID */;
	void SetName(string &in name) /*! Set name */;
	int GetPing() /*! Get ping */;
	int GetIndex() /*! Get player index */;
	string& GetVersion() /*! Get version */;
	void SetInvisible(bool inv) /*! Set invisible for everybody */;
	void SetLocalInvisible(Player player, bool inv) /*! Set invisible for one player */;
	void Kick(int code = 0, string& in custom = "") /*! Kick player with specified code. Custom text will work with CUSTOMERROR code */;
	void ShowDialog(int type, int index, string& in header, string& in message, string& in leftbutton, string& in rightbutton = "", bool align = true) /*! Shows multifunctional menu. Calls PlayerDialogAction on response. */;
	void ShowDialog(int type, DIALOGCALLBACK@ callback, string& in header, string& in message, string& in leftbutton, string& in rightbutton = "", bool align = true) /*! Shows multifunctional menu. Calls callback function on response. */;
	void SetDialogData(string& in data) /*! Set dialog data for script messaging. */;
	string& GetDialogData() /*! Get dialog data */;
	void HideDialog() /*! Hide current dialog */;
	void SendMessage(string& in message, float time = 6.0, bool localized = false) /*! Send middle screen message. */;
	void Desync(bool value) /*! If enabled, PlayerUpdate will not be called and no new player data will be accepted. Useful for freezing a player's actions */;
	bool IsDesync() /*! Desynced? */;
	Player GetSpectatePlayer() /*! Get current spectate player. This function works even if the player is alive. */;
	bool Kill(bool bloody = false, bool createcorpse = true) /*! Kill player. If successfully, returns true  */;
	bool Respawn() /*! Respawn player. If successfully, returns true. Calls PlayerRespawn_c callback */;
	bool IsDead() /*! Is dead */;
	void SetInjuries(float val) /*! Set injuries */;
	float GetInjuries() /*! Get injuries */;
	void SetBloodloss(float val) /*! Set bloodloss */;
	float GetBloodloss() /*! Get bloodloss */;
	bool GetGodmode() /*! Get godmode */;
	void SetGodmode(bool val) /*! Set godmode */;
	void SetColor(int hx) /*! Set color in players list in HEX Value (0xFFFFFFFF - full white). It's not recommend to use this function often */;
	int GetColor() /*! Get color in players list */;
	void GetNetworkPosition(float& out x, float& out y, float& out z) /*! Get network data after latest PlayerUpdate */;
	void GetNetworkRotation(float& out pitch, float& out yaw) /*! Get network data after latest PlayerUpdate */;
	void SetNetworkPosition(float x, float y, float z) /*! Set network data after latest PlayerUpdate */;
	void SetNetworkRotation(float pitch, float yaw) /*! Set network data after latest PlayerUpdate */;
	void SetPosition(float x, float y, float z, Room room = NULL, bool updatepivot = true) /*! Set position and send sync back to player */;
	void SetRotation(float, float) /*! Set rotation and send sync back to player */;
	void SetRoom(Room room) /*! Set player room. Useful for bots. */;
	Room GetRoom() /*! Get player room */;
	void SetPositionBounds(Room room, float x = 0.0, float y = 0.0, float z = 0.0, float distance = 0.0) /*! Set player position limiter. The player will not be able to go beyond this limit in any way. If room is NULL then limiter is disabled*/;
	void Explode(bool thrust = false) /*! Send explosion timer to player. If thrust is true then only camera shaking and sound will be sent.*/;
	void MovePlayer(float speedmult, float angle) /*! Forcibly moves the player on his side. If the player does not respond, there will be no movement.*/;
	void IgnoreProximity(bool value) /*! Ignore all players proximity set by 'proximityplayers' setting. This function was created specially for SCP-096*/;
	void SendDamage(Player player, float force, bool headshot, float offsetx, float offsety, float offsetz) /*! Send damage to player. Offset is blood particle position offset*/;
	void SetAdmin(bool val) /*! Set admin access */;
	bool IsAdmin() /*! Is admin? */;
	void SetGlobalTransmission(bool val) /*! Set global transmission for voice. Use for example for intercom */;
	bool IsGlobalTransmission() /*! Is global transmission enabled */;
	bool SendVoice(int bank, int radio = 0, bool global = false, Player target = NULL) /*! Send voice data from player. Radio can be send too. Global is local sound. If target != NULL then voice data will send only to target player*/;
	int GetItemsCount() /*! Get items count in inventory */;
	Items GetInventory(int) /*! Get item from inventory slot */;
	Items GetSelectedItem() /*! Get current selected item */;
	float GetBlinkTimer() /*! Get blink timer. */;
	void SetBlinkTimer(float time) /*! Set blink timer. Better to use SetBlinkEffect instead of this. */;
	bool IsBlinking() /*! Is player blinking */;
	void SetBlinkEffect(float effectvalue, float time) /*! Set blink effect.*/;
	void GetBlinkEffect(float &out effectvalue, float &out time) /*! Get blink effect */;
	int GetRadio() /*! Get player current using radio. */;
	void SetNetworkAnimation(int animid) /*! Set network animation */;
	void SetAnimation(int animid) /*! Set animation constantly after PlayerUpdate.*/;
	int GetAnimation() /*! Get current animation */;
	void SetSpeedMultiplier(float multiplier) /*! Set speed multiplier */;
	void SetStaminaMultiplier(float multiplier) /*! Set stamina multiplier. The more the faster the stamina is spent. */;
	float GetSpeedMultiplier() /*! Get speed multiplier */;
	float GetStaminaMultiplier() /*! Get stamina multiplier */;
	void SetAttach(int bodyindex, int attachmodelindex, Items item = NULL) /*! Sets the exist attach */;
	int GetAttach(int bodyindex) /*! Get attach model from body index */;
	Items GetAttachItem(int bodyindex) /*! Get attach item from body index */;
	int GetModel() /*! Get model */;
	void SetModel(int modelid, int textureid = -1) /*! Set model and texture id. It is not recommended to use this command too often. */;
	void SetModelSize(float) /*! Set model size. It is not recommended to use this command too often. */;
	float GetModelSize() /*! Get model size */;
	void SetModelTexture(int textureid) /*! Set model texture. It is not recommended to use this command too often. */;
	int GetModelTexture() /*! Get model texture */;
	float GetVolume() /*! Get current player volume (Voice, steps, shoots, etc...) */;
	bool IsCrouch() /*! Is player crouch? */;
	void SetGravity(float multiplier) /*! Set gravity multiplier for player. Global gravity will be ignored. If multiplier = 0.0, then global gravity will be used */;
	float GetGravity() /*! Get player gravity multiplier. If not set, return 0.0 */;
	void SetTagText(int index, string& in) /*! Set tag text. The index from 0 to 2 is reserved for nickname, voice, tag. */;
	void SetTagScales(int index, float, float) /*! Set tag scales */;
	void SetTagOffset(int index, float) /*! Set tag offset */;
	void SetTagColors(int index, int, int) /*! Set tag colors */;
	void SetTagFont(int index, string& in) /*! Set tag font */;
	int GetShootsCount() /*! Get shoots count. */;
	void SetShootsCount(int count) /*! Set shoots count. The player will shoot until this value is reached. */;
	void RedirectMove(bool move) /*! If enabled, the player is controlled by his entity, not network data. Useful for bots. */;
	bool IsBot() /*! Bot? */;
	void SetWearData(int bodyindex, Items item) /*! Sets the item for attaches. This thing only useful for bots, as they cannot update data. */;
	void Console(string& in message) /*! Sends console message to player */;
	bool GetKeyState(int keytype) /*! Is key pressed */;
	void GetTeleportData(float&out x, float&out y, float&out z, Room&out room, int&out tick) /* Get latest SetPosition data */;
};
class Room
{
public:
	string& GetName() /*! Get name */;
	int GetIndex() /*! Get index */;
	int GetIdentifier() /*! Get identifier */;
	Entity GetEntity() /*! Get entity. Has few children */;
	bool IsAdjacent(Room) /*! Is room adjacent? */;
	Room GetAdjacentRoom(int index) /*! Get adjacent room by index */;
	Door GetAdjacentDoor(int index) /*! Get adjacent door by index*/;
	Door GetDoor(int) /*! Get room door */;
	bool IsInside(Entity) /*! Is entity inside this room */;
};
class Server
{
public:
	void Restart() /*! Restart server */;
	void Console(string& in) /*! Send console message to server world */;
	string& GetVersion() /*! Get server version */;
	int GetUPS() /*! Get server updates count per second */;
	Config ParseConfig(string& in filename) /*! Parse .cfg file */;
	string& hostname/*! Changes hostname */;
	int port/*! Not used. Using this variable may harm the server. */;
	int corpsealivetime/*! Dead bodies removal time in seconds (may cause perfomance issues if too high). */;
	int timeout/*! Player timeout connection loss kick in seconds */;
	bool chat/*! Allow players to chat */;
	bool console/*! Allow console for everybody */;
	int voicebitrate/*! KBit/s, lower value will reduce network eating but quality will be bad, 0 - auto, 255 - max. 60 is recommended */;
	int maxplayers/*! 60 is VERY recommended due to MTU limit (some players may lose data if more than 60) */;
	string& mapseed/*! Changes map seed. Will apply after restarting. Empty string - random seed. Use it only in ServerRestart_c callback because the server was loaded with another map seed, and as a result, the players will not be able to join. */;
	string& adminpassword/*! Password for console allow, empty - disabled. Use /logadmin [password] */;
	int difficulty/*! 0 - safe, 1 - euclid, 2 - keter, 3 - apollyon */;
	string& gamemode/*! Gamemode */;
	int emptybehaviour/*! 0 - restart server and waiting for players, 1 - pause and waiting for players, 2 - without pause and restart, 0 not recommended */;
	bool scriptsautoload/*! Not used */;
	bool disablenpcs/*! Not used. Using this variable may harm the server. */;
	float proximityplayers/*! The players will see the players at that distance. The distance must be squared (^2) */;
	float mapbounds/*! The bounds of map (player XYZ can't go through this value) */;
	int respawntime/*! Respawn time in seconds. 0 - disable auto-respawn. Won't be synchronized for current players. */;
	string& contenturl/*! Content URL for content downloading. Can be HTTP and HTTPs */;
	string& password/*! Server password */;
	bool improvedgates/*! Use it only in ServerRestart_c callback because the server was loaded with another gates type, and as a result, the players will not be able to join. */;
	int mapsize/*! 6-28 is allowed. 21 is default. (small - 14) (medium - 18) (big - 22) With small map sizes it is very possible for important rooms to not appear, so keep this in mind when shrinking the map. Use it only in ServerRestart_c callback because the server was loaded with another map size, and as a result, the players will not be able to join. */;
	int masterserver/*! Not used */;
	bool allowjump/*! Allow jumps */;
	string& description/*! Server description */;
	bool fastslots/*! Allow fast slots */;
	float gravity/*! Gravity multiplier */;
};
class World
{
public:
	void CreateDecal(int decalid, float x, float y, float z, float pitch, float yaw, float roll, Room room = NULL, float lifetime = 1.0f, float alpha = 1.0f, float size = 1.0f, float sizechange = 0.0f, float maxsize = 1.0f, float alphachange = 0.0f, int r = 0, int g = 0, int b = 0, float timer = 0.0);
	Player CreateBot(string& in) /*! Creates bot with specified name. Calls PlayerConnect callback. Can return null */;
	void RaycastItems() /*! After creating a large number of items, it is recommended to use this function, as it is possible that the items will sink under the floor. */;
	Items GetItem(int index) /*! Get item by index (MAX_ITEMS) */;
	Items CreateItem(string& in templatename, bool collision = true, float x = 0, float y = 0, float z = 0, int r = 0, int g = 0, int b = 0, float alpha = 1.0, int invslots = 0) /*! Creates an item by template name. There is a possibility of not creating due to reaching the limit. */;
	Items CreateItem(int templateindex, bool collision = true, float x = 0, float y = 0, float z = 0, int r = 0, int g = 0, int b = 0, float alpha = 1.0, int invslots = 0) /*! Creates an item by template index. There is a possibility of not creating due to reaching the limit. */;
	Room GetRoomByName(string& in) /*! Get room by name */;
	Room GetRoomByIndex(int) /*! Get room by index (MAX_ROOMS) */;
	Room GetRoomByIdentifier(int) /*! Get room by identifier */;
	Corpse GetCorpse(int index) /*! Get corpse by index. (MAX_CORPSES) */;
	Door GetDoor(int) /*! Get door by index. (MAX_DOORS) */;
	Event GetEvent(int index) /*! Get event by index (MAX_EVENTS) */;
	Event GetEventByIdentifier(int index) /*! Get event by identifier. */;
	Object CreateObject(int objectid, Room room = NULL, bool animated = false) /*! Creates object. If no room is specified, the object will be synchronized by distance, not by room. Use animated if you want to use Entity::SetAnimTime */;
	Object GetObject(int index) /*! Get object by index. (MAX_OBJECTS) */;
	NPC CreateNPC(int npctype, float x, float y, float z) /*! Creates a NPC. Doesn't work with 'disablenpcs' setting */;
	NPC GetNPC(int index) /*! Get NPC by index. (MAX_NPCS)*/;
	ModelPreset GetModelPreset(int modelid) /* Get model data by modelid */;
};
