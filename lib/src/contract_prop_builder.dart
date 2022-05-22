import 'package:contract_prop/contract_prop.dart';
import 'package:flutter/widgets.dart';

typedef ContractBuilder<T> = Widget Function(
  BuildContext context,
  T contract,
);

/// Contract prop builder
///
/// used for get contract from scope or default contract [contract]
///
/// [contract] - default contract
/// [builder] - builder provide contract from [ContractScope] or default
/// contract
///
/// ```dart
///
/// class LabelContract with ContractInterface {
///   final String name;
///
///   LabelContract({this.name = 'foo bar'});
///
///   ContractProp<String> get label => ContractProp<String>(contract: (_) => name);
/// }
///
///
/// ContractPropBuilder<LabelContract>(
///   contract: LabelContract(),
///   builder: (_, contract) => Text(
///     text ?? contract.label.value(context) ?? '',
///   ),
/// );
/// ```
///
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
    /// skip contract from [ContractScope] if found [ContractIgnore] in tree
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
