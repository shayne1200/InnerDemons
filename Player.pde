class Player
{
  float x, y;
  PImage [][] movement;
  PImage [][] attack;
  boolean inMotion; //Lets you know if character is moving or not
  boolean attacking; //Lets program know if player is attacking or not
  int currentDirection;
  float currentFrame;
  float currentFrame2;

  final int UP = 0, LEFT = 1, DOWN = 2, RIGHT =3;

  Player()
  {
    inMotion = false;
    attacking = false;
    currentDirection=3;
    currentFrame=3;
    currentFrame2=1;
    x = 100;
    y = 625;

    setupSprites();
  }

  void setupSprites()
  {
    movement= new PImage[12][9]; //Create 2D array for Images
    characterChecks();
    spriteSheet = loadImage(presetVar); //Load entire spritesheet
    for (int i = 0; i < 9; i++)
    {
      movement[0][i] = spriteSheet.get(10 + 64 * i, 514, 40, 65); //Upward moving sprite
      movement[1][i] = spriteSheet.get(10 + 64 * i, 578, 45, 65); //Left moving sprite
      movement[2][i] = spriteSheet.get(10 + 64 * i, 642, 40, 65); //Downward moving sprite
      movement[3][i] = spriteSheet.get(10 + 64 * i, 706, 40, 65); //Right moving sprite
      movement[4][i] = spriteSheet.get(10 + 64 * i, 384, 40, 65); //Left attacking animation
      movement[5][i] = spriteSheet.get(10 + 64 * i, 448, 40, 65); //Right attacking animation
    }
  }
  



  void levelChange() 
  {
    fill(255, 90);
    text("Level Up!", 70, 70);
    level++;
    currentDirection = 3;
    x = 100;
    y = 625;
  }


  
  
  
  void drawPlayer()
  {
    if (inMotion)
    {
      image(movement[currentDirection][1 + int(currentFrame)], x, y); //Cycles through the frames with the help of line 46
     
    }
     else
    {
      image(movement[currentDirection][0], x, y);
    } 
   
   
    
     if(attacking)
    {
      image(movement[5][1 + int(currentFrame2)],x , y);
    }
     else
    {
      image(movement[5][0], x, y);
    } 
    
}
  
  void attackUpdate()
  {
    currentFrame2 = (currentFrame2 + 0.6) % 8;
    attacking = true;
    
  }
  
  
  
  
  void updatePlayer(int xDelta, int yDelta)
  {
    currentFrame = (currentFrame + 0.6 /*Changing the 0.2 changes animation speed*/) % 8; //helps change through the frames
    inMotion = true;

    if (xDelta ==0 && yDelta ==0)
      inMotion =false;
    else if (xDelta <= -1)
      currentDirection = LEFT;
    else if (xDelta >= 1)
      currentDirection = RIGHT;
    else if (yDelta == -1)
      currentDirection = UP;
    else if (yDelta == 1)
      currentDirection = DOWN;


    x = x + xDelta;
    y = y + yDelta;

    if (isPlayerOffScreen(x, y))
    {
      x = x - xDelta;
      y = y - yDelta;
    }
    if (currentDirection==3) 
    {
      image(weaponImage[currentWeapon], x+10, y+40);
    }
    if (currentDirection==1) 
    {
      pushMatrix();
      scale(-1, 1);
      image(weaponImage[currentWeapon], x+30, y+40);
      popMatrix();
    }
  }
  boolean isPlayerOffScreen(float x, float y)
  {
    if (x < 0 || x > width-30 || y<0 || y > height - 56)
      return true;
    return false;
  }
}