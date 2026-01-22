import 'package:community_matrimonial/app_utils/SingleSelectDialog.dart';
import 'package:community_matrimonial/network_utils/model/CommonMasters.dart';
import 'package:community_matrimonial/network_utils/model/DataFetch.dart';
import 'package:community_matrimonial/network_utils/model/caste.dart';
import 'package:community_matrimonial/network_utils/model/city_list.dart';
import 'package:community_matrimonial/network_utils/model/country.dart';
import 'package:community_matrimonial/network_utils/model/edu_degree.dart';
import 'package:community_matrimonial/network_utils/model/institute_model.dart';
import 'package:community_matrimonial/network_utils/model/marital_status.dart';
import 'package:community_matrimonial/network_utils/model/occupation.dart';
import 'package:community_matrimonial/network_utils/model/state_model.dart';
import 'package:community_matrimonial/network_utils/model/subcaste_model.dart';
import 'package:community_matrimonial/network_utils/service/api_service.dart';
import 'package:community_matrimonial/utils/SharedPrefs.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class DataFetchParams {
  final String label;
  final String value;
  final String value2;

  DataFetchParams({required this.label , required this.value , required this.value2});

}

class DataFetchParamsFour {
  final String label;
  final String value;
  final String label1;
  final String label2;

  DataFetchParamsFour({required this.label , required this.value , required this.label1 , required this.label2});

}


class DataFetchstate {
  final String Id;
  final String state_name;
  final String state_hindi;
  final String state_guj;
  final String state_marathi;
  final String state_tamil;
  final String state_urdu;
  final String country_id;

  DataFetchstate({required this.state_name, required this.state_hindi, required this.state_guj, required this.state_marathi, required this.state_tamil, required this.state_urdu, required this.country_id, required this.Id });

}


class EduFetchstate {
  final String Id;
  final String degree_name;
  final String degree_hindi;
  final String degree_guj;
  final String degree_marathi;
  final String degree_tamil;
  final String degree_urdu;


  EduFetchstate({required this.degree_name, required this.degree_hindi, required this.degree_guj, required this.degree_marathi, required this.degree_tamil, required this.degree_urdu,  required this.Id });

}


class OcupationFetchstate {
  final String Id;
  final String occupation;
  final String occupation_hindi;
  final String occupation_guj;
  final String occupation_marathi;
  final String occupation_tamil;
  final String occupation_urdu;


  OcupationFetchstate({required this.occupation, required this.occupation_hindi, required this.occupation_guj, required this.occupation_marathi, required this.occupation_tamil, required this.occupation_urdu,  required this.Id });

}


class InstituteFetchstate {
  final String Id;
  final String institute_name;
  final String institute_hindi;
  final String institute_guj;
  final String institute_marathi;
  final String institute_tamil;
  final String institute_urdu;


  InstituteFetchstate({required this.institute_name  , required this.institute_hindi, required this.institute_guj, required this.institute_marathi, required this.institute_tamil, required this.institute_urdu,  required this.Id });

}





class Values{

  static List<String> relationwithcandidate(){

    return ["Grand Mother" ,"Grand Father" , "Mother's Father" , "Father" , "Mother" , "Brother" , "Sister" , "Brother's Wife" , "Son" , "Daughter" , "nephew" , "niece"];
  }

  static List<String> maritalStatus(){

    return ["Married" , "Single" , "Widow" , "Widower" , "Divorced"];
  }

  static Future<List<DataFetch>> getValues(BuildContext context ,String valpass , String valpass2) async {

    List<DataFetch> items = [];

    SharedPreferences prefs = await SharedPreferences.getInstance();

    final _response = await Provider.of<ApiService>(context, listen: false)
        .postMasterTable(
        {
          "type": valpass, // blog , caste , roles , all_staff
          "communityId": prefs.getString(SharedPrefs.communityId),
          "original": "en",
          "translate": ["en"]
        }
    );

    if(valpass == "caste") {
      print(_response.body.toString());

      caste mStatus = caste.fromJson(_response.body);


      mStatus.data.forEach((map) {

        map.forEach((key, value) {

          items.add(DataFetch(label: value.caste, value: value.id.toString()));

        });

      });


    }else if(valpass == "subcaste" && valpass2 != "subcaste2"){

      SubcasteData mStatus = SubcasteData.fromJson(_response.body);

      mStatus.data.forEach((map) {

        map.forEach((key, value) {

          if(value.casteId == valpass2) {
            items.add(
                DataFetch(label: value.subcaste, value: value.id.toString()));
          }

        });

      });


    }else if(valpass == "subcaste" && valpass2 == "subcaste2"){

      SubcasteData mStatus = SubcasteData.fromJson(_response.body);

      mStatus.data.forEach((map) {

        map.forEach((key, value) {


            items.add(
                DataFetch(label: value.subcaste, value: value.id.toString()));


        });

      });


    }

    else {


      Commonmasters mStatus = Commonmasters.fromJson(_response.body);

      mStatus.data.forEach((map) {

        map.items.forEach((value) {
          items.add(DataFetch(label: value.label , value: value.value.toString()));
        });

      });



    }


    return items;

  }








