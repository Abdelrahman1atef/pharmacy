import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy/app_bloc_providers.dart';
import 'package:pharmacy/pharmacy_app.dart';
import 'package:pharmacy/utils/device_size.dart';
import 'package:pharmacy/utils/network_image_utils.dart';

import 'core/di/module.dart';
import 'core/themes/text_styles.dart';
import 'features/details/logic/favorite/favorite_cubit.dart';
import 'features/details/logic/favorite/favorite_state.dart';
import 'features/home/ui/home/widgets/best_seller_widget.dart';
import 'gen/assets.gen.dart';
import 'gen/colors.gen.dart';
import 'gen/fonts.gen.dart';
import 'generated/l10n.dart';

void main() {
  setupDependencies();

  runApp( const AppBlocProviders(child: PharmacyApp()));

}
