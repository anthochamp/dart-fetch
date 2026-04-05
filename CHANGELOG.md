# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.3.1] - 2026-04-05

### Changed

- `FetchUtilities.findBestDataCoder` converted to top-level function `fetchFindBestDataCoder`;
  deprecated `FetchUtilities` class retained for backward compatibility

### Fixed

- `waitData` and `waitStructuredData` now throw a typed `StateError` (instead of bare `Exception`)
  when called a second time with different arguments

## 0.3.0

- Update SDK environment requirement (>= 3.7.0 && <4.0.0)
- Upgrade freezed/freezed_annotation packages

## 0.2.1

- Upgrade ac_httpx_client package to 0.2.0

## 0.2.0

- Upgrade freezed/freezed_annotation packages
- Upgrade ac_lints package to 0.4.0

## 0.1.2

- Upgrade freezed/freezed_annotation packages (lint generated files)
- Upgrade ac_lints package to 0.3.0

## 0.1.1

- Update LICENSE's copyright to include contributors and use SPDX file header
- Widen SDK environment requirement to include Dart 3 versions
- Upgrade ac_essentials package to 0.2.1
- Upgrade ac_lints package to 0.2.0

## 0.1.0

- Initial release
