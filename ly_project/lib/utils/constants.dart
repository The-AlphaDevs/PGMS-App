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

const Map<String, String> wardIdMap = {
  'Ward A': "WardA#50ad3f7a-dea5-49aa-b27c-59b72aa0b1c2",
  'Ward B': "WardB#8007bb31-6571-4905-92ed-26788504d837",
  'Ward C': "WardC#d9328d63-6ac3-48bd-8d87-565afa37d1c2",
  'Ward D': "WardD#9fc00c88-02fa-4a3c-a577-198e9e7a008b",
  'Ward E': "WardE#d2fa9120-7dd5-432d-be22-fd0de7f98986",
  'Ward F North': "WardFNorth#e5f11f14-14e1-4d4f-bfd6-aded3eb5eb6b",
  'Ward F South': "WardFSouth#86c808e9-6c75-4b3f-8e5f-1b82ee779fa7",
  'Ward G North': "WardGNorth#320192df-ea17-4f0c-b792-be1b2821834a",
  'Ward G South': "WardGSouth#484e9189-473e-4cf2-941c-5125e5173ee8",
  'Ward H East': "WardHEast#9474ef81-82ac-4706-a3ae-a8dd12f98116",
  'Ward H West': "WardHWest#4b9b4bbc-6caa-4d32-bac8-dd7af13a180d",
  'Ward K East': "WardKEast#4e3d488a-6589-45d7-8b2d-efe1525d81e3",
  'Ward K West': "WardKWest#053a621a-8036-40e0-b4c6-163553a3e702",
  'Ward L': "WardL#986d2642-5377-401f-b6f1-93baea9cf6b4",
  'Ward M East': "WardMEast#a7da5ad3-0763-4665-a07c-957faa1ff18c",
  'Ward M West': "WardMWest#99adb54a-ce6c-4cf3-9398-c8d359a62b22",
  'Ward N': "WardN#33dca927-7303-413f-9d0a-42504585d618",
  'Ward P North': "WardPNorth#b64435f2-ebc2-446f-a20f-8d38f351a7d9",
  'Ward P South': "WardPSouth#7e79e314-afb5-412d-9b82-39d6fd22e8b3",
  'Ward R Central': "WardRCentral#abcceb1e-455b-44ba-9211-44d90943c44e",
  'Ward R North': "WardRNorth#21596834-ab81-4fd6-a35b-e3ec64c28f7d",
  'Ward R South': "WardRSouth#ce381886-7ce7-464c-a9b8-f3c1b02411e2",
  'Ward S': "WardS#ea39ccad-b0ba-49ab-8755-2bcdde898327",
  'Ward T': "WardT#bf0b3c37-a7ea-445b-bee9-2d4b2ed95651",
  'Unassigned': "WardUnassigned#10ad3f7a-dea5-49aa-b27c-59b72aa0b1c2"
};

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

enum Stauts {PENDING, IN_PROGRESS, RESOLVED, CLOSED, ISSUE_REPORTED, REJECTED}
const statusString = ["Pending", "In Progress", "Resolved", "Closed", "Issue Reported", "Rejected"];

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
