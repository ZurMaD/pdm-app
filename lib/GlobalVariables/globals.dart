library bmi.globals;

import 'dart:ffi';

enum Gender {
  Male,
  Female,
}
int age = 18;

bool buttonPressed = false;
bool loopActive = false;
int weight = 50;

int heightCal = 170;
double minHeight = 120;
double maxHeight = 220;
bool isCentSelected = true;

Gender selectedGender;
bool isSwitched = false;
dynamic isDarkTheme = false;
String themeLabel = "Dark Mode";

int feetValue = 4;
String inchValue = '8"';
String selectedChoice = "Centimetre";

String aboutBMI =
    "MedicPUCP SensorKIT es una aplicación que brinda información sobre los últimas cifras que los sensores de signos vitales envían a nuestros servidores. Además muestra notificacione y el historial correspondiente.";
String mailTo =
    '''mailto:pablo.dzv@gmail.com?subject=Comentarios-Sugerencias MedicPUCP App''';
