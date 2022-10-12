import 'package:flutter/material.dart';
import 'package:mafia/theme.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({Key? key, this.icon, required this.onTap})
      : super(key: key);

  final Icon? icon;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Ink(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: Colors.white),

          // margin: const EdgeInsets.symmetric(vertical: 5),
          child: icon ?? const SizedBox()),
    );
  }
}

class MainButton extends StatelessWidget {
  const MainButton(
      {this.text,
      this.icon,
      super.key,
      this.color,
      required this.onTap,
      this.textStyle});

  final String? text;
  final IconData? icon;
  final Color? color;
  final Function onTap;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.5),
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: Ink(
          // margin: const EdgeInsets.symmetric(vertical: 5),
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(5)),
          width: double.infinity,
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              (Align(alignment: Alignment.center, child: Icon(icon))),
              Expanded(
                  child: Align(
                      alignment: Alignment.center,
                      child: Text(text ?? "", style: textStyle))),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomAnimatedCard extends StatefulWidget {
  const CustomAnimatedCard(
      {super.key, required this.text, required this.onClose});
  final String text;
  final Function onClose;
  @override
  State<CustomAnimatedCard> createState() => _CustomAnimatedCardState();
}

class _CustomAnimatedCardState extends State<CustomAnimatedCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
        duration: const Duration(milliseconds: 300),
        vsync: this,
        lowerBound: 0,
        upperBound: 15);
    _controller.forward();

    _controller.addListener(() => setState(() {}));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: _controller.value / 15,
      child: Container(
        margin: EdgeInsets.only(top: _controller.value),
        height: 50,
        child: Card(
          margin: EdgeInsets.zero,
          // padding: const EdgeInsets.symmetric(vertical: 5),
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Text(widget.text,
                        style: Theme.of(context).textTheme.titleSmall!)),
                CustomIconButton(
                  onTap: () {
                    widget.onClose();
                  },
                  icon: const Icon(Icons.close),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
