import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quizapp/service/data.dart';
import 'package:random_string/random_string.dart';

class AddQuizScreen extends StatefulWidget {
  const AddQuizScreen({super.key});

  @override
  State<AddQuizScreen> createState() => _AddQuizScreenState();
}

final TextEditingController option1TEController = TextEditingController();
final TextEditingController option2TEController = TextEditingController();
final TextEditingController option3TEController = TextEditingController();
final TextEditingController option4TEController = TextEditingController();
final TextEditingController correctAnsTEController = TextEditingController();

final List<String> quizItem = [
  'Python',
  'Dart',
  'Java',
  'Javascript',
  'Php',
  'Swift'
];

class _AddQuizScreenState extends State<AddQuizScreen> {
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;
  String? value;
  Future getImage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    selectedImage = File(image!.path);
    setState(() {});
  }

  uploadItem() async {
    if (selectedImage != null &&
        option1TEController.text != "" &&
        option2TEController.text != "" &&
        option3TEController.text != "" &&
        option3TEController.text != "" &&
        option4TEController.text != "") {
      String addId = randomAlphaNumeric(10);
      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child("blogImage").child(addId);
      final UploadTask task = firebaseStorageRef.putFile(selectedImage!);
      var downloadUrl = await (await task).ref.getDownloadURL();
      Map<String, dynamic> addQuiz = {
        "Image": downloadUrl,
        "option1": option1TEController.text,
        "option2": option2TEController.text,
        "option3": option3TEController.text,
        "option4": option4TEController.text,
        "correct": correctAnsTEController.text,
      };

      await DatabaseMethods().addQuizCategory(addQuiz, value!).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
          "Quiz has been Added!!",
          style: TextStyle(fontSize: 20),
        )));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Add Quiz",
          style: TextStyle(
              color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin:
              const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Upload the quiz Picture",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              selectedImage == null
                  ? GestureDetector(
                      onTap: () {
                        getImage();
                      },
                      child: Center(
                        child: Material(
                          borderRadius: BorderRadius.circular(20),
                          elevation: 4,
                          child: Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 1.5),
                                borderRadius: BorderRadius.circular(20)),
                            child: const Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    )
                  : Center(
                      child: Material(
                        borderRadius: BorderRadius.circular(20),
                        elevation: 4,
                        child: Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 1.5),
                              borderRadius: BorderRadius.circular(20)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.file(
                              selectedImage!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Option 1",
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(15)),
                child: TextFormField(
                  controller: option1TEController,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Option 1",
                      hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600)),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Option 2",
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(15)),
                child: TextFormField(
                  controller: option2TEController,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Option 2",
                      hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600)),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Option 3",
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(15)),
                child: TextFormField(
                  controller: option3TEController,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Option 3",
                      hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600)),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Option 4",
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(15)),
                child: TextFormField(
                  controller: option4TEController,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Option 4",
                      hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600)),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Correct Answer",
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(15)),
                child: TextFormField(
                  controller: correctAnsTEController,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter The Correct Answer",
                      hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600)),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(15)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    items: quizItem
                        .map((item) => DropdownMenuItem(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.black),
                            )))
                        .toList(),
                    onChanged: (v) {
                      setState(() {
                        value = v;
                      });
                      print(value);
                    },
                    dropdownColor: Colors.white,
                    hint: const Text(
                      "Select Categories",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    iconSize: 36,
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                    ),
                    value: value,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: (){
                  uploadItem();
                },
                child: Center(
                  child: Material(
                    elevation: 4,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10)),
                      width: 150,
                      child: const Center(
                        child: Text(
                          "Add",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
