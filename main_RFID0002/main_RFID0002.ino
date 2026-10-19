# include <ArduinoOSCWiFi.h>
# include <SPI.h>
# include <MFRC522.h>

# define RST_PIN   22  
# define SS_PIN    25  
# define MISO_PIN  33 
# define MOSI_PIN  19 
# define SCK_PIN   21 

MFRC522 mfrc522(SS_PIN, RST_PIN);  // Create MFRC522 instance


const char* ssid = "L305";
const char* pwd = "4dp_1450";
const IPAddress ip(192,168,2,2); // M5のIPアドレス
const IPAddress gateway(192,168,2,1);// ルーター
const IPAddress subnet(255,255,255,0);

//↓はピリオド！！
const char* host = "192.168.2.184"; //macのIPアドレス
const int recv_port = 5555;

// unsigned long go;

// void onOscReceived(const OscMessage& m){
//   int val = m.arg<int>(0);

//   Serial.println("bbb");

//   Serial.println(val);
// }


void setup() {
  // put your setup code here, to run once:
  Serial.begin(115200);
  
  // RFID関係
  while (!Serial);        // Do nothing if no serial port is opened (added for Arduinos based on ATMEGA32U4)
  SPI.begin(SCK_PIN, MISO_PIN, MOSI_PIN);
  mfrc522.PCD_Init();        // Init MFRC522
  delay(4);                // Optional delay. Some board do need more time after init to be ready, see Readme
  Serial.println("Hello!!");
  mfrc522.PCD_DumpVersionToSerial();    // Show details of PCD - MFRC522 Card Reader details
  Serial.println(F("Scan PICC to see UID, SAK, type, and data blocks..."));

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


    // OscWiFi.subscribe(recv_port,"/callback",onOscReceived);
    OscWiFi.send(host,recv_port,"/reply",100,200,300);
    Serial.println("aaa");

    // go = millis();


}

void loop() {
  // put your main code here, to run repeatedly:
  OscWiFi.update();
    // OscWiFi.send(host,recv_port,"/reply",100,200,300);
  // Reset the loop if no new card present on the sensor/reader. This saves the entire process when idle.
    if ( ! mfrc522.PICC_IsNewCardPresent()) {
        return; //
    }

    // Select one of the cards
    if ( ! mfrc522.PICC_ReadCardSerial()) {
        return;
    }

  // if((millis() - go) > 1000){
  // }

 
    // Dump debug info about the card; PICC_HaltA() is automatically called
    mfrc522.PICC_DumpToSerial(&(mfrc522.uid)); //シリアル通信で全ての情報を送信

    //UIDを文字列に変換
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
