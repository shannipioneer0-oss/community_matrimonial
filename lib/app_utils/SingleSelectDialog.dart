

import 'dart:async';

import 'package:community_matrimonial/app_utils/Values.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:no_context_navigation/no_context_navigation.dart';

import '../network_utils/model/DataFetch.dart';

class SingleSelectDialog {

  List<DataFetch> _filteredItems = [];
  List<DataFetchParams> filteredItemscity = [];
  List<DataFetchstate> _filteredItems2 = [];
  List<String> listsingleitem = [];
  List<EduFetchstate> listsingleitemEdu = [];
  List<InstituteFetchstate> listSingleitemIsntitute = [];
  List<OcupationFetchstate> listsingleitemOccupation = [];
  List<MultiSelectItem<dynamic>> list_annual_income = [];

   Future<DataFetch> showBottomSheet(BuildContext context , List<DataFetch> items , String title) async {

     Completer<DataFetch> completer = Completer();
    _filteredItems = items;

   await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,

      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.85,
          builder: (BuildContext context, ScrollController scrollController) {

            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState)
            {

              void filterItems(String value){

                setState((){

                  _filteredItems = items
                      .where((item) =>
                      item.label.toLowerCase().contains(
                          value.toLowerCase()))
                      .toList();

                });



              }



              return Container(
                  constraints: BoxConstraints(maxHeight: double.infinity),
                  child: Column(
                    children: [
                      Container(padding:EdgeInsets.all(10) , alignment: Alignment.topLeft ,child:Text(title , style: TextStyle(fontSize: 18 ,fontWeight: FontWeight.bold ,color: Colors.purple),),),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: TextField(
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    hintText: 'Search...',
                                    hintStyle: TextStyle(color: Colors.grey),
                                    prefixIcon: Icon(
                                        Icons.search, color: Colors.grey),
                                    border: InputBorder.none,
                                  ),
                                  onChanged: (value) {filterItems(value);
                                  },
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          controller: scrollController,
                          itemCount: items.length,
                          // Replace with your actual item count
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(_filteredItems[index].label),
                              onTap: () {
                                completer.complete(_filteredItems[index]);
                                Navigator.pop(context);
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ));
            });
          },
        );
      },
    );



     return completer.future;

  }


   Future<DataFetchstate> showBottomSheet2(BuildContext context ,List<DataFetchstate> items , String title) async {

    Completer<DataFetchstate> completer = Completer();
    _filteredItems2 = items;

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,

      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.85,
          builder: (BuildContext context, ScrollController scrollController) {

            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState)
            {

              void filteritems(String value){

                setState((){

                  _filteredItems2 = items
                      .where((item) =>
                      item.state_name.toLowerCase().contains(
                          value.toLowerCase()))
                      .toList();

                });

              }

              return Container(
                  constraints: BoxConstraints(maxHeight: double.infinity),
                  child: Column(
                    children: [
                      Text(title , style: TextStyle(fontSize: 16 ,fontWeight: FontWeight.bold ,color: Colors.purple),),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: TextField(
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    hintText: 'Search...',
                                    hintStyle: TextStyle(color: Colors.grey),
                                    prefixIcon: Icon(
                                        Icons.search, color: Colors.grey),
                                    border: InputBorder.none,
                                  ),
                                  onChanged: (value) {

                                    filteritems(value);

                                  },
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          controller: scrollController,
                          itemCount: _filteredItems2.length,
                          // Replace with your actual item count
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(_filteredItems2[index].state_name),
                              onTap: () {
                                completer.complete(_filteredItems2[index]);
                                Navigator.pop(context);
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ));
            });
          },
        );
      },
    );



    return completer.future;

  }


   Future<DataFetchParams> showBottomSheet3(BuildContext context ,List<DataFetchParams> items) async {

    Completer<DataFetchParams> completer = Completer();
    filteredItemscity = items;

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.85,
          builder: (BuildContext context, ScrollController scrollController) {



            return Container(constraints: BoxConstraints(maxHeight: double.infinity)   ,child:Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: TextField(
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              hintText: 'Search...',
                              hintStyle: TextStyle(color: Colors.grey),
                              prefixIcon: Icon(Icons.search, color: Colors.grey),
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {

                              filteredItemscity = items
                                  .where((item) => item.label.toLowerCase().contains(value.toLowerCase()))
                                  .toList();

                            },
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: filteredItemscity.length, // Replace with your actual item count
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(filteredItemscity[index].label),
                        onTap: () {

                          completer.complete(filteredItemscity[index]);
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ),
              ],
            ));
          },
        );
      },
    );



    return completer.future;

  }


   Future<String> showBottomSheetSingle(BuildContext context ,List<String> items , String title) async {

    Completer<String> completer = Completer();
    listsingleitem = items;

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.85,
          builder: (BuildContext context, ScrollController scrollController) {

            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState)
            {

              void filterValue(String value){

                setState((){

                  listsingleitem = items
                      .where((item) =>
                      item.toLowerCase().contains(
                          value.toLowerCase()))
                      .toList();

                });


              }

              return Container(
                  constraints: BoxConstraints(maxHeight: double.infinity),
                  child: Column(
                    children: [

                      Container(padding:EdgeInsets.all(10) , alignment: Alignment.topLeft ,child:Text(title , style: TextStyle(fontSize: 18 ,fontWeight: FontWeight.bold ,color: Colors.purple),),),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: TextField(
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    hintText: 'Search...',
                                    hintStyle: TextStyle(color: Colors.grey),
                                    prefixIcon: Icon(
                                        Icons.search, color: Colors.grey),
                                    border: InputBorder.none,
                                  ),
                                  onChanged: (value) {

                                    filterValue(value);

                                  },
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          controller: scrollController,
                          itemCount: listsingleitem.length,
                          // Replace with your actual item count
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(listsingleitem[index]),
                              onTap: () {
                                completer.complete(listsingleitem[index]);
                                Navigator.pop(context);
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ));
            });
          },
        );
      },
    );



    return completer.future;

  }


   Future<EduFetchstate> showBottomSheetEducation(BuildContext context ,List<EduFetchstate> items) async {

    Completer<EduFetchstate> completer = Completer();
    listsingleitemEdu = items;

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          expand: false,
            initialChildSize: 0.85,
          builder: (BuildContext context, ScrollController scrollController)
        {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {

              void fetchitems(String value){

                setState(() {
                  listsingleitemEdu = items
                      .where((item) =>
                      item.degree_name.toLowerCase().contains(
                          value.toLowerCase()))
                      .toList();
                });

              }


              return Container(
                  constraints: BoxConstraints(maxHeight: double.infinity),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: TextField(
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    hintText: 'Search...',
                                    hintStyle: TextStyle(color: Colors.grey),
                                    prefixIcon: Icon(
                                        Icons.search, color: Colors.grey),
                                    border: InputBorder.none,
                                  ),
                                  onChanged: (value) {

                                    fetchitems(value);

                                  },
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          controller: scrollController,
                          itemCount: listsingleitemEdu.length,
                          // Replace with your actual item count
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(listsingleitemEdu[index].degree_name),
                              onTap: () {
                                completer.complete(listsingleitemEdu[index]);
                                Navigator.pop(context);
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ));
            },
          );
        });
      },
    );



    return completer.future;

  }

   Future<InstituteFetchstate> showBottomSheetInstitute(BuildContext context ,List<InstituteFetchstate> items) async {

    Completer<InstituteFetchstate> completer = Completer();
    listSingleitemIsntitute = items;

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.85,
          builder: (BuildContext context, ScrollController scrollController) {

            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState)
            {

              void filteritems(String value){

                setState((){

                  listSingleitemIsntitute = items
                      .where((item) =>
                      item.institute_name.toLowerCase()
                          .contains(value.toLowerCase()))
                      .toList();

                });


              }

              return Container(
                  constraints: BoxConstraints(maxHeight: double.infinity),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: TextField(
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    hintText: 'Search...',
                                    hintStyle: TextStyle(color: Colors.grey),
                                    prefixIcon: Icon(
                                        Icons.search, color: Colors.grey),
                                    border: InputBorder.none,
                                  ),
                                  onChanged: (value) {

                                     filteritems(value);
                                  },
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          controller: scrollController,
                          itemCount: listSingleitemIsntitute.length,
                          // Replace with your actual item count
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(listSingleitemIsntitute[index]
                                  .institute_name),
                              onTap: () {
                                completer.complete(
                                    listSingleitemIsntitute[index]);
                                Navigator.pop(context);
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ));
            });
          },
        );
      },
    );



    return completer.future;

  }


  Future<OcupationFetchstate> showBottomSheetOccupation(BuildContext context ,List<OcupationFetchstate> items) async {

    Completer<OcupationFetchstate> completer = Completer();
    listsingleitemOccupation = items;

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.85,
          builder: (BuildContext context, ScrollController scrollController) {

            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState)
            {

              void filteritems(String value){


                setState((){

                  listsingleitemOccupation = items
                      .where((item) =>
                      item.occupation.toLowerCase().contains(
                          value.toLowerCase()))
                      .toList();

                });


              }

              return Container(
                  constraints: BoxConstraints(maxHeight: double.infinity),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: TextField(
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    hintText: 'Search...',
                                    hintStyle: TextStyle(color: Colors.grey),
                                    prefixIcon: Icon(
                                        Icons.search, color: Colors.grey),
                                    border: InputBorder.none,
                                  ),
                                  onChanged: (value) {
                                    filteritems(value);
                                  },
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          controller: scrollController,
                          itemCount: listsingleitemOccupation.length,
                          // Replace with your actual item count
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                  listsingleitemOccupation[index].occupation),
                              onTap: () {
                                completer.complete(
                                    listsingleitemOccupation[index]);
                                Navigator.pop(context);
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ));
            });
          },
        );
      },
    );



    return completer.future;

  }



  Future<MultiSelectItem<dynamic>> showBottomSheetAnnualincome(BuildContext context ,List<MultiSelectItem<dynamic>> items) async {

    Completer<MultiSelectItem<dynamic>> completer = Completer();
    list_annual_income = items;

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.85,
          builder: (BuildContext context, ScrollController scrollController) {

            return StatefulBuilder(
                builder: (BuildContext context, StateSetter setState)
                {

                  void filteritems(String value){


                    setState((){

                      list_annual_income = items
                          .where((item) =>
                          item.label.toLowerCase().contains(
                              value.toLowerCase()))
                          .toList();

                    });


                  }

                  return Container(
                      constraints: BoxConstraints(maxHeight: double.infinity),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: TextField(
                                      style: TextStyle(color: Colors.black),
                                      decoration: InputDecoration(
                                        hintText: 'Search...',
                                        hintStyle: TextStyle(color: Colors.grey),
                                        prefixIcon: Icon(
                                            Icons.search, color: Colors.grey),
                                        border: InputBorder.none,
                                      ),
                                      onChanged: (value) {
                                        filteritems(value);
                                      },
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.close),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              controller: scrollController,
                              itemCount: list_annual_income.length,
                              // Replace with your actual item count
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(
                                      list_annual_income[index].label),
                                  onTap: () {
                                    completer.complete(
                                        list_annual_income[index]);
                                    Navigator.pop(context);
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ));
                });
          },
        );
      },
    );



    return completer.future;

  }

}