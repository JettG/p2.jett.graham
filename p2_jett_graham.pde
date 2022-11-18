//objects
UIWidget mirrorGlass;
UIWidget botThird;
UIWidget topThird;
UIWidget buttonBar;
UIWidget button1;
UIWidget button2;
UIWidget button3;
UIWidget button4;
UIWidget button5;
UIWidget calendar;
UIWidget weather;
UIWidget fitness;
UIWidget sleep;
UIWidget settings;

//global vars
boolean startupBool = true;
PFont sourceBold;
PFont sourceBlack;
PFont sourceItalic;
PFont sourceMed;
Table events;
Table news;
Table forecast;
int timerMillisecs;
int timerSeconds;
int timerMinutes;
int userWeight = int(random(80,300));
  
void setup() {
  
  //load tables from csv files
  events = loadTable("events.csv", "header");
  news = loadTable("news.csv", "header");
  forecast = loadTable("weather.csv", "header");
  
  int masterWidth = 600;
  int masterHeight = 800;
  float mirrorWidth = masterWidth*0.8;    // 480p
  float mirrorHeight = masterHeight*0.92; // 736p
  float barYPos = 718;
  float bottomYPos = 477; //this is eyeballed
  float topYPos = 160; //eyeballed
  float topHeight = (686)/3; // 228.6p
  float botHeight = 380;
  float barWidth = mirrorWidth-30;
  float barHeight = mirrorHeight*0.1;
  float button1X = 120;
  float buttonWidth = ((barWidth-20)/5)-4;
  float buttonHeight = barHeight-4;
  
  
  sourceBold = createFont("SourceCodePro-Bold.ttf",16,true); //headers
  sourceBlack = createFont("SourceCodePro-Black.ttf",16,true); //text1
  sourceItalic = createFont("SourceCodePro-Italic.ttf",16,true); //text2
  sourceMed = createFont("SourceCodePro-Medium.ttf",16,true); //stopwatch
 
  size(600, 800);
  background(220);
  strokeWeight(4);
  
  //drawing widgets
  mirrorGlass = new UIWidget(masterWidth/2,masterHeight/2,mirrorWidth,mirrorHeight,180,120,false,false);
  botThird = new UIWidget(masterWidth/2,bottomYPos,barWidth,botHeight,160,160,false,false);
  topThird = new UIWidget(masterWidth/2,topYPos,barWidth,topHeight,160,160,false,false);
  buttonBar = new UIWidget(masterWidth/2,barYPos,barWidth,barHeight,120,120,false,false);
  button1 = new UIWidget(button1X,barYPos,buttonWidth,buttonHeight,160,160,true,false);
  button2 = new UIWidget(button1X+90,barYPos,buttonWidth,buttonHeight,160,160,true,false);
  button3 = new UIWidget(button1X+180,barYPos,buttonWidth,buttonHeight,160,160,true,false);
  button4 = new UIWidget(button1X+270,barYPos,buttonWidth,buttonHeight,160,160,true,false);
  button5 = new UIWidget(button1X+360,barYPos,buttonWidth,buttonHeight,160,160,true,false);
  calendar = new UIWidget(masterWidth/2,bottomYPos,barWidth,botHeight,120,120,false,true);
  weather = new UIWidget(masterWidth/2,bottomYPos,barWidth,botHeight,120,120,false,true);
  fitness = new UIWidget(masterWidth/2,bottomYPos,barWidth,botHeight,120,120,false,true);
  sleep = new UIWidget(masterWidth/2,bottomYPos,barWidth,botHeight,120,120,false,true);
  settings = new UIWidget(masterWidth/2,bottomYPos,barWidth,botHeight,120,120,false,true);
 
}

void draw() {
  
  timeDate();
  
  //mirror timer
 if (int(millis()/100)  % 10 != timerMillisecs){
    timerMillisecs++;   
  }
  if (timerMillisecs >= 10){
    timerMillisecs -= 10;
    timerSeconds++;
  }
  if (timerSeconds >= 60){
    timerSeconds -= 60;
    timerMinutes++;
  }
  
  fill(120);
  stroke(120);
  rectMode(CENTER);
  rect(478,70,80,35);
  rect(132,70,100,35);
  
  textFont(sourceMed,16);
  textAlign(CENTER);
  fill(255);
  stroke(255);
  
  text(userWeight + " lbs", 125, 74);
  
  text(nf(timerMinutes, 2) + ":" + nf(timerSeconds, 2) + "." + nf(timerMillisecs, 1) , 478, 74);
 
  startupBool = oneTimeSetup(startupBool); //run initial draw pass and change start flag to false
  update();
  
  //draw buttons
  button1.displayWidget(0);
  button2.displayWidget(0);
  button3.displayWidget(0);
  button4.displayWidget(0);
  button5.displayWidget(0);
  
}

