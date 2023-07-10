import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mallu_calls/admin/add/provider/add_view_provider.dart';
import 'package:mallu_calls/admin/add/view/widget/dash_painter.dart';
import 'package:mallu_calls/util/colors.dart';
import 'package:mallu_calls/util/responsive.dart';
import 'package:provider/provider.dart';

class AddView extends StatefulWidget {
  const AddView({super.key});

  @override
  State<AddView> createState() => _AddViewState();
}

class _AddViewState extends State<AddView> {
  AddViewProvider? provider;
  @override
  void initState() {
    super.initState();
    provider = context.read<AddViewProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          "Add New Call",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff671af0),
                Color(0xff671af0),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                CustomPaint(
                  painter: DashRectPainter(
                    color: const Color(0xff671af0),
                    strokeWidth: 1,
                    gap: 5,
                  ),
                  child: SizedBox(
                    height: Responsive.height! * 12,
                    width: Responsive.width! * 28,
                    child: Consumer<AddViewProvider>(
                      builder: (context, obj, _) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: Responsive.width! * 1),
                            Expanded(
                              child: obj.imageFile == null
                                  ? const Text(
                                      "Profile Picture",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'Galano',
                                        fontSize: 14,
                                        color: Apc.blackColor,
                                      ),
                                    )
                                  : Image.file(
                                      obj.imageFile!,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            SizedBox(width: Responsive.width! * 1),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(width: Responsive.width! * 3),
                TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onPressed: () {
                    provider?.pickImage();
                  },
                  child: Text(
                    "Upload".toUpperCase(),
                    style: const TextStyle(
                      fontFamily: 'Galano',
                      fontSize: 16,
                      color: Apc.blackColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: Responsive.height! * 2),
            TextFieldWidget(
              name: "Name",
              controller: provider!.nameController,
            ),
            SizedBox(height: Responsive.height! * 2),
            TextFieldWidget(
              name: "Place",
              controller: provider!.placeController,
            ),
            SizedBox(height: Responsive.height! * 2),
            TextFieldWidget(
              name: "Coin for making call",
              controller: provider!.coinsController,
              textInputType: TextInputType.number,
            ),
            SizedBox(height: Responsive.height! * 2),
            GestureDetector(
              onTap: () {
                provider?.pickVideo();
              },
              child: CustomPaint(
                painter: DashRectPainter(
                  color: const Color(0xff671af0),
                  strokeWidth: 1,
                  gap: 5,
                ),
                child: SizedBox(
                  width: Responsive.width! * 100,
                  height: Responsive.height! * 5.5,
                  child: Row(
                    children: [
                      SizedBox(width: Responsive.width! * 4),
                      Consumer<AddViewProvider>(
                        builder: (context, obj, _) {
                          return Expanded(
                            child: Text(
                              obj.videoFile == null
                                  ? "Select Video"
                                  : obj.videoFile!.path.split("/").last,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontFamily: 'Galano',
                                fontSize: 14,
                                color: Apc.blackColor,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: Responsive.height! * 2),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.width! * 4,
                vertical: Responsive.height! * 2,
              ),
              height: Responsive.height! * 6,
              width: Responsive.width! * 100,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xff671af0),
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  const Text(
                    "Normal Call",
                    style: TextStyle(
                      fontFamily: 'Galano',
                      fontSize: 14,
                      color: Apc.blackColor,
                    ),
                  ),
                  const Spacer(),
                  Selector<AddViewProvider, bool>(
                    selector: (context, obj) => obj.normalCallSelected,
                    builder: (context, value, _) {
                      return CupertinoSwitch(
                        activeColor: const Color(0xff671af0),
                        value: value,
                        onChanged: (value) {
                          provider?.normalCall(value: value);
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: Responsive.height! * 2),
            SizedBox(
              width: Responsive.width! * 100,
              height: Responsive.height! * 5.5,
              child: MaterialButton(
                color: const Color(0xff671af0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                onPressed: () {
                  provider?.upload();
                },
                child: Selector<AddViewProvider, bool>(
                  selector: (context, obj) => obj.isLoading,
                  builder: (context, loading, _) {
                    return loading
                        ? const CupertinoActivityIndicator(
                            color: Apc.whiteColor,
                          )
                        : const Text(
                            "SUBMIT",
                            style: TextStyle(
                              fontFamily: 'Galano',
                              fontSize: 16,
                              color: Apc.whiteColor,
                            ),
                          );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    required this.name,
    required this.controller,
    this.textInputType,
  });

  final String name;
  final TextEditingController controller;
  final TextInputType? textInputType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: textInputType,
      controller: controller,
      style: const TextStyle(
        fontFamily: 'Galano',
        fontSize: 14,
        color: Color(0xff000000),
      ),
      inputFormatters: const [],
      decoration: InputDecoration(
        labelText: name,
        labelStyle: const TextStyle(
          fontFamily: 'Galano',
          fontSize: 14,
          color: Color(0xff000000),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: Responsive.width! * 4,
        ),
        hintText: name,
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xff671af0),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xff671af0),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xff671af0),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xff671af0),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
    );
  }
}
