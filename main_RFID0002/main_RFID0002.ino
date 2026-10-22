# include <ArduinoOSCWiFi.h>
# include <SPI.h>
# include <MFRC522.h>

# define RST_PIN   22  
# define SS_PIN    25  
# define MISO_PIN  33 
# define MOSI_PIN  19 
# define SCK_PIN   21 

MFRC522 mfrc522(SS_PIN, RST_PIN);  // Create MFRC522 instance


const char* ssid = "Buffalo-G-F030";
const char* pwd = "4dp_1450";
const IPAddress ip(192,168,13,201);
const IPAddress gateway(192,168,13,1);
const IPAddress subnet(255,255,255,0);

//↓はピリオド！！
const char* host = "192.168.13.202";
const int recv_port = 5555;

void setup()
{
  Serial.begin(115200);
  
  // RFID関係
  while (!Serial);
  SPI.begin(SCK_PIN, MISO_PIN, MOSI_PIN);
  mfrc522.PCD_Init();
  delay(4);
  mfrc522.PCD_DumpVersionToSerial();

  delay(2000);

 //以降OSC関係
  #ifdef ESP_PLATFORM
    WiFi.disconnect(true,true);
    delay(1000);
    WiFi.mode(WIFI_STA);
  #endif
    WiFi.begin(ssid,pwd);
    WiFi.config(ip,gateway,subnet);
    while (WiFi.status() != WL_CONNECTED) {
      Serial.print(".");
      delay(500);
    }
    Serial.print("WiFi connected,IP = ");
    Serial.println(WiFi.localIP());
}

void loop()
{
    OscWiFi.update();
    if ( ! mfrc522.PICC_IsNewCardPresent()) {
        return; //
    }

    if ( ! mfrc522.PICC_ReadCardSerial()) {
        return;
    }
 
    mfrc522.PICC_DumpToSerial(&(mfrc522.uid));

  // UIDを文字列に変換
  String strBuf[mfrc522.uid.size];
  for (byte i = 0; i < mfrc522.uid.size; i++) {
    strBuf[i] =  String(mfrc522.uid.uidByte[i], HEX);
    if (strBuf[i].length() == 1) {
      strBuf[i] = "0" + strBuf[i];
    }
  }

  //UIDを変数に格納
  char mes1[9];
  snprintf(mes1,sizeof(mes1), "%02x%02x%02x%02x", mfrc522.uid.uidByte[0], mfrc522.uid.uidByte[1], mfrc522.uid.uidByte[2], mfrc522.uid.uidByte[3]);
  Serial.printf("UID: %s\n", mes1);

  OscWiFi.send(host, recv_port, "/reply", String(mes1)); //OSCでUIDのみを送信

  delay(1000);
}
