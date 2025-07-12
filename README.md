[![Build Status](https://github.com/hnvcam/teno_mindmap/actions/workflows/ci.yaml/badge.svg)](https://github.com/hnvcam/teno_mindmap)
[![codecov](https://codecov.io/gh/hnvcam/teno_mindmap/graph/badge.svg?token=02SX31INHW)](https://codecov.io/gh/hnvcam/teno_mindmap)
[![Pub Package](https://img.shields.io/pub/v/teno_mindmap)](https://pub.dev/packages/teno_mindmap)

> **⚠️ WARNING:** I have downgraded `freezed` to version 2.5.7 so old projects will not have compatibility issues with `source_gen` 2.0.0

Simple implementation of a Mind Map using a Radial layout.
This layout ensures child nodes do not overlap with their parents or siblings by automatically rebalancing node positions. 
Additionally, nodes with more children automatically take up more angular span.

![teno_mindmap.png](https://raw.githubusercontent.com/hnvcam/teno_mindmap/refs/heads/main/teno_mindmap.png)

## Features
With the default implementation, it provides:
- Automatic rebalancing
- Add, update, and remove nodes
- Panning and zooming support

Fully customizable:
- Node and connector rendering (see Dashboard.dart)
- BLoC state management integration

## Getting started
Check out the example folder for usage with the default implementation.

## Usage

```shell
flutter pub add teno_mindmap
```

```dart
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mind Map Canvas')),
      body: const MindMap(title: 'Your Goal'),
    );
  }
}
```

## TODO LIST:
- [ ] Increase test coverage
- [ ] Add prebuilt styles for the default implementation
