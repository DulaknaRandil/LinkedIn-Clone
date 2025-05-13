import 'dart:io';
import 'package:flutter/material.dart';

class TestImageProvider extends ImageProvider<TestImageProvider> {
  final String _assetName;

  TestImageProvider(this._assetName);

  @override
  Future<TestImageProvider> obtainKey(ImageConfiguration configuration) {
    return Future.value(this);
  }

  @override
  ImageStreamCompleter load(TestImageProvider key, decode) {
    return NetworkImage('dummy_url').load(this, decode);
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    return other is TestImageProvider && other._assetName == _assetName;
  }

  @override
  int get hashCode => _assetName.hashCode;

  @override
  String toString() =>
      '${objectRuntimeType(this, 'TestImageProvider')}("$_assetName")';
}

// Helper class to make network images work in tests
class NetworkImageFake extends Fake implements NetworkImage {
  @override
  ImageStreamCompleter load(NetworkImage key, ImageDecoderCallback decode) {
    return MultiFrameImageStreamCompleter(
      codec: Future.sync(() => SingleFrameImageStreamCompleter()),
      scale: 1.0,
      informationCollector: () sync* {
        yield DiagnosticsProperty<ImageProvider>(
          'Image provider',
          this,
        );
        yield DiagnosticsProperty<ImageProvider>(
          'Image key',
          key,
        );
      },
    );
  }
}

class Fake implements Mock {}

class Mock {}
