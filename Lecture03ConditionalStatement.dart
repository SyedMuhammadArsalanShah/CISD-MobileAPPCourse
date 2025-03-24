import 'dart:math';

void main() {
  String name = "SMAS";

  String email = "smas@gmail.com";
  String password = "1234";

  String emailLogin = "smas@gmail.com";
  String passwordLogin = "1234";

// if /else simple
  if (emailLogin == email && password == passwordLogin) {
    print("Account Successfully Login");

// nested If/ Else
    int number1 = -10;

    if (number1 > 0) {
      print("Positive");
    } else {
      print("Negative");
    }

    // if / else  ladder

    double eng, urdu, isl, obt, per;

    eng = 19;
    urdu = 10;
    isl = 40;

    obt = eng + urdu + isl;
    per = (obt / 300) * 100;
    print("Obatined Marks $obt ");
    print("Percentage ${per.toStringAsFixed(2)} % ");

    if (per <= 100 && per >= 80) {
      print("Grade A1");
    } else if (per <= 79 && per >= 70) {
      print("Grade A");
    } else if (per <= 69 && per >= 60) {
      print("Grade B");
    } else if (per <= 59 && per >= 50) {
      print("Grade C");
    } else if (per <= 49 && per >= 40) {
      print("IU Jaien");
    } else {
      print("ghar bethen");
    }


    int year = 2025;

    if (year % 4 == 0) {
      print("leap year");
    } else {
      print("is not a leap year");
    }
  } else {
    print("Incorrect Email Or  Password");
  }
}
