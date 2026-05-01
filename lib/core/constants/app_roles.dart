import 'app_permissions.dart';

class AppRoles {
  AppRoles._();

  static const admin = 'Admin';
  static const contributor = 'Contributor';
  static const reader = 'Reader';

  static const values = [
    admin,
    contributor,
    reader,
  ];

  static List<String> permissionsForRole(String role) {
    switch (role) {
      case admin:
        return const [
          AppPermissions.viewDashboard,
          AppPermissions.viewVillas,
          AppPermissions.manageVillas,
          AppPermissions.viewIncome,
          AppPermissions.manageIncome,
          AppPermissions.viewExpenses,
          AppPermissions.manageExpenses,
          AppPermissions.viewReports,
          AppPermissions.exportReports,
          AppPermissions.manageUsers,
          AppPermissions.manageSettings,
          AppPermissions.deleteRecords,
        ];
      case contributor:
        return const [
          AppPermissions.viewDashboard,
          AppPermissions.viewVillas,
          AppPermissions.viewIncome,
          AppPermissions.manageIncome,
          AppPermissions.viewExpenses,
          AppPermissions.manageExpenses,
        ];
      case reader:
      default:
        return const [
          AppPermissions.viewDashboard,
          AppPermissions.viewVillas,
          AppPermissions.viewIncome,
          AppPermissions.viewExpenses,
        ];
    }
  }
}
