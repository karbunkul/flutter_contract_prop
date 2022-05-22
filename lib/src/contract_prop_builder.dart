import 'package:contract_prop/contract_prop.dart';
import 'package:flutter/widgets.dart';

typedef ContractBuilder<T> = Widget Function(
  BuildContext context,
  T contract,
);

class ContractPropBuilder<T> extends StatelessWidget {
  final ContractBuilder<T> builder;
  final T contract;

  const ContractPropBuilder({
    required this.builder,
    required this.contract,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (context.findAncestorWidgetOfExactType<ContractIgnore>() != null) {
      return builder(context, contract);
    }

    final contracts = ContractScope.maybeOf(context)?.contracts ?? [];

    final _contract = contracts.firstWhere(
      (element) => element is T,
      orElse: () => contract as ContractInterface,
    );

    return builder(context, _contract as T);
  }
}
