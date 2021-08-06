import 'package:flutter/material.dart';

// ignore: must_be_immutable
class QuantityIcon extends StatefulWidget {
  QuantityIcon({
    Key key,
    @required this.amount,
    @required this.maxAmount,
    @required this.setter,
  }) : super(key: key);
  int amount;
  int maxAmount;
  Function setter;
  @override
  _QuantityIconState createState() => _QuantityIconState();
}

class _QuantityIconState extends State<QuantityIcon> {
  @override
  Widget build(BuildContext context) {
    bool addButtonState = (widget.amount < widget.maxAmount);
    bool removeButtonState = (widget.amount > 1);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          width: 35,
          height: 35,
          decoration: BoxDecoration(
            border: Border.all(
              color: widget.amount == 1
                  ? Color.fromARGB(255, 66, 66, 66)
                  : Theme.of(context).primaryColor,
            ),
            borderRadius: BorderRadius.circular(5),
            color: widget.amount == 1
                ? Color.fromARGB(255, 66, 66, 66)
                : Theme.of(context).primaryColor,
          ),
          child: Center(
            child: IconButton(
              splashColor: removeButtonState
                  ? ThemeData().splashColor
                  : Colors.transparent,
              enableFeedback: removeButtonState,
              highlightColor: removeButtonState
                  ? ThemeData().highlightColor
                  : Colors.transparent,
              icon: const Icon(
                Icons.remove,
                color: Colors.white,
                size: 18,
              ),
              onPressed: () {
                if (widget.amount > 1) {
                  setState(() {
                    removeButtonState = true;
                    addButtonState = true;
                    widget.amount--;
                    widget.setter(widget.amount);
                  });
                  if (widget.amount == 1) {
                    setState(() {
                      removeButtonState = false;
                    });
                  }
                }
              },
            ),
          ),
        ),
        Text(
          widget.amount.toString(),
          style: const TextStyle(
            fontSize: 24,
            color: Colors.black,
          ),
        ),
        Container(
          width: 35,
          height: 35,
          decoration: BoxDecoration(
            border: Border.all(
              color: widget.amount == widget.maxAmount
                  ? Color.fromARGB(255, 66, 66, 66)
                  : Theme.of(context).primaryColor,
            ),
            borderRadius: BorderRadius.circular(5),
            color: widget.amount == widget.maxAmount
                ? Color.fromARGB(255, 66, 66, 66)
                : Theme.of(context).primaryColor,
          ),
          child: Center(
            child: IconButton(
              splashColor:
                  addButtonState ? ThemeData().splashColor : Colors.transparent,
              enableFeedback: addButtonState,
              highlightColor: addButtonState
                  ? ThemeData().highlightColor
                  : Colors.transparent,
              icon: const Icon(
                Icons.add,
                color: Colors.white,
                size: 18,
              ),
              onPressed: () {
                if (widget.amount < widget.maxAmount) {
                  setState(() {
                    removeButtonState = true;
                    widget.amount++;
                    widget.setter(widget.amount);
                  });
                  if (widget.amount == widget.maxAmount) {
                    setState(() {
                      addButtonState = false;
                    });
                  }
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