  static Future<List<DataFetch>> getValuesContacts(BuildContext context ,String valpass , String valpass2) async {

    List<DataFetch> items = [];


    SharedPreferences prefs = await SharedPreferences.getInstance();

    final _response = await Provider.of<ApiService>(context, listen: false)
        .postCountryList(
        {
          "original": "en",
          "translate": ["en"],
          "communityId": prefs.getString(SharedPrefs.communityId)
        }
    );

    if(valpass == "country") {
      print(_response.body.toString());

      Country mStatus = Country.fromJson(_response.body);

      mStatus.data.forEach((map) {

        map.forEach((key, value) {
          items.add(DataFetch(label: value.country_name, value: value.id.toString()));
        });

      });

    }else if(valpass == "city"){

      List<DataFetch> items = [];

      final _response = await Provider.of<ApiService>(context, listen: false)
          .postCityFetch(
          {
            "original": "en",
            "translate": ["en"]
          }
      );


    }

    return items;
  }


  static Future<List<DataFetchstate>> getValuesContactsState(BuildContext context ,String valpass , String valpass2 , String country_id) async {

    List<DataFetchstate> items = [];



    SharedPreferences prefs = await SharedPreferences.getInstance();
    final _response = await Provider.of<ApiService>(context, listen: false)
        .postStateList(
        {
          "original": "en",
          "translate": ["en"],
          "communityId": prefs.getString(SharedPrefs.communityId).toString(),
          "countryId": country_id
        }
     );

    print(prefs.getString(SharedPrefs.communityId).toString()+"===-------");

      StateData mStatus = StateData.fromJson(_response.body);

      mStatus.data.forEach((map) {

        map.forEach((key, value) {
          items.add(new DataFetchstate(Id: value.id.toString(), state_name: value.stateName, state_hindi: value.stateHindi, state_guj: value.stateGuj, state_marathi: value.stateMarathi, state_tamil: value.stateTamil, state_urdu: value.stateUrdu, country_id: value.countryId , ));
        });

        items.add(new DataFetchstate(state_name: "Other", state_hindi: "", state_guj: "", state_marathi: "", state_tamil: "", state_urdu: "", country_id: "", Id: country_id));

      });



    return items;
  }


  static Future<List<DataFetchParams>> getValuesContactsCity(BuildContext context ,String valpass , String valpass2) async {

    List<DataFetchParams> items = [];



    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(valpass+"----"+valpass2+"-----"+prefs.getString(SharedPrefs.communityId).toString());


    final _response = await Provider.of<ApiService>(context, listen: false)
        .postCityFetch(
        {
          "state_id":valpass,
          "country_id":valpass2,
          "original": "en",
          "translate": ["en"],
          "communityId": prefs.getString(SharedPrefs.communityId).toString(),
        }
    );

    print(_response.body.toString());


    CityList mStatus = CityList.fromJson(_response.body);

    mStatus.data.forEach((map) {

      items.add( DataFetchParams(label: map.cityName  ,  value: map.id.toString() , value2: ""));


    });
    items.add( DataFetchParams(label: "Other"  ,  value: "" , value2: ""));




    return items;
  }


  static Future<List<EduFetchstate>> getEducationList(BuildContext context ,String valpass , String valpass2) async {

    List<EduFetchstate> items = [];

    final _response = await Provider.of<ApiService>(context, listen: false)
        .postEduDegree(
        {
            "original": "en",
            "translate": ["en"]

        }
    );

    print(_response.body.toString());


    DegreesList mStatus = DegreesList.fromJson(_response.body);

    mStatus.data.forEach((map) {

      map.forEach((key, value) {

        items.add( EduFetchstate(degree_name: value.degreeName, degree_hindi: value.degreeHindi, degree_guj: value.degreeGuj, degree_marathi: value.degreeMarathi, degree_tamil: value.degreeTamil, degree_urdu: value.degreeUrdu, Id: value.id.toString()));

      });

      items.add(EduFetchstate(degree_name: "Other", degree_hindi: "", degree_guj: "", degree_marathi: "", degree_tamil: "", degree_urdu: "", Id: "0"));

    });



    return items;
  }


