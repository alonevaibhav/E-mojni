import 'package:emojni/Auth/sign_up_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';
import '../Constants/color_constant.dart';
import '../Controller/get_translation_controller/translated_uiutils.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpViewController());
    const double scaleFactor = 0.85;

    return Scaffold(
      backgroundColor: SetuColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w * scaleFactor * 0.8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Gap(10.h * scaleFactor * 0.8),
                  _buildHeader(scaleFactor)
                      .animate()
                      .fadeIn(duration: 800.ms)
                      .slideY(begin: -0.3, end: 0),
                  Gap(30.h * scaleFactor * 0.8),
                  _buildSignUpForm(controller, scaleFactor)
                      .animate()
                      .fadeIn(duration: 1000.ms, delay: 300.ms)
                      .slideY(begin: 0.3, end: 0)
                      .scale(begin: const Offset(0.9, 0.9)),
                  Gap(20.h * scaleFactor * 0.8),
                  _buildLoginLink(scaleFactor)
                      .animate()
                      .fadeIn(duration: 800.ms, delay: 600.ms),
                  Gap(20.h * scaleFactor * 0.8),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(double scaleFactor) {
    return Column(
      children: [
        Container(
          width: 100.w * scaleFactor * 0.8,
          height: 100.w * scaleFactor * 0.8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30 * scaleFactor * 0.8),
            gradient: LinearGradient(
              colors: [
                SetuColors.lightGreen.withOpacity(0.2),
                SetuColors.accent.withOpacity(0.1),
              ],
            ),
            border: Border.all(
              color: SetuColors.lightGreen.withOpacity(0.5),
              width: 2 * scaleFactor * 0.8,
            ),
            boxShadow: [
              BoxShadow(
                color: SetuColors.lightGreen.withOpacity(0.15),
                blurRadius: 20 * scaleFactor * 0.8,
                offset: Offset(0, 10 * scaleFactor * 0.8),
              ),
            ],
          ),
          child: Icon(
            PhosphorIcons.userPlus(PhosphorIconsStyle.regular),
            size: 50.sp * scaleFactor * 0.8,
            color: SetuColors.primaryGreen,
          ),
        ),
        Gap(20.h * scaleFactor * 0.8),
        Text(
          'Emojni',
          style: GoogleFonts.poppins(
            fontSize: 25.sp * scaleFactor * 0.8,
            fontWeight: FontWeight.bold,
            color: SetuColors.primaryDark,
          ),
        ),
        Gap(8.h * scaleFactor * 0.8),
        Text(
          'Create Your Account',
          style: GoogleFonts.inter(
            fontSize: 16.sp * scaleFactor * 0.8,
            color: SetuColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildSignUpForm(SignUpViewController controller, double scaleFactor) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24 * scaleFactor * 0.8),
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.8),
            Colors.white.withOpacity(0.6),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(
          color: SetuColors.lightGreen.withOpacity(0.3),
          width: 2 * scaleFactor * 0.8,
        ),
        boxShadow: [
          BoxShadow(
            color: SetuColors.lightGreen.withOpacity(0.15),
            blurRadius: 20 * scaleFactor * 0.8,
            offset: Offset(0, 10 * scaleFactor * 0.8),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15 * scaleFactor * 0.8,
            offset: Offset(0, 5 * scaleFactor * 0.8),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(24.w * scaleFactor * 0.8),
        child: Form(
          key: controller.formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Join Us!',
                style: GoogleFonts.poppins(
                  fontSize: 24.sp * scaleFactor * 0.8,
                  fontWeight: FontWeight.bold,
                  color: SetuColors.primaryDark,
                ),
              ),
              Gap(8.h * scaleFactor * 0.8),
              Text(
                'Sign up to access rural services',
                style: GoogleFonts.inter(
                  fontSize: 16.sp * scaleFactor * 0.8,
                  color: SetuColors.textSecondary,
                ),
              ),
              Gap(20.h * scaleFactor * 0.8),
              _buildUsernameField(controller, scaleFactor)
                  .animate()
                  .fadeIn(duration: 600.ms, delay: 100.ms)
                  .slideX(begin: -0.2, end: 0),
              Gap(16.h * scaleFactor * 0.8),
              _buildFullNameField(controller, scaleFactor)
                  .animate()
                  .fadeIn(duration: 600.ms, delay: 150.ms)
                  .slideX(begin: -0.2, end: 0),
              Gap(16.h * scaleFactor * 0.8),
              _buildEmailField(controller, scaleFactor)
                  .animate()
                  .fadeIn(duration: 600.ms, delay: 200.ms)
                  .slideX(begin: -0.2, end: 0),
              Gap(16.h * scaleFactor * 0.8),
              _buildPhoneField(controller, scaleFactor)
                  .animate()
                  .fadeIn(duration: 600.ms, delay: 250.ms)
                  .slideX(begin: -0.2, end: 0),
              Gap(16.h * scaleFactor * 0.8),
              _buildPasswordField(controller, scaleFactor)
                  .animate()
                  .fadeIn(duration: 600.ms, delay: 300.ms)
                  .slideX(begin: -0.2, end: 0),
              Gap(24.h * scaleFactor * 0.8),
              _buildSignUpButton(controller, scaleFactor)
                  .animate()
                  .fadeIn(duration: 600.ms, delay: 350.ms)
                  .scale(begin: const Offset(0.9, 0.9)),
            ],
          ),
        ),
      ),
    );
  }

  // Refactored form fields using TranslatedUIUtils
  Widget _buildUsernameField(SignUpViewController controller, double scaleFactor) {
    return TranslatedUIUtils.buildTextFormField(
      controller: controller.usernameController,
      label: 'Username',
      hint: 'Choose a username',
      icon: PhosphorIcons.user(PhosphorIconsStyle.regular),
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a username';
        }
        if (value.length < 3) {
          return 'Username must be at least 3 characters';
        }
        return null;
      },
      textInputAction: TextInputAction.next,
    );
  }

  Widget _buildFullNameField(SignUpViewController controller, double scaleFactor) {
    return TranslatedUIUtils.buildTextFormField(
      controller: controller.fullNameController,
      label: 'Full Name',
      hint: 'Enter your full name',
      icon: PhosphorIcons.identificationCard(PhosphorIconsStyle.regular),
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your full name';
        }
        if (value.length < 2) {
          return 'Name must be at least 2 characters';
        }
        return null;
      },
      textInputAction: TextInputAction.next,
    );
  }

  Widget _buildEmailField(SignUpViewController controller, double scaleFactor) {
    return TranslatedUIUtils.buildTextFormField(
      controller: controller.emailController,
      label: 'Email',
      hint: 'Enter your email',
      icon: PhosphorIcons.envelope(PhosphorIconsStyle.regular),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        if (!GetUtils.isEmail(value)) {
          return 'Please enter a valid email';
        }
        return null;
      },
      textInputAction: TextInputAction.next,
    );
  }

  Widget _buildPhoneField(SignUpViewController controller, double scaleFactor) {
    return TranslatedUIUtils.buildTextFormField(
      controller: controller.phoneController,
      label: 'Phone Number',
      hint: 'Enter your phone number',
      icon: PhosphorIcons.phone(PhosphorIconsStyle.regular),
      keyboardType: TextInputType.phone,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(10),
      ],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your phone number';
        }
        if (value.length != 10) {
          return 'Phone number must be 10 digits';
        }
        return null;
      },
      textInputAction: TextInputAction.next,
    );
  }

  Widget _buildPasswordField(SignUpViewController controller, double scaleFactor) {
    return Obx(() => TranslatedUIUtils.buildTextFormField(
      controller: controller.passwordController,
      label: 'Password',
      hint: 'Create a password',
      icon: PhosphorIcons.lock(PhosphorIconsStyle.regular),
      keyboardType: TextInputType.text,
      obscureText: !controller.isPasswordVisible.value,
      suffixIcon: GestureDetector(
        onTap: controller.togglePasswordVisibility,
        child: Icon(
          controller.isPasswordVisible.value
              ? PhosphorIcons.eyeSlash(PhosphorIconsStyle.regular)
              : PhosphorIcons.eye(PhosphorIconsStyle.regular),
          color: SetuColors.textSecondary,
          size: 24.sp * scaleFactor * 0.8,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a password';
        }
        if (value.length < 6) {
          return 'Password must be at least 6 characters';
        }
        return null;
      },
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (value) => controller.signUp(),
    ));
  }

  Widget _buildSignUpButton(SignUpViewController controller, double scaleFactor) {
    return SizedBox(
      width: double.infinity,
      height: 56.h * scaleFactor * 0.8,
      child: Obx(() => ElevatedButton(
        onPressed: controller.isLoading.value ? null : controller.signUp,
        style: ElevatedButton.styleFrom(
          backgroundColor: SetuColors.primaryGreen,
          foregroundColor: Colors.white,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16 * scaleFactor * 0.8),
          ),
          elevation: 0,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16 * scaleFactor * 0.8),
            boxShadow: [
              BoxShadow(
                color: SetuColors.primaryGreen.withOpacity(0.3),
                blurRadius: 12 * scaleFactor * 0.8,
                offset: Offset(0, 6 * scaleFactor * 0.8),
              ),
            ],
          ),
          child: Center(
            child: controller.isLoading.value
                ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 20.w * scaleFactor * 0.8,
                  height: 20.w * scaleFactor * 0.8,
                  child: CircularProgressIndicator(
                    strokeWidth: 2 * scaleFactor * 0.8,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
                Gap(12.w * scaleFactor * 0.8),
                Text(
                  'Creating Account...',
                  style: GoogleFonts.inter(
                    fontSize: 18.sp * scaleFactor * 0.8,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            )
                : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  PhosphorIcons.userPlus(PhosphorIconsStyle.bold),
                  color: Colors.white,
                  size: 24.sp * scaleFactor * 0.8,
                ),
                Gap(12.w * scaleFactor * 0.8),
                Text(
                  'Sign Up',
                  style: GoogleFonts.inter(
                    fontSize: 18.sp * scaleFactor * 0.8,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }

  Widget _buildLoginLink(double scaleFactor) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Already have an account? ',
            style: GoogleFonts.inter(
              fontSize: 16.sp * scaleFactor * 0.8,
              color: SetuColors.textSecondary,
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text(
              'Sign In',
              style: GoogleFonts.inter(
                fontSize: 20.sp * scaleFactor * 0.8,
                color: SetuColors.primaryGreen,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
