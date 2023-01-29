import 'package:flutter/widgets.dart';
import 'package:simple_provider/src/simple_provider.dart';

extension ProviderExt on BuildContext {
  T read<T>() => SimpleProvider.of<T>(this);
  T watch<T>() => SimpleProvider.of<T>(this, listen: true);
}
