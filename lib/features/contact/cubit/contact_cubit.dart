import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:whatsy/core/constant/data_base.dart';
import 'package:whatsy/core/model/user_model.dart';

part 'contact_state.dart';

class ContactCubit extends Cubit<ContactState> {
  ContactCubit() : super(ContactLoading());

  List<UserModel> phoneContacts = [];
  List<UserModel> firebaseContacts = [];

  Future<void> fetchContacts() async {
    emit(ContactLoading());
    try {
      if (await FlutterContacts.requestPermission()) {
        bool isContactFound = false;
        final userCollection = await Db.store.collection('users').get();

        final allPhoneContacts = await FlutterContacts.getContacts(
          withProperties: true,
        );

        for (var contact in allPhoneContacts) {
          for (var contactDoc in userCollection.docs) {
            var firebaseContact = UserModel.fromJson(contactDoc.data());
            if (contact.phones[0].number.replaceAll(' ', '') ==
                firebaseContact.phone) {
              firebaseContacts.add(firebaseContact);
              isContactFound = true;
              break;
            }
          }
          if (!isContactFound) {
            phoneContacts.add(
              UserModel(
                id: '',
                name: contact.displayName,
                imageUrl: '',
                lastSeen: 0,
                active: false,
                phone: contact.phones[0].number.replaceAll(' ', ''),
              ),
            );
          }
          isContactFound = false;
        }
        emit(ContactSuccess(contacts: [firebaseContacts, phoneContacts]));
      }
    } catch (e) {
      debugPrint(e.toString());
      emit(ContactError(error: 'Something went wrong, Please try again!'));
    }
  }
}
