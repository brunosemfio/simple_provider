import 'package:flutter/material.dart';
import 'package:simple_provider/simple_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Provider',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleProvider.value(
      value: 'increment',
      child: SimpleProvider(
        create: () => Counter(),
        child: Builder(
          builder: (context) {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    AppTitle(),
                    CounterView(),
                    IncrementButton(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class AppTitle extends StatelessWidget {
  const AppTitle({super.key});

  @override
  Widget build(BuildContext context) {
    print('build: $runtimeType');
    return const Text('title');
  }
}

class IncrementButton extends StatelessWidget {
  const IncrementButton({super.key});

  @override
  Widget build(BuildContext context) {
    print('build: $runtimeType');
    return TextButton(
      onPressed: context.read<Counter>().increment,
      child: Text(context.read<String>()),
    );
  }
}

class Counter extends ValueNotifier<int> {
  Counter() : super(0);

  void increment() {
    value += 1;
  }
}

class CounterView extends StatelessWidget {
  const CounterView({super.key});

  @override
  Widget build(BuildContext context) {
    print('build: $runtimeType');
    return Text('${context.watch<Counter>().value}');
  }
}
