module sqlite3;

import std.conv;

extern(C)
{
	// Run-Time Library Version Numbers
	@property string sqlite3_version()
	{
		return sqlite3_libversion().to!string();
	}
	char* sqlite3_libversion();
	char* sqlite3_sourceid();
	int sqlite3_libversion_number();

	// Run-Time Library Compilation Options Diagnostics
	int sqlite3_compileoption_used(const char* zOptName);
	char* sqlite3_compileoption_get(int N);

	// Test To See If The Library Is Threadsafe
	int sqlite3_threadsafe();

	// Database Connection Handle
	struct sqlite3;

	// 64-Bit Integer Types
	alias long sqlite_int64, sqlite3_int64;
	alias ulong sqlite_uint64, sqlite3_uint64;

	// Closing A Database Connection
	int sqlite3_close(sqlite3* pDb);

	// The type for a callback function
	alias int function(void* notused, int argc, char** argv, char** zColName) sqlite3_callback;

	// One-Step Query Execution Interface
	int sqlite3_exec(sqlite3* pDb, const char* sql, int function(void*, int, char**, char**) callback, void* arg, char** errmsg);

	// Result Codes
	enum
	{
		SQLITE_OK         =  0 , /* Successful result */
		/* beginning-of-error-codes */
		SQLITE_ERROR      =  1 , /* SQL error or missing database */
		SQLITE_INTERNAL   =  2 , /* Internal logic error in SQLite */
		SQLITE_PERM       =  3 , /* Access permission denied */
		SQLITE_ABORT      =  4 , /* Callback routine requested an abort */
		SQLITE_BUSY       =  5 , /* The database file is locked */
		SQLITE_LOCKED     =  6 , /* A table in the database is locked */
		SQLITE_NOMEM      =  7 , /* A malloc() failed */
		SQLITE_READONLY   =  8 , /* Attempt to write a readonly database */
		SQLITE_INTERRUPT  =  9 , /* Operation terminated by sqlite3_interrupt()*/
		SQLITE_IOERR      = 10 , /* Some kind of disk I/O error occurred */
		SQLITE_CORRUPT    = 11 , /* The database disk image is malformed */
		SQLITE_NOTFOUND   = 12 , /* Unknown opcode in sqlite3_file_control() */
		SQLITE_FULL       = 13 , /* Insertion failed because database is full */
		SQLITE_CANTOPEN   = 14 , /* Unable to open the database file */
		SQLITE_PROTOCOL   = 15 , /* Database lock protocol error */
		SQLITE_EMPTY      = 16 , /* Database is empty */
		SQLITE_SCHEMA     = 17 , /* The database schema changed */
		SQLITE_TOOBIG     = 18 , /* String or BLOB exceeds size limit */
		SQLITE_CONSTRAINT = 19 , /* Abort due to constraint violation */
		SQLITE_MISMATCH   = 20 , /* Data type mismatch */
		SQLITE_MISUSE     = 21 , /* Library used incorrectly */
		SQLITE_NOLFS      = 22 , /* Uses OS features not supported on host */
		SQLITE_AUTH       = 23 , /* Authorization denied */
		SQLITE_FORMAT     = 24 , /* Auxiliary database format error */
		SQLITE_RANGE      = 25 , /* 2nd parameter to sqlite3_bind out of range */
		SQLITE_NOTADB     = 26 , /* File opened that is not a database file */
		SQLITE_ROW        = 100, /* sqlite3_step() has another row ready */
		SQLITE_DONE       = 101, /* sqlite3_step() has finished executing */
		/* end-of-error-codes */
	}

	// Extended Result Codes
	enum
	{
		SQLITE_IOERR_READ              = (SQLITE_IOERR | (1<<8))   ,
		SQLITE_IOERR_SHORT_READ        = (SQLITE_IOERR | (2<<8))   ,
		SQLITE_IOERR_WRITE             = (SQLITE_IOERR | (3<<8))   ,
		SQLITE_IOERR_FSYNC             = (SQLITE_IOERR | (4<<8))   ,
		SQLITE_IOERR_DIR_FSYNC         = (SQLITE_IOERR | (5<<8))   ,
		SQLITE_IOERR_TRUNCATE          = (SQLITE_IOERR | (6<<8))   ,
		SQLITE_IOERR_FSTAT             = (SQLITE_IOERR | (7<<8))   ,
		SQLITE_IOERR_UNLOCK            = (SQLITE_IOERR | (8<<8))   ,
		SQLITE_IOERR_RDLOCK            = (SQLITE_IOERR | (9<<8))   ,
		SQLITE_IOERR_DELETE            = (SQLITE_IOERR | (10<<8))  ,
		SQLITE_IOERR_BLOCKED           = (SQLITE_IOERR | (11<<8))  ,
		SQLITE_IOERR_NOMEM             = (SQLITE_IOERR | (12<<8))  ,
		SQLITE_IOERR_ACCESS            = (SQLITE_IOERR | (13<<8))  ,
		SQLITE_IOERR_CHECKRESERVEDLOCK = (SQLITE_IOERR | (14<<8))  ,
		SQLITE_IOERR_LOCK              = (SQLITE_IOERR | (15<<8))  ,
		SQLITE_IOERR_CLOSE             = (SQLITE_IOERR | (16<<8))  ,
		SQLITE_IOERR_DIR_CLOSE         = (SQLITE_IOERR | (17<<8))  ,
		SQLITE_IOERR_SHMOPEN           = (SQLITE_IOERR | (18<<8))  ,
		SQLITE_IOERR_SHMSIZE           = (SQLITE_IOERR | (19<<8))  ,
		SQLITE_IOERR_SHMLOCK           = (SQLITE_IOERR | (20<<8))  ,
		SQLITE_IOERR_SHMMAP            = (SQLITE_IOERR | (21<<8))  ,
		SQLITE_IOERR_SEEK              = (SQLITE_IOERR | (22<<8))  ,
		SQLITE_LOCKED_SHAREDCACHE      = (SQLITE_LOCKED |  (1<<8)) ,
		SQLITE_BUSY_RECOVERY           = (SQLITE_BUSY   |  (1<<8)) ,
		SQLITE_CANTOPEN_NOTEMPDIR      = (SQLITE_CANTOPEN | (1<<8)),
		SQLITE_CANTOPEN_ISDIR          = (SQLITE_CANTOPEN | (2<<8)),
		SQLITE_CORRUPT_VTAB            = (SQLITE_CORRUPT | (1<<8)) ,
		SQLITE_READONLY_RECOVERY       = (SQLITE_READONLY | (1<<8)),
		SQLITE_READONLY_CANTLOCK       = (SQLITE_READONLY | (2<<8)),
		SQLITE_ABORT_ROLLBACK          = (SQLITE_ABORT | (2<<8))   ,
	}

	// Flags For File Open Operations
	enum
	{
		SQLITE_OPEN_READONLY       = 0x00000001, /* Ok for sqlite3_open_v2() */
		SQLITE_OPEN_READWRITE      = 0x00000002, /* Ok for sqlite3_open_v2() */
		SQLITE_OPEN_CREATE         = 0x00000004, /* Ok for sqlite3_open_v2() */
		SQLITE_OPEN_DELETEONCLOSE  = 0x00000008, /* VFS only */
		SQLITE_OPEN_EXCLUSIVE      = 0x00000010, /* VFS only */
		SQLITE_OPEN_AUTOPROXY      = 0x00000020, /* VFS only */
		SQLITE_OPEN_URI            = 0x00000040, /* Ok for sqlite3_open_v2() */
		SQLITE_OPEN_MEMORY         = 0x00000080, /* Ok for sqlite3_open_v2() */
		SQLITE_OPEN_MAIN_DB        = 0x00000100, /* VFS only */
		SQLITE_OPEN_TEMP_DB        = 0x00000200, /* VFS only */
		SQLITE_OPEN_TRANSIENT_DB   = 0x00000400, /* VFS only */
		SQLITE_OPEN_MAIN_JOURNAL   = 0x00000800, /* VFS only */
		SQLITE_OPEN_TEMP_JOURNAL   = 0x00001000, /* VFS only */
		SQLITE_OPEN_SUBJOURNAL     = 0x00002000, /* VFS only */
		SQLITE_OPEN_MASTER_JOURNAL = 0x00004000, /* VFS only */
		SQLITE_OPEN_NOMUTEX        = 0x00008000, /* Ok for sqlite3_open_v2() */
		SQLITE_OPEN_FULLMUTEX      = 0x00010000, /* Ok for sqlite3_open_v2() */
		SQLITE_OPEN_SHAREDCACHE    = 0x00020000, /* Ok for sqlite3_open_v2() */
		SQLITE_OPEN_PRIVATECACHE   = 0x00040000, /* Ok for sqlite3_open_v2() */
		SQLITE_OPEN_WAL            = 0x00080000, /* VFS only */
		/* Reserved:               = 0x00F00000, */
	}

	// Device Characteristics
	enum
	{
		SQLITE_IOCAP_ATOMIC                = 0x00000001,
		SQLITE_IOCAP_ATOMIC512             = 0x00000002,
		SQLITE_IOCAP_ATOMIC1K              = 0x00000004,
		SQLITE_IOCAP_ATOMIC2K              = 0x00000008,
		SQLITE_IOCAP_ATOMIC4K              = 0x00000010,
		SQLITE_IOCAP_ATOMIC8K              = 0x00000020,
		SQLITE_IOCAP_ATOMIC16K             = 0x00000040,
		SQLITE_IOCAP_ATOMIC32K             = 0x00000080,
		SQLITE_IOCAP_ATOMIC64K             = 0x00000100,
		SQLITE_IOCAP_SAFE_APPEND           = 0x00000200,
		SQLITE_IOCAP_SEQUENTIAL            = 0x00000400,
		SQLITE_IOCAP_UNDELETABLE_WHEN_OPEN = 0x00000800,
		SQLITE_IOCAP_POWERSAFE_OVERWRITE   = 0x00001000,
	}

	// File Locking Levels
	enum
	{
		SQLITE_LOCK_NONE      = 0,
		SQLITE_LOCK_SHARED    = 1,
		SQLITE_LOCK_RESERVED  = 2,
		SQLITE_LOCK_PENDING   = 3,
		SQLITE_LOCK_EXCLUSIVE = 4,
	}

	// Synchronization Type Flags
	enum
	{
		SQLITE_SYNC_NORMAL   = 0x00002,
		SQLITE_SYNC_FULL     = 0x00003,
		SQLITE_SYNC_DATAONLY = 0x00010,
	}

	// OS Interface Open File Handle
	struct sqlite3_file
	{
		const sqlite3_io_methods* pMethods;  /* Methods for an open file */
	}

	// OS Interface Open File Handle
	struct sqlite3_io_methods
	{
		int iVersion;
		int function(sqlite3_file* pDb) xClose;
		int function(sqlite3_file* pDb, void*, int iAmt, sqlite3_int64 iOfst) xRead;
		int function(sqlite3_file* pDb, const void*, int iAmt, sqlite3_int64 iOfst)xWrite;
		int function(sqlite3_file* pDb, sqlite3_int64 size) xTruncate;
		int function(sqlite3_file* pDb, int flags) xSync;
		int function(sqlite3_file* pDb, sqlite3_int64 *pSize) xFileSize;
		int function(sqlite3_file* pDb, int) xLock;
		int function(sqlite3_file* pDb, int) xUnlock;
		int function(sqlite3_file* pDb, int* pResOut) xCheckReservedLock;
		int function(sqlite3_file* pDb, int op, void* pArg) xFileControl;
		int function(sqlite3_file* pDb) xSectorSize;
		int function(sqlite3_file* pDb) xDeviceCharacteristics;
		/* Methods above are valid for version 1 */
		int function(sqlite3_file* pDb, int iPg, int pgsz, int, void**) xShmMap;
		int function(sqlite3_file* pDb, int offset, int n, int flags) xShmLock;
		void function(sqlite3_file* pDb) xShmBarrier;
		int function(sqlite3_file* pDb, int deleteFlag) xShmUnmap;
		/* Methods above are valid for version 2 */
		/* Additional methods may be added in future releases */
	}

	// Standard File Control Opcodes
	enum
	{
		SQLITE_FCNTL_LOCKSTATE           =  1,
		SQLITE_GET_LOCKPROXYFILE         =  2,
		SQLITE_SET_LOCKPROXYFILE         =  3,
		SQLITE_LAST_ERRNO                =  4,
		SQLITE_FCNTL_SIZE_HINT           =  5,
		SQLITE_FCNTL_CHUNK_SIZE          =  6,
		SQLITE_FCNTL_FILE_POINTER        =  7,
		SQLITE_FCNTL_SYNC_OMITTED        =  8,
		SQLITE_FCNTL_WIN32_AV_RETRY      =  9,
		SQLITE_FCNTL_PERSIST_WAL         = 10,
		SQLITE_FCNTL_OVERWRITE           = 11,
		SQLITE_FCNTL_VFSNAME             = 12,
		SQLITE_FCNTL_POWERSAFE_OVERWRITE = 13,
		SQLITE_FCNTL_PRAGMA              = 14,		
	}

	// Mutex Handle
	struct sqlite3_mutex;

	// OS Interface Object
	alias void function() sqlite3_syscall_ptr;
	struct sqlite3_vfs
	{
		int iVersion;            /* Structure version number (currently 3) */
		int szOsFile;            /* Size of subclassed sqlite3_file */
		int mxPathname;          /* Maximum file pathname length */
		sqlite3_vfs* pNext;      /* Next registered VFS */
		const char* zName;       /* Name of this virtual file system */
		void* pAppData;          /* Pointer to application-specific data */
		int function(sqlite3_vfs*, const char* zName, sqlite3_file*, int flags, int* pOutFlags) xOpen;
		int function(sqlite3_vfs*, const char* zName, int syncDir) xDelete;
		int function(sqlite3_vfs*, const char* zName, int flags, int* pResOut) xAccess;
		int function(sqlite3_vfs*, const char* zName, int nOut, char* zOut) xFullPathname;
		void* function(sqlite3_vfs*, const char* zFilename) xDlOpen;
		void function(sqlite3_vfs*, int nByte, char* zErrMsg) xDlError;
		void function(sqlite3_vfs*, void*, const char* zSymbol) xDlSym;
		void function(sqlite3_vfs*, void*) xDlClose;
		int function(sqlite3_vfs*, int nByte, char* zOut) xRandomness;
		int function(sqlite3_vfs*, int microseconds) xSleep;
		int function(sqlite3_vfs*, double*) xCurrentTime;
		int function(sqlite3_vfs*, int, char*) xGetLastError;
		int function(sqlite3_vfs*, sqlite3_int64*) xCurrentTimeInt64;
		int function(sqlite3_vfs*, const char* zName, sqlite3_syscall_ptr) xSetSystemCall;
		sqlite3_syscall_ptr function(sqlite3_vfs*, const char *zName) xGetSystemCall;
		const char* function(sqlite3_vfs*, const char *zName) xNextSystemCall;
	}

	// Flags for the xAccess VFS method
	enum
	{
		SQLITE_ACCESS_EXISTS    = 0,
		SQLITE_ACCESS_READWRITE = 1,   /* Used by PRAGMA temp_store_directory */
		SQLITE_ACCESS_READ      = 2,   /* Unused */
	}

	// Flags for the xShmLock VFS method
	enum
	{
		SQLITE_SHM_UNLOCK    = 1,
		SQLITE_SHM_LOCK      = 2,
		SQLITE_SHM_SHARED    = 4,
		SQLITE_SHM_EXCLUSIVE = 8,
	}

	// Maximum xShmLock index
	enum
	{
		SQLITE_SHM_NLOCK = 8,
	}

	// Initialize The SQLite Library
	int sqlite3_initialize();
	int sqlite3_shutdown();
	int sqlite3_os_init();
	int sqlite3_os_end();



	/* Free Memory Used By A Database Connection */
	int sqlite3_db_release_memory(sqlite3* pDb);

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

	// Configuration Options
	enum
	{
		SQLITE_CONFIG_SINGLETHREAD =  1, /* nil */
		SQLITE_CONFIG_MULTITHREAD  =  2, /* nil */
		SQLITE_CONFIG_SERIALIZED   =  3, /* nil */
		SQLITE_CONFIG_MALLOC       =  4, /* sqlite3_mem_methods* */
		SQLITE_CONFIG_GETMALLOC    =  5, /* sqlite3_mem_methods* */
		SQLITE_CONFIG_SCRATCH      =  6, /* void*, int sz, int N */
		SQLITE_CONFIG_PAGECACHE    =  7, /* void*, int sz, int N */
		SQLITE_CONFIG_HEAP         =  8, /* void*, int nByte, int min */
		SQLITE_CONFIG_MEMSTATUS    =  9, /* boolean */
		SQLITE_CONFIG_MUTEX        = 10, /* sqlite3_mutex_methods* */
		SQLITE_CONFIG_GETMUTEX     = 11, /* sqlite3_mutex_methods* */
		/* previously SQLITE_CONFIG_CHUNKALLOC 12 which is now unused. */ 
		SQLITE_CONFIG_LOOKASIDE  = 13, /* int int */
		SQLITE_CONFIG_PCACHE     = 14, /* no-op */
		SQLITE_CONFIG_GETPCACHE  = 15, /* no-op */
		SQLITE_CONFIG_LOG        = 16, /* xFunc, void* */
		SQLITE_CONFIG_URI        = 17, /* int */
		SQLITE_CONFIG_PCACHE2    = 18, /* sqlite3_pcache_methods2* */
		SQLITE_CONFIG_GETPCACHE2 = 19, /* sqlite3_pcache_methods2* */
	}

	// Database Connection Configuration Options
	enum
	{
		SQLITE_DBCONFIG_LOOKASIDE      = 1001,  /* void* int int */
		SQLITE_DBCONFIG_ENABLE_FKEY    = 1002,  /* int int* */
		SQLITE_DBCONFIG_ENABLE_TRIGGER = 1003,  /* int int* */
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
	int sqlite3_bind_text16(sqlite3_stmt* pStmt, int, const wchar*, int, void function(void*));
	int sqlite3_bind_value(sqlite3_stmt* pStmt, int, const sqlite3_value*);
	int sqlite3_bind_zeroblob(sqlite3_stmt* pStmt, int, int n);

	/* Number Of SQL Parameters */
	int sqlite3_bind_parameter_count(sqlite3_stmt* pStmt);

	// Name Of A Host Parameter
	char* sqlite3_bind_parameter_name(sqlite3_stmt* pStmt, int);

	// Index Of A Parameter With A Given Name
	int sqlite3_bind_parameter_index(sqlite3_stmt* pStmt, const char* zName);

	// Reset All Bindings On A Prepared Statement
	int sqlite3_clear_bindings(sqlite3_stmt* pStmt);

	// Number Of Columns In A Result Set
	int sqlite3_column_count(sqlite3_stmt* pStmt);

	/* Column Names In A Result Set */
	char* sqlite3_column_name(sqlite3_stmt* pStmt, int iCol);
	wchar* sqlite3_column_name16(sqlite3_stmt* pStmt, int iCol);

	// Source Of Data In A Query Result
	char* sqlite3_column_database_name(sqlite3_stmt* pStmt, int iCol);
	wchar* sqlite3_column_database_name16(sqlite3_stmt* pStmt, int iCol);
	char* sqlite3_column_table_name(sqlite3_stmt* pStmt, int iCol);
	wchar* sqlite3_column_table_name16(sqlite3_stmt* pStmt, int iCol);
	char* sqlite3_column_origin_name(sqlite3_stmt* pStmt, int iCol);
	wchar* sqlite3_column_origin_name16(sqlite3_stmt* pStmt, int iCol);

	/* Declared Datatype Of A Query Result */
	char* sqlite3_column_decltype(sqlite3_stmt* pStmt,int iCol);
	wchar* sqlite3_column_decltype16(sqlite3_stmt* pStmt,int iCol);

	// Evaluate An SQL Statement
	int sqlite3_step(sqlite3_stmt* pStmt);

	/* Number of columns in a result set */
	int sqlite3_data_count(sqlite3_stmt* pStmt);

	// Fundamental Datatypes
	enum
	{
		SQLITE_INTEGER = 1,
		SQLITE_FLOAT   = 2,
		SQLITE_BLOB    = 4,
		SQLITE_NULL    = 5,
		SQLITE_TEXT    = 3,
		SQLITE3_TEXT   = 3,
	}

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

	// Destroy A Prepared Statement Object
	int sqlite3_finalize(sqlite3_stmt* pStmt);

	// Reset A Prepared Statement Object
	int sqlite3_reset(sqlite3_stmt* pStmt);

	// Create Or Redefine SQL Functions
	int sqlite3_create_function(sqlite3* pDb, const char* zFunctionName, int nArg, int eTextRep, void* pApp, void function(sqlite3_context*, int, sqlite3_value**) xFunc, void function(sqlite3_context*, int, sqlite3_value**) xStep, void function(sqlite3_context*) xFinal);
	int sqlite3_create_function16(sqlite3* pDb, const wchar* zFunctionName, int nArg, int eTextRep, void* pApp, void function(sqlite3_context*, int, sqlite3_value**) xFunc, void function(sqlite3_context*, int, sqlite3_value**) xStep, void function(sqlite3_context*) xFinal);
	int sqlite3_create_function_v2(sqlite3 *pDb, const char* zFunctionName, int nArg, int eTextRep, void* pApp, void function(sqlite3_context*, int, sqlite3_value**) xFunc, void function(sqlite3_context*, int, sqlite3_value**) xStep, void function(sqlite3_context*) xFinal, void function(void*) xDestroy);

	// Text Encodings
	enum
	{
		SQLITE_UTF8          = 1,
		SQLITE_UTF16LE       = 2,
		SQLITE_UTF16BE       = 3,
		SQLITE_UTF16         = 4,    /* Use native byte order */
		SQLITE_ANY           = 5,    /* sqlite3_create_function only */
		SQLITE_UTF16_ALIGNED = 8,    /* sqlite3_create_collation only */
	}

	// Deprecated Functions
	deprecated
	{
		int sqlite3_aggregate_count(sqlite3_context*);
		int sqlite3_expired(sqlite3_stmt*);
		int sqlite3_transfer_bindings(sqlite3_stmt*, sqlite3_stmt*);
		int sqlite3_global_recover();
		void sqlite3_thread_cleanup();
		int sqlite3_memory_alarm(void function(void*,sqlite3_int64,int), void*, sqlite3_int64);
	}

	// Obtaining SQL Function Parameter Values
	void* sqlite3_value_blob(sqlite3_value* pValue);
	int sqlite3_value_bytes(sqlite3_value* pValue);
	int sqlite3_value_bytes16(sqlite3_value* pValue);
	double sqlite3_value_double(sqlite3_value* pValue);
	int sqlite3_value_int(sqlite3_value* pValue);
	sqlite3_int64 sqlite3_value_int64(sqlite3_value* pValue);
	char* sqlite3_value_text(sqlite3_value* pValue);
	wchar* sqlite3_value_text16(sqlite3_value* pValue);
	void* sqlite3_value_text16le(sqlite3_value* pValue);
	void* sqlite3_value_text16be(sqlite3_value* pValue);
	int sqlite3_value_type(sqlite3_value* pValue);
	int sqlite3_value_numeric_type(sqlite3_value* pValue);

	// Obtain Aggregate Function Context
	void* sqlite3_aggregate_context(sqlite3_context* pContext, int nBytes);

	/* User Data For Functions */
	void* sqlite3_user_data(sqlite3_context* pContext);

	// Database Connection For Functions
	sqlite3* sqlite3_context_db_handle(sqlite3_context* pContext);

	// Function Auxiliary Data
	void* sqlite3_get_auxdata(sqlite3_context* pContext, int N);
	void sqlite3_set_auxdata(sqlite3_context* pContext, int N, void*, void function(void*));

	// Constants Defining Special Destructor Behavior
	/*
	typedef void (*sqlite3_destructor_type)(void*);
	#define SQLITE_STATIC      ((sqlite3_destructor_type)0)
	#define SQLITE_TRANSIENT   ((sqlite3_destructor_type)-1)
	*/

	// Setting The Result Of An SQL Function
	void sqlite3_result_blob(sqlite3_context*, const void*, int, void function(void*));
	void sqlite3_result_double(sqlite3_context*, double);
	void sqlite3_result_error(sqlite3_context*, const char*, int);
	void sqlite3_result_error16(sqlite3_context*, const void*, int);
	void sqlite3_result_error_toobig(sqlite3_context*);
	void sqlite3_result_error_nomem(sqlite3_context*);
	void sqlite3_result_error_code(sqlite3_context*, int);
	void sqlite3_result_int(sqlite3_context*, int);
	void sqlite3_result_int64(sqlite3_context*, sqlite3_int64);
	void sqlite3_result_null(sqlite3_context*);
	void sqlite3_result_text(sqlite3_context*, const char*, int, void function(void*));
	void sqlite3_result_text16(sqlite3_context*, const wchar*, int, void function(void*));
	void sqlite3_result_text16le(sqlite3_context*, const void*, int,void function(void*));
	void sqlite3_result_text16be(sqlite3_context*, const void*, int,void function(void*));
	void sqlite3_result_value(sqlite3_context*, sqlite3_value*);
	void sqlite3_result_zeroblob(sqlite3_context*, int n);

	// Define New Collating Sequences
	int sqlite3_create_collation(sqlite3* pDb, const char* zName, int eTextRep, void* pArg, int function(void*, int, const void*, int, const void*) xCompare);
	int sqlite3_create_collation_v2(sqlite3* pDb, const char* zName, int eTextRep, void* pArg, int function(void*, int, const void*, int, const void*) xCompare, void function(void*) xDestroy);
	int sqlite3_create_collation16(sqlite3* pDb, const void* zName, int eTextRep, void* pArg, int function(void*, int, const void*, int, const void*) xCompare);

	// Collation Needed Callbacks
	int sqlite3_collation_needed(sqlite3* pDb, void*, void function(void*, sqlite3*, int eTextRep, const char*));
	int sqlite3_collation_needed16(sqlite3* pDb, void*, void function(void*, sqlite3*, int eTextRep, const wchar*));

	// Specify the key for an encrypted database
	int sqlite3_key(sqlite3 *pDb, const void* pKey, int nKey);

	// Change the key on an open database
	int sqlite3_rekey(sqlite3* pDb, const void* pKey, int nKey);

	// Specify the activation key for a SEE database.  Unless activated, none of the SEE routines will work.
	void sqlite3_activate_see(const char* zPassPhrase);

	// Specify the activation key for a CEROD database
	void sqlite3_activate_cerod(const char* zPassPhrase);

	// Suspend Execution For A Short Time
	int sqlite3_sleep(int nMilliseconds);

	// Name Of The Folder Holding Temporary Files
	// SQLITE_API SQLITE_EXTERN char *sqlite3_temp_directory;
	// Name Of The Folder Holding Database Files
	// SQLITE_API SQLITE_EXTERN char *sqlite3_data_directory;

	// Test For Auto-Commit Mode
	int sqlite3_get_autocommit(sqlite3* pDb);

	// Find The Database Handle Of A Prepared Statement
	sqlite3* sqlite3_db_handle(sqlite3_stmt* pStmt);

	// Return The Filename For A Database Connection
	char* sqlite3_db_filename(sqlite3* pDb, const char* zDbName);

	// Determine if a database is read-only
	int sqlite3_db_readonly(sqlite3 *pDb, const char *zDbName);

	// Find the next prepared statement
	sqlite3_stmt* sqlite3_next_stmt(sqlite3* pDb, sqlite3_stmt* pStmt);

	// Commit And Rollback Notification Callbacks
	void* sqlite3_commit_hook(sqlite3*, int function(void*), void*);
	void* sqlite3_rollback_hook(sqlite3*, void function(void *), void*);

	// Data Change Notification Callbacks
	void *sqlite3_update_hook(sqlite3*, void function(void*, int, const char*, const char*, sqlite3_int64), void*);

	// Enable Or Disable Shared Pager Cache
	int sqlite3_enable_shared_cache(int);

	// Attempt To Free Heap Memory
	int sqlite3_release_memory(int);

	// Free Memory Used By A Database Connection
	int sqlite3_db_release_memory(sqlite3* pDb);

	// Impose A Limit On Heap Size
	sqlite3_int64 sqlite3_soft_heap_limit64(sqlite3_int64 N);

	// Deprecated Soft Heap Limit Interface
	deprecated void sqlite3_soft_heap_limit(int N);

	// Extract Metadata About A Column Of A Table
	int sqlite3_table_column_metadata(sqlite3 *pDb, const char* zDbName, const char* zTableName, const char* zColumnName, const char** pzDataType, const char** pzCollSeq, int* pNotNull, int* pPrimaryKey, int* pAutoinc);

	// Load An Extension
	int sqlite3_load_extension(sqlite3 *pDb, const char* zFile, const char* zProc, char** pzErrMsg);

	// Enable Or Disable Extension Loading
	int sqlite3_enable_load_extension(sqlite3* pDb, int onoff);

	// Automatically Load Statically Linked Extensions
	int sqlite3_auto_extension(void function() xEntryPoint);

	// Reset Automatic Extension Loading
	void sqlite3_reset_auto_extension();

	// Virtual Table Object
	struct sqlite3_module
	{
		int iVersion;
		int function(sqlite3*, void *pAux, int argc, const char** argv, sqlite3_vtab **ppVTab, char**) xCreate;
		int function(sqlite3*, void *pAux, int argc, const char** argv, sqlite3_vtab **ppVTab, char**) xConnect;
		int function(sqlite3_vtab* pVTab, sqlite3_index_info*) xBestIndex;
		int function(sqlite3_vtab* pVTab) xDisconnect;
		int function(sqlite3_vtab* pVTab) xDestroy;
		int function(sqlite3_vtab* pVTab, sqlite3_vtab_cursor** ppCursor) xOpen;
		int function(sqlite3_vtab_cursor*) xClose;
		int function(sqlite3_vtab_cursor*, int idxNum, const char* idxStr, int argc, sqlite3_value** argv) xFilter;
		int function(sqlite3_vtab_cursor*) xNext;
		int function(sqlite3_vtab_cursor*) xEof;
		int function(sqlite3_vtab_cursor*, sqlite3_context*, int) xColumn;
		int function(sqlite3_vtab_cursor*, sqlite3_int64* pRowid) xRowid;
		int function(sqlite3_vtab*, int, sqlite3_value**, sqlite3_int64*) xUpdate;
		int function(sqlite3_vtab* pVTab) xBegin;
		int function(sqlite3_vtab* pVTab) xSync;
		int function(sqlite3_vtab* pVTab) xCommit;
		int function(sqlite3_vtab* pVTab) xRollback;
		int function(sqlite3_vtab* pVtab, int nArg, const char* zName, void function(sqlite3_context*,int,sqlite3_value**)* pxFunc, void **ppArg) xFindFunction;
		int function(sqlite3_vtab* pVtab, const char* zNew) xRename;
		// The methods above are in version 1 of the sqlite_module object. Those below are for version 2 and greater.
		int function(sqlite3_vtab* pVTab, int) xSavepoint;
		int function(sqlite3_vtab* pVTab, int) xRelease;
		int function(sqlite3_vtab* pVTab, int) xRollbackTo;
	}

	// Virtual Table Indexing Information
	struct sqlite3_index_info
	{
/+
		/* Inputs */
		int nConstraint;           /* Number of entries in aConstraint */
		struct sqlite3_index_constraint {
			int iColumn;              /* Column on left-hand side of constraint */
			unsigned char op;         /* Constraint operator */
			unsigned char usable;     /* True if this constraint is usable */
			int iTermOffset;          /* Used internally - xBestIndex should ignore */
		} *aConstraint;            /* Table of WHERE clause constraints */
		int nOrderBy;              /* Number of terms in the ORDER BY clause */
		struct sqlite3_index_orderby {
			int iColumn;              /* Column number */
			unsigned char desc;       /* True for DESC.  False for ASC. */
		} *aOrderBy;               /* The ORDER BY clause */
		/* Outputs */
		struct sqlite3_index_constraint_usage {
			int argvIndex;           /* if >0, constraint is part of argv to xFilter */
			unsigned char omit;      /* Do not code a test for this constraint */
		} *aConstraintUsage;
		int idxNum;                /* Number used to identify the index */
		char *idxStr;              /* String, possibly obtained from sqlite3_malloc */
		int needToFreeIdxStr;      /* Free idxStr using sqlite3_free() if true */
		int orderByConsumed;       /* True if output is already ordered */
		double estimatedCost;      /* Estimated cost of using this index */
+/
	}

	// Virtual Table Constraint Operator Codes
	enum
	{
		SQLITE_INDEX_CONSTRAINT_EQ    = 2 ,
		SQLITE_INDEX_CONSTRAINT_GT    = 4 ,
		SQLITE_INDEX_CONSTRAINT_LE    = 8 ,
		SQLITE_INDEX_CONSTRAINT_LT    = 16,
		SQLITE_INDEX_CONSTRAINT_GE    = 32,
		SQLITE_INDEX_CONSTRAINT_MATCH = 64,
	}

	// Register A Virtual Table Implementation
	int sqlite3_create_module(sqlite3* pDb, const char* zName, const sqlite3_module *p, void *pClientData);
	int sqlite3_create_module_v2(sqlite3* pDb, const char* zName, const sqlite3_module* p, void* pClientData, void function(void*) xDestroy);
	
	// Virtual Table Instance Object
	struct sqlite3_vtab
	{
		const sqlite3_module* pModule;
		int nRef;
		char* zErrMsg;
		/* Virtual table implementations will typically add additional fields */
	}

	// Virtual Table Cursor Object
	struct sqlite3_vtab_cursor
	{
		sqlite3_vtab* pVtab;
		/* Virtual table implementations will typically add additional fields */
	}

	// Declare The Schema Of A Virtual Table
	int sqlite3_declare_vtab(sqlite3* pDb, const char* zSQL);

	// Overload A Function For A Virtual Table
	int sqlite3_overload_function(sqlite3* pDb, const char* zFuncName, int nArg);

	// A Handle To An Open BLOB
	struct sqlite3_blob;

	// Open A BLOB For Incremental I/O
	int sqlite3_blob_open(sqlite3* pDb, const char* zDb, const char* zTable, const char* zColumn, sqlite3_int64 iRow, int flags, sqlite3_blob** ppBlob);

	// Move a BLOB Handle to a New Row
	// SQLITE_EXPERIMENTAL
	int sqlite3_blob_reopen(sqlite3_blob*, sqlite3_int64);

	// Close A BLOB Handle
	int sqlite3_blob_close(sqlite3_blob*);

	// Return The Size Of An Open BLOB
	int sqlite3_blob_bytes(sqlite3_blob *);

	// Read Data From A BLOB Incrementally
	int sqlite3_blob_read(sqlite3_blob *, void *Z, int N, int iOffset);

	// Write Data Into A BLOB Incrementally
	int sqlite3_blob_write(sqlite3_blob *, const void *z, int n, int iOffset);

	// Virtual File System Objects
	sqlite3_vfs* sqlite3_vfs_find(const char* zVfsName);
	int sqlite3_vfs_register(sqlite3_vfs*, int makeDflt);
	int sqlite3_vfs_unregister(sqlite3_vfs*);

	// Mutexes
	sqlite3_mutex* sqlite3_mutex_alloc(int);
	void sqlite3_mutex_free(sqlite3_mutex*);
	void sqlite3_mutex_enter(sqlite3_mutex*);
	int sqlite3_mutex_try(sqlite3_mutex*);
	void sqlite3_mutex_leave(sqlite3_mutex*);

	// Mutex Methods Object
	struct sqlite3_mutex_methods
	{
		int function() xMutexInit;
		int function() xMutexEnd;
		sqlite3_mutex* function(int) xMutexAlloc;
		void function(sqlite3_mutex*) xMutexFree;
		void function(sqlite3_mutex*) xMutexEnter;
		int function(sqlite3_mutex*) xMutexTry;
		void function(sqlite3_mutex*) xMutexLeave;
		int function(sqlite3_mutex*) xMutexHeld;
		int function(sqlite3_mutex*) xMutexNotheld;
	}

	// Mutex Verification Routines
	int sqlite3_mutex_held(sqlite3_mutex* pMutex);
	int sqlite3_mutex_notheld(sqlite3_mutex* pMutex);

	// Mutex Types
	enum
	{
		SQLITE_MUTEX_FAST          = 0,
		SQLITE_MUTEX_RECURSIVE     = 1,
		SQLITE_MUTEX_STATIC_MASTER = 2,
		SQLITE_MUTEX_STATIC_MEM    = 3, /* sqlite3_malloc() */
		SQLITE_MUTEX_STATIC_MEM2   = 4, /* NOT USED */
		SQLITE_MUTEX_STATIC_OPEN   = 4, /* sqlite3BtreeOpen() */
		SQLITE_MUTEX_STATIC_PRNG   = 5, /* sqlite3_random() */
		SQLITE_MUTEX_STATIC_LRU    = 6, /* lru page list */
		SQLITE_MUTEX_STATIC_LRU2   = 7, /* NOT USED */
		SQLITE_MUTEX_STATIC_PMEM   = 7, /* sqlite3PageMalloc() */
	}

	// Retrieve the mutex for a database connection
	sqlite3_mutex* sqlite3_db_mutex(sqlite3* pDb);

	// Low-Level Control Of Database Files
	int sqlite3_file_control(sqlite3* pDb, const char* zDbName, int op, void*);

	// Testing Interface
	int sqlite3_test_control(int op, ...);

	// Testing Interface Operation Codes
	enum
	{	
		SQLITE_TESTCTRL_FIRST               =  5,
		SQLITE_TESTCTRL_PRNG_SAVE           =  5,
		SQLITE_TESTCTRL_PRNG_RESTORE        =  6,
		SQLITE_TESTCTRL_PRNG_RESET          =  7,
		SQLITE_TESTCTRL_BITVEC_TEST         =  8,
		SQLITE_TESTCTRL_FAULT_INSTALL       =  9,
		SQLITE_TESTCTRL_BENIGN_MALLOC_HOOKS = 10,
		SQLITE_TESTCTRL_PENDING_BYTE        = 11,
		SQLITE_TESTCTRL_ASSERT              = 12,
		SQLITE_TESTCTRL_ALWAYS              = 13,
		SQLITE_TESTCTRL_RESERVE             = 14,
		SQLITE_TESTCTRL_OPTIMIZATIONS       = 15,
		SQLITE_TESTCTRL_ISKEYWORD           = 16,
		SQLITE_TESTCTRL_SCRATCHMALLOC       = 17,
		SQLITE_TESTCTRL_LOCALTIME_FAULT     = 18,
		SQLITE_TESTCTRL_EXPLAIN_STMT        = 19,
		SQLITE_TESTCTRL_LAST                = 19,
	}

	// SQLite Runtime Status
	int sqlite3_status(int op, int* pCurrent, int* pHighwater, int resetFlag);

	// Status Parameters
	enum
	{
		SQLITE_STATUS_MEMORY_USED        = 0,
		SQLITE_STATUS_PAGECACHE_USED     = 1,
		SQLITE_STATUS_PAGECACHE_OVERFLOW = 2,
		SQLITE_STATUS_SCRATCH_USED       = 3,
		SQLITE_STATUS_SCRATCH_OVERFLOW   = 4,
		SQLITE_STATUS_MALLOC_SIZE        = 5,
		SQLITE_STATUS_PARSER_STACK       = 6,
		SQLITE_STATUS_PAGECACHE_SIZE     = 7,
		SQLITE_STATUS_SCRATCH_SIZE       = 8,
		SQLITE_STATUS_MALLOC_COUNT       = 9,
	}

	// Database Connection Status
	int sqlite3_db_status(sqlite3* pDb, const int op, int* pCur, int* pHiwtr, const int resetFlg);

	// Status Parameters for database connections
	enum
	{
		SQLITE_DBSTATUS_LOOKASIDE_USED      = 0,
		SQLITE_DBSTATUS_CACHE_USED          = 1,
		SQLITE_DBSTATUS_SCHEMA_USED         = 2,
		SQLITE_DBSTATUS_STMT_USED           = 3,
		SQLITE_DBSTATUS_LOOKASIDE_HIT       = 4,
		SQLITE_DBSTATUS_LOOKASIDE_MISS_SIZE = 5,
		SQLITE_DBSTATUS_LOOKASIDE_MISS_FULL = 6,
		SQLITE_DBSTATUS_CACHE_HIT           = 7,
		SQLITE_DBSTATUS_CACHE_MISS          = 8,
		SQLITE_DBSTATUS_CACHE_WRITE         = 9,
		SQLITE_DBSTATUS_MAX                 = 9, /* Largest defined DBSTATUS */
	}

	// Prepared Statement Status
	int sqlite3_stmt_status(sqlite3_stmt* pStmt, int op, int resetFlg);

	// Status Parameters for prepared statements
	enum
	{
		SQLITE_STMTSTATUS_FULLSCAN_STEP = 1,
		SQLITE_STMTSTATUS_SORT          = 2,
		SQLITE_STMTSTATUS_AUTOINDEX     = 3,
	}

	// Custom Page Cache Object
	struct sqlite3_pcache;
	struct sqlite3_pcache_page
	{
		void* pBuf;        /* The content of the page */
		void* pExtra;      /* Extra information associated with the page */
	}

	// Application Defined Page Cache.
	struct sqlite3_pcache_methods2
	{
		int iVersion;
		void* pArg;
		/+
		int (*xInit)(void*);
		void (*xShutdown)(void*);
		sqlite3_pcache *(*xCreate)(int szPage, int szExtra, int bPurgeable);
		void (*xCachesize)(sqlite3_pcache*, int nCachesize);
		int (*xPagecount)(sqlite3_pcache*);
		sqlite3_pcache_page *(*xFetch)(sqlite3_pcache*, unsigned key, int createFlag);
		void (*xUnpin)(sqlite3_pcache*, sqlite3_pcache_page*, int discard);
		void (*xRekey)(sqlite3_pcache*, sqlite3_pcache_page*, 
					   unsigned oldKey, unsigned newKey);
		void (*xTruncate)(sqlite3_pcache*, unsigned iLimit);
		void (*xDestroy)(sqlite3_pcache*);
		void (*xShrink)(sqlite3_pcache*);
		+/
	}

	// This is the obsolete pcache_methods object that has now been replaced by sqlite3_pcache_methods2
	deprecated struct sqlite3_pcache_methods
	{
		void* pArg;
		/+
		int (*xInit)(void*);
		void (*xShutdown)(void*);
		sqlite3_pcache *(*xCreate)(int szPage, int bPurgeable);
		void (*xCachesize)(sqlite3_pcache*, int nCachesize);
		int (*xPagecount)(sqlite3_pcache*);
		void *(*xFetch)(sqlite3_pcache*, unsigned key, int createFlag);
		void (*xUnpin)(sqlite3_pcache*, void*, int discard);
		void (*xRekey)(sqlite3_pcache*, void*, unsigned oldKey, unsigned newKey);
		void (*xTruncate)(sqlite3_pcache*, unsigned iLimit);
		void (*xDestroy)(sqlite3_pcache*);
		+/
	}

	// Online Backup Object
	struct sqlite3_backup;
	
	// SQLite Online Backup API
	sqlite3_backup* sqlite3_backup_init(sqlite3* pDest, const char* zDestName, sqlite3* pSource, const char* zSourceName);
	int sqlite3_backup_step(sqlite3_backup* pBackup, int nPage);
	int sqlite3_backup_finish(sqlite3_backup* pBackup);
	int sqlite3_backup_remaining(sqlite3_backup* pBackup);
	int sqlite3_backup_pagecount(sqlite3_backup* pBackup);

	// Unlock Notification
	int sqlite3_unlock_notify(sqlite3 *pBlocked, void function(void** apArg, int nArg) xNotify, void* pNotifyArg);

	// String Comparison
	int sqlite3_stricmp(const char*, const char*);
	int sqlite3_strnicmp(const char*, const char*, int);

	// Error Logging Interface
	void sqlite3_log(int iErrCode, const char* zFormat, ...);

	// Write-Ahead Log Commit Hook
	void* sqlite3_wal_hook(sqlite3* pDb, int function(void*, sqlite3*, const char*, int), void*);

	// Configure an auto-checkpoint
	int sqlite3_wal_autocheckpoint(sqlite3* pDb, int N);

	// Checkpoint a database
	int sqlite3_wal_checkpoint(sqlite3* pDb, const char* zDb);
	int sqlite3_wal_checkpoint_v2(sqlite3* pDb, const char* zDb, int eMode, int* pnLog, int* pnCkpt);

	// Checkpoint operation parameters
	enum
	{
		SQLITE_CHECKPOINT_PASSIVE = 0,
		SQLITE_CHECKPOINT_FULL    = 1,
		SQLITE_CHECKPOINT_RESTART = 2,
	}
}
