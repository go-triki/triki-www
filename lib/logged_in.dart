// Copyright (c) 2015, Kornel Maczyński. All rights reserved. Use of this source
// code is governed by AGPLv3 license that can be found in the LICENSE file.
// If you want to contribute read the rules in the CONTRIBUTING file.

@HtmlImport('logged_in_nodart.html')
library logged_in;

import 'dart:html';
import 'dart:async';
import 'dart:convert';

import 'package:polymer/polymer.dart';

import 'src/api_urls.dart';

@CustomTag('logged-in')
class LoggedIn extends PolymerElement {
  @PublishedProperty(reflect: true) bool loggedIn = false;
  @PublishedProperty(reflect: true) String usrId = "";
  @PublishedProperty(reflect: true) String authTkn = "";
  @PublishedProperty(reflect: true) bool rememberMe = false;

  static final String _usrId = 'trikiUsrId';
  static final String _authTkn = 'trikiAuthTkn';
  static final String _logInEv = 'log-in';
  static final String _logInFailedEv = 'log-in-failed';
  static final String _logOutEv = 'log-out';

  static final String _url = 'localhost:8888/api/auth/login';

  StreamSubscription<StorageEvent> _storageSubscr;

  LoggedIn.created() : super.created();

  @override
  void ready() {
    _readLS();
    _writeLS();
    _storageSubscr = window.onStorage.listen((_) => _readLS);
  }

  @override
  void detached() {
    super.detached();
    _storageSubscr.cancel();
  }

  void loggedInChanged(bool oldL, bool newL) {
    String type = _logOutEv;
    if (newL) {
      type = _logInEv;
    }
    this.fire(type, onNode: this, canBubble: false, cancelable: false);
  }

  Cancel logIn(String usrId, String usrPass, bool rememberMe) {
    HttpRequest req = new HttpRequest();
    Cancel c = new Cancel(req);
    req.responseType = 'json';
    req.send(JSON.encode({'usr': usrId, 'pass': usrPass}));
    req.open('POST', ApiUrl.login);
    req.onLoad.listen((ProgressEvent e) {
      if (c.cancelled) return;
      try {
        var resp = JSON.decode(req.responseText);
        if (resp['tkn'] != null && resp['tkn'] != '') {
          String authTkn = resp.tkn;
          this.usrId = usrId;
          this.authTkn = authTkn;
          this.loggedIn = true;
          this.rememberMe = rememberMe;
          _writeLS();
        } else {
          this.fire(_logInFailedEv,
              onNode: this,
              canBubble: false,
              cancelable: false,
              detail: resp['err']);
        }
      } catch (e) {
        window.console.error(
            'error reading login response `${req.responseText}` from the server: ${e}');
        this.fire(_logInFailedEv,
            onNode: this, canBubble: false, cancelable: false, detail: e);
      }
    }, onError: (e) {
      if (c.cancelled) return;
      this.fire(_logInFailedEv,
          onNode: this, canBubble: false, cancelable: false, detail: e);
    });
    return c;
  }

  logOut({bool remember: null}) {
    //TODO(km): notify server (usrId, usrTkn)
    if (remember != null) {
      rememberMe = remember;
    }
    loggedIn = false;
    authTkn = "";
    if (!rememberMe) {
      usrId = "";
    }
    _writeLS();
  }

  ElementStream<CustomEvent> get onLogIn {
    return this.on[_logInEv];
  }

  ElementStream<CustomEvent> get onLogOut {
    return this.on[_logOutEv];
  }

  void _readLS() {
    String lUsrId = window.localStorage[_usrId];
    String lAuthTkn = window.localStorage[_authTkn];
    if (lUsrId != null && lUsrId != "") {
      rememberMe = true;
      usrId = lUsrId;
      if (lAuthTkn != null && lAuthTkn != "") {
        authTkn = lAuthTkn;
        loggedIn = true;
      } else {
        loggedIn = false;
        authTkn = "";
      }
    } else {
      logOut();
    }
  }

  void _writeLS() {
    if (usrId != null && usrId != "") {
      window.localStorage[_usrId] = usrId;
      if (authTkn != null && authTkn != "") {
        window.localStorage[_authTkn] = authTkn;
      } else {
        window.localStorage.remove(_authTkn);
      }
    } else {
      window.localStorage.remove(_authTkn);
      window.localStorage.remove(_usrId);
    }
  }
}

class Cancel {
  bool _cancel = false;
  HttpRequest _req;
  Cancel(this._req);
  bool get cancelled => _cancel;
  void call() {
    _cancel = true;
    _req.abort();
  }
}
