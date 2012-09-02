module sqlite3c;

import core.vararg, std.conv, sqlite3;

// Result Codes
enum SQLITE
{
	OK = SQLITE_OK,
	ERROR = SQLITE_ERROR,
	INTERNAL = SQLITE_INTERNAL,
	PERM = SQLITE_PERM,   
	ABORT = SQLITE_ABORT,
	BUSY = SQLITE_BUSY,
	LOCKED = SQLITE_LOCKED,
	NOMEM = SQLITE_NOMEM, 
	READONLY = SQLITE_READONLY,  
	INTERRUPT = SQLITE_INTERRUPT,
	IOERR = SQLITE_IOERR,
	CORRUPT = SQLITE_CORRUPT,  
	NOTFOUND = SQLITE_NOTFOUND,
	FULL = SQLITE_FULL,
	CANTOPEN = SQLITE_CANTOPEN,   
	PROTOCOL = SQLITE_PROTOCOL,
	EMPTY = SQLITE_EMPTY,
	SCHEMA = SQLITE_SCHEMA,  
	TOOBIG = SQLITE_TOOBIG, 
	CONSTRAINT = SQLITE_CONSTRAINT,
	MISMATCH = SQLITE_MISMATCH,
	MISUSE = SQLITE_MISUSE,
	NOLFS = SQLITE_NOLFS, 
	AUTH = SQLITE_AUTH,  
	FORMAT = SQLITE_FORMAT,   
	RANGE = SQLITE_RANGE, 
	NOTADB = SQLITE_NOTADB,  
	ROW = SQLITE_ROW, 
	DONE = SQLITE_DONE,    
}

// Extended Result Codes

// Flags For File Open Operations
enum SQLITE_OPEN
{
	READONLY       = SQLITE_OPEN_READONLY, /* Ok for sqlite3_open_v2() */
	READWRITE      = SQLITE_OPEN_READWRITE, /* Ok for sqlite3_open_v2() */
	CREATE         = SQLITE_OPEN_CREATE, /* Ok for sqlite3_open_v2() */
	DELETEONCLOSE  = SQLITE_OPEN_DELETEONCLOSE, /* VFS only */
	EXCLUSIVE      = SQLITE_OPEN_EXCLUSIVE, /* VFS only */
	AUTOPROXY      = SQLITE_OPEN_AUTOPROXY, /* VFS only */
	URI            = SQLITE_OPEN_URI, /* Ok for sqlite3_open_v2() */
	MEMORY         = SQLITE_OPEN_MEMORY, /* Ok for sqlite3_open_v2() */
	MAIN_DB        = SQLITE_OPEN_MAIN_DB, /* VFS only */
	TEMP_DB        = SQLITE_OPEN_TEMP_DB, /* VFS only */
	TRANSIENT_DB   = SQLITE_OPEN_TRANSIENT_DB, /* VFS only */
	MAIN_JOURNAL   = SQLITE_OPEN_MAIN_JOURNAL, /* VFS only */
	TEMP_JOURNAL   = SQLITE_OPEN_TEMP_JOURNAL, /* VFS only */
	SUBJOURNAL     = SQLITE_OPEN_SUBJOURNAL, /* VFS only */
	MASTER_JOURNAL = SQLITE_OPEN_MASTER_JOURNAL, /* VFS only */
	NOMUTEX        = SQLITE_OPEN_NOMUTEX, /* Ok for sqlite3_open_v2() */
	FULLMUTEX      = SQLITE_OPEN_FULLMUTEX, /* Ok for sqlite3_open_v2() */
	SHAREDCACHE    = SQLITE_OPEN_SHAREDCACHE, /* Ok for sqlite3_open_v2() */
	PRIVATECACHE   = SQLITE_OPEN_PRIVATECACHE, /* Ok for sqlite3_open_v2() */
	WAL            = SQLITE_OPEN_WAL, /* VFS only */
	/* Reserved:               = 0x00F00000, */
}

// Device Characteristics

