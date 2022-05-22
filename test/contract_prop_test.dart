import 'package:contract_prop/contract_prop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('default contract', (tester) async {
    await tester.pumpWidget(testableApp(const ContractText()));
    expect(find.text('foo bar'), findsOneWidget);
  });

  testWidgets('override contract', (tester) async {
    await tester.pumpWidget(testableApp(
      const ContractScope(
        contracts: [
          LabelContract(name: 'foo baz'),
        ],
        child: ContractText(),
      ),
    ));
    expect(find.text('foo baz'), findsOneWidget);
  });

  testWidgets('override contract, contract not found', (tester) async {
    await tester.pumpWidget(testableApp(
      const ContractScope(
        contracts: [],
        child: ContractText(),
      ),
    ));
    expect(find.text('foo bar'), findsOneWidget);
  });

  testWidgets('contract ignore', (tester) async {
    await tester.pumpWidget(testableApp(
      const ContractScope(
        contracts: [
          LabelContract(name: 'foo baz'),
        ],
        child: ContractIgnore(child: ContractText()),
      ),
    ));
    expect(find.text('foo bar'), findsOneWidget);
  });
}

Widget testableApp(Widget child) {
  return MaterialApp(home: Scaffold(body: child));
}

class ContractText extends StatelessWidget {
  final String? text;

  const ContractText({Key? key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContractPropBuilder<LabelContract>(
      contract: const LabelContract(),
      builder: (_, contract) => Text(
        text ?? contract.label.value(context) ?? '',
      ),
    );
  }
}

class LabelContract with ContractInterface {
  final String name;

  const LabelContract({this.name = 'foo bar'});

  ContractProp<String> get label => ContractProp<String>(contract: (_) => name);
}
