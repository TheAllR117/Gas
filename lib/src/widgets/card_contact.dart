import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gasfast/src/helpers/helpers.dart';
import 'package:gasfast/src/models/contact/contact_list_response.dart';
import 'package:gasfast/src/providers/ui_provider.dart';
import 'package:gasfast/src/services/contact_service.dart';
import 'package:provider/provider.dart';

class CardContact extends StatelessWidget {
  final PartnerL? partnerL;
  final bool? delete;
  const CardContact({Key? key, this.partnerL, this.delete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final contactService = new ContactService();
    final uiProvider = Provider.of<UiProvider>(context);
    final size = MediaQuery.of(context).size;
    return FadeIn(
      child: Container(
          child: GestureDetector(
        onTap: () {
          contactService.partnerL = partnerL;
          uiProvider.selectViewInter = 1;
        },
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Colors.black,
                Colors.black,
                Colors.black,
                Colors.black,
              ],
            ),
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 1,
                offset: Offset(1.5, 1.5), // changes position of shadow
              ),
            ],
          ),
          child: Slidable(
            actionPane: SlidableDrawerActionPane(),
            actionExtentRatio: 0.25,
            child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      child: Icon(
                        Icons.person_outline,
                        color: Color.fromRGBO(245, 223, 76, 1.0),
                        size: size.height * 0.1,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Membresía',
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                        ),
                        Text(
                          '${partnerL!.membership}',
                          style: TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 16),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Nombre',
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                        ),
                        Text(
                          '${partnerL!.name}',
                          style: TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                )),
            actions: <Widget>[
              (delete!)
                  ? _actionDelete(context, contactService)
                  : _actionAdd(context, contactService)
            ],
            secondaryActions: <Widget>[
              (delete!)
                  ? _actionDelete(context, contactService)
                  : _actionAdd(context, contactService)
            ],
          ),
        ),
      )),
    );
  }

  Widget _actionDelete(BuildContext context, ContactService contactService) {
    return IconSlideAction(
      foregroundColor: Color.fromRGBO(245, 223, 76, 1.0),
      //caption: 'Archive',
      color: Colors.black,
      icon: Icons.delete_forever,
      onTap: () async {
        final resp =
            await contactService.deleteContact(partnerL!.clientId.toString());
        if (resp.ok!) {
          showAlert(context, 'Exito', resp.message!);
        } else {
          showAlert(context, 'Error', resp.message!);
        }
      },
    );
  }

  Widget _actionAdd(BuildContext context, ContactService contactService) {
    return IconSlideAction(
      foregroundColor: Color.fromRGBO(245, 223, 76, 1.0),
      //caption: 'Archive',
      color: Colors.black,
      icon: Icons.save,
      onTap: () async {
        final resp =
            await contactService.addContact(partnerL!.clientId.toString());
        if (resp.ok!) {
          showAlert(context, 'Exito', resp.message!);
        } else {
          showAlert(context, 'Error', resp.message!);
        }
      },
    );
  }
}
