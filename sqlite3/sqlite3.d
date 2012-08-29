module sqlite3;

import std.conv;

struct sqlite3;
struct sqlite3_backup;
struct sqlite3_mutex;

alias long sqlite3_int64;
alias ulong sqlite3_uint64;

alias void function() sqlite3_syscall_ptr;

struct sqlite3_vfs
{
	int iVersion;            /* Structure version number (currently 3) */
	int szOsFile;            /* Size of subclassed sqlite3_file */
	int mxPathname;          /* Maximum file pathname length */
	sqlite3_vfs* pNext;      /* Next registered VFS */
	const char* zName;       /* Name of this virtual file system */
	void* pAppData;          /* Pointer to application-specific data */
	int function(sqlite3_vfs*, const char *zName, sqlite3_file*, int flags, int *pOutFlags) xOpen;
	int function(sqlite3_vfs*, const char *zName, int syncDir) xDelete;
	int function(sqlite3_vfs*, const char *zName, int flags, int *pResOut) xAccess;
	int function(sqlite3_vfs*, const char *zName, int nOut, char *zOut) xFullPathname;
	void* function(sqlite3_vfs*, const char *zFilename) xDlOpen;
	void function(sqlite3_vfs*, int nByte, char *zErrMsg) xDlError;
	void function(sqlite3_vfs*,void*, const char *zSymbol) xDlSym;
	void function(sqlite3_vfs*, void*) xDlClose;
	int function(sqlite3_vfs*, int nByte, char *zOut) xRandomness;
	int function(sqlite3_vfs*, int microseconds) xSleep;
	int function(sqlite3_vfs*, double*) xCurrentTime;
	int function(sqlite3_vfs*, int, char *) xGetLastError;
	int function(sqlite3_vfs*, sqlite3_int64*) xCurrentTimeInt64;
	int function(sqlite3_vfs*, const char *zName, sqlite3_syscall_ptr) xSetSystemCall;
	sqlite3_syscall_ptr function(sqlite3_vfs*, const char *zName) xGetSystemCall;
	const char* function(sqlite3_vfs*, const char *zName) xNextSystemCall;
}

struct sqlite3_file
{
	const sqlite3_io_methods* pMethods;  /* Methods for an open file */
}

