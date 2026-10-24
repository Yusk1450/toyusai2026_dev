/***************************************************
  名前: 稲友祭2026「IT×お化け屋敷」照明
****************************************************/

#define LIGHT_1_PIN 26
#define LIGHT_2_PIN 27

void setup()
{
  Serial.begin(9600);

  pinMode(LIGHT_1_PIN, OUTPUT);
  pinMode(LIGHT_2_PIN, OUTPUT);

  digitalWrite(LIGHT_1_PIN, HIGH);
  digitalWrite(LIGHT_2_PIN, HIGH);

  Serial.println("Initializing complete");
}

void loop()
{
  // OscWiFi.update();
}

// void onOscLightOn(const OscMessage& m) {
//   digitalWrite(LIGHT_1_PIN, HIGH);
//   digitalWrite(LIGHT_2_PIN, HIGH);
// }

// void onOscLightOff(const OscMessage& m) {
//   digitalWrite(LIGHT_1_PIN, LOW);
//   digitalWrite(LIGHT_2_PIN, LOW);
// }

