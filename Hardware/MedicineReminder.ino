#include <LiquidCrystal.h>
#include <Servo.h>

LiquidCrystal lcd(9, 8, 5, 4, 3, 2);

Servo servo_1;
Servo servo_2;
Servo servo_3;

const int buzzer = 10;

String ssid = "Simulator Wifi";     // SSID to connect to
String password = "";               // Our virtual wifi has no password (so dont do your banking stuff on this network)
String host = "api.thingspeak.com"; // Open Weather Map API
const int httpPort = 80;
String screenUrl = "/channels/1545251/fields/1.json?api_key=19MF3JMGCMXMUD2G&results=1";
String ringUrl = "/channels/1524140/fields/1.json?api_key=LHB2K2PZD2VM34MO&results=1";

int setupESP8266(void)
{
    // Start our ESP8266 Serial Communication
    Serial.begin(115200);
    Serial.println("AT");
    delay(10);
    if (!Serial.find("OK"))
        return 1;

    Serial.println("AT+CWJAP=\"" + ssid + "\",\"" + password + "\"");
    delay(10);

    if (!Serial.find("OK"))
        return 2;
    Serial.println("AT+CIPSTART=\"TCP\",\"" + host + "\"," + httpPort);
    delay(50);

    if (!Serial.find("OK"))
        return 3;
    return 0;
}

String getScreenData(String uri, char *field)
{
    String httpPacket3 = "GET " + uri + " HTTP/1.1\r\nHost: " + host + "\r\n\r\n";
    int length3 = httpPacket3.length();

    Serial.print("AT+CIPSEND=");
    Serial.println(length3);
    delay(10);

    Serial.print(httpPacket3);
    delay(10);

    while (!Serial.available())
        delay(5);
    String s = "";
    if (Serial.find("\r\n\r\n"))
    {
        delay(5);

        unsigned int i = 0;

        while (!Serial.find(field))
        {
        }

        bool ok = false;
        while (i < 60000)
        {
            if (Serial.available())
            {
                char c = Serial.read();
                s += c;
            }
            i++;
        }
    }
    int start = s.indexOf("zz");
    int end = s.lastIndexOf("zz");
    Serial.println(s);
    String time = "";
    for (int i = start + 2; i <= end; ++i)
    {
        time += s[i];
    }
    return time;
}

int checkRingStatus(String uri, char *field)
{
    String httpPacket3 = "GET " + uri + " HTTP/1.1\r\nHost: " + host + "\r\n\r\n";
    int length3 = httpPacket3.length();

    Serial.print("AT+CIPSEND=");
    Serial.println(length3);
    delay(10);

    Serial.print(httpPacket3);
    delay(10);

    while (!Serial.available())
        delay(5);
    String s = "";
    if (Serial.find("\r\n\r\n"))
    {
        delay(5);

        unsigned int i = 0;

        while (!Serial.find(field))
        {
        }

        bool ok = false;
        while (i < 60000)
        {
            if (Serial.available())
            {
                char c = Serial.read();
                s += c;
            }
            i++;
        }
    }
    int a = s.indexOf("Bacterial");
    int b = s.indexOf("Viral");
    int c = s.indexOf("Other");
    Serial.println(s);
    if (a != -1)
        return 1;
    if (b != -1)
        return 2;
    if (c != -1)
        return 3;
    return 0;
}

void setup()
{
    setupESP8266();
    lcd.begin(16, 2);

    pinMode(buzzer, OUTPUT);
    pinMode(A0, OUTPUT);
    pinMode(A1, OUTPUT);
    pinMode(A2, OUTPUT);

    servo_1.attach(13);
    servo_2.attach(12);
    servo_3.attach(11);
}

void loop()
{

    servo_1.write(0);
    servo_2.write(0);
    servo_3.write(0);

    lcd.setCursor(0, 0);
    lcd.print("Medicine");
    lcd.print("Dispenser");
    delay(5000);

    lcd.clear();

    delay(1000);
    String time = getScreenData(screenUrl, "\"feeds\":");
    lcd.print("NextCyle = " + time);
    delay(5000);
    lcd.clear();

    int value = checkRingStatus(ringUrl, "\"feeds\":");
    if (value == 1)
    {
        digitalWrite(A0, HIGH); // Green light on
        servo_1.write(90);
        servo_2.write(0);
        servo_3.write(0);
        tone(buzzer, 500); // Send 1KHz sound signal...
        delay(1000);       // ...for 1 sec
        noTone(buzzer);    // Stop sound...
        delay(1000);       // ...for 1sec
        tone(buzzer, 500); // Send 1KHz sound signal...
        delay(1000);       // ...for 1 sec
        noTone(buzzer);

        digitalWrite(A0, LOW); //Green Light Off
        lcd.clear();
        servo_1.write(0);
        servo_2.write(0);
        servo_3.write(0);
    }

    if (value == 2)
    {

        // SECOND CYCLE
        digitalWrite(A1, HIGH); //Blue Light On

        servo_1.write(0); //TEST
        servo_2.write(90);
        servo_3.write(0);
        tone(buzzer, 500); // Send 1KHz sound signal...
        delay(1000);       // ...for 1 sec
        noTone(buzzer);    // Stop sound...
        delay(1000);       // ...for 1sec
        tone(buzzer, 500); // Send 1KHz sound signal...
        delay(1000);       // ...for 1 sec
        noTone(buzzer);    // Stop sound...

        digitalWrite(A1, LOW); //Blue Light Off
        lcd.clear();
        servo_1.write(0);
        servo_2.write(0);
        servo_3.write(0);
    }

    if (value == 3)
    {

        digitalWrite(A2, HIGH); //Red Light On

        servo_1.write(0); //TEST
        servo_2.write(0);
        servo_3.write(90);
        tone(buzzer, 500); // Send 1KHz sound signal...
        delay(1000);       // ...for 1 sec
        noTone(buzzer);    // Stop sound...
        delay(1000);       // ...for 1sec
        tone(buzzer, 500); // Send 1KHz sound signal...
        delay(1000);       // ...for 1 sec
        noTone(buzzer);    // Stop sound...

        digitalWrite(A2, LOW); //Red Light Off
        lcd.clear();
        servo_1.write(0);
        servo_2.write(0);
        servo_3.write(0);
    }

    delay(2000); // Wait for 2000 millisecond(s)
}