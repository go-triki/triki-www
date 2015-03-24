// Copyright (c) 2014, Kornel Maczyński. All rights reserved. Use of this source
// code is governed by AGPLv3 license that can be found in the LICENSE file.
// If you want to contribute read the rules in the CONTRIBUTING file.

//@HtmlImport('search_box.html')
library search_box;

import 'dart:html';
import 'dart:async';

import 'package:polymer/polymer.dart';

@CustomTag('search-box')
class SearchBox extends PolymerElement {
  @observable String searchTerm = "";
  @observable bool valid = true;

  static const int _MIN_LENGTH = 3;

  InputElement _input;
  DivElement _div;
  StreamSubscription<Event> _onFocusSub;
  StreamSubscription<Event> _onBlurSub;

  SearchBox.created() : super.created();

  @override
  void ready() {
    super.ready();
    _input = $[r'searchInput'];
    _div = shadowRoot.querySelector('.heightLimit');
    _onFocusSub = _input.onFocus.listen((_) {
      new Future(() => _div.style.maxWidth = "30em");
    });
    _onBlurSub = _input.onBlur.listen((_) {
    	_div.style.maxWidth = "13em";
    });
  }

  @override
  void detached() {
    super.detached();
    _onBlurSub.cancel();
    _onFocusSub.cancel();
  }

  void search(Event e) {
    e.preventDefault();
    if (searchTerm.length < _MIN_LENGTH) {
      valid = false;
      _input.focus();
      return;
    }
    print(searchTerm);
  }

  void searchTermChanged(String oldValue, String newValue) {
    if (newValue == null) {
      newValue = "";
    }
    if (newValue.length >= _MIN_LENGTH || newValue.length == 0) {
      valid = true;
    }
  }

  void clear() {
    _input.focus();
    _input.value = "";
    valid = true;
  }

  String get errorMsg {
    return "Type at least ${_MIN_LENGTH} characters.";
  }
}
