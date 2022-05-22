# contract_prop

Dependency Injection (DI) for widget properties, provide override contract from inherited scope.

## Getting started

Add package to your project ``` flutter pub add any_to_widget```

Implements ContractInterface for your contract. For example

```dart
class LabelContract with ContractInterface {
  final String name;

  LabelContract({this.name = 'foo bar'});

  ContractProp<String> get label => ContractProp<String>(contract: (_) => name);
}
```

Create widget, wrap your widget ContractPropBuilder

```dart
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
```

Override contracts

```dart

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
```

## Additional information

See tests for more example
