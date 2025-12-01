class EndPoints {
  static const String baseUrl = 'http://loczone.net:5050';
  static const String login = '/api/auth/login';

  static const String registerPatient = '/api/patients/register';
  static const String forgotPassword = '/api/auth/forgot-password';
  static const String resetPassword = '/api/auth/reset-password';
  static const String verifyPhoneNumber = '/api/auth/verify-otp';
  static const String verifyPhoneNumberPatient =
      '/api/patients/register/verify-otp';
  static const String verifyPhoneNumberDoctor =
      '/api/doctors/register/verify-otp';
  static const String getUserData = '/api/auth/me';
  static const String getSpecialities = '/api/doctors/specialties';
  static const String getTopDoctors = '/api/doctors/top-score';
  static const String getMostFamousDoctors = '/api/doctors/famous';
  static const String searchDoctors = '/api/doctors/search';
  static String getDoctors(String id) => '/api/doctors/specialties/$id';
  static String getDoctorDetails(String id) => '/api/doctors/$id';
  static String getDoctorReviews(String id) => '/api/doctors/$id/scores';
  static String getPatientAppointments = '/api/patients/appointments';
  static String getDoctorAppointments = '/api/doctors/appointments';
  static String getDoctorAppointmentDetails(String id) =>
      '/api/doctors/appointments/$id';
  static String getCurrentDoctorAppointment =
      '/api/doctors/appointments/current';
  static String cancelPatientAppointment(String id) =>
      '/api/patients/appointments/$id/cancel';
  static String rateDoctor(String id) =>
      '/api/patients/appointments/$id/review';
  static String endSession(String id) =>
      '/api/patients/appointments/$id/confirm';
  static String editPatientAppointment(String id) =>
      '/api/patients/appointments/$id';
  static const String editPatientProfile = '/api/patients/profile/update';
  static const String getWaitingDoctorAppointments =
      '/api/doctors/appointments/waiting-approval';

  static const String getCategories = "/api/Categories";
  static const String getProducts = "/api/Products";
}
