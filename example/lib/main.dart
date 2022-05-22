import 'package:contract_prop/contract_prop.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (_, child) {
        return ContractScope(
          contracts: [
            LabelContract(name: 'Hello world'),
          ],
          child: child!,
        );
      },
      home: const Scaffold(body: Center(child: DemoPage())),
    );
  }
}

class ContractText extends StatelessWidget {
  final String? text;

  const ContractText({Key? key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContractPropBuilder<LabelContract>(
      contract: LabelContract(),
      builder: (_, contract) => Text(
        text ?? contract.label.value(context) ?? '',
      ),
    );
  }
}

class DemoPage extends StatelessWidget {
  const DemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ContractText();
  }
}

class LabelContract with ContractInterface {
  final String name;

  LabelContract({this.name = 'foo bar'});

  ContractProp<String> get label => ContractProp<String>(contract: (_) => name);
}

class CustomLabelContract extends LabelContract {
  @override
  ContractProp<String> get label => ContractProp(contract: (_) => 'custom');
}
