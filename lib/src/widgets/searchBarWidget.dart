import 'package:ironbox/src/helpers/helper.dart';
import 'package:flutter/material.dart';
import '../helpers/app_constants.dart' as Constants;

class SearchBarWidget extends StatelessWidget {
  Function searchPlans;
  SearchBarWidget(this.searchPlans);
  TextEditingController _planSearchController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
      height: Helper.of(context).getScreenHeight() * 0.10,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.8),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15.0),
          bottomRight: Radius.circular(15.0),
        ),
      ),
      child: TextFormField(
        controller: _planSearchController,
        keyboardType: TextInputType.text,
        // onSaved: (input) => _email = input,
        // validator: (input) =>
        //     !input.contains('@') ? Constants.invalidEmail : null,
        onFieldSubmitted: (String value) {
          print(value);
          searchPlans(value);
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10),
          fillColor: Theme.of(context).scaffoldBackgroundColor,
          filled: true,
          labelText: Constants.search,
          labelStyle: Helper.of(context)
              .textStyle(size: 12.0, color: Theme.of(context).accentColor),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          suffixIcon: GestureDetector(
            onTap: () {
              print(_planSearchController.text);
              searchPlans(_planSearchController.text);
            },
            child: Icon(
              Icons.search,
              color: Theme.of(context).primaryColor,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(150.0),
            ),
          ),
        ),
      ),
    );
  }
}
