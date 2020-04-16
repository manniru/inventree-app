
import 'package:InvenTree/api.dart';
import 'package:InvenTree/inventree/company.dart';
import 'package:InvenTree/widget/drawer.dart';
import 'package:InvenTree/widget/refreshable_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CompanyDetailWidget extends StatefulWidget {

  final InvenTreeCompany company;

  CompanyDetailWidget(this.company, {Key key}) : super(key: key);

  @override
  _CompanyDetailState createState() => _CompanyDetailState(company);

}


class _CompanyDetailState extends RefreshableState<CompanyDetailWidget> {

  final InvenTreeCompany company;

  @override
  String getAppBarTitle(BuildContext context) { return "Company"; }

  @override
  Future<void> request(BuildContext context) async {
    await company.reload(context);
  }

  _CompanyDetailState(this.company) {
    // TODO
  }

  List<Widget> _companyTiles() {

    var tiles = List<Widget>();

    bool sep = false;

    tiles.add(Card(
      child: ListTile(
        title: Text("${company.name}"),
        subtitle: Text("${company.description}"),
        leading: Image(
          image: InvenTreeAPI().getImage(company.image),
          width: 48,
        ),
      ),
    ));

  if (company.website.isNotEmpty) {
    tiles.add(ListTile(
      title: Text("${company.website}"),
      leading: FaIcon(FontAwesomeIcons.globe),
      onTap: () {
        // TODO - Open website
      },
    ));

    sep = true;
  }

  if (company.email.isNotEmpty) {
    tiles.add(ListTile(
      title: Text("${company.email}"),
      leading: FaIcon(FontAwesomeIcons.at),
      onTap: () {
        // TODO - Open email
      },
    ));

    sep = true;
  }

  if (company.phone.isNotEmpty) {
    tiles.add(ListTile(
      title: Text("${company.phone}"),
      leading: FaIcon(FontAwesomeIcons.phone),
      onTap: () {
        // TODO - Call phone number
      },
    ));

    sep = true;
  }

    // External link
    if (company.link.isNotEmpty) {
      tiles.add(ListTile(
        title: Text("${company.link}"),
        leading: FaIcon(FontAwesomeIcons.link),
        onTap: () {
          // TODO - Open external link
        },
      ));

      sep = true;
    }

    if (sep) {
      tiles.add(Divider());
    }

    if (company.isSupplier) {
      // TODO - Add list of supplier parts
      // TODO - Add list of purchase orders

      tiles.add(Divider());
    }

    if (company.isCustomer) {

      // TODO - Add list of sales orders

      tiles.add(Divider());
    }

    if (company.notes.isNotEmpty) {
      tiles.add(ListTile(
        title: Text("Notes"),
        leading: FaIcon(FontAwesomeIcons.stickyNote),
        onTap: null,
      ));
    }

    return tiles;
  }

  @override
  Widget getBody(BuildContext context) {

    return Center(
      child: ListView(
        children: _companyTiles(),
      )
    );
  }
}