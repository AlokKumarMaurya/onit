class OnitUrl{
  // static const baseUrl = 'https://onitonline.in';
  static const baseUrl = 'http://test.devarshidevaldhaam.com/';
  static const login = '$baseUrl/api/login.php';
  static const getService = '$baseUrl/api/get-service.php?profile_hash=';
  static const appliedService = '$baseUrl/api/get-service-applied.php';
  static const getConfig = '$baseUrl/api/get-config.php';
  static const getUserDetails = '$baseUrl/api/get-user-details.php';
  static const getUserOther = '$baseUrl/api/get-user-other.php';
  static const getDocType = '$baseUrl/api/get-doc-type.php';
  static const register = '$baseUrl/api/register.php';
  static const updateProfile = '$baseUrl/api/update-profile.php';
  static const verifyOtp = '$baseUrl/api/verify-otp.php';
  static const uploadDoucment = '$baseUrl/api/upload-user-file.php';
  static const forgetPassword = '$baseUrl/api/forgot-password.php';
  static const resetPassword="${baseUrl}/api/change-password.php";
  static const updateOtherDetails="${baseUrl}/api/update-user-other.php";
  static const getAllUserFile="${baseUrl}/api/get-user-file.php";
  static const applyService="${baseUrl}/api/apply-service.php";
}