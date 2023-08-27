enum ProductType { health, fd, life, cms }

enum LifeStatus { allStatus, enforced, lapsed, paid, matured }

enum HealthStatus { allStatus, active, ported, lapsed }

enum FDStatus { allStatus, applied, inHand, handover, redeemed }

class EnumUtils {
  static String convertTypeToKey(ProductType type) {
    switch (type) {
      case ProductType.health:
        return 'Health';
      case ProductType.fd:
        return 'FD';
      case ProductType.life:
        return 'Life';

      case ProductType.cms:
        return 'Cms';
    }
  }

  static String convertHealthStatusToName(HealthStatus status) {
    switch (status) {
      case HealthStatus.allStatus:
        return 'All Status';
      default:
        return status.name;
    }
  }

  static HealthStatus convertNameToHealthStatus(String status) {
    switch (status) {
      case "All Status":
        return HealthStatus.allStatus;
      case "active":
        return HealthStatus.active;
      case "ported":
        return HealthStatus.ported;
      case "lapsed":
        return HealthStatus.lapsed;
      default:
        return HealthStatus.allStatus;
    }
  }

  static String convertFDStatusToName(FDStatus status) {
    switch (status) {
      case FDStatus.allStatus:
        return 'All Status';
      default:
        return status.name;
    }
  }

  static FDStatus convertNameToFdStatus(String status) {
    switch (status) {
      case "All Status":
        return FDStatus.allStatus;
      case "applied":
        return FDStatus.applied;
      case "inHand":
        return FDStatus.inHand;
      case "handover":
        return FDStatus.handover;

      case "redeemed":
        return FDStatus.redeemed;
      default:
        return FDStatus.allStatus;
    }
  }

  static String convertLifeStatusToName(LifeStatus status) {
    switch (status) {
      case LifeStatus.allStatus:
        return 'All Status';
      default:
        return status.name;
    }
  }

  static LifeStatus convertNameToLifeStatus(String status) {
    switch (status) {
      case "All Status":
        return LifeStatus.allStatus;
      case "enforced":
        return LifeStatus.enforced;
      case "lapsed":
        return LifeStatus.lapsed;
      case "paid":
        return LifeStatus.paid;
      case "matured":
        return LifeStatus.matured;
      default:
        return LifeStatus.allStatus;
    }
  }
}
