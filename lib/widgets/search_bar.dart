import 'package:flutter/material.dart';

class SearchActionField extends StatelessWidget {
  const SearchActionField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      margin: const EdgeInsets.only(left: 15),
      child: Material(
        borderRadius: BorderRadius.circular(7),
        elevation: 1,
        child: TextFormField(
          decoration: InputDecoration(
              prefixIcon: InkWell(
                onTap: () {},
                child: const Padding(
                  padding: EdgeInsets.only(
                    left: 6,
                  ),
                  child: Icon(
                    Icons.search,
                    color: Colors.black,
                    size: 23,
                  ),
                ),
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.only(top: 10),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(7),
                ),
                borderSide: BorderSide.none,
              ),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(7),
                ),
                borderSide: BorderSide(
                  color: Colors.black38,
                  width: 1,
                ),
              ),
              hintText: 'Search here..',
              hintStyle:
                  const TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
        ),
      ),
    );
  }
}
