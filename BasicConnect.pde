# BasicConnect

boolean menuawal=true;
String pil;
boolean human=true;
int maxvertical,maxhorizontal;

int black,red; // definisi nilai score
int count = 1; //
int baris = 6;
int kolom = 7;

int winner = 0; // perhitungan nilai winner
int batasx=105; //batas pojok koordinat x 
int batasy=125; //batas pojok koordinat y 
boolean down =false,rwaktu=false;

boolean lockHigl = false;
boolean gameOn = false;
BtnKotak[][] grid = new BtnKotak[100][100];
int[][] KotakCek = new int[100][100];
int [] colum = new int [100];
int brs=5,klm=0,mulai=0,rx=0,ry=375,vx=0,vy=50;

int millwaktu; //menghitung waktu
int startWaktu = 0; //digunakan untuk me-reset detik yang ditampilkan pada layar 
int Twaktu; //Waktu yang ditampilkan di layar
int restartwaktu=0; //jumlah detik berlalu yang terakhir
int bataswaktu=10;

PImage ph;
void setup()
{
  ph = loadImage("back.jpg");
  frameRate(800);
  smooth();
  size(555,550);
  
    // mengisi nilai atribut pada objek grid 
  for (int a = 0; a<kolom; a++) {
    for (int b = 0; b<baris; b++) {
       grid[a][b] = new BtnKotak(50* a + batasx, 50*b + batasy, 45, color(180,80,80), color(153)); // mengisi objek grid
       colum[a] = 50*b+batasy; // membuat batas setiap kolom animasi ke bawah 
       KotakCek[a][b] = 10; 
    }
  }
}
//fungsi untuk merestart permainan
void mousePressed() {
  if (gameOn == false) {
    if(winner== 8){
       black++;
    }
    if(winner == 4){
        red++;
    }
    baris++;kolom++;
    batasx-=25;
     restartwaktu = millwaktu; //stores elapsed SECONDS
     Twaktu = startWaktu; //restart screen timer  
    gameOn = true;
    setup();
  }
}
//fungsi waktu
void time() {
  millwaktu = millis()/1000; //konversi millisecod ke second
  Twaktu = millwaktu - restartwaktu; //seconds to be shown on screen
  fill(#000000); 
  textAlign(CENTER);
  text(Twaktu, 250, 25);
} 

// fungsi score
void score(){
  stroke(126); 
  textSize(18);
  fill(0);
  text("Black", 30, 20); 
  text(black, 30, 40); 
  fill(255,0,0);
  text("Red", 510, 20);
  text(red, 510, 40); 
}

//menampilkan kemenangan
void shadowtext (String s, float x, float y, int o) {
  fill(100, 100);
  text(s, x+o, y+o);
  fill(58, 12, 247);
  text(s, x, y);
}
void redWin(){
  shadowtext("Merah Menang!", width/2, height/2, 3);
}
void blackWin(){
  shadowtext("Hitam Menang!", width/2, height/2, 3);
} 

void draw()
{  
  if(menuawal == true){
    background(#00FB00);
    fill(0);
    textSize(25);
    text("1.MAN VS MAN",200,150);
    text("2.MAN VS COM easy",200,205);
    text("3.EXIT",200,255);
    text("Press the number on the keyboard",100,305);
    if(keyCode == '1'){
        restartwaktu =millis()/1000 ;
        pil = "humanvshuman";
        menuawal=false;
        gameOn = true;
      }
      if(keyCode == '2'){
        restartwaktu =millis()/1000 ;
        pil = "humanvscom";
        menuawal=false;
        gameOn = true;
      }
      if(keyCode == '3'){
        exit();
      }
    }else{
      background(ph);
      for (int c = 0; c<kolom; c++) {  
        for (int d = 0; d<baris; d++) {
          grid[c][d].display();        // menampilkan metode display pada objek grid 
        }
      }
     score();
     time();
     
     
            if (count % 2 == 0) { 
               if(pil != "humanvscom"){ 
                 fill(255, 0, 0);
                 rect(rx+batasx,ry,45,45);
                 rect(vx+batasx,50,45,45);//kotak atas
               }          
            }else{
                 fill(0);
                 rect(rx+batasx,ry,45,45);
                 rect(vx+batasx,50,45,45);//kotak atas
              } 
      //println(bataswaktu);
     //animasi ke bawah
        if (key == 10) {
          if (grid[klm][brs].getColor() != color(255, 0, 0) || grid[klm][brs].getColor() != color(0) ){
          if(vy < colum[klm]){
              vy++;
            }else{
              vy =50 ; 
              key = 0;
            down = false;
           } 
          if (count % 2 == 0) {
            fill(0);
            }else{
              if(pil != "humanvscom"){
              fill(255,0,0);
              }
            }
           rect(vx+batasx,vy,45,45);
          }
      }
    
    if(Twaktu > bataswaktu){
            restartwaktu = millwaktu; //mengisi variabel restat.. dengan isi 
            Twaktu = startWaktu; //restart tampilan waktu
            gameOn = false;
            PFont font = createFont("ARCARTER-78.vlw", 14);
            textFont(font, 35);
            if (count % 2 == 0) {
                blackWin();
                winner = 8;
            }else{
                redWin();
                winner= 4;
            }
            //cekWin() = true;
            shadowtext("Click to play again", width/2, height/3, 1);
      }  
      
    if (cekWin() == true) {
      restartwaktu = millwaktu; //mengisi variabel restat.. dengan isi 
      Twaktu = startWaktu; //restart tampilan waktu
      gameOn = false;
      PFont font = createFont("ARCARTER-78.vlw", 14);
      textFont(font, 35);
      if (winner == 4) {
          redWin();
      }
      else if (winner == 8) {
          blackWin();
      }else if (winner >= baris*kolom) {
        shadowtext("Draw!", width/3.5, height/2, 3);
      }
        shadowtext("Click to play again", width/2, height/3, 1);
      }
    }
          //jika pilihan humanvscom maka melaksanakan perintah komputer move
         if(gameOn == true){
            if(human == false){
               if(pil == "humanvscom"){ 
                     comMove();       
               }
            }
         }
   
  
}
// fungsi keyboard
void keyPressed(){
  
 if(gameOn == true){ 
  if( klm < kolom-1 ){
      if (key == CODED && keyCode == RIGHT || key == 'd' ) {
          klm+=1;
          rx+=50;
          vx+=50;
      }
  }
   if(klm > 0){
      if (key == CODED && keyCode == LEFT || key == 'a') {
          klm-=1;
          rx-=50;
          vx-=50;
      }
  }
  if(brs > 0){
      if (key == CODED && keyCode == UP || key == 'w') {
          brs-=1;
          ry-=50;
      }
  }
  if( brs < baris-1){  
      if (key == CODED && keyCode == DOWN || key == 's') {
          brs+=1;
          ry+=50;
      }
  }
      if (key == 10) {  
        if(pil == "humanvscom"){
          if(human == true){
          if (grid[klm][brs].getColor() != color(255, 0, 0) && grid[klm][brs].getColor() != color(0)) {
                if (brs == baris-1 || (KotakCek[klm][brs + 1] == 1 || KotakCek[klm][brs+1] == 2)) {
                      colum[klm] -= 50;
                      restartwaktu = millwaktu; //mengisi variabel restat.. dengan isi 
                      Twaktu = startWaktu; //restart tampilan waktu
                      grid[klm][brs].setColor(color(0));
                      KotakCek[klm][brs] = 2;
                      human = false;  
                      count++;key = 0;
                 }
            }  
          }
        }else{ 
         if (grid[klm][brs].getColor() != color(255, 0, 0) && grid[klm][brs].getColor() != color(0)) {
          if (brs == baris-1 || (KotakCek[klm][brs + 1] == 1 || KotakCek[klm][brs+1] == 2)) { // langkah awal pada baris paling bawah atau jika pada baris dibawahnya ada isinya maka eksekusi program 
             restartwaktu = millwaktu; //mengisi variabel restat.. dengan isi 
             Twaktu = startWaktu; //restart tampilan waktu
             colum[klm] -= 50;
                 key = 0;   
                    if (count % 2 == 0) {
                      grid[klm][brs].setColor(color(255, 0, 0));
                      KotakCek[klm][brs] = 1;
                    }
                    else {
                      grid[klm][brs].setColor(color(0));
                      KotakCek[klm][brs] = 2;
                    }
               // print(" "+KotakCek[klm][brs]);
                count++;
             }
          }
        }
      } 
 }    
} 
 //vy=50;
void comMove(){
 int cbrs = baris-1;
for(int d=0;d<baris;d++){
 for (int c = 0; c<kolom; c++) {
                              if ((grid[c][cbrs].getColor() != color(255, 0, 0) && grid[c][cbrs].getColor() != color(0))) { 
                                  if(human == false){
                                  restartwaktu = millwaktu; //mengisi variabel restart... isi dari  waktu millisecond
                                  Twaktu = startWaktu; //restart tampilan waktu
                                  grid[c][cbrs].setColor(color(255, 0, 0));
                                  KotakCek[c][cbrs] = 1;
                                  human =true;  // human terisi true maka player boleh berjalan 
                                  count++;
                                  println(c);  
                                  }
                                }
                      }cbrs=cbrs-1; println(cbrs);// jika pada baris tersebut semua kolom tidak terisi maka akan mengurangi jumlah 1 baris atau naik ke baris atas 
          }        
}
// cek kemenangan
boolean cekWin()
{
  int counter;
  int draw=0;  
  //horizontal
  for (int a=0; a < baris; a++) {
    for (int b=0; b < kolom-3; b++) {
      int tCheck = (KotakCek[b][a]) + (KotakCek[b+1][a]) + (KotakCek[b+2][a]) + (KotakCek[b+3][a]);
      if (tCheck == 8 || tCheck == 4)
      {
        winner = tCheck;
        return true;
      }
    }
  }
  //vertical
  for (int a=0; a < baris-3; a++) {
    for (int b=0; b < kolom; b++) {
      int tCheck = (KotakCek[b][a]) + (KotakCek[b][a+1]) + (KotakCek[b][a+2]) + (KotakCek[b][a+3]);
      if (tCheck == 8 || tCheck == 4)
      {
        winner = tCheck;
        return true;
      }
    }
  }
  //diagonals
  for (int a=0; a < baris-3; a++) {
    for (int b=0; b < kolom-3; b++) {
      int tCheck = (KotakCek[b][a]) + (KotakCek[b+1][a+1]) + (KotakCek[b+2][a+2]) + (KotakCek[b+3][a+3]);
      if (tCheck == 8 || tCheck == 4)
      {
        winner = tCheck;
        return true;
      }
    }
  }
  for (int a=0; a < baris-3; a++) {
    for (int b=3; b < kolom; b++) {
      int tCheck = (KotakCek[b][a]) + (KotakCek[b-1][a+1]) + (KotakCek[b-2][a+2]) + (KotakCek[b-3][a+3]);
      if (tCheck == 8 || tCheck == 4)
      {
        winner = tCheck;
        return true;
      }
    }
  }
  //draw
  for (int a=0; a < baris; a++) {
    for (int b=0; b < kolom; b++) {
      if (KotakCek[b][a] == 1 ||  KotakCek[b][a] == 2)
        draw++;
        if(draw>=baris*kolom){
          winner = draw;
          return true;
        }
    }
  } 
  return false;
}

class BtnKotak
{
  int x, y;
  int size;
  color currentcolor;
  BtnKotak(int ix, int iy, int isize, color icolor, color ihighlight)
  {
    x = ix;
    y = iy;
    size = isize;
    currentcolor = icolor;
  }
  void setColor(color a) {
    currentcolor = a;
  }
  color getColor() {
    return currentcolor;
  }
   void display()
  {
    smooth();
    stroke(currentcolor);
    fill(currentcolor);
    rect(x, y, size, size);
  }
}
