import 'package:contract_prop/contract_prop.dart';
import 'package:flutter/widgets.dart';

/// Contract scope
///
/// provides override contracts
///
/// [contracts] - list of override contracts
class ContractScope extends InheritedWidget {
  final List<ContractInterface> contracts;

  const ContractScope({
    Key? key,
    required this.contracts,
    required Widget child,
  }) : super(key: key, child: child);

  static ContractScope of(BuildContext context) {
    final ContractScope? result =
        context.dependOnInheritedWidgetOfExactType<ContractScope>();
    assert(result != null, 'No ContractScope found in context');
    return result!;
  }

  static ContractScope? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ContractScope>();
  }

  @override
  bool updateShouldNotify(ContractScope oldWidget) {
    return true;
  }
}
