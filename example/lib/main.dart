import 'package:flutter/material.dart';
import 'package:simple_provider/simple_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleProvider(
      create: (_) => DarkMode.new,
      child: Builder(builder: (context) {
        return ValueListenableBuilder(
          valueListenable: context.read<DarkMode>(),
          builder: (context, state, child) {
            return MaterialApp(
              title: 'Simple Provider',
              theme: state ? ThemeData.dark() : ThemeData(),
              home: SimpleProvider(
                create: (_) => Counter(),
                child: const MyHomePage(),
              ),
            );
          },
        );
      }),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            DarkModeButton(),
            InitialCounterView(),
            CurrentCounterView(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: context.read<Counter>().increment,
        child: const Text('+1'),
      ),
    );
  }
}

class DarkMode extends ValueNotifier<bool> {
  DarkMode() : super(false);

  void toggle() {
    value = !value;
  }
}

class DarkModeButton extends StatelessWidget {
  const DarkModeButton({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = context.watch<DarkMode>();
    return TextButton(
      onPressed: darkMode.toggle,
      child: Text('dark mode: ${darkMode.value}'),
    );
  }
}

class Counter extends ValueNotifier<int> {
  Counter() : super(0) {
    print(runtimeType);
  }

  void increment() {
    value += 1;
  }
}

class InitialCounterView extends StatelessWidget {
  const InitialCounterView({super.key});

  @override
  Widget build(BuildContext context) {
    print(runtimeType);
    return SimpleProvider.value(
      value: 'initial counter value: ${context.read<Counter>().value}',
      child: const Console(),
    );
  }
}

class CurrentCounterView extends StatelessWidget {
  const CurrentCounterView({super.key});

  @override
  Widget build(BuildContext context) {
    print(runtimeType);
    return SimpleProvider.value(
      value: 'current counter value: ${context.watch<Counter>().value}',
      child: const Console(),
    );
  }
}

class Console extends StatelessWidget {
  const Console({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(context.watch<String>());
  }
}