//checks if mouse is over a button and updates flags as needed
void update() { 
  if (button1.overButton(button1.xpos,button1.ypos,button1.width,button1.height)){
    button1.buttonOver = true;
  } else {
    button1.buttonOver = false;
  }
  if (button2.overButton(button2.xpos,button2.ypos,button2.width,button2.height)){ 
    button2.buttonOver = true;
  } else {
    button2.buttonOver = false;
  }
  if (button3.overButton(button3.xpos,button3.ypos,button3.width,button3.height)){ 
    button3.buttonOver = true;
  } else {
    button3.buttonOver = false;
  }
  if (button4.overButton(button4.xpos,button4.ypos,button4.width,button4.height)){
    button4.buttonOver = true;
  } else {
    button4.buttonOver = false;
  }
  if (button5.overButton(button5.xpos,button5.ypos,button5.width,button5.height)){
    button5.buttonOver = true;
  } else {
    button5.buttonOver = false;
  }
}

void mousePressed() {
    
    if (button1.buttonHilight()){
      calendar.displayWidget(1);
      button2.buttonRevert();
      button3.buttonRevert();
      button4.buttonRevert();
      button5.buttonRevert();
    };
    if (button2.buttonHilight()){
      weather.displayWidget(2);
      button1.buttonRevert();
      button3.buttonRevert();
      button4.buttonRevert();
      button5.buttonRevert();
    };
    if (button3.buttonHilight()){
      fitness.displayWidget(3);
      button1.buttonRevert();
      button2.buttonRevert();
      button4.buttonRevert();
      button5.buttonRevert();
    };
    if (button4.buttonHilight()){
      sleep.displayWidget(4);
      button1.buttonRevert();
      button2.buttonRevert();
      button3.buttonRevert();
      button5.buttonRevert();
    };
    if (button5.buttonHilight()){
      settings.displayWidget(5);
      button1.buttonRevert();
      button2.buttonRevert();
      button3.buttonRevert();
      button4.buttonRevert();
    }; 
}

boolean oneTimeSetup(boolean mirrorStart){
  if(mirrorStart == true){
    mirrorGlass.displayWidget(0);
    //botThird.displayWidget(0);
    //midThird.displayWidget(0);
    //topThird.displayWidget(0);
    buttonBar.displayWidget(0);
  }
  return false;
}

void timeDate() {
  int day = day();
  int mon = month();
  int hr = hour();
  int min = minute();
  String minuteString;
  
  if(min < 9) {
    minuteString = "0"+min;
  }
  else {
    minuteString = str(min);
  }
  
  String currentTime;  
  boolean am = false;
  if(hr < 12){
  am = true;
  }
  
  String[] monthsArray = {"January","February","March","April","May","June","July",
  "August","September","October","November","December"};
                           
  String currentDate = monthsArray[mon-1] + " " + day;
  println(currentDate);
  
  if(am == true){
    currentTime = hr + ":" + minuteString + " A.M.";
  } else {
    currentTime = hr + ":" + minuteString + " P.M.";
  }
  println(currentTime);
  
  //background box
  fill(120);
  stroke(120);
  rectMode(CENTER);
  rect(300,165,160,60);
  
  //clock
  textFont(sourceBold,24);
  textAlign(CENTER);
  fill(255);
  stroke(255);
  text(currentDate,300,168);
  
  textFont(sourceItalic,18);
  text(currentTime,300,193);
}

class UIWidget{
  
  float xpos;
  float ypos;
  float width;
  float height;
  float titleY = 322;
  float box1X = 188;
  float eventX = box1X - 100;
  float boxY = 477;
  
  color borderColor;
  color fillColor;
  color weatherCold = color(211,234,242);
  color weatherHot = color(252,219,212);
  boolean isButton; //for interactive widgets
  boolean buttonOver; //is the mouse over the widget?
  boolean isPressed; //for button widgets
  boolean specialWidget; //e.g. calendar, settings, etc
  char degrees = '°';
  
  PImage iconCalendar = loadImage("iconCalendar.png");
  PImage iconWeather = loadImage("iconWeather.png");
  PImage iconFitness = loadImage("iconFitness.png");
  PImage iconSleep = loadImage("iconSleep.png");
  PImage iconSettings = loadImage("iconSettings.png");
  PImage iconPower = loadImage("iconPower.png");
  
  String[] eventNames = new String[4];
  String[] eventTimes = new String[4];
  String[] newsHeadlines = new String[4];
  String[] newsOutlets = new String[4];
  String[] weatherDay = new String[7];
  String[] weatherForecast = new String[7];
  String[] weatherHigh = new String[7];
  String[] weatherLow = new String[7];
  