struct sqlite3_io_methods {
	int iVersion;
	int function(sqlite3_file*) xClose;
	int function(sqlite3_file*, void*, int iAmt, sqlite3_int64 iOfst) xRead;
	int function(sqlite3_file*, const void*, int iAmt, sqlite3_int64 iOfst)xWrite;
	int function(sqlite3_file*, sqlite3_int64 size) xTruncate;
	int function(sqlite3_file*, int flags) xSync;
	int function(sqlite3_file*, sqlite3_int64 *pSize) xFileSize;
	int function(sqlite3_file*, int) xLock;
	int function(sqlite3_file*, int) xUnlock;
	int function(sqlite3_file*, int *pResOut) xCheckReservedLock;
	int function(sqlite3_file*, int op, void *pArg) xFileControl;
	int function(sqlite3_file*) xSectorSize;
	int function(sqlite3_file*) xDeviceCharacteristics;
	int function(sqlite3_file*, int iPg, int pgsz, int, void**) xShmMap;
	int function(sqlite3_file*, int offset, int n, int flags) xShmLock;
	void function(sqlite3_file*) xShmBarrier;
	int function(sqlite3_file*, int deleteFlag) xShmUnmap;
}

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

	int sqlite3_step(sqlite3_stmt* pStmt);

	/* Test To See If The Library Is Threadsafe */
	int sqlite3_threadsafe();

	int sqlite3_reset(sqlite3_stmt* pStmt);

	int sqlite3_finalize(sqlite3_stmt* pStmt);

	int sqlite3_column_count(sqlite3_stmt *pStmt);

	/* Number of columns in a result set */
	int sqlite3_data_count(sqlite3_stmt* pStmt);

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

	/* SQLite Online Backup API */
	sqlite3_backup* sqlite3_backup_init(sqlite3* pDest, const char* zDestName, sqlite3* pSource, const char* zSourceName);
	int sqlite3_backup_step(sqlite3_backup* pBackup, int nPage);
	int sqlite3_backup_finish(sqlite3_backup* pBackup);
	int sqlite3_backup_remaining(sqlite3_backup* pBackup);
	int sqlite3_backup_pagecount(sqlite3_backup* pBackup);

	/* Initialize The SQLite Library */
	int sqlite3_initialize();
	int sqlite3_shutdown();
	int sqlite3_os_init();
	int sqlite3_os_end();

	/* Configuring The SQLite Library */
	int sqlite3_config(int, ...);

	/* Configure database connections */
	int sqlite3_db_config(sqlite3* pDb, int op, ...);

	struct sqlite3_mem_methods
	{
		void* function(int) xMalloc;			/* Memory allocation function */
		void function(void*) xFree;				/* Free a prior allocation */
		void* function(void*, int) xRealloc;	/* Resize an allocation */
		int function(void*) xSize;				/* Return the size of an allocation */
		int function(int) xRoundup;				/* Round up request size to allocation size */
		int function(void*) xInit;				/* Initialize the memory allocator */
		void function(void*) xShutdown;			/* Deinitialize the memory allocator */
		void* pAppData;							/* Argument to xInit() and xShutdown() */
	}

	/* Enable Or Disable Extended Result Codes */
	int sqlite3_extended_result_codes(sqlite3* pDb, int onoff);

	/* Last Insert Rowid */
	sqlite3_int64 sqlite3_last_insert_rowid(sqlite3* pDb);

	/* Count The Number Of Rows Modified */
	int sqlite3_changes(sqlite3* pDb);

	/* Total Number Of Rows Modified */
	int sqlite3_total_changes(sqlite3* pDb);

	/* Interrupt A Long-Running Query */
	void sqlite3_interrupt(sqlite3* pDb);

	/* Determine If An SQL Statement Is Complete */
	int sqlite3_complete(const char* sql);
	int sqlite3_complete16(const wchar* sql);

	/* Register A Callback To Handle SQLITE_BUSY Errors */
	int sqlite3_busy_handler(sqlite3* pDb, int function(void*, int), void*);

	/* Set A Busy Timeout */
	int sqlite3_busy_timeout(sqlite3* pDb, int ms);

	/* Convenience Routines For Running Queries */
	int sqlite3_get_table(sqlite3* pDb, const char* zSql, char*** pazResult, int* pnRow, int* pnColumn, char** pzErrmsg);
	void sqlite3_free_table(char** result);

	/* Formatted String Printing Functions */
	alias char* va_list;
	char* sqlite3_mprintf(const char*, ...);
	char* sqlite3_vmprintf(const char*, va_list);
	char* sqlite3_snprintf(int,char*, const char*, ...);
	char* sqlite3_vsnprintf(int,char*, const char*, va_list);

	/* Memory Allocation Subsystem */
	void* sqlite3_malloc(int);
	void* sqlite3_realloc(void*, int);
	void sqlite3_free(void*);

	/* Memory Allocator Statistics */
	sqlite3_int64 sqlite3_memory_used();
	sqlite3_int64 sqlite3_memory_highwater(int resetFlag);

	/* Pseudo-Random Number Generator */
	void sqlite3_randomness(int N, void* P);

	/* Compile-Time Authorization Callbacks */
	int sqlite3_set_authorizer(sqlite3* pDb, int function(void*, int, const char*, const char*, const char*, const char*) xAuth, void *pUserData);

	/* Authorizer Return Codes */
	enum
	{
		SQLITE_DENY   = 1,	/* Abort the SQL statement with an error */
		SQLITE_IGNORE = 2,	/* Don't allow access, but don't generate an error */
	}

	/* Authorizer Action Codes */
	enum
	{
		SQLITE_CREATE_INDEX        =  1, /* Index Name      Table Name      */
		SQLITE_CREATE_TABLE        =  2, /* Table Name      NULL            */
		SQLITE_CREATE_TEMP_INDEX   =  3, /* Index Name      Table Name      */
		SQLITE_CREATE_TEMP_TABLE   =  4, /* Table Name      NULL            */
		SQLITE_CREATE_TEMP_TRIGGER =  5, /* Trigger Name    Table Name      */
		SQLITE_CREATE_TEMP_VIEW    =  6, /* View Name       NULL            */
		SQLITE_CREATE_TRIGGER      =  7, /* Trigger Name    Table Name      */
		SQLITE_CREATE_VIEW         =  8, /* View Name       NULL            */
		SQLITE_DELETE              =  9, /* Table Name      NULL            */
		SQLITE_DROP_INDEX          = 10, /* Index Name      Table Name      */
		SQLITE_DROP_TABLE          = 11, /* Table Name      NULL            */
		SQLITE_DROP_TEMP_INDEX     = 12, /* Index Name      Table Name      */
		SQLITE_DROP_TEMP_TABLE     = 13, /* Table Name      NULL            */
		SQLITE_DROP_TEMP_TRIGGER   = 14, /* Trigger Name    Table Name      */
		SQLITE_DROP_TEMP_VIEW      = 15, /* View Name       NULL            */
		SQLITE_DROP_TRIGGER        = 16, /* Trigger Name    Table Name      */
		SQLITE_DROP_VIEW           = 17, /* View Name       NULL            */
		SQLITE_INSERT              = 18, /* Table Name      NULL            */
		SQLITE_PRAGMA              = 19, /* Pragma Name     1st arg or NULL */
		SQLITE_READ                = 20, /* Table Name      Column Name     */
		SQLITE_SELECT              = 21, /* NULL            NULL            */
		SQLITE_TRANSACTION         = 22, /* Operation       NULL            */
		SQLITE_UPDATE              = 23, /* Table Name      Column Name     */
		SQLITE_ATTACH              = 24, /* Filename        NULL            */
		SQLITE_DETACH              = 25, /* Database Name   NULL            */
		SQLITE_ALTER_TABLE         = 26, /* Database Name   Table Name      */
		SQLITE_REINDEX             = 27, /* Index Name      NULL            */
		SQLITE_ANALYZE             = 28, /* Table Name      NULL            */
		SQLITE_CREATE_VTABLE       = 29, /* Table Name      Module Name     */
		SQLITE_DROP_VTABLE         = 30, /* Table Name      Module Name     */
		SQLITE_FUNCTION            = 31, /* NULL            Function Name   */
		SQLITE_SAVEPOINT           = 32, /* Operation       Savepoint Name  */
		SQLITE_COPY                =  0, /* No longer used */
	}

	/* Tracing And Profiling Functions */
	void* sqlite3_trace(sqlite3* pDb, void function(void*, const char*) xTrace, void*);
	void* sqlite3_profile(sqlite3* pDb, void function(void*, const char*, sqlite3_uint64) xProfile, void*);

	/* Query Progress Callbacks */
	void sqlite3_progress_handler(sqlite3* pDb, int, int function(void*), void*);

	/* Opening A New Database Connection */
	int sqlite3_open(const char* filename, sqlite3** ppDb);
	int sqlite3_open16(const wchar* filename, sqlite3** ppDb);
	int sqlite3_open_v2(const char* filename, sqlite3** ppDb, int flags, const char* zVfs);

	/* Obtain Values For URI Parameters */
	char* sqlite3_uri_parameter(const char* zFilename, const char* zParam);
	int sqlite3_uri_boolean(const char* zFile, const char* zParam, int bDefault);
	sqlite3_int64 sqlite3_uri_int64(const char*, const char*, sqlite3_int64);

	/* Error Codes And Messages */
	int sqlite3_errcode(sqlite3* pDb);
	int sqlite3_extended_errcode(sqlite3* pDb);
	char* sqlite3_errmsg(sqlite3* pDb);
	wchar* sqlite3_errmsg16(sqlite3* pDb);

	/* SQL Statement Object */
	struct sqlite3_stmt;

	/* Run-time Limits */
	int sqlite3_limit(sqlite3* pDb, const int id, const int newVal);

	/* Run-Time Limit Categories */
	enum
	{
		SQLITE_LIMIT_LENGTH              =  0,
		SQLITE_LIMIT_SQL_LENGTH          =  1,
		SQLITE_LIMIT_COLUMN              =  2,
		SQLITE_LIMIT_EXPR_DEPTH          =  3,
		SQLITE_LIMIT_COMPOUND_SELECT     =  4,
		SQLITE_LIMIT_VDBE_OP             =  5,
		SQLITE_LIMIT_FUNCTION_ARG        =  6,
		SQLITE_LIMIT_ATTACHED            =  7,
		SQLITE_LIMIT_LIKE_PATTERN_LENGTH =  8,
		SQLITE_LIMIT_VARIABLE_NUMBER     =  9,
		SQLITE_LIMIT_TRIGGER_DEPTH       = 10,
	}

	/* Compiling An SQL Statement */
	int sqlite3_prepare(sqlite3* pDb, const char* zSql, int nByte, sqlite3_stmt** ppStmt, const char** pzTail);
	int sqlite3_prepare_v2(sqlite3* pDb, const char* zSql, int nByte, sqlite3_stmt** ppStmt, const char** pzTail);
	int sqlite3_prepare16(sqlite3* pDb, const char* zSql, int nByte, sqlite3_stmt** ppStmt, const wchar** pzTail);
	int sqlite3_prepare16_v2(sqlite3* pDb, const char* zSql, int nByte, sqlite3_stmt** ppStmt, const wchar** pzTail);

	/* Retrieving Statement SQL */
	char* sqlite3_sql(sqlite3_stmt* pStmt);

	/* Determine If An SQL Statement Writes The Database */
	int sqlite3_stmt_readonly(sqlite3_stmt* pStmt);
	
	/* Determine If A Prepared Statement Has Been Reset */
	int sqlite3_stmt_busy(sqlite3_stmt* pStmt);

	/* Dynamically Typed Value Object */
	struct sqlite3_value;

	/* SQL Function Context Object */
	struct sqlite3_context;

	/* Binding Values To Prepared Statements */
	int sqlite3_bind_blob(sqlite3_stmt* pStmt, int, const void*, int n, void function(void*));
	int sqlite3_bind_double(sqlite3_stmt* pStmt, int, double);
	int sqlite3_bind_int(sqlite3_stmt* pStmt, int, int);
	int sqlite3_bind_int64(sqlite3_stmt* pStmt, int, sqlite3_int64);
	int sqlite3_bind_null(sqlite3_stmt* pStmt, int);
	int sqlite3_bind_text(sqlite3_stmt* pStmt, int, const char*, int n, void function(void*));
	int sqlite3_bind_text16(sqlite3_stmt* pStmt, int, const void*, int, void function(void*));
	int sqlite3_bind_value(sqlite3_stmt* pStmt, int, const sqlite3_value*);
	int sqlite3_bind_zeroblob(sqlite3_stmt* pStmt, int, int n);

	/* Number Of SQL Parameters */
	int sqlite3_bind_parameter_count(sqlite3_stmt* pStmt);

	/* Prepared Statement Status */
	int sqlite3_stmt_status(sqlite3_stmt* pStmt, int op, int resetFlg);

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

	/* Error Logging Interface */
	void sqlite3_log(int iErrCode, const char* zFormat, ...);
}

@property string sqlite3_version()
{
	return sqlite3_libversion().to!string();
}
