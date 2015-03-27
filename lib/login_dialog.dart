// Copyright (c) 2014, Kornel Maczyński. All rights reserved. Use of this source
// code is governed by AGPLv3 license that can be found in the LICENSE file.
// If you want to contribute read the rules in the CONTRIBUTING file.

library login_dialog;

import 'dart:html';
import 'dart:async';

import 'package:polymer/polymer.dart';

import 'package:paper_elements/paper_action_dialog.dart';

@CustomTag('login-dialog')
class LoginDialog extends PolymerElement {
  @observable String heading = "";
  @observable bool isLogin = true;
  @observable final int minPassLength = 5;
  @observable bool opened = false;
  @observable String Usr = "";
  @observable String Pass = "";
  @observable String serverMsg = "";

  FormElement get form => $['form'];

  PaperActionDialog _dialog;
  StreamSubscription _closeSubscr;

  LoginDialog.created() : super.created();

  @override
  void ready() {
    super.ready();
    _dialog = shadowRoot.querySelector('paper-action-dialog');
    _closeSubscr =
        _dialog.on['core-overlay-close-completed'].listen((_) => reset);
  }
  @override
  void detached() {
    super.detached();
    _closeSubscr.cancel();
  }

  void login() {
    if (_dialog.opened) {
      return;
    }
    _login();
    _dialog.open();
    return;
  }
  void _login() {
    heading = "Log-in";
    isLogin = true;
  }

  void signup() {
    if (_dialog.opened) {
      return;
    }
    _signup();
    _dialog.open();
  }
  _signup() {
    heading = "Sign-up";
    isLogin = false;
  }

  void other(Event e) {
    e.preventDefault();
    reset();
    if (isLogin) {
      _signup();
    } else {
      _login();
    }
    _dialog.focus();
    form.querySelector('input[autofocus]').focus();
  }
  void reset() {
  	serverMsg = "";
    Pass = "";
    Usr = "";
    form.reset();
  }

  bool submit(Event e) {
    e.preventDefault();
    print("${Usr} ${Pass}");
    return false;
  }
  bool OkClick(Event e) {
    e.preventDefault();
    e.stopPropagation();
    (form.querySelector('input[type="submit"]') as InputElement).click();
    //form.click();
    return false;
  }

  void openedChanged() {
    if (!opened) {
      reset();
    }
  }
}
