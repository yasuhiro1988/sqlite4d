module sqlite3;

import std.conv;

struct sqlite3;
struct sqlite3_context;
struct sqlite3_mutex;
struct sqlite3_stmt;
struct sqlite3_value;

extern(C)
{
	char* sqlite3_libversion();
	char* sqlite3_sourceid();
	int sqlite3_libversion_number();

	int sqlite3_compileoption_used(const char *zOptName);
	char* sqlite3_compileoption_get(int N);

	/* Closing A Database Connection */
	int sqlite3_close(sqlite3* pDb);

	alias int function(void* notused, int argc, char** argv, char** zColName) sqlite3_callback;

	int sqlite3_exec(sqlite3* pDb, const char *sql, sqlite3_callback callback, void* arg, char** errmsg);

	int sqlite3_open(const char* filename, sqlite3** ppDb);

	int sqlite3_open16(const wchar* filename, sqlite3** ppDb);

	int sqlite3_open_v2(const char* filename, sqlite3** ppDb, int flags, const char* zVfs);

	int sqlite3_prepare(sqlite3* pDb, const char* zSql, int nByte, sqlite3_stmt** ppStmt, const char** pzTail);

	int sqlite3_step(sqlite3_stmt* pStmt);

	/* Run-time Limits */
	int sqlite3_limit(sqlite3* pDb, const int id, const int newVal);

	/* Test To See If The Library Is Threadsafe */
	int sqlite3_threadsafe();

	int sqlite3_reset(sqlite3_stmt* pStmt);

	int sqlite3_finalize(sqlite3_stmt* pStmt);

	int sqlite3_column_count(sqlite3_stmt *pStmt);

	/* Number of columns in a result set */
	int sqlite3_data_count(sqlite3_stmt* pStmt);

	/* Retrieving Statement SQL */
	char* sqlite3_sql(sqlite3_stmt* pStmt);

	/* Count The Number Of Rows Modified */
	int sqlite3_changes(sqlite3* pDb);

	/* Determine If An SQL Statement Is Complete */
	int sqlite3_complete(const char* sql);
	int sqlite3_complete16(const wchar* sql);

	/* Determine If A Prepared Statement Has Been Reset */
	int sqlite3_stmt_busy(sqlite3_stmt* pStmt);

	/* Determine If An SQL Statement Writes The Database */
	int sqlite3_stmt_readonly(sqlite3_stmt* pStmt);

	/* Prepared Statement Status */
	int sqlite3_stmt_status(sqlite3_stmt* pStmt, int op, int resetFlg);

	/* Configure database connections */
	int sqlite3_db_config(sqlite3* pDb, int op, ...);

	/* Return The Filename For A Database Connection */
	char* sqlite3_db_filename(sqlite3* pDb, const char* zDbName);

	/* Find The Database Handle Of A Prepared Statement */
    sqlite3* sqlite3_db_handle(sqlite3_stmt* pStmt);

	/* Retrieve the mutex for a database connection */
    sqlite3_mutex* sqlite3_db_mutex(sqlite3* pDb);

	/* Database Connection Status */
    int sqlite3_db_status(sqlite3* pDb, const int op, int* pCur, int* pHiwtr, const int resetFlg);

	/* Determine if a database is read-only */
	int sqlite3_db_readonly(sqlite3 *pDb, const char *zDbName);

	/* Free Memory Used By A Database Connection */
	int sqlite3_db_release_memory(sqlite3* pDb);

	sqlite3_stmt* sqlite3_next_stmt(sqlite3* pDb, sqlite3_stmt* pStmt);

	/* Initialize The SQLite Library */
    int sqlite3_initialize();
    int sqlite3_shutdown();
    int sqlite3_os_init();
    int sqlite3_os_end();

	/* User Data For Functions */
	void* sqlite3_user_data(sqlite3_context* pContext);

	/* Result Values From A Query */
	void* sqlite3_column_blob(sqlite3_stmt* pStmt, int iCol);
	int sqlite3_column_bytes(sqlite3_stmt* pStmt, int iCol);
	int sqlite3_column_bytes16(sqlite3_stmt* pStmt, int iCol);
	double sqlite3_column_double(sqlite3_stmt* pStmt, int iCol);
	int sqlite3_column_int(sqlite3_stmt* pStmt, int iCol);
	long sqlite3_column_int64(sqlite3_stmt* pStmt, int iCol);
	char* sqlite3_column_text(sqlite3_stmt* pStmt, int iCol);
	wchar* sqlite3_column_text16(sqlite3_stmt* pStmt, int iCol);
	int sqlite3_column_type(sqlite3_stmt* pStmt, int iCol);
	sqlite3_value* sqlite3_column_value(sqlite3_stmt* pStmt, int iCol);

	/* Declared Datatype Of A Query Result */
	char* sqlite3_column_decltype(sqlite3_stmt* pStmt,int iCol);
	wchar* sqlite3_column_decltype16(sqlite3_stmt* pStmt,int iCol);
	
	/* Column Names In A Result Set */
	char* sqlite3_column_name(sqlite3_stmt* pStmt, int iCol);
    wchar* sqlite3_column_name16(sqlite3_stmt* pStmt, int iCol);

	/* Error Codes And Messages */
	int sqlite3_errcode(sqlite3* pDb);
	int sqlite3_extended_errcode(sqlite3* pDb);
	char* sqlite3_errmsg(sqlite3* pDb);
	wchar* sqlite3_errmsg16(sqlite3* pDb);

	/* Error Logging Interface */
    void sqlite3_log(int iErrCode, const char* zFormat, ...);
}

@property string sqlite3_version()
{
	return sqlite3_libversion().to!string();
}
