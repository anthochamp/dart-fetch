// Copyright 2023, Anthony Champagne. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:ac_httpx_client/ac_httpx_client.dart';

class FetchGlobals {
  static final _instance = FetchGlobals._();
  factory FetchGlobals() => _instance;

  FetchGlobals._();

  HttpxClient defaultHttpxClient = HttpxClient();
}
