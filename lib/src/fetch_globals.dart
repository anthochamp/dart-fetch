// SPDX-FileCopyrightText: © 2023 - 2024 Anthony Champagne <dev@anthonychampagne.fr>
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:ac_httpx_client/ac_httpx_client.dart';

class FetchGlobals {
  static final _instance = FetchGlobals._();
  factory FetchGlobals() => _instance;

  FetchGlobals._();

  HttpxClient defaultHttpxClient = HttpxClient();
}
