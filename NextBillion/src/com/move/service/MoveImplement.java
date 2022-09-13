package com.move.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;

public class MoveImplement implements MoveService {

	String url,apiKey;
	@Override
	public String[] searchLocation(String location) throws IOException, JSONException {

		
		File configFile = new File("/Users/krithiknagesh/eclipse-workspace/NextBillion/config.properties");
		InputStream inputStream = new FileInputStream(configFile);
		Properties props = new Properties();
		props.load(inputStream);
		
		//Class variables
		url = props.getProperty("baseUrl");
		apiKey = props.getProperty("apiKey");
		
		OkHttpClient client = new OkHttpClient().newBuilder().build();
		Request requestC = new Request.Builder().url(url+"discover?key="+apiKey+"&lang=EN&limit=20&in=circle:13.02756,77.63253;r=40000&q="+location).method("GET", null)
				.addHeader("Content-Type", "application/json").build();
		Response responseC = client.newCall(requestC).execute();
		String responseBodyC=responseC.body().string();	
		JSONObject jsonObjectC= new JSONObject(responseBodyC);
		JSONArray jsonArray= jsonObjectC.getJSONArray("items");
		int arrayLength= jsonArray.length();
		String[] title = new String [arrayLength];
		String[] latt = new String [arrayLength];
		String[] outcome = new String [arrayLength*2];

		
		if(arrayLength>0) {
			for (int i = 0, j=0; i < arrayLength && j<arrayLength; i++, j++) {
				
				JSONObject jsonObjectA= jsonArray.getJSONObject(i);
				JSONObject jsonObjectB= jsonObjectA.getJSONObject("position");
				JSONObject jsonObjectD= jsonObjectA.getJSONObject("address");

				Double lat= (Double) jsonObjectB.get("lat");
				Double lng=(Double) jsonObjectB.get("lng");
				String name=jsonObjectA.getString("title");
				

				title[i]= jsonObjectA.getString("title")+", "+ jsonObjectD.getString("district");
				latt[j]=lat+","+lng+",'"+name+"'";
	
			}
		}
		
		for (int i = 0, k=0; i < title.length && k < outcome.length; i++) {
			outcome[k]=title[i];
			outcome[k+1]=latt[i];
			k+=2;		
		}
		
		for (int i = 0; i < outcome.length; i++) {
			System.out.println(outcome[i]);
		}
		return outcome;
	}

	public static void main(String[] args) throws FileNotFoundException, IOException, JSONException {
		MoveImplement moveImplement=new MoveImplement();
		String[] title=moveImplement.searchLocation("Mg Road");
		
		for (int i = 0; i < title.length; ) {
			System.out.println(title[i]);
			System.out.println(title[i+1]);
			i+=2;
		}

	}
}

