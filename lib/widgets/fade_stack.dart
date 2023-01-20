import 'package:flutter/material.dart';
import 'package:practiceinsta/widgets/sign_in_form.dart';
import 'package:practiceinsta/widgets/sign_up_form.dart';

class FadeStack extends StatefulWidget {
  const FadeStack({Key? key, required this.selectedForm}) : super(key: key);
  final int selectedForm;

  @override
  State<FadeStack> createState() => _FadeStackState();
}

class _FadeStackState extends State<FadeStack> with SingleTickerProviderStateMixin  {

  late AnimationController _animationController;
  List<Widget> forms = [SignUpForm(), SignInForm()];

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _animationController.forward();
    super.initState();
  }
  @override
  void didUpdateWidget(covariant FadeStack oldWidget) {
    // TODO: implement didUpdateWidget
    if(widget.selectedForm != oldWidget.selectedForm)
    {
      _animationController.forward(from : 0.0);
    }
    super.didUpdateWidget(oldWidget);
  }
  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationController,
      child: IndexedStack(
        index: widget.selectedForm,
        children: forms,
      ),
    );
  }
}
