enum ConvTypes
{
	cdecl		= 0,
	stdcall		= 1
}

int currentlib = 0;
int convtype = 0;
string libmethod = "";

void OnInitialize()
{

}

void ExampleLoad() // To use this, put this in OnInitialize() function
{
	SetLibrary(LoadLibrary("uemph.dll"));
	SetConvType(stdcall);

	RegisterFunction("const char SplitString(const char, const char, int)", "_SplitString@12");
	RegisterFunction("void CreateConsole()", "_CreateConsole@0");
	RegisterFunction("void ConsoleTitle(const char)", "_ConsoleTitle@4");
	RegisterFunction("const char ConsoleInput(const char)", "_ConsoleInput@4");
	RegisterFunction("void ConsoleColor(int)", "_ConsoleColor@4");
	RegisterFunction("void ConsoleMessage(const char)", "_ConsoleMessage@4");
	
	RegisterFunction("int malloc(int)", "_Memory_Alloc@4");
	RegisterFunction("void free(int)", "_Memory_Dealloc@4");
	RegisterFunction("void mem_pokebyte(int,int8)", "_Memory_PokeByte@8");
	RegisterFunction("void mem_pokeshort(int,int16)", "_Memory_PokeShort@8");
	RegisterFunction("void mem_pokeint(int,int)", "_Memory_PokeInt@8");
	RegisterFunction("void mem_pokefloat(int,float)", "_Memory_PokeFloat@8");
	RegisterFunction("void mem_pokeint64(int,int64)", "_Memory_PokeInt64@12");
	
	RegisterFunction("int8 mem_peekbyte(int)", "_Memory_PeekByte@4");
	RegisterFunction("int16 mem_peekshort(int)", "_Memory_PeekShort@4");
	RegisterFunction("int mem_peekint(int)", "_Memory_PeekInt@4");
	RegisterFunction("float mem_peekfloat(int)", "_Memory_PeekFloat@4");
	RegisterFunction("int64 mem_peekint64(int)", "_Memory_PeekInt64@4");
	RegisterFunction("const char mem_peekconstchar(int)", "_Memory_PeekConstChar@4");
}

void SetLibrary(int lib)
{
	currentlib = lib;
}

void SetConvType(int type)
{
	convtype = type;
}

void SetLibraryMethod(string method)
{
	libmethod = method;
}

void RegisterMethod(string declaration, string proc)
{
	RegisterLibraryMethod(libmethod, declaration, GetProcAddress(currentlib, proc), convtype);
}

void RegisterFunction(string declaration, string proc)
{
	RegisterLibraryFunction(declaration, GetProcAddress(currentlib, proc),convtype);
}

void RegisterClass(string decl, string get, string proc)
{
	RegisterLibraryObject(decl);
	RegisterFunction(decl + "& " + get, proc);
}
