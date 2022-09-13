package com.move.service;

import java.io.FileNotFoundException;
import java.io.IOException;

import org.json.JSONException;

public interface MoveService {
	
	public String[] searchLocation(String location) throws IOException, JSONException;

}
