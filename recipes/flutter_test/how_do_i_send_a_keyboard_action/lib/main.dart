import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MyForm(),
      ),
    );
  }
}

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  // We are creating controllers and focus nodes for our two text fields
  TextEditingController firstNameController;
  FocusNode firstNameFocusNode;

  TextEditingController lastNameController;
  FocusNode lastNameFocusNode;

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController();
    firstNameFocusNode = FocusNode();

    lastNameController = TextEditingController();
    lastNameFocusNode = FocusNode();
  }

  // and we are cleaning up after ourselves by disposing the controllers and focus nodes
  @override
  void dispose() {
    firstNameController.dispose();
    firstNameFocusNode.dispose();

    lastNameController.dispose();
    lastNameFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          decoration: InputDecoration(labelText: "First name"),
          textInputAction: TextInputAction.next,
          controller: firstNameController,
          focusNode: firstNameFocusNode,
          // When a user hits 'next' on the keyboard, it will unfocus firstName and focus lastName
          onSubmitted: (String _firstName) {
            firstNameFocusNode.unfocus();
            FocusScope.of(context).requestFocus(lastNameFocusNode);
          },
        ),
        TextField(
          decoration: InputDecoration(labelText: "Last name"),
          textInputAction: TextInputAction.done,
          controller: lastNameController,
          focusNode: lastNameFocusNode,
          // When a user hits 'done' on the keyboard, it will unfocus lastName and then show a SnackBar with the full name
          onSubmitted: (String _lastName) {
            lastNameFocusNode.unfocus();
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(
                  "Your name is: ${firstNameController.text} ${lastNameController.text}"),
            ));
          },
        ),
      ],
    );
  }
}
