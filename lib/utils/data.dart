

class Data{


 List<String> heights = [
  '4ft 0inch',
  '4ft 1inch',
  '4ft 2inch',
 '4ft 3inch',
 '4ft 4inch',
  '4ft 5inch',
  '4ft 6inch',
  '4ft 7inch',
  '4ft 8inch',
  '4ft 9inch',
  '4ft 10inch',
  '4ft 11inch',
   '5ft 0inch',
  '5ft 1inch',
   '5ft 2inch',
  '5ft 3inch',
  '5ft 4inch',
   '5ft 5inch',
   '5ft 6inch',
 '5ft 7inch',
  '5ft 8inch',
  '5ft 9inch',
   '5ft 10inch',
   '5ft 11inch',
   '6ft 0inch',
   '6ft 1inch',
  '6ft 2inch',
   '6ft 3inch',
  '6ft 4inch',
   '6ft 5inch',
   '6ft 6inch',
   '6ft 7inch',
  '6ft 8inch',
  '6ft 9inch',
  '6ft 10inch',
  '6ft 11inch',
   '7ft 0inch',
   '7ft 1inch',
   '7ft 2inch',
   '7ft 3inch',
   '7ft 4inch',
   '7ft 5inch',
  ];

   List<String> getHeight(){
     return heights;
   }


   List<String> getWeight(){
    return List<String>.generate(121, (index) => '${index + 30}');
   }


 List<String> getEmploymnetType(){
  return ["Private Sector" , "Public Sector" , "Self Employed" , "Contract Basis" , "Study" , "Not Working", "Business"];
 }


 List<String> getHouseOwned(){
  return ["Owned" , "Rented"];
 }


}