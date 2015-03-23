// Copyright (c) 2014, Kornel Maczyński. All rights reserved. Use of this source
// code is governed by AGPLv3 license that can be found in the LICENSE file.
// If you want to contribute read the rules in the CONTRIBUTING file.

@HtmlImport('triki_main.html')
library triki_main;

import 'package:polymer/polymer.dart';

import 'package:core_elements/core_drawer_panel.dart';

/// Main triki app element.
@CustomTag('triki-main')
class MainApp extends PolymerElement {
  CoreDrawerPanel _drawerPanel;

  /// Constructor used to create instance of MainApp.
  MainApp.created() : super.created() {
    //_drawerPanel = $[r'drawerPanel'] as CoreDrawerPanel;
  }

  void togglePanel() {
    _drawerPanel.togglePanel();
  }
  void closePanel() {
    _drawerPanel.closeDrawer();
  }
  // Optional lifecycle methods - uncomment if needed.

//	attached() {
//		super.attached();
//	}

//	/// Called when an instance of main-app is removed from the DOM.
//	detached() {
//		super.detached();
//	}

//	/// Called when an attribute (such as a class) of an instance of
//	/// main-app is added, changed, or removed.
//	attributeChanged(String name, String oldValue, String newValue) {
//		super.attributeChanges(name, oldValue, newValue);
//	}

  @override
  void ready() {
    super.ready();
    _drawerPanel = $[r'drawerPanel'] as CoreDrawerPanel;
  }
}