// File Locking Levels
enum SQLITE_LOCK
{
	NONE      = SQLITE_LOCK_NONE,
	SHARED    = SQLITE_LOCK_SHARED,
	RESERVED  = SQLITE_LOCK_RESERVED,
	PENDING   = SQLITE_LOCK_PENDING,
	EXCLUSIVE = SQLITE_LOCK_EXCLUSIVE,
}

// Synchronization Type Flags
enum SQLITE_SYNC
{
	NORMAL   = SQLITE_SYNC_NORMAL,
	FULL     = SQLITE_SYNC_FULL,
	DATAONLY = SQLITE_SYNC_DATAONLY,
}

class sqlite3c
{
	sqlite3* db = null;

	// Run-Time Library Version Numbers

	string libversion() const
	{
		return sqlite3_libversion().to!string();
	}

	string sourceid() const
	{
		return sqlite3_sourceid().to!string();
	}

	int libversion_number() const
	{
		return sqlite3_libversion_number();
	}

	//^Run-Time Library Version Numbers

	// Test To See If The Library Is Threadsafe
	int threadsafe() const
	{
		return sqlite3_threadsafe();
	}
	
	// Closing A Database Connection
	int close()
	{
		return sqlite3_close(db);
	}

	// One-Step Query Execution Interface
	int exec(sqlite3* pDb, const char* sql, sqlite3_callback callback, void* arg, char** errmsg)
	{
		return sqlite3_exec(db, sql, callback, arg, errmsg);
	}

	int open(const char* filename)
	{
		return sqlite3_open(filename, &db);
	}

	int open_v2(const char* filename, int flags, const char *zVfs)
	{
		return sqlite3_open_v2(filename, &db, flags, zVfs);
	}

	int open16(const wchar* filename)
	{
		return sqlite3_open16(filename, &db);
	}

	int prepare(string zSql, sqlite3_stmt** ppStmt, const char** pzTail)
	{
		return sqlite3_prepare(db, zSql.ptr, char.sizeof * zSql.length, ppStmt, pzTail);
	}

	int prepare_v2(string zSql, sqlite3_stmt** ppStmt, const char** pzTail)
	{
		return sqlite3_prepare_v2(db, zSql.ptr, char.sizeof * zSql.length, ppStmt, pzTail);
	}

	int prepare16(string zSql, sqlite3_stmt** ppStmt, const wchar** pzTail)
	{
		return sqlite3_prepare16(db, zSql.ptr, char.sizeof * zSql.length, ppStmt, pzTail);
	}

	int prepare16_v2(string zSql, sqlite3_stmt** ppStmt, const wchar** pzTail)
	{
		return sqlite3_prepare16_v2(db, zSql.ptr, char.sizeof * zSql.length, ppStmt, pzTail);
	}

	int step(sqlite3_stmt* pStmt) const
	{
		return sqlite3_step(pStmt);
	}

	int reset(sqlite3_stmt* pStmt) const
	{
		return sqlite3_reset(pStmt);
	}

	int limit(in int id, in int newVal)
	{
		return sqlite3_limit(db, id, newVal);
	}

	int finalize(sqlite3_stmt* pStmt) const
	{
		return sqlite3_finalize(pStmt);
	}

	int changes()
	{
		return sqlite3_changes(db);
	}

	void interrupt()
	{
		sqlite3_interrupt(db);
	}

	int complete(const char* sql) const
	{
		return sqlite3_complete(sql);
	}

	int complete16(const wchar* sql) const
	{
		return sqlite3_complete16(sql);
	}

	// Initialize The SQLite Library

	int initialize() const
	{
		return sqlite3_initialize();
	}

    int shutdown() const
	{
		return sqlite3_shutdown();
	}
    
	int os_init() const
	{
		return sqlite3_os_init();
	}

    int os_end() const
	{
		return sqlite3_os_end();
	}

	//^Initialize The SQLite Library

	void* user_data(sqlite3_context* pContext)
	{
		return sqlite3_user_data(pContext);
	}

	int column_count(sqlite3_stmt *pStmt) const
	{
		return sqlite3_column_count(pStmt);
	}

	void* column_blob(sqlite3_stmt* pStmt, int iCol) const
	{
		return sqlite3_column_blob(pStmt, iCol);
	}

