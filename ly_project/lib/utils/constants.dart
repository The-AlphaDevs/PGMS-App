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

const OCCUPATIONS = [
    "Service",
    "Student",
    "Business",
    "Other",
    "Housewife"
];



const EMAIL_REGEX = r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";

const Map<String, String> authExceptionMessageMap = {
  "invalid-email": INVALID_EMAIL_ID,
  "user-disabled": USER_DISABLED,
  "user-not-found": USER_NOT_FOUND,
  "wrong-password": WRONG_PASSWORD
};
