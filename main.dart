import 'dart:io';
import 'dart:math' show Random;
void main() {
 List<List<int>> matrix=[[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]];
  matrix=add2ToEmptySpace(matrix);
  printMatrix(matrix);
  var moveCount=0;
  while(containsNumber(0,matrix)){
    moveCount++;
    print('This is the $moveCount th move');
    print("Enter l for left .Enter r for right. Enter u for up. Enter d for down");
    var move=stdin.readLineSync();
    switch(move){
      case 'l': print("Making left move");
      matrix=leftSlideMatrix(matrix);
      break;
      case 'r': print("Making right move");
      matrix=rightSlideMatrix(matrix);
      break;
      case 'u': print("Making Up move");
      matrix=upSlideMatrix(matrix);
      break;
      case 'd': print("Making Down move");
      matrix=downSlideMatrix(matrix);
      break;
    }
    matrix=add2ToEmptySpace(matrix);
    printMatrix(matrix);
    if(containsNumber(2048,matrix)){
      print("You Win!!"+"Number of Moves=$moveCount");
    }
  }

}
List<List<int>> initializeMatrix(){
    List<List<int>> matrix=[[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]];
    matrix=add2ToEmptySpace(matrix);
    return matrix;
  }
  List<List<int>> leftSlideMatrix(List<List<int>> matrix) {
    for(var i=0;i<matrix.length;i++){
      matrix[i]=leftSlide(matrix[i]);
    }
    return matrix;
  }
  List<List<int>> rightSlideMatrix(List<List<int>>matrix) {
    for(var i=0;i<matrix.length;i++){
      matrix[i]=rightSlide(matrix[i]);
    }
    return matrix;
  }
  List<List<int>> upSlideMatrix(List<List<int>>matrix){
    matrix=transpose(matrix);
    for(var i=0;i<matrix.length;i++){
      matrix[i]=leftSlide(matrix[i]);
    }
    matrix=transpose(matrix);
    return matrix;
  }
  List<List<int>> downSlideMatrix(List<List<int>>matrix){
    matrix=transpose(matrix);
    for(var i=0;i<matrix.length;i++){
      matrix[i]=rightSlide(matrix[i]);
    }
    matrix=transpose(matrix);
    return matrix;
  }
List<List<int>> transpose(List<List<int>> matrix) {
    List<List<int>> temp=initializeMatrix();
    for(var i=0;i<matrix.length;i++){
      for(var j=0;j<matrix.length;j++){
        temp[i][j]=matrix[j][i];
      }
    }
    return temp;
  }

  List<int> rightSlide(tiles) {
    tiles=tiles.reversed.toList();
    tiles=leftSlide(tiles);
    return tiles.reversed.toList();
  }
  List<int> leftSlide(tiles) {
    tiles = slideZeros(tiles);
    for (var j = 0; j < tiles.length - 1; j++) {
      tiles = slideZeros(tiles);
      if (tiles[j + 1] == tiles[j]) {
        //adjacent tiles matching so perform merge
        tiles[j] = tiles[j] + tiles[j + 1]; //add
        tiles[j + 1] = 0; //create empty space
      }
    }
    return tiles;
  }

  List<int> slideZeros(tiles) {
    List<int> result = [];
    for (var i = 0; i < tiles.length; i++) {
      if (tiles[i] != 0) {
        result.add(tiles[i]);
      }
    }
    var zeroCount = tiles.length - result.length;
    for (var i = 0; i < zeroCount; i++) {
      result.add(0);
    }
    return result;
  }

 List<List<int>> add2ToEmptySpace(List<List<int>> matrix){
    var row;
    var col;
    do{
      var rng = new Random();
      row =rng.nextInt(matrix.length);
      col= rng.nextInt(matrix.length);
    }
    while(matrix[row][col]!=0);
    matrix[row][col]=2;
    return matrix;
  }
   void printMatrix(List<List<int>> matrix){
    for(var i=0;i<matrix.length;i++){
      var str='';
      for(var j=0;j<matrix.length;j++){
        str=str+'['+matrix[i][j].toString()+']';
      }
      print(str);
    }
  }
  bool containsNumber(number,matrix){
    for(var i=0;i<matrix.length;i++){
      for(var j=0;j<matrix.length;j++){
        if(matrix[i][j]==number){
          return true;
        }
      }}
    return false;
  }
