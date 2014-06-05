package a2l.testparseitem;

import java.util.ArrayList;
import java.util.List;

import a2l.testparseitem.database.DataManager;
import android.app.Activity;
import android.app.Fragment;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.database.Cursor;
import android.os.AsyncTask;
import android.os.Bundle;
import android.support.v4.content.LocalBroadcastManager;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ListView;
import android.widget.TextView;

public class ListViewFragment extends Fragment {

	//	Private constants
	private static final String DEBUG_TAG = "TransactionFragment";

	private ListView mListView;

	private MessageReceiver mMessageReceiver;	
	private TransactionListAdapter mTransactionListAdapter;
	
	//--------------------------------------------------------------------------------------------------
    //	Fragment lifecycle
    //--------------------------------------------------------------------------------------------------
    @Override
    public void onAttach(Activity activity) {
        super.onAttach(activity);
        Log.d(DEBUG_TAG, "onAttach");
    }
    
    //--------------------------------------------------------------------------------------------------
    @Override 
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    //--------------------------------------------------------------------------------------------------
    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_main, container, false);
        
        mListView = (ListView)view.findViewById(R.id.list_view);
        
        //--------------------------------------------------------------------------------------------------
        //	Load records
        loadTransactionRecords();
        
        return view;
    }
    
    //--------------------------------------------------------------------------------------------------
    @Override
    public void onActivityCreated(Bundle savedInstanceState) {
        super.onActivityCreated(savedInstanceState);
    }
    
    //--------------------------------------------------------------------------------------------------
    @Override
    public void onStart() {
    	super.onStart();
    	Log.d(DEBUG_TAG, "onStart");
    }
    
    //--------------------------------------------------------------------------------------------------
    @Override
    public void onResume() {
    	super.onResume();
    }
    
    //--------------------------------------------------------------------------------------------------
    @Override
    public void onPause() {
    	super.onPause();
    }
    
    //--------------------------------------------------------------------------------------------------
    @Override
    public void onStop() {
    	LocalBroadcastManager.getInstance(getActivity()).unregisterReceiver(mMessageReceiver);
    	
    	super.onStop();
    	Log.d(DEBUG_TAG, "onStop");
    }
    
    //--------------------------------------------------------------------------------------------------
    @Override
    public void onDestroyView() {
    	super.onDestroyView();
    }
    
    //--------------------------------------------------------------------------------------------------
    @Override
    public void onDestroy() {
    	super.onDestroy();
    }

    //--------------------------------------------------------------------------------------------------
    @Override
    public void onDetach() {
        super.onDetach();
        Log.d(DEBUG_TAG, "onDetach");
    }

    //--------------------------------------------------------------------------------------------------
    //	Custom functions
    //--------------------------------------------------------------------------------------------------
    private void loadTransactionRecords() {    	
    	AsyncTask<Void, Void, List<Item>> loadingTask = new AsyncTask<Void, Void, List<Item>>() {

    		//--------------------------------------------------------------------------------------------------
			@Override
			protected List<Item> doInBackground(Void... params) {
				//	TODO:
				//	Load data according filter
				List<Item> list = new ArrayList<Item>();
				DataManager dataManager = DataManager.getInstance(getActivity());
				dataManager.openDatabase();
				String query = "SELECT * FROM " + ItemCst.TABLE_NAME;
				Cursor cursor = dataManager.getSQLiteDatabase().rawQuery(query, null);
				while (cursor.moveToNext()) {
					Item item = new Item();
					item.setBrand(dataManager.getStringFromColumn(cursor, ItemCst.FIELD_BRAND));
					item.setName(dataManager.getStringFromColumn(cursor, ItemCst.FIELD_NAME));
					item.setCategory(dataManager.getStringFromColumn(cursor, ItemCst.FIELD_CATEGORY));
					list.add(item);
				}
				cursor.close();
				dataManager.closeDatabase();
				return list;
			}
			
			//--------------------------------------------------------------------------------------------------
			@Override
			protected void onPostExecute(List<Item> list) {
				if (mTransactionListAdapter == null) {
					mTransactionListAdapter = new TransactionListAdapter(getActivity(), list);
					mListView.setAdapter(mTransactionListAdapter);
				} else {
					mTransactionListAdapter.updateList(list);
				}
			}
    		
    	};
    	loadingTask.execute();
    }
    

    
    
    
    //--------------------------------------------------------------------------------------------------
    //	Inner class/interface
    //==================================================================================================
    //	This class can be refractor to a separate class if we need to reuse it again
    public class TransactionListAdapter extends BaseAdapter {

    	//	Variables
    	private Context mContext;
    	private List<Item> mList;
    	
    	
    	//--------------------------------------------------------------------------------------------------
    	//	Constructors
    	//--------------------------------------------------------------------------------------------------
    	public TransactionListAdapter(Context context, List<Item> list)  {
    		mContext = context;
    		mList = new ArrayList<Item>(list);
    	}
    	
    	
    	//--------------------------------------------------------------------------------------------------
    	//	BaseAdpater functions
    	//--------------------------------------------------------------------------------------------------
    	@Override
    	public int getCount() {
    		return mList.size();
    	}

    	//--------------------------------------------------------------------------------------------------
    	@Override
    	public Item getItem(int position) {
    		return mList.get(position);
    	}

    	//--------------------------------------------------------------------------------------------------
    	@Override
    	public long getItemId(int position) {
    		return 0;
    	}

    	//--------------------------------------------------------------------------------------------------
    	@Override
    	public View getView(int position, View convertView, ViewGroup parent) {
    		View view = convertView;
    		
    		if (convertView == null)  {
    			//	No available recycled view, create a new one
    			LayoutInflater inflater = (LayoutInflater)mContext.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
    			view = inflater.inflate(R.layout.list_detail, null);
    			
    			ViewHolder viewHolder = new ViewHolder();
    			viewHolder.nameTextView = (TextView)view.findViewById(R.id.name);
    			viewHolder.categoryTextView = (TextView)view.findViewById(R.id.category);
    			viewHolder.brandTextView = (TextView)view.findViewById(R.id.brand);
    			view.setTag(viewHolder);
    		}
    		
    		//	View setup
    		//	TODO: setup the cell using list data
    		Item item = getItem(position);
    		ViewHolder viewHolder = (ViewHolder)view.getTag();
    		viewHolder.nameTextView.setText(item.getName());
    		viewHolder.brandTextView.setText(item.getBrand());
			viewHolder.categoryTextView.setText(item.getCategory());   		
    		return view;
    	}
    	
    	
    	//--------------------------------------------------------------------------------------------------
    	//	Custom functions
    	//--------------------------------------------------------------------------------------------------
    	public void updateList(List<Item> list) {
    		mList.clear();
    		mList.addAll(list);
    		notifyDataSetChanged();
    	}
    	
    	
    	//--------------------------------------------------------------------------------------------------
    	//	Inner class/interface
    	//==================================================================================================
    	private class ViewHolder  {
    		TextView nameTextView;
    		TextView brandTextView;
    		TextView categoryTextView;
    	}
    }

    
    //==================================================================================================
    private class MessageReceiver extends BroadcastReceiver {
		@Override
		public void onReceive(Context context, Intent intent) {}
    	
    }
    
	
}