  static Future<List<OcupationFetchstate>> getOccupationList(BuildContext context ,String valpass , String valpass2) async {

    List<OcupationFetchstate> items = [];

    final _response = await Provider.of<ApiService>(context, listen: false).postOccupationList(
        {
          "original": "en",
          "translate": ["en"]
        }
    );

    print(_response.body.toString());


    OccupationData mStatus = OccupationData.fromJson(_response.body);

    mStatus.data.forEach((map) {

      map.forEach((key, value) {
        items.add( OcupationFetchstate(occupation: value.occupationName, occupation_hindi: value.occupationHindi, occupation_guj: value.occupationGuj, occupation_marathi: value.occupationMarathi,  occupation_urdu: value.occupationUrdu, occupation_tamil: value.occupationTamil, Id: value.id.toString()));
      });

      items.add(OcupationFetchstate(occupation: "Other", occupation_hindi: "", occupation_guj: "", occupation_marathi: "",  occupation_urdu: "", occupation_tamil: "", Id: "0"));

    });



    return items;
  }


  static Future<List<InstituteFetchstate>> getReputedUniveristy(BuildContext context ,String valpass , String valpass2) async {

    List<InstituteFetchstate> items = [];

    final _response = await Provider.of<ApiService>(context, listen: false)
        .postInstituteReputed(
        {
          "original": "en",
          "translate": ["en"]
        }
    );

    print(_response.body.toString());


    InstituteList mStatus = InstituteList.fromJson(_response.body);

    mStatus.data.forEach((map) {

      map.forEach((key, value) {

        items.add( InstituteFetchstate(institute_name: value.instituteName, Id: value.id.toString(), institute_hindi: value.instituteHindi, institute_guj: value.instituteGuj, institute_marathi: value.instituteMarathi, institute_tamil: value.instituteMarathi, institute_urdu: value.instituteUrdu));

      });

    });



    return items;
  }











  static Future<List<MultiSelectItem>> getValuesMultiple(BuildContext context ,String valpass , String valpass2) async {

    List<MultiSelectItem> multiselect_items = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final _response = await Provider.of<ApiService>(context, listen: false)
        .postMasterTable(
        {
          "type": valpass, // blog , caste , roles , all_staff
          "communityId": prefs.getString(SharedPrefs.communityId) ,
          "original": "en",
          "translate": ["en"]
        }
    );

    print(_response.body);


    Commonmasters mStatus = Commonmasters.fromJson(_response.body);

    mStatus.data.forEach((map) {

      map.items.forEach((value) {
        multiselect_items.add(MultiSelectItem(value.value , value.label));
      },);

    });


    return multiselect_items;
  }





  static Future<List<MultiSelectItem>> getValuesMultipleState(BuildContext context ,String valpass , String valpass2) async {

    List<MultiSelectItem> items = [];

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final _response = await Provider.of<ApiService>(context, listen: false)
        .postStateList(
        {
          "original": "en",
          "translate": ["en"],
          "countryId": valpass2,
          "communityId":prefs.getString(SharedPrefs.communityId)
        }
    );

    print(_response.body);

    StateData mStatus = StateData.fromJson(_response.body);

    mStatus.data.forEach((map) {
      map.forEach((key, value) {
        items.add(MultiSelectItem(value.id , value.stateName));
      });
    });


    return items;
  }


  static Future<List<MultiSelectItem>> getValuesMultipleCity(BuildContext context ,String valpass , String valpass2) async {

    List<MultiSelectItem> items = [];

    final _response = await Provider.of<ApiService>(context, listen: false)
        .postCityFetchMultiple(
        {
          "Ids":valpass,
          "original": "en",
          "translate": ["en"]
        }
    );

    print(_response.body.toString());


    CityList mStatus = CityList.fromJson(_response.body);

    mStatus.data.forEach((map) {
        items.add(MultiSelectItem(map.id , map.cityName));

    });


    return items;
  }


  static Future<List<MultiSelectItem>> getValuesMultipleEducation(BuildContext context ,String valpass , String valpass2) async {

    List<MultiSelectItem> items = [];

    final _response = await Provider.of<ApiService>(context, listen: false)
        .postEduDegree(
        {
          "original": "en",
          "translate": ["en"]

        }
    );

    DegreesList mStatus = DegreesList.fromJson(_response.body);

    mStatus.data.forEach((map) {

      map.forEach((key, value) {

        items.add(MultiSelectItem(value.id , value.degreeName));

      });


    });


    return items;
  }

  static Future<List<MultiSelectItem>> getValuesMultipleOccupation(BuildContext context ,String valpass , String valpass2) async {

    List<MultiSelectItem> items = [];

    final _response = await Provider.of<ApiService>(context, listen: false).postOccupationList(
        {
          "original": "en",
          "translate": ["en"]
        }
    );

    OccupationData mStatus = OccupationData.fromJson(_response.body);


    mStatus.data.forEach((map) {

      map.forEach((key, value) {

        items.add(MultiSelectItem(value.id , value.occupationName));

      });


    });


    return items;
  }


}