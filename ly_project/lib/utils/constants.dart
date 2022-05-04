import 'package:ly_project/utils/constant_strings.dart';

const WARDS = [
  'Ward A',
  'Ward B',
  'Ward C',
  'Ward D',
  'Ward E',
  'Ward F North',
  'Ward F South',
  'Ward G North',
  'Ward G South',
  'Ward H East',
  'Ward H West',
  'Ward K East',
  'Ward K West',
  'Ward L',
  'Ward M East',
  'Ward M West',
  'Ward N',
  'Ward P North',
  'Ward P South',
  'Ward R Central',
  'Ward R North',
  'Ward R South',
  'Ward S',
  'Ward T',
];

const LEADERBOARD_DURATIONS = [
  "Today",
  "This Week",
  "This Month",
  "This Year",
  "All Time"
];

const Map<String, String> L_DURATIONS_TO_DB_FIELD_MAP = {
  "Today": "realtimeScore",
  "This Week": "weeklyScore",
  "This Month": "monthlyScore",
  "This Year": "yearlyScore",
  "All Time": "lifetimeScore"
};

const OCCUPATIONS = ["Service", "Student", "Business", "Other", "Housewife"];

enum Stauts {PENDING, IN_PROGRESS, RESOLVED, CLOSED, ISSUE_RAISED, REJECTED}
const statusString = ["Pending", "In Progress", "Resolved", "Closed", "Issue Raised", "Rejected"];

const EMAIL_REGEX =
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";

const Map<String, String> authExceptionMessageMap = {
  "invalid-email": INVALID_EMAIL_ID,
  "user-disabled": USER_DISABLED,
  "user-not-found": USER_NOT_FOUND,
  "wrong-password": WRONG_PASSWORD
};

const Map<String, String> emailRegistrationExceptionMessageMap = {
  "email-already-in-use": EMAIL_ALREADY_IN_USE,
  "invalid-email": INVALID_EMAIL_ID,
  "operation-not-allowed": OPERATION_NOT_ALLOWED,
  "weak-password": WEAK_PASSWORD
};

const Map<String, String> passwordChangeExceptionMessageMap = {
  "email-already-in-use": EMAIL_ALREADY_IN_USE,
  "user-not-found": USER_NOT_FOUND,
};

const List<Map<String, String>> dummyPerformanceData = [
  {"Rank": "1", "Ward": "Ward A", "Locality": "Colaba", "Points": "529"},
  {"Rank": "2", "Ward": "Ward B", "Locality": "Churchgate", "Points": "528"},
  {"Rank": "3", "Ward": "Ward C", "Locality": "Byculla", "Points": "518"},
  {"Rank": "4", "Ward": "Ward D", "Locality": "Marine Lines", "Points": "509"},
  {"Rank": "5", "Ward": "Ward E", "Locality": "Malbar Hills", "Points": "505"},
  {"Rank": "6", "Ward": "Ward F", "Locality": "Grant Road", "Points": "499"},
  {"Rank": "7", "Ward": "Ward G", "Locality": "Mahalakshmi", "Points": "490"},
  {"Rank": "8", "Ward": "Ward H", "Locality": "Parel", "Points": "487"},
  {"Rank": "9", "Ward": "Ward I", "Locality": "Worli", "Points": "478"},
  {"Rank": "10", "Ward": "Ward J", "Locality": "Masjid", "Points": "469"},
  {"Rank": "11", "Ward": "Ward K", "Locality": "Chinchpokli", "Points": "465"},
  {"Rank": "12","Ward": "Ward R Central","Locality": "Vikroli","Points": "459"},
];

const RESOLUTION_POINTS = 5;
const COMPLETION_POINTS = 10;
const OVERDUE_POINTS = -10;

const Map<String, dynamic> SUPERVISOR_LEVELS = {
  "levelsCount": 11,
  "levels": {
    "1": {
      "scores": [-100000, 0],
      "levelName": "Overduer"
    },
    "2": {
      "scores": [1, 49],
      "levelName": "Newbie"
    },
    "3": {
      "scores": [50, 99],
      "levelName": "Fresher"
    },
    "4": {
      "scores": [100, 149],
      "levelName": "Persistant"
    },
    "5": {
      "scores": [150, 224],
      "levelName": "Performer"
    },
    "6": {
      "scores": [225, 299],
      "levelName": ""
    },
    "7": {
      "scores": [300, 399],
      "levelName": "Magnificent"
    },
    "8": {
      "scores": [400, 549],
      "levelName": "Super"
    },
    "9": {
      "scores": [550, 749],
      "levelName": "Epic"
    },
    "10": {
      "scores": [750, 999],
      "levelName": "Ultimate"
    },
    "11": {
      "scores": [1000, 999999],
      "levelName": "Godlevel"
    }
  }
};
