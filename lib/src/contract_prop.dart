import 'package:flutter/widgets.dart';

typedef ContractHandler<T> = T? Function(BuildContext context);

/// Contract prop
///
/// [contract] prop value from contract
/// [defaultValue] (optional) default value for prop, used if [contract] return
/// nullable value
class ContractProp<T> {
  final ContractHandler<T> contract;
  final T? defaultValue;

  ContractProp({required this.contract, this.defaultValue});

  T? value(BuildContext context) {
    final val = contract(context);

    return val ?? defaultValue;
  }
}
