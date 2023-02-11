import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:matrimonycrud/models/persons_model.dart';
import 'package:matrimonycrud/pages/home_page.dart';
import 'package:matrimonycrud/services/db_service.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key, this.model, this.isEditMode = false})
      : super(key: key);
  final PersonModel? model;
  final bool isEditMode;

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  TextEditingController _DateOfBirthController = TextEditingController();
  DateTime? _dateOfBirth;
  bool isDisableButton = true;
  late DateTime initialDate;
  late PersonModel user;
  late int a;
  late DBService dbService;
  List<dynamic> gen = [
    {"id": "1", "name": "Male"},
    {"id": "2", "name": "Female"},
    {"id": "3", "name": "Others"}
  ];
  List<dynamic> fav = [
    {"id": "0", "name": "Yes"},
    {"id": "1", "name": "No"},
  ];

  String countryValue = '';
  String stateValue = '';
  String cityValue = '';

  String address = "";
  @override
  void initState() {
    dbService = DBService();
    super.initState();
    user = PersonModel(
      personName: "",
      age: 0,
      contactNum: '',
      date: "",
      email: "",
      gender: 0,
      city: '',
      state: '',
      country: '',
      IsFavorite: 0,
    );

    if (user.contactNum == null) {
      user.contactNum = '';
    }
    if (user.email == null) {
      user.email = "";
    }

    if (widget.isEditMode) {
      user = widget.model!;
      List<String> n = user.date.split("/");
      initialDate = DateTime.parse(n[2] + '-' + n[1] + '-' + n[0]);
    } else {
      initialDate = DateTime.now();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(34, 33, 91, 1),
        title: Text(
          widget.isEditMode ? 'Edit Details' : "Add Details",
          style: const TextStyle(fontSize: 23.0, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                Form(
                  key: globalKey,
                  child: _formUI(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _formUI() {
    return SingleChildScrollView(
      child: Column(
        children: [
          FormHelper.inputFieldWidgetWithLabel(
            context,
            "PersonName",
            "Name",
            "",
            (onValidate) {
              if (onValidate.isEmpty) {
                return "* Required";
              }
              return null;
            },
            (onSaved) {
              user.personName = onSaved.toString().trim();
            },
            focusedBorderWidth: 1,
            borderWidth: 1,
            borderColor: Color.fromRGBO(34, 33, 91, 1),
            labelFontSize: 15,
            labelBold: true,
            paddingLeft: 0,
            borderRadius: 10,
            prefixIcon: const Icon(Icons.account_circle_rounded),
            showPrefixIcon: true,
            prefixIconPaddingLeft: 10,
            prefixIconColor: const Color.fromRGBO(34, 33, 91, .5),
            textColor: const Color.fromRGBO(34, 33, 91, 1),
            borderFocusColor: Colors.redAccent,
            contentPadding: 15,
            fontSize: 15,
            paddingRight: 0,
            initialValue: user.personName,
          ),
          FormHelper.dropDownWidgetWithLabel(
            context,
            "Gender",
            "--Select--",
            user.gender,
            gen,
            (onChanged) {
              user.gender = int.parse(onChanged);
            },
            (onValidate) {
              if (onValidate == null) {
                return "* Required";
              }
              return null;
            },
            borderRadius: 10,
            paddingRight: 0,
            paddingLeft: 0,
            labelFontSize: 15,
            borderFocusColor: Colors.redAccent,
            borderColor: Color.fromRGBO(34, 33, 91, 1),
            prefixIcon: const Icon(Icons.male),
            showPrefixIcon: true,
            prefixIconPaddingLeft: 10,
            prefixIconColor: const Color.fromRGBO(34, 33, 91, .5),
            focusedBorderWidth: 1,
          ),
          Column(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(top: 15),
                child: const Text(
                  "Date of Birth",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                child: TextFormField(
                  onSaved: (d) async {
                    user.date = d.toString();
                    user.age = await a;
                  },
                  decoration: InputDecoration(
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      color: Color.fromRGBO(34, 33, 91, 1),
                    ),
                    contentPadding: const EdgeInsets.all(15),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color.fromRGBO(34, 33, 91, 1),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color.fromRGBO(34, 33, 91, 1),
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    prefixIcon: const Icon(
                      Icons.date_range_rounded,
                      color: Color.fromRGBO(34, 33, 91, .5),
                    ),
                  ),
                  controller: _DateOfBirthController,
                  keyboardType: TextInputType.name,
                  onTap: () => pickDateOfBirth(context),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Select Date';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          FormHelper.inputFieldWidgetWithLabel(
              context, "MobileNumber", "Mobile Number", "", (onValidate) {},
              (onSaved) {
            user.contactNum = onSaved;
          },
              focusedBorderWidth: 1,
              borderWidth: 1,
              borderColor: Color.fromRGBO(34, 33, 91, 1),
              labelFontSize: 15,
              labelBold: true,
              paddingLeft: 0,
              borderRadius: 10,
              prefixIcon: const Icon(Icons.call),
              showPrefixIcon: true,
              prefixIconPaddingLeft: 10,
              prefixIconColor: const Color.fromRGBO(34, 33, 91, .5),
              textColor: const Color.fromRGBO(34, 33, 91, 1),
              borderFocusColor: Colors.redAccent,
              contentPadding: 10,
              fontSize: 15,
              paddingRight: 0,
              isNumeric: true,
              initialValue: user.contactNum.toString()),
          FormHelper.inputFieldWidgetWithLabel(
            context,
            "Email",
            "Email",
            "",
            (onValidate) {},
            (onSaved) {
              user.email = onSaved.toString().trim();
            },
            initialValue: user.email.toString(),
            focusedBorderWidth: 1,
            borderWidth: 1,
            borderColor: Color.fromRGBO(34, 33, 91, 1),
            labelFontSize: 15,
            labelBold: true,
            paddingLeft: 0,
            borderRadius: 10,
            prefixIcon: const Icon(Icons.email),
            showPrefixIcon: true,
            prefixIconPaddingLeft: 10,
            prefixIconColor: const Color.fromRGBO(34, 33, 91, .5),
            textColor: const Color.fromRGBO(34, 33, 91, 1),
            borderFocusColor: Colors.redAccent,
            contentPadding: 15,
            fontSize: 15,
            paddingRight: 0,
          ),
          Column(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(top: 15),
                child: const Text(
                  "Location",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: CSCPicker(
                  currentCountry:
                      user.country.isNotEmpty ? user.country : '*Country',
                  currentState: user.state.isNotEmpty ? user.state : '*State',
                  currentCity: user.city.isNotEmpty ? user.city : '*City',
                  showStates: true,
                  showCities: true,
                  flagState: CountryFlag.ENABLE,
                  dropdownDecoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: Colors.white,
                    border: Border.all(
                        color: Color.fromRGBO(34, 33, 91, 1), width: 1),
                  ),
                  disabledDropdownDecoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: Colors.grey.shade300,
                    border: Border.all(
                        color: Color.fromRGBO(34, 33, 91, 1), width: 1),
                  ),
                  countrySearchPlaceholder: "Country",
                  stateSearchPlaceholder: "State",
                  citySearchPlaceholder: "City",
                  countryDropdownLabel: "*Country",
                  stateDropdownLabel: "*State",
                  cityDropdownLabel: "*City",
                  selectedItemStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                  dropdownHeadingStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                  dropdownItemStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                  dropdownDialogRadius: 10.0,
                  searchBarRadius: 10.0,
                  onCountryChanged: (value) {
                    setState(() {
                      countryValue = value;
                      user.country = countryValue;
                    });
                  },
                  onStateChanged: (value) {
                    setState(() {
                      stateValue = value.toString();
                      user.state = stateValue;
                    });
                  },
                  onCityChanged: (value) {
                    setState(
                      () {
                        cityValue = value.toString();
                        user.city = cityValue;
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: isDisableButton
                    ? null
                    : () {
                        if (validateAndSave()) {
                          if (widget.isEditMode) {
                            dbService.updatePerson(user).then((value) {
                              FormHelper.showSimpleAlertDialog(
                                  context,
                                  "SQFlite",
                                  "Data Modified Successfully ",
                                  "Ok", () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const MyHomePage(title: '')),
                                );
                              });
                            });
                            globalKey.currentState!.save();
                          } else {
                            dbService.addPerson(user).then((value) {
                              FormHelper.showSimpleAlertDialog(
                                  context,
                                  "SQFlite",
                                  "Data added successfully ",
                                  "Ok", () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const MyHomePage(title: '')),
                                );
                              });
                            });
                            globalKey.currentState!.save();
                          }
                        }
                      },
                child: const Text('Submit'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> pickDateOfBirth(BuildContext context) async {
    final newDate = await showDatePicker(
        context: context,
        initialDate: _dateOfBirth ?? initialDate,
        firstDate: DateTime(DateTime.now().year - 100),
        lastDate: DateTime(DateTime.now().year + 1),
        builder: (context, child) => Theme(
              data: ThemeData().copyWith(
                  colorScheme: const ColorScheme.light(
                primary: Colors.redAccent,
              )),
              child: child ?? const Text(''),
            ));
    if (newDate == null) {
      return;
    }
    setState(() {
      _dateOfBirth = newDate;
      String dob = DateFormat('dd/MM/yyyy').format(newDate);
      _DateOfBirthController.text = dob;
      a = calculateAge(newDate);
    });
  }

  calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    if (user.gender == 1 && age >= 21) {
      isDisableButton = false;
    } else if (user.gender == 2 && age >= 18) {
      isDisableButton = false;
    } else if (user.gender == 3 && age >= 18) {
      isDisableButton = false;
    } else {
      isDisableButton = true;
    }
    return age;
  }

  bool validateAndSave() {
    final form = globalKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
