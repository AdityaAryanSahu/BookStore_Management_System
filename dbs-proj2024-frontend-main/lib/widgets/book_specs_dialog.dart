import 'package:flutter/material.dart';

import '../models/book.dart';

Dialog getBookSpecificationsDialogObject(BuildContext context, Book book) {
  return Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    //this right here
    child: SizedBox(
      height: 300.0,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Published by: ${book.publisher!}",
            textAlign: TextAlign.center,
            style: const TextStyle(letterSpacing: 1),
          ),
          Text(
            "Formats currently available: ${book.format!}",
            textAlign: TextAlign.center,
            style: const TextStyle(letterSpacing: 1),
          ),
          Text(
            "Edition: ${book.edition!}",
            textAlign: TextAlign.center,
            style: const TextStyle(letterSpacing: 1),
          ),
          Text(
            "ISBN: ${book.isbn!}",
            textAlign: TextAlign.center,
            style: const TextStyle(letterSpacing: 1),
          ),
          Visibility(
            visible: book.format != "Audio",
            child: Text(
              "Physical Dimensions:\nX: ${book.dimensionX} mm"
              "\nY: ${book.dimensionY} mm\nZ: ${book.dimensionZ} mm"
              "\nWeight: ${book.dimensionW} g",
              textAlign: TextAlign.center,
              style: const TextStyle(letterSpacing: 1),
            ),
          ),
        ],
      ),
    ),
  );
}
