// Copyright (c) 2015, Kornel Maczyński. All rights reserved. Use of this source
// code is governed by AGPLv3 license that can be found in the LICENSE file.
// If you want to contribute read the rules in the CONTRIBUTING file.

library triki_menu_item;

import 'dart:html';
import 'dart:async';

import 'package:polymer/polymer.dart';

@CustomTag('triki-menu-item')
class TrikiMenuItem extends PolymerElement {
  @published String href;
  @published String icon;
  @published bool get isHref => href != null && href != "";
  @published bool get isIcon => icon != null && icon != "";
  TrikiMenuItem.created() : super.created();

  bool go(MouseEvent e) {
    e.preventDefault();
    MouseEvent ev = new MouseEvent(e.type,
        button: e.button,
        canBubble: false, // don't get into an infinite loop
        ctrlKey: e.ctrlKey,
        altKey: e.altKey,
        shiftKey: e.shiftKey,
        metaKey: e.metaKey);
    if (isHref) {
      new Future(() =>($['text'] as AnchorElement).dispatchEvent(ev));
    }
    return false;
  }
}
