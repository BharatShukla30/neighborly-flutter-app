import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:neighborly_flutter_app/core/utils/helpers.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_style.dart';
import '../../../../core/widgets/text_field_widget.dart';
import '../bloc/resend_otp_bloc/resend_otp_bloc.dart';
import '../bloc/register_with_email_bloc/register_with_email_bloc.dart';
import '../widgets/button_widget.dart';
import '../widgets/dob_picker_widget.dart';

class RegisterWithEmailScreen extends StatefulWidget {
  const RegisterWithEmailScreen({super.key});

  @override
  State<RegisterWithEmailScreen> createState() =>
      _RegisterWithEmailScreenState();
}

class _RegisterWithEmailScreenState extends State<RegisterWithEmailScreen> {
  bool isActive = false;
  bool isEmailFilled = false;
  bool isPasswordFilled = false;
  bool isConfirmPasswordFilled = false;
  bool isDayFilled = false;
  bool isMonthFilled = false;
  bool isYearFilled = false;
  bool isEmailValid = true;
  bool isPasswordShort = false;

  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  late TextEditingController _dateController;
  late TextEditingController _monthController;
  late TextEditingController _yearController;
  String _selectedGender = 'male';

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _dateController = TextEditingController();
    _monthController = TextEditingController();
    _yearController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _dateController.dispose();
    _monthController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  bool checkIsActive() {
    return isEmailFilled &&
        isPasswordFilled &&
        isConfirmPasswordFilled &&
        _passwordController.text == _confirmPasswordController.text;
  }

  String formatDOB(String day, String month, String year) {
    return '$year-$month-$day';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: InkWell(
            child: const Icon(
              Icons.arrow_back_ios,
              size: 15,
            ),
            onTap: () {
              context.pop();
            },
          ),
          centerTitle: true,
          title: Row(
            children: [
              const SizedBox(width: 100),
              Image.asset(
                'assets/onboardingIcon.png',
                width: 25,
                height: 25,
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('assets/big_email_icon.png'),
                const SizedBox(height: 20),
                Text('Continue with Email', style: onboardingHeading1Style),
                const SizedBox(height: 5),
                Text('Join Neighborly with your email.',
                    style: onboardingBodyStyle),
                const SizedBox(height: 25),
                TextFieldWidget(
                  border: true,
                  controller: _emailController,
                  lableText: 'Enter Email Address',
                  isPassword: false,
                  onChanged: (value) {
                    setState(() {
                      isEmailFilled = _emailController.text.isNotEmpty;
                    });
                  },
                ),
                !isEmailValid
                    ? const Text(
                        'Please enter a valid email address',
                        style: TextStyle(color: Colors.red),
                      )
                    : const SizedBox(),
                const SizedBox(height: 12),
                TextFieldWidget(
                  border: true,
                  onChanged: (value) {
                    setState(() {
                      isPasswordFilled = _passwordController.text.isNotEmpty;
                    });
                  },
                  controller: _passwordController,
                  lableText: 'Password',
                  isPassword: true,
                ),
                isPasswordShort
                    ? const Text(
                        'Password must be at least 8 characters long',
                        style: TextStyle(color: Colors.red),
                      )
                    : const SizedBox(),
                const SizedBox(height: 12),
                TextFieldWidget(
                  border: true,
                  onChanged: (value) {
                    setState(() {
                      isConfirmPasswordFilled =
                          _confirmPasswordController.text.isNotEmpty;
                    });
                  },
                  controller: _confirmPasswordController,
                  isPassword: true,
                  lableText: 'Re-Password',
                ),
                const SizedBox(height: 25),
                Text('Your Basic Information', style: onboardingHeading2Style),
                const SizedBox(height: 10),
                Text('Select your Gender', style: blackonboardingBody1Style),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: [
                        Radio<String>(
                          value: 'Male',
                          groupValue: _selectedGender,
                          onChanged: (String? value) {
                            setState(() {
                              _selectedGender = value!;
                            });
                          },
                        ),
                        const Text('Male'),
                      ],
                    ),
                    Row(
                      children: [
                        Radio<String>(
                          value: 'Female',
                          groupValue: _selectedGender,
                          onChanged: (String? value) {
                            setState(() {
                              _selectedGender = value!;
                            });
                          },
                        ),
                        const Text('Female'),
                      ],
                    ),
                    Row(
                      children: [
                        Radio<String>(
                          value: 'Others',
                          groupValue: _selectedGender,
                          onChanged: (String? value) {
                            setState(() {
                              _selectedGender = value!;
                            });
                          },
                        ),
                        const Text('Others'),
                      ],
                    ),
                  ],
                ),
                const Divider(color: Colors.grey),
                Text('Date of Birth', style: blackonboardingBody1Style),
                const SizedBox(height: 8),
                DOBPickerWidget(
                    dateController: _dateController,
                    monthController: _monthController,
                    yearController: _yearController,
                    isDayFilled: isDayFilled,
                    isMonthFilled: isMonthFilled,
                    isYearFilled: isYearFilled),
                const SizedBox(height: 45),
                BlocConsumer<RegisterWithEmailBloc, RegisterWithEmailState>(
                  listener:
                      (BuildContext context, RegisterWithEmailState state) {
                    if (state is RegisterFailureState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.error)),
                      );
                    } else if (state is RegisterSuccessState) {
                      BlocProvider.of<ResendOtpBloc>(context).add(
                        ResendOTPButtonPressedEvent(
                          email: _emailController.text,
                        ),
                      );
                      context.push('/otp/${_emailController.text}/true');
                    }
                  },
                  builder: (context, state) {
                    if (state is RegisterLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ButtonContainerWidget(
                        isActive: checkIsActive(),
                        color: AppColors.primaryColor,
                        text: 'Sign Up',
                        isFilled: true,
                        onTapListener: () {
                          if (!isValidEmail(_emailController.text.trim())) {
                            setState(() {
                              isEmailValid = false;
                            });
                            return;
                          }
                          if (_passwordController.text.length < 8) {
                            setState(() {
                              isPasswordShort = true;
                            });
                            return;
                          }
                          setState(() {
                            isEmailValid = true;
                          });
                          BlocProvider.of<RegisterWithEmailBloc>(context).add(
                            RegisterButtonPressedEvent(
                              email: _emailController.text.trim(),
                              password: _passwordController.text.trim(),
                              dob: formatDOB(
                                  _dateController.text.trim(),
                                  _monthController.text.trim(),
                                  _yearController.text.trim()),
                              gender: _selectedGender,
                            ),
                          );
                        });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
