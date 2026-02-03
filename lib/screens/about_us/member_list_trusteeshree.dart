
import 'dart:io';
import 'package:community_matrimonial/utils/SharedPrefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:http/http.dart' as http;
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../network_utils/service/api_service.dart';
import '../../utils/Strings.dart';
import '../../utils/utils.dart';

class AttachmentFile {
  final String url;
  final String name;
  final String type; // 'pdf' or 'image'

  AttachmentFile({
    required this.url,
    required this.name,
    required this.type,
  });
}



class HtmlWithFilesScreen extends StatefulWidget {

  final String type;
  HtmlWithFilesScreen(this.type, {super.key});


  @override
  State<HtmlWithFilesScreen> createState() => _HtmlWithFilesScreenState();

}

class _HtmlWithFilesScreenState extends State<HtmlWithFilesScreen> {

  bool _downloading = false;
  int _downloadingIndex = -1;

  String htmlText = "";
  String file1 = "" , file2 = "" ,file3 = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    initapi();

  }

  List files = [];

  initapi() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final _response = await Provider.of<ApiService>(context , listen: false).select_member_list_community({"communityId": prefs.getString(SharedPrefs.communityId) , "type":widget.type});

    setState(() {

      htmlText = _response.body["data"][0]["description"];
      file1 = _response.body["data"][0]["file1"];
      file2 = _response.body["data"][0]["file2"];
      file3 = _response.body["data"][0]["file3"];

      AttachmentFile attachfile1 = AttachmentFile(url: Strings.IMAGE_BASE_URL +
          "/uploads/" +utils().imagePath(prefs.getString(SharedPrefs.communityId).toString())+file1, name: file1 , type: file1.endsWith(".pdf") ? "pdf" : (file1.endsWith(".jpeg") || file1.endsWith(".jpg") || file1.endsWith(".png") || file1.endsWith(".PNG") || file1.endsWith(".JPEG")) ? "image" : "0");

      AttachmentFile attachfile2 = AttachmentFile(url: Strings.IMAGE_BASE_URL +
          "/uploads/" +utils().imagePath(prefs.getString(SharedPrefs.communityId).toString())+file2, name: file2 , type: file2.endsWith(".pdf") ? "pdf" : (file2.endsWith(".jpeg") || file2.endsWith(".jpg") || file2.endsWith(".png") || file2.endsWith(".PNG") || file2.endsWith(".JPEG")) ? "image" : "0");

      AttachmentFile attachfile3 = AttachmentFile(url: Strings.IMAGE_BASE_URL +
          "/uploads/" +utils().imagePath(prefs.getString(SharedPrefs.communityId).toString())+file3, name: file3 , type: file3.endsWith(".pdf") ? "pdf" : (file3.endsWith(".jpeg") || file3.endsWith(".jpg") || file3.endsWith(".png") || file3.endsWith(".PNG") || file3.endsWith(".JPEG")) ? "image" : "0");

      files = [attachfile1 , attachfile2 , attachfile3];

    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text( widget.type == "mlist" ? "Member List" : "Trustee Shreeo")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: files.where((element) => (element as AttachmentFile).type != "0" ).length != 0 ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// HTML CONTENT (only if not empty)
            if (htmlText != null &&
                htmlText!.trim().isNotEmpty)
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: HtmlWidget(htmlText!),
                ),
              ),

            const SizedBox(height: 16),

            /// ATTACHMENTS
            if (files.isNotEmpty) ...[
              const Text(
                "Attachments",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),

              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: files.where((element) => (element as AttachmentFile).type != "0" ).length,
                itemBuilder: (context, index) {
                  final file = files[index];
                  final isPdf = file.type.toLowerCase() == 'pdf';

                  return Card(
                    child: ListTile(
                      leading: Icon(
                        isPdf ? Icons.picture_as_pdf : Icons.image,
                        color: isPdf ? Colors.red : Colors.blue,
                        size: 30,
                      ),
                      title: Text(
                        file.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: _downloading && _downloadingIndex == index
                          ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                          : IconButton(
                        icon: const Icon(Icons.download),
                        onPressed: () => _downloadAndOpen(file, index),
                      ),
                      onTap: () => _downloadAndOpen(file, index),
                    ),
                  );
                },
              ),
            ],
          ],
        ) : Container(height: MediaQuery.of(context).size.height*0.8  ,child:Center(child: Text("No Data Found!" ,style: TextStyle(fontWeight: FontWeight.bold , fontSize: 20),),),),
      ),
    );
  }

  /// DOWNLOAD + OPEN
  Future<void> _downloadAndOpen(AttachmentFile file, int index) async {
    try {
      setState(() {
        _downloading = true;
        _downloadingIndex = index;
      });

      final dir = await getApplicationDocumentsDirectory();
      final filePath = "${dir.path}/${file.name}";
      final localFile = File(filePath);

      if (!await localFile.exists()) {
        final response = await http.get(Uri.parse(file.url));
        await localFile.writeAsBytes(response.bodyBytes);
      }

      await OpenFilex.open(filePath);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to open file")),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _downloading = false;
          _downloadingIndex = -1;
        });
      }
    }
  }


}