	int column_bytes(sqlite3_stmt* pStmt, int iCol) const
	{
		return sqlite3_column_bytes(pStmt, iCol);
	}
	
	int column_bytes16(sqlite3_stmt* pStmt, int iCol) const
	{
		return sqlite3_column_bytes16(pStmt, iCol);
	}
	
	double column_double(sqlite3_stmt* pStmt, int iCol) const
	{
		return sqlite3_column_double(pStmt, iCol);
	}
	
	int column_int(sqlite3_stmt* pStmt, int iCol) const
	{
		return sqlite3_column_int(pStmt, iCol);
	}
	
	long column_int64(sqlite3_stmt* pStmt, int iCol) const
	{
		return sqlite3_column_int64(pStmt, iCol);
	}

	string column_text(sqlite3_stmt* pStmt, int iCol) const
	{
		return sqlite3_column_text(pStmt, iCol).to!string();
	}

    wstring column_text16(sqlite3_stmt* pStmt, int iCol) const
	{
		return sqlite3_column_text16(pStmt, iCol).to!wstring();
	}

    int column_type(sqlite3_stmt* pStmt, int iCol) const
	{
		return sqlite3_column_type(pStmt, iCol);
	}

	sqlite3_value* column_value(sqlite3_stmt* pStmt, int iCol) const
	{
		return sqlite3_column_value(pStmt, iCol);
	}

	string column_decltype(sqlite3_stmt* pStmt, int iCol) const
	{
		return sqlite3_column_decltype(pStmt, iCol).to!string();
	}

	wstring column_decltype16(sqlite3_stmt* pStmt, int iCol) const
	{
		return sqlite3_column_decltype16(pStmt, iCol).to!wstring();
	}

	string column_name(sqlite3_stmt* pStmt, int iCol) const
	{
		return sqlite3_column_name(pStmt, iCol).to!string();
	}

    wstring column_name16(sqlite3_stmt* pStmt, int iCol) const
	{
		return sqlite3_column_name16(pStmt, iCol).to!wstring();
	}

	int data_count(sqlite3_stmt* pStmt) const
	{
		return sqlite3_data_count(pStmt);
	}

	int stmt_busy(sqlite3_stmt* pStmt) const
	{
		return sqlite3_stmt_busy(pStmt);
	}

	int stmt_readonly(sqlite3_stmt* pStmt) const
	{
		return sqlite3_stmt_readonly(pStmt);
	}

	int stmt_status(sqlite3_stmt* pStmt, int op, int resetFlg) const
	{
		return sqlite3_stmt_status(pStmt, op, resetFlg);
	}

	int db_config(int op, ...)
	{
		return sqlite3_db_config(db, op, _arguments);
	}

	string db_filename(const char* zDbName)
	{
		return sqlite3_db_filename(db, zDbName).to!string();
	}

	sqlite3* db_handle(sqlite3_stmt* pStmt) const
	{
		return sqlite3_db_handle(pStmt);
	}

	sqlite3_mutex* db_mutex()
	{
		return sqlite3_db_mutex(db);
	}

	int db_readonly(const char *zDbName)
	{
		return sqlite3_db_readonly(db, zDbName);
	}

	int db_status(in int op, ref int iCur, ref int iHiwtr, in bool resetFlg)
	{
		return sqlite3_db_status(db, op, &iCur, &iHiwtr, resetFlg ? 1 : 0);
	}

	sqlite3_stmt* next_stmt(sqlite3_stmt* pStmt)
	{
		return sqlite3_next_stmt(db, pStmt);
	}

	int errcode()
	{
		return sqlite3_errcode(db);
	}

	int extended_errcode()
	{
		return sqlite3_extended_errcode(db);
	}

	string errmsg()
	{
		return sqlite3_errmsg(db).to!string();
	}

	wstring errmsg16()
	{
		return sqlite3_errmsg16(db).to!wstring();
	}

	void log(int iErrCode, const char *zFormat, ...)
	{
		return sqlite3_log(iErrCode, zFormat, _arguments);
	}
}
