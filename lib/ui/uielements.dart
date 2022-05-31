import 'package:flutter/material.dart';

class UIElements {
  GoldenGradiant() {
    return LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      stops: [
        0.1,
        0.5,
      ],
      colors: [
        Color(0xffd1913c),
        Color(0xffffd194),
      ],
    );
  }

  CircleButtons({labletext, onPressed, isActive = false}) {
    return ElevatedButton(
      child: Text(
        labletext,
        style: TextStyle(
          color: isActive ? Colors.white : Color(0xffd1913c),
          fontSize: 25,
        ),
      ),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: isActive ? Color(0xffffd194) : Colors.white,
        shape: CircleBorder(), //<-- SEE HERE
        padding: EdgeInsets.all(10),
      ),
    );
  }

  TextStyleGen({fontSize = 20}) {
    return TextStyle(
      fontSize: fontSize * 1.0,
      color: Colors.redAccent,
    );
  }

  LanguageButton({lableText, onPressed}) {
    return ElevatedButton(
      child: Text(
        lableText,
        style: this.TextStyleGen(fontSize: 15),
      ),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.all(
            Radius.circular(20),
          ),
        ),
      ),
    );
  }

  Buttons({@required labletext, image, onPressed, fontsize = 20}) {
    return ElevatedButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            image,
            height: 40,
          ),
          Text(
            labletext,
            style: this.TextStyleGen(fontSize: fontsize),
          )
        ],
      ),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.all(
            Radius.circular(20),
          ),
        ),
      ),
    );
  }

  HomeButtons({@required labletext, onPressed, image}) {
    return Container(
        width: 240,
        height: 70,
        margin: EdgeInsets.all(10),
        child: this.Buttons(
          labletext: labletext,
          onPressed: onPressed,
          fontsize: 25,
          image: image,
        ));
  }
}
