import 'package:flutter/material.dart';

class AlternativeHomeButtonWidget extends StatelessWidget {
  final IconData? icon;
  final String buttonName;
  final String? image;
  final VoidCallback? onPressed;
  final Color? color;

  const AlternativeHomeButtonWidget({
    Key? key,
    this.icon,
    required this.buttonName,
    this.onPressed,
    this.color,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.blueGrey,
      borderRadius: BorderRadius.circular(15.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(15.0),
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 2.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                constraints: const BoxConstraints(
                  minHeight: 58.0,
                  maxHeight: 174.0,
                  minWidth: 58.0,
                  maxWidth: 174.0,
                ),
                width: MediaQuery.of(context).size.width / 7,
                height: MediaQuery.of(context).size.width / 7,
                /*decoration: BoxDecoration(
                  color: onPressed == null
                      ? Colors.grey
                      : color ?? CustomColorTheme.primaryColor.shade500,
                  borderRadius: BorderRadius.circular(20.0),
                ),*/
                child: (icon == null)
                    ? Align(
                        child: SizedBox.square(
                          dimension: 50,
                          child: Image.asset(
                            image!,
                          ),
                        ),
                      )
                    : Icon(
                        icon,
                        size: () {
                          int vezes = MediaQuery.of(context).size.width ~/ 100;
                          return 13.0 * vezes;
                        }.call(),
                        color: Colors.white.withOpacity(0.9),
                      ),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Flexible(
                child: Text(
                  buttonName,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: () {
                          int vezes = MediaQuery.of(context).size.width ~/ 100;
                          return 5.0 * vezes;
                        }.call(),
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
