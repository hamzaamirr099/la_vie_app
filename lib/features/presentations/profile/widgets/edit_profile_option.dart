import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class EditProfileOption extends StatelessWidget {
  final String option;
  final VoidCallback onTapFunction;

  const EditProfileOption(
      {Key? key, required this.option, required this.onTapFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // debugPrint("edit profile");
      // HomeCubit.get(context).updateUserName(CacheHelper.getData(key: 'userToken'));
      // print(HomeCubit.get(context).userData!.data!.firstName);

      onTap: onTapFunction,
      child: Container(
        width: double.infinity,
        height: 80.0,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              SvgPicture.asset("assets/images/profileIcon.svg"),
              const SizedBox(
                width: 10.0,
              ),
              Text(
                option,
                style: const TextStyle(fontSize: 18.0),
              ),
              const Spacer(),
              const Icon(
                Icons.arrow_forward,
                color: Color.fromRGBO(29, 89, 44, 1),
              )
            ],
          ),
        ),
      ),
    );
  }
}
