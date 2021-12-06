#include <LiquidCrystal.h>

LiquidCrystal lcd(13, 12, 5, 4, 3, 2);

// API declration
const String ssid = "Simulator Wifi";
const String password = "";
const String host = "api.thingspeak.com";
const int httpPort = 80;
const String uriSmartAc = "/channels/1585831/fields/2.json?api_key=X0TQ0ZX91GVO379D&results=1";
const String uriSmartTv = "/channels/1585831/fields/4.json?api_key=X0TQ0ZX91GVO379D&results=1";
const String uriSmartLight = "/channels/1585831/fields/3.json?api_key=X0TQ0ZX91GVO379D&results=1";
const String uriTemperature = "/update?api_key=EALW984ZAPWOAW0L&field1=";

// Hardware Pin constants
const int RED = 11;
const int BLUE = 10;
const int GREEN = 9;
const int MOTOR = 8;
const int LIGHTBULB = 7;
const int TEMPSENSOR = A0;

// Components stats
bool tvStatus = false;
bool acStatus = false;
bool lightStatus = false;

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

void setup()
{
    Serial.begin(9600);

    setupESP8266();
    lcd.begin(16, 2);
    pinMode(RED, OUTPUT);
    pinMode(BLUE, OUTPUT);
    pinMode(GREEN, OUTPUT);
    pinMode(MOTOR, OUTPUT);
    pinMode(LIGHTBULB, OUTPUT);
    pinMode(TEMPSENSOR, INPUT);
}

// smart Tv looping setup

void switchTVState()
{
    if (tvStatus)
    {
        Serial.println("Tv is ON");
        analogWrite(RED, 255);
        delay(500);
        analogWrite(RED, 255), analogWrite(GREEN, 70);
        delay(500);
        analogWrite(RED, 255), analogWrite(GREEN, 255), analogWrite(BLUE, 0);
        delay(500);
        analogWrite(RED, 127), analogWrite(GREEN, 255), analogWrite(BLUE, 0);
        delay(500);
        analogWrite(RED, 0), analogWrite(GREEN, 255), analogWrite(BLUE, 0);
        delay(500);
        analogWrite(RED, 0), analogWrite(GREEN, 255), analogWrite(BLUE, 127);
        delay(500);
        analogWrite(RED, 0), analogWrite(GREEN, 255), analogWrite(BLUE, 255);
        delay(500);
        analogWrite(RED, 0), analogWrite(GREEN, 127), analogWrite(BLUE, 255);
        delay(500);
        analogWrite(RED, 0), analogWrite(GREEN, 0), analogWrite(BLUE, 255);
        delay(500);
        analogWrite(RED, 127), analogWrite(GREEN, 0), analogWrite(BLUE, 255);
        delay(500);
        analogWrite(RED, 255), analogWrite(GREEN, 0), analogWrite(BLUE, 255);
        delay(500);
        analogWrite(RED, 255), analogWrite(GREEN, 0), analogWrite(BLUE, 127);
        delay(500);
    }
    else
    {
        Serial.println("TV if OFF");
        analogWrite(RED, 0);
        analogWrite(BLUE, 0);
        analogWrite(GREEN, 0);
    }
}

void switchACState()
{
    if (acStatus)
    {
        Serial.println("AC is running");
        digitalWrite(MOTOR, HIGH);
    }
    else
    {
        Serial.println("Ac is not running");
        digitalWrite(MOTOR, LOW);
    }
}

void switchLIGHTState()
{
    if (lightStatus)
    {
        Serial.println("Light is ON");
        digitalWrite(LIGHTBULB, HIGH);
    }
    else
    {
        Serial.println("Light is OFF");
        digitalWrite(LIGHTBULB, LOW);
    }
}

// Send POST request from the API

int thingspeakPost(float value)
{

    String httpPacket = "GET " + uriTemperature + "'" + String(value) + "'" + " HTTP/1.1\r\nHost: " + host + "\r\n\r\n";
    const int length = httpPacket.length();
    Serial.println("\n....Sending......\n" + httpPacket + "\n");

    Serial.print("AT+CIPSEND=");
    Serial.println(length);
    delay(10);

    Serial.print(httpPacket);
    delay(20);
    if (!Serial.find("SEND OK\r\n"))
        return 1;
    return 0;
}

float getTemperature()
{
    float vout = analogRead(TEMPSENSOR);
    vout = map(((analogRead(A0) - 20) * 3.04), 0, 1023, -40, 125);

    int returnStatus = thingspeakPost(vout);
    if (returnStatus == 1)
        Serial.println("\n..Sending data Failed\n");
    else
        Serial.println("\n..Sending data success\n");
    return vout;
}

// Send GET request to the API with given
// HTTP packet

int getRequest(String uri, char *field)
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
    int on = s.indexOf("ON");
    int off = s.indexOf("OFF");
    Serial.println(s);
    if (on != -1)
        return 1;
    if (off != -1)
        return 0;
    return -1;
}

void checkAC()
{
    Serial.println("\n....Checking AC state....\n");

    int state = getRequest(uriSmartAc, "\"feeds\":");
    if (state == -1)
        return;
    Serial.println(state);
    acStatus = (state == 1 ? true : false);
    Serial.println("done");
}
void checkTV()
{
    Serial.println("\n....Checking TV state....\n");

    int state = getRequest(uriSmartTv, "\"feeds\":");
    if (state == -1)
        return;
    Serial.println(state);
    tvStatus = (state == 1 ? true : false);
    Serial.println("done");
}

void checkLight()
{
    Serial.println("\n....Checking Light state....\n");

    int state = getRequest(uriSmartLight, "\"feeds\":");
    if (state == -1)
        return;
    Serial.println(state);
    lightStatus = (state == 1 ? true : false);
    Serial.println("done");
}

void loop()
{
    checkTV();
    checkAC();
    checkLight();

    switchTVState();
    switchACState();
    switchLIGHTState();
    float tempC = getTemperature();
    lcd.setCursor(0, 0);
    lcd.print("Temp In C = ");
    lcd.print(tempC);
    delay(1000);
}
