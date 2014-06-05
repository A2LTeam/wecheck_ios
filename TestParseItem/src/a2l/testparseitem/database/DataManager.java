package a2l.testparseitem.database;

import java.util.concurrent.atomic.AtomicInteger;

import android.content.Context;
import android.database.Cursor;
import android.database.SQLException;
import android.database.sqlite.SQLiteDatabase;

public class DataManager {
	
	//	Private constants
	private static final String DEBUG_TAG = "DataManager";
	
	//	Static variables
	private static DataManager sDataManager;
	
	//	Variables
	private Context mContext;
	private SQLiteDatabase mDatabase;
	private DatabaseOpenHelper mDatabaseOpenHelper;
	
	private AtomicInteger mConnectionCount;
	
	
	//--------------------------------------------------------------------------------------------------
	//	Static functions
	//--------------------------------------------------------------------------------------------------
	public static DataManager getInstance(Context context) {
		if (sDataManager != null) {return sDataManager;}
		
		sDataManager = new DataManager(context);
		return sDataManager;
	}

	
	//--------------------------------------------------------------------------------------------------
	//	Constructors
	//--------------------------------------------------------------------------------------------------
	private DataManager(Context context) {
		mContext = context.getApplicationContext();
		mDatabaseOpenHelper = new DatabaseOpenHelper(context);
		mConnectionCount = new AtomicInteger();
	}
	
	
	// --------------------------------------------------------------------------------------------------
	//	Getters & Setters
	// --------------------------------------------------------------------------------------------------
	public SQLiteDatabase getSQLiteDatabase() {
		return mDatabase;
	}
	
	
	//--------------------------------------------------------------------------------------------------
	//	Database management functions
	//--------------------------------------------------------------------------------------------------
	public synchronized void openDatabase() throws SQLException {
		if (mConnectionCount.incrementAndGet() == 1) {
			mDatabase = mDatabaseOpenHelper.getWritableDatabase();
		}
	}
	
	//--------------------------------------------------------------------------------------------------
	public synchronized void closeDatabase() {
		if (mConnectionCount.decrementAndGet() == 0) {
			mDatabase.close();
		}
	}
	
	
	//--------------------------------------------------------------------------------------------------
	//	Cursor related functions
	//--------------------------------------------------------------------------------------------------
	public String getStringFromColumn(Cursor cursor, String columnName) {
		String value = cursor.getString(cursor.getColumnIndex(columnName));
		return value;
	}
	
	//--------------------------------------------------------------------------------------------------
	public int getIntFromColumn(Cursor cursor, String columnName) {
		int value = cursor.getInt(cursor.getColumnIndex(columnName));
		return value;
	}
	
	//--------------------------------------------------------------------------------------------------
	public float getFloatFromColumn(Cursor cursor, String columnName) {
		float value = cursor.getFloat(cursor.getColumnIndex(columnName));
		return value;
	}
	
	//--------------------------------------------------------------------------------------------------
	public double getDoubleFromColumn(Cursor cursor, String columnName) {
		double value = cursor.getDouble(cursor.getColumnIndex(columnName));
		return value;
	}
	
	
	//--------------------------------------------------------------------------------------------------
	//	Example functions
	//--------------------------------------------------------------------------------------------------
//	public synchronized void insertRecord(Object object) {
//		ContentValues contentValues = new ContentValues();
//		contentValues.put("COL_NAME_1", "str");
//		contentValues.put("COL_NAME_2", 1);
//		contentValues.put("COL_NAME_3", 2.0);
//		
//		openDatabase();
//		long colId = mDatabase.insert("Table", null, contentValues);
//		closeDatabase();
//	
//		if (colId == -1) {
//			Log.e(DEBUG_TAG, "Error on inserting record");
//		}
//	}
//	
//	//-------------------------------------------------------------------------------------------------
//	public synchronized void updateRecord(Object object) {
//		ContentValues contentValues = new ContentValues();
//		contentValues.put("COL_NAME_2", 1);
//		contentValues.put("COL_NAME_3", 2.0);
//		
//		String whereClause = "COL_NAME_1 = ?";
//		String[] whereArgs = new String[] {"arg"};
//		
//		openDatabase();
//		int affectedRows = mDatabase.update("Table", contentValues, whereClause, whereArgs);
//		closeDatabase();
//		
//		if (affectedRows == 0) {
//			Log.e(DEBUG_TAG, "Error on updating record");
//		}
//	}
//	
//	//-------------------------------------------------------------------------------------------------
//	public synchronized void updateRecords(List<Object> list) {
//		openDatabase();
//		mDatabase.beginTransaction();
//		try {
//			
//			String queryString = "INSERT OR REPLACE INTO Table" +
//								" VALUES (?, ?, ?)";
//			SQLiteStatement statement = mDatabase.compileStatement(queryString);
//			
//			for (Object object : list) {
//				statement.bindString(1, "str");
//				statement.bindLong(2, 1);
//				statement.bindDouble(3, 2.0);
//				
//				statement.execute();
//			}
//			
//			mDatabase.setTransactionSuccessful();
//		} catch (IllegalStateException e) {
//			e.printStackTrace();
//		} finally {
//			mDatabase.endTransaction();
//			closeDatabase();
//		}
//	}
//	
//	//-------------------------------------------------------------------------------------------------
//	public synchronized List<Object> getAllRecords() {
//		openDatabase();
//		
//		//	Method 1
//		String[] columns = new String[] {"COL_NAME_1", "COL_NAME_2", "COL_NAME_3"};	//	Or null = all columns
//		String whereClause = "COL_NAME_1 = ? AND COL_NAME_2 = 3";
//		String[] whereArgs = new String[] {"str"};
//		String groupBy = null;
//		String having = null;
//		String orderBy = null;
//		String limit = null;
//		Cursor cursor = mDatabase.query("table", columns, whereClause, whereArgs, groupBy, having, orderBy, limit);
//		
//		//	Method 2
//		String queryString = "SELECT * FROM Table" +
//							" WHERE COL_NAME = ? AND COL_NAME = 3";
//		String[] whereArgs = new String[] {"str"};
//		Cursor cursor = mDatabase.rawQuery(queryString, whereArgs);
//		
//		List<Object> list = new ArrayList<Object>();
//		cursor.moveToFirst();
//		while (!cursor.isAfterLast()) {
//			cursor.moveToNext();
//			
//			Object object = new Object();
//			object.set(getStringFromColumn(cursor, "COL_NAME_1"));
//			object.set(getIntFromColumn(cursor, "COL_NAME_21"));
//			object.set(getDoubleFromColumn(cursor, "COL_NAME_3"));
//			
//			list.add(object);
//		}
//		cursor.close();
//		closeDatabase();
//		
//		return list;
//	}
}