  //constructor
  UIWidget(float tempX, float tempY, float tempWidth, float tempHeight, color tempBorder, color tempFill, boolean tempButton, boolean spec){
  xpos = tempX;
  ypos = tempY;
  width = tempWidth;
  height = tempHeight;
  borderColor = tempBorder;
  fillColor = tempFill;
  isButton = tempButton;
  specialWidget = spec;
  }
  
  void displayWidget(int widgetType) {
    rectMode(CENTER);
    stroke(borderColor);
    fill(fillColor);
    rect(xpos,ypos,width,height);
    if(widgetType != 0) widgetAction(widgetType); //0 means no widget action
    
    //drawing button icons
    imageMode(CENTER);
    image(iconCalendar,120,718,90,73);
    image(iconWeather,210,718,60,49);
    image(iconFitness,300,718,60,49);
    image(iconSleep,390,718,60,49);
    image(iconPower,480,718,60,49);
  }
  
  void widgetAction(int type) {
    if(specialWidget == true){ //this function does nothing if this is false
      switch(type) {
      case 1: //calendar
        drawCalendar();
        break;
      case 2: //weather
        drawWeather();
        break;
      case 3: //fitness
        drawFitness();
        break;
      case 4: //sleep
        drawSleep();
        break;
      case 5: //power
        powerOff();
        break;
      }
    }
  }
  
  void drawCalendar(){
            
    float eventY = 357;
    float timeY = 372;
    float newsX = xpos + 15;
    float headlineY = 358;
    float outletY = 354;
    
    textFont(sourceBold,16);
    stroke(140);
    fill(140);  
    
    fill(255);
    textAlign(LEFT);
    text("Today's Events",eventX,boxY-155);
    stroke(255);
    strokeWeight(2);
    line(eventX,boxY-142,eventX+200,boxY-142);
    line(eventX+223,boxY-142,eventX+423,boxY-142);
    strokeWeight(4);
    text("News",newsX,boxY-155);
    
    textAlign(LEFT);
    //fill arrays with data from events.csv
    for (TableRow row : events.rows()) {

      int id = row.getInt("id");
      eventNames[id] = row.getString("name");
      eventTimes[id] = row.getString("time");
      
      textFont(sourceBlack,12);
      println(eventNames[id]);
      text(eventNames[id],eventX,eventY);
      
      textFont(sourceItalic,12);
      println(eventTimes[id]);
      text(eventTimes[id],eventX,timeY);
      
      timeY = timeY + 55;
      eventY = eventY + 55;
      
    }
    
    //fill arrays with data from news.csv
    for (TableRow row : news.rows()) {

      int id = row.getInt("id");
      newsHeadlines[id] = row.getString("headline");
      newsOutlets[id] = row.getString("outlet");
      
      textFont(sourceBlack,12);
      println(newsHeadlines[id]);
      rectMode(CORNER);
      text(newsHeadlines[id],newsX,headlineY,200,40);
      
      textFont(sourceItalic,12);
      println(newsOutlets[id]);
      
      text(newsOutlets[id],newsX,outletY);
      headlineY = headlineY + 70;
      outletY = outletY + 70;
       
    }
    rectMode(CENTER);
  }
  
  void drawWeather(){
    
    //local vars    
    float weatherY = titleY+50;
    float weatherX = 110;
    
    //text formatting
    textFont(sourceBold,16);
    stroke(255);
    fill(255);
    
    //title formatting
    textAlign(CENTER);
    text("Weekly Forecast",xpos,titleY);
    textAlign(LEFT);
    
    for (TableRow row : forecast.rows()) {

      int id = row.getInt("id");
      weatherDay[id] = row.getString("day");
      weatherForecast[id] = row.getString("forecast");
      weatherHigh[id] = row.getString("high");
      weatherLow[id] = row.getString("low");
      
      textFont(sourceBlack,12);
      println(weatherDay[id]);
      text(weatherDay[id],weatherX,weatherY);
      
      textFont(sourceItalic,12);
      println(weatherForecast[id]);
      text(weatherForecast[id],weatherX+140,weatherY);
      
      textFont(sourceBlack,12);
      println(weatherHigh[id]);
      fill(weatherHot); //light red for high temps
      text(weatherHigh[id]+degrees,weatherX+300,weatherY);
      
      textFont(sourceBlack,12);
      println(weatherLow[id]);
      fill(weatherCold); //light blue for low temps
      text(weatherLow[id]+degrees,weatherX+350,weatherY);
      fill(255); //revert text color to white
      
      if(id != 6){ //no line drawn if last entry
      strokeWeight(1);
      line(weatherX,weatherY+16,weatherX+368,weatherY+16);
      strokeWeight(4);
      }
      
      weatherY = weatherY+40;      
    }
  }
  
