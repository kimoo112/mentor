import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentor/logic/counter%20cubit/counter_cubit.dart';

class TestView extends StatefulWidget {
  const TestView({
    super.key,
  });

  @override
  State<TestView> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<TestView> {
  @override
  Widget build(BuildContext context) {
    final blocProvider = BlocProvider.of<CounterCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kimo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BlocBuilder<CounterCubit, CounterState>(
              builder: (context, state) {
                return Text(
                  blocProvider.countValue.toString(),
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    blocProvider.increaseValue();
                  },
                  tooltip: 'Increment',
                  child: const Icon(Icons.add),
                ),
                FloatingActionButton(
                  onPressed: (() {
                    blocProvider.decreaseValue();
                  }),
                  tooltip: 'decrement',
                  child: const Icon(Icons.minimize),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
