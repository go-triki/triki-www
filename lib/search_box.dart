// Copyright (c) 2014, Kornel Maczyński. All rights reserved. Use of this source
// code is governed by AGPLv3 license that can be found in the license file.
// If you want to contribute read the rules in the contributing file.

import 'dart:html';

import 'package:polymer/polymer.dart';

@CustomTag('search-box')
class SearchBox extends PolymerElement {
	@observable String searchTerm;
	@observable bool valid = true;
  
	static const int MIN_LENGTH = 3;
	
	InputElement _input;
	
	SearchBox.created() : super.created() {
		//_input = $[r'searchInput'] as InputElement;
	}
	
	@override
	void ready() {
		super.ready();
		_input = $[r'searchInput'] as InputElement;
	}
	
	void search(Event e) {
		e.preventDefault();
		if (searchTerm.length < MIN_LENGTH) {
			valid = false;
			return;
		}
		print(searchTerm);
	}
	
	void searchTermChanged(String oldValue, String newValue) {
		if (newValue == null || newValue.length >= MIN_LENGTH || newValue.length == 0) {
			valid = true;
		}
	}
	
	void clear() {
		_input.value = "";
		valid = true;
		_input.focus();
	}
	
	String get errorMsg {
		return "Type at least ${MIN_LENGTH} characters.";
	}
}