  void drawFitness(){
    
    //float exerciseX = xpos+15;
    float stepRatio;
    float exerciseRatio;
    float plotXStart = 135;
    float eventX2 = 88;
    
    float[]dailySteps = new float[7];
    float[]dailyExTime = new float[7]; //minutes
    
    int todaySteps;
    int todayExTime;
    
    for (int i = 0; i < 7; i++) {
    dailySteps[i] = int(random(500,10000));
    dailyExTime[i] = int(random(0,300));
    println(dailySteps[i]+" steps");
    println(dailyExTime[i]+ "minutes");
    }
    
    todaySteps = int(dailySteps[6]);
    todayExTime = int(dailyExTime[6]);
    
    //header formatting
    textAlign(LEFT);
    textFont(sourceBold,16);
    stroke(255);
    fill(255);
    text("Steps",eventX2,boxY-155);
    text("Exercise Time",eventX2,boxY+15);
    strokeWeight(1);
    line(eventX2,boxY-145,eventX2+423,boxY-145);
    line(eventX2,boxY+25,eventX2+423,boxY+25);
    strokeWeight(4);
    
    //static text formatting
    textFont(sourceItalic,12);
    textAlign(RIGHT);
    text(todaySteps+" steps today",eventX2+420,boxY-155);
    text(todayExTime+" minutes today",eventX2+420,boxY+15);
    
    //graph rectangles
    fill(160);
    stroke(160);
    //rect(300,boxY-70,420,120);
    //rect(300,boxY+100,420,120);
    
    textFont(sourceItalic,10);
    textAlign(LEFT);
    fill(255);
    stroke(255);
    text("10000",eventX2+5,boxY-120);
    text("0",eventX2+5,boxY-12);
    text("300",eventX2+5,boxY+50);
    text("0",eventX2+5,boxY+158);
    
    //boxY = 477
    //step graph y pixel range: 355-460 (105 pixels)
    //circle(plotXStart,460,2);
    stepRatio = ((dailySteps[0])/10000)*105;
    float[] lastStepX = new float[7];
    float[] lastStepY = new float[7];
    
    for (int i = 0; i < 7; i++) {      
      stepRatio = ((dailySteps[i])/10000)*105;
      println(stepRatio);     
      strokeWeight(2);
      
      if(i != 0) {
        stroke(255);
        line(lastStepX[i-1],lastStepY[i-1],plotXStart,460-stepRatio);
      }
      
      strokeWeight(4);      
      fill(0);
      circle(plotXStart,460-stepRatio,6);      
      lastStepX[i] = plotXStart;
      lastStepY[i] = 460-stepRatio;   
      plotXStart = plotXStart + 55;      
    }
    
    plotXStart = 135;
    //boxY = 477
    //exercise graph y pixel range: 530-635 (105 pixels)
    //circle(plotXStart,635,2);
    exerciseRatio = ((dailyExTime[0])/300)*105;
    float[] lastExX = new float[7];
    float[] lastExY = new float[7];   
    
    for (int i = 0; i < 7; i++) {      
      exerciseRatio = ((dailyExTime[i])/300)*105;
      println(exerciseRatio);     
      strokeWeight(2);
      
      if(i != 0) {
        stroke(255);
        line(lastExX[i-1],lastExY[i-1],plotXStart,635-exerciseRatio);
      }
      
      strokeWeight(4);     
      fill(0);
      circle(plotXStart,635-exerciseRatio,6);     
      lastExX[i] = plotXStart;
      lastExY[i] = 635-exerciseRatio;   
      plotXStart = plotXStart + 55;      
    }
  }
  
  void drawSleep(){
    
  }
  
  //turn off the mirror
  void powerOff(){
    exit();
  }
  
  //change color to white to hilight clicked button
  boolean buttonHilight(){
    if(buttonOver == true){ //only do anything if button is clicked (this conditional may not be necessary since only button objects call this anyway)      
      fillColor = weatherCold;
      borderColor = 255;
      isPressed = true;
      return true;
    } else {
      return false;
    }
  }
  
  void buttonRevert(){
      isPressed = false;
      fillColor = 160;
      borderColor = 160;
  }
  
  boolean overButton(float xPos, float yPos, float width, float height){
    if (mouseX >= xPos-(width/2) && mouseX <= xPos + (width/2) && 
      mouseY >= yPos-(height/2) && mouseY <= yPos + (height/2)) {
    return true;
    } else {
    return false;
    }
  }

}
