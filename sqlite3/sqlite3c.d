module sqlite3c;

import core.vararg, std.conv, sqlite3;

class sqlite3c
{
	sqlite3* db = null;

	@property string _version()
	{
		return libversion();
	}

	string libversion() const
	{
		return sqlite3_libversion().to!string();
	}

	int open(const char* filename)
	{
		return sqlite3_open(filename, &db);
	}

	int open(const char* filename, int flags, const char *zVfs)
	{
		return sqlite3_open_v2(filename, &db, flags, zVfs);
	}

	int open16(const wchar* filename)
	{
		return sqlite3_open16(filename, &db);
	}

	int close()
	{
		return sqlite3_close(db);
	}

	int exec(sqlite3* pDb, const char* sql, sqlite3_callback callback, void* arg, char** errmsg)
	{
		return sqlite3_exec(db, sql, callback, arg, errmsg);
	}

	int prepare(string zSql, sqlite3_stmt** ppStmt, const char** pzTail)
	{
		return sqlite3_prepare(db, zSql.ptr, char.sizeof * zSql.length, ppStmt, pzTail);
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

	int threadsafe() const
	{
		return sqlite3_threadsafe();
	}

	int finalize(sqlite3_stmt* pStmt) const
	{
		return sqlite3_finalize(pStmt);
	}

	int changes()
	{
		return sqlite3_changes(db);
	}

	int complete(const char* sql) const
	{
		return sqlite3_complete(sql);
	}

	int complete16(const wchar* sql) const
	{
		return sqlite3_complete16(sql);
	}

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

	int db_release_memory()
	{
		return sqlite3_db_release_memory(db);
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
