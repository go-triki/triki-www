// Copyright (c) 2014, Kornel Maczyński. All rights reserved. Use of this source
// code is governed by AGPLv3 license that can be found in the LICENSE file.
// If you want to contribute read the rules in the CONTRIBUTING file.

@HtmlImport('triki_menu_item.html')
library triki_menu_item;

import 'package:polymer/polymer.dart';
import 'package:paper_elements/paper_item.dart';
import 'dart:html';

@CustomTag('triki-menu-item')
class TrikiMenuItem extends PolymerElement {
  @published String route;

  PaperItem _item;

  TrikiMenuItem.created() : super.created();

  @override
  void ready() {
    super.ready();
    _item = $[r'item'] as PaperItem;
    window.onHashChange.listen((HashChangeEvent e) {
      _item.classes.toggle("core-selected");
    });
  }

  void go() {}
}
