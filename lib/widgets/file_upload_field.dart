import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class FilePickerDropdown extends StatefulWidget {
  final String label;
  final File? fileName;
  final void Function(File?) onFileSelected;

  FilePickerDropdown({
    required this.label,
    required this.fileName,
    required this.onFileSelected,
  });

  @override
  _FilePickerDropdownState createState() => _FilePickerDropdownState();
}

class _FilePickerDropdownState extends State<FilePickerDropdown> {
  File? selectedFile;

  Future<void> selectFile() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final file = File(pickedFile.path);
      setState(() {
        selectedFile = file;
      });
      widget.onFileSelected(file);
    }
  }

  void clearSelectedFile() {
    setState(() {
      selectedFile = null;
    });
    widget.onFileSelected(null);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          textScaleFactor: MediaQuery.of(context).textScaleFactor,
          textAlign: TextAlign.start,
          text: TextSpan(
            children: [
              TextSpan(
                text: widget.label,
                style: const TextStyle(
                  fontSize: 14, // Adjust the font size as needed
                  color: Colors.grey, // Change the color as needed
                  fontFamily: "Helvetica",
                ),
              ),
              const TextSpan(
                text: "*",
                style: TextStyle(
                  fontSize: 14, // Adjust the font size as needed
                  color: Colors.red, // Change the color as needed
                  fontFamily: "Helvetica",
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 2),
        Padding(
          padding: const EdgeInsets.only(right: 40),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: TextFormField(
                    readOnly: true,
                    controller: TextEditingController(
                      text: selectedFile != null ? selectedFile!.path : '',
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      counterText: "",
                      suffixIcon: selectedFile != null
                          ? Padding(
                              padding: const EdgeInsets.only(right: 5.0),
                              child: IconButton(
                                icon: const Icon(Icons.clear, size: 20, color: Colors.red),
                                onPressed: clearSelectedFile,
                              ),
                            )
                          : null,
                      suffixIconConstraints: const BoxConstraints(),
                      filled: true,
                      isDense: true,
                      border: InputBorder.none,
                      hintText: 'document.jpg',
                      hintStyle: const TextStyle(
                        color: Colors.grey, // Change the color as needed
                        fontFamily: "Helvetica",
                        fontSize: 14, // Adjust the font size as needed
                      ),
                      fillColor: Colors.grey[200], // Change the background color as needed
                    ),
                    style: const TextStyle(
                      fontSize: 14, // Adjust the font size as needed
                      fontFamily: "Helvetica",
                    ),
                    onChanged: (value) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: GestureDetector(
                  onTap: selectFile,
                  child: const Text(
                    "Select a file",
                    style: TextStyle(
                      color: Colors.blue, // Change the color as needed
                      fontWeight: FontWeight.w400,
                      fontSize: 14, // Adjust the font size as needed
                      fontFamily: "Helvetica",
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

