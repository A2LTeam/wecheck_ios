package a2l.testparseitem.database;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import a2l.testparseitem.Item;
import a2l.testparseitem.ItemCst;
import a2l.testparseitem.ItemParser;
import android.content.ContentValues;
import android.content.Context;
import android.content.res.AssetManager;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
import android.util.Log;

public class DatabaseOpenHelper extends SQLiteOpenHelper {

	//	Private constants
	private static final String DEBUG_TAG = "DatabaseOpenHelper";
	
	private static final String DATABASE_NAME = "item.db";
	private static final int DATABASE_VERSION = 1;
	private static final String DATABASE_SCRIPT_NAME = "initialScript.sql";
	
	//	Variables
	private Context mContext;
	
	//--------------------------------------------------------------------------------------------------
	//	Constructors
	//--------------------------------------------------------------------------------------------------
	public DatabaseOpenHelper(Context context) {
		super(context, DATABASE_NAME, null, DATABASE_VERSION);
		mContext = context;
	}
	
	
	//--------------------------------------------------------------------------------------------------
	//	Database create/upgrade functions
	//--------------------------------------------------------------------------------------------------
	@Override
	public void onCreate(SQLiteDatabase database) {
		Log.d(DEBUG_TAG, "onCreate");
//		PurchaseRecordTable.onCreate(database);
//		database.execSQL(sql);
		
		String filename = String.format(DATABASE_SCRIPT_NAME, DATABASE_VERSION);
		String script = readScriptFromAssets(filename);
		String[] querys = script.split("/");
		for (int i = 0; i < querys.length; i++) {
			database.execSQL(querys[i]);
		}
		
		JSONObject jsonObj = ItemParser.getJSONFromUrl(ItemCst.URL);
		try {
			JSONArray jArray = jsonObj.getJSONArray("items");
			for (int i = 0; i < jArray.length(); i++){
				JSONObject obj = jArray.getJSONObject(i);
				ContentValues contentValues = new ContentValues();
				contentValues.put(ItemCst.FIELD_BRAND, obj.getString(ItemCst.BRAND));
				contentValues.put(ItemCst.FIELD_NAME, obj.getString(ItemCst.NAME));
				contentValues.put(ItemCst.FIELD_CATEGORY, ItemCst.CATEGORY);
				contentValues.put(ItemCst.FIELD_CODE, obj.getString(ItemCst.CODE));
				database.insert(ItemCst.TABLE_NAME, null, contentValues);
			}
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	//--------------------------------------------------------------------------------------------------
	@Override
	public void onUpgrade(SQLiteDatabase database, int oldVersion, int newVersion) {
		Log.d(DEBUG_TAG, "onUpgrade: " + oldVersion + " -> " + newVersion);
		for (int i = oldVersion + 1; i <= newVersion; i++) {
			String filename = String.format(DATABASE_SCRIPT_NAME, DATABASE_VERSION);
			String script = readScriptFromAssets(filename);
			database.execSQL(script);
		}
		
	}
	
	
	
	//--------------------------------------------------------------------------------------------------
	//	Custom functions
	//--------------------------------------------------------------------------------------------------
	private String readScriptFromAssets(String filename) {
		AssetManager assetManager = mContext.getAssets();
		InputStream inputStream = null;
		BufferedReader bufferedReader = null;
		StringBuilder stringBuilder = new StringBuilder();

		try {
			// Read the data from the file
			inputStream = assetManager.open(filename);
			bufferedReader = new BufferedReader(new InputStreamReader(inputStream));
			
			String line = null;
			while ((line = bufferedReader.readLine()) != null) {
				stringBuilder.append(line);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
			stringBuilder.setLength(0); // Error in reading data, clearing the builder
		} finally {
			// Close the stream
			try {
				if (bufferedReader != null) {
					bufferedReader.close();
				}
				if (inputStream != null) {
					inputStream.close();
				}
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		}

		return stringBuilder.toString();
	}
	
}