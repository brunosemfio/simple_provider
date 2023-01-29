import 'package:flutter/widgets.dart';
import 'package:simple_provider/src/provider.dart';

extension ProviderExt on BuildContext {
  T read<T>() => Provider.of<T>(this);
  T watch<T>() => Provider.of<T>(this, listen: true);
}
