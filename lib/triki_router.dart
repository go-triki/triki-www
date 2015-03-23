// Copyright (c) 2015, Kornel Maczyński. All rights reserved. Use of this source
// code is governed by AGPLv3 license that can be found in the license file.
// If you want to contribute read the rules in the contributing file.

import 'dart:html';
import 'package:route_hierarchical/client.dart';

import 'triki_route.dart';

import 'package:polymer/polymer.dart';

/// Triki router element.
@CustomTag('triki-router')
class TrikiRouter extends PolymerElement {
	
	final Router _router = new Router(useFragment: true);
	
	TrikiRouter.created() : super.created();
	
	@override
	void attached() {
		super.attached();
		ElementList<TrikiRouter> routers = querySelectorAll('triki-router');
		if (routers == null || !routers.every((TrikiRouter r) => r == this)) {
			throw "The (single) `triki-router` should be a child of body.";
		}
		this.querySelectorAll('triki-route').forEach((r) {
			print("mounting: ${r}");
			r.mount(_router.root);
		});
		print("listening...");
		_router.listen();
	}
}

Router _router = null;

Router router() {
	if (_router == null) {
		_router = (querySelector('triki-router') as TrikiRouter)._router;
	}
	//_router = (document.documentElement.getElementsByClassName('TrikiRouter') as TrikiRouter)._router;
	return _router;
}
