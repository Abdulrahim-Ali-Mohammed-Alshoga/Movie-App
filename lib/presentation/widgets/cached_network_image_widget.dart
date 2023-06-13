import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/business_logic/cubit/network/network_cubit.dart';
import 'package:movies/business_logic/cubit/network/network_state.dart';
import 'package:movies/constants/color_manager.dart';
import '../../constants/image_network_name.dart';

class CachedNetworkImageWidget extends StatefulWidget {
  CachedNetworkImageWidget({Key? key,this.width, this.height, this.image})
      : super(key: key);
  String? image;
  double? height,width;

  @override
  State<CachedNetworkImageWidget> createState() =>
      _CachedNetworkImageWidgetState();
}

class _CachedNetworkImageWidgetState extends State<CachedNetworkImageWidget> {
  double newKey = 0;

  @override
  Widget build(BuildContext context) {
    return BlocListener<NetworkCubit, NetworkState>(
      listener: (context, state) {
        if (state is NetworkIsConnected && newKey > 0) {
          setState(() {
            //newKey=0;
          });
        }
      },
      child: CachedNetworkImage(
        height: widget.height,
        width: widget.width,
        key: ValueKey(widget.image == null
            ? widget.image
            : widget.image! + newKey.toString()),
        imageBuilder: (context, imageProvider) {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.fill,
              ),
            ),
          );
        },
        imageUrl: widget.image == null
            ? "لل"
            : ImageNetworkName.rootImages + widget.image!,
        errorWidget: (context, url, error) {
          if (widget.image != null) {
            newKey++;
          }

          if (error.toString() == "Failed host lookup: 'image.tmdb.org'") {
            return GestureDetector(
              onTap: () {},
              child: Container(
                height: double.infinity,
                child: Center(
                    child: Icon(
                  Icons.wifi_off,
                  size: 30.sp,
                  color: ColorManager.deepOrange,
                )),
              ),
            );
          }
          return GestureDetector(
            onTap: () {},
            child: Center(
              child: Icon(
                Icons.image_not_supported,
                size: 30.sp,
              ),
            ),
          );
        },
        placeholder: (context, url) {
          return const Center(
            child: CircularProgressIndicator(color: ColorManager.deepOrange),
          );
        },
      ),
    );
  }
}
