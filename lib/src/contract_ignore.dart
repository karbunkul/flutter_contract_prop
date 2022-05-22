import 'package:flutter/widgets.dart';

/// Contract ignore
///
/// ignore contract from [ContractScope]
///
/// ```dart
///  const ContractIgnore(child: ContractText());
/// ```
class ContractIgnore extends StatelessWidget {
  final Widget child;

  const ContractIgnore({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
