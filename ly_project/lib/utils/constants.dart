import 'package:ly_project/Utils/constant_strings.dart';

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

const EMAIL_REGEX =
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";

const Map<String, String> authExceptionMessageMap = {
  "invalid-email": INVALID_EMAIL_ID,
  "user-disabled": USER_DISABLED,
  "user-not-found": USER_NOT_FOUND,
  "wrong-password": WRONG_PASSWORD
};

const List<Map<String, String>> dummyPerformanceData = [
  {
    "Rank": "1",
    "Ward": "Ward A",
    "Locality": "Colaba",
    "Points": "529"
  },{
    "Rank": "2",
    "Ward": "Ward B",
    "Locality": "Churchgate",
    "Points": "528"
  },{
    "Rank": "3",
    "Ward": "Ward C",
    "Locality": "Byculla",
    "Points": "518"
  },{
    "Rank": "4",
    "Ward": "Ward D",
    "Locality": "Marine Lines",
    "Points": "509"
  },{
    "Rank": "5",
    "Ward": "Ward E",
    "Locality": "Malbar Hills",
    "Points": "505"
  },{
    "Rank": "6",
    "Ward": "Ward F",
    "Locality": "Grant Road",
    "Points": "499"
  },{
    "Rank": "7",
    "Ward": "Ward G",
    "Locality": "Mahalakshmi",
    "Points": "490"
  },{
    "Rank": "8",
    "Ward": "Ward H",
    "Locality": "Parel",
    "Points": "487"
  },{
    "Rank": "9",
    "Ward": "Ward I",
    "Locality": "Worli",
    "Points": "478"
  },{
    "Rank": "10",
    "Ward": "Ward J",
    "Locality": "Masjid",
    "Points": "469"
  },{
    "Rank": "11",
    "Ward": "Ward K",
    "Locality": "Chinchpokli",
    "Points": "465"
  },{
    "Rank": "12",
    "Ward": "Ward R Central",
    "Locality": "Vikroli",
    "Points": "459"
  },
